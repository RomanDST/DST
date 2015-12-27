NEI <- readRDS("Data/summarySCC_PM25.rds") 
SCC <- readRDS("Data/Source_Classification_Code.rds") 

NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008')) 
MD.onroad <- subset(NEI, fips == 24510 & type == 'ON-ROAD') 
MD.df <- aggregate(MD.onroad[, 'Emissions'], by=list(MD.onroad$year), sum) 
colnames(MD.df) <- c('year', 'Emissions') 

png(filename='plot5.png') 

install.packages("ggplot2") 
library(ggplot2)

ggplot(data=MD.df, aes(x=year, y=Emissions)) + guides(fill=F) +  
  geom_line(aes(group=1, col=Emissions)) + geom_point(aes(size=1, col=Emissions)) + 
  ggtitle('Total Emissions of Motor Vehicle Sources in Baltimore City, Maryland') +  
  ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position='none') +  
  geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=2)) 

dev.off() 
