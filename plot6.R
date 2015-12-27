NEI <- readRDS("Data/summarySCC_PM25.rds") 
SCC <- readRDS("Data/Source_Classification_Code.rds") 

NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008')) 
MD.onroad <- subset(NEI, fips == '24510' & type == 'ON-ROAD') 
CA.onroad <- subset(NEI, fips == '06037' & type == 'ON-ROAD') 
MD.DF <- aggregate(MD.onroad[, 'Emissions'], by=list(MD.onroad$year), sum) 
colnames(MD.DF) <- c('year', 'Emissions') 
MD.DF$City <- paste(rep('MD', 4)) 
CA.DF <- aggregate(CA.onroad[, 'Emissions'], by=list(CA.onroad$year), sum) 
colnames(CA.DF) <- c('year', 'Emissions') 
CA.DF$City <- paste(rep('CA', 4)) 
DF <- as.data.frame(rbind(MD.DF, CA.DF)) 

png(filename='plot6.png') 

install.packages("ggplot2") 
library(ggplot2)

ggplot(data=DF, aes(x=year, y=Emissions)) + guides(fill=F) + 
  geom_line(aes(group=1, col=Emissions)) + geom_point(aes(size=1, col=Emissions)) + 
  ggtitle('Total Emissions of Motor Vehicle Sources\nLos Angeles County, California vs. Baltimore City, Maryland') +  
  ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position='none') + facet_grid(. ~ City) +  
  geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=-1)) 

dev.off() 
