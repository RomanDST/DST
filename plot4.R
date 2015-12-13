
dataFile <- "./data/household_power_consumption.txt" 
2 data <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".") 
3 subSetData <- data[data$Date %in% c("1/2/2007","2/2/2007") ,] 
4 

5 #str(subSetData) 
6 datetime <- strptime(paste(subSetData$Date, subSetData$Time, sep=" "), "%d/%m/%Y %H:%M:%S")  
7 globalActivePower <- as.numeric(subSetData$Global_active_power) 
8 globalReactivePower <- as.numeric(subSetData$Global_reactive_power) 
9 voltage <- as.numeric(subSetData$Voltage) 
10 subMetering1 <- as.numeric(subSetData$Sub_metering_1) 
11 subMetering2 <- as.numeric(subSetData$Sub_metering_2) 
12 subMetering3 <- as.numeric(subSetData$Sub_metering_3) 
13 

14 

15 png("plot4.png", width=480, height=480) 
16 par(mfrow = c(2, 2))  
17 

18 plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2) 
19 

20 plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage") 
21 

22 plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="") 
23 lines(datetime, subMetering2, type="l", col="red") 
24 lines(datetime, subMetering3, type="l", col="blue") 
25 legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o") 
26 

27 plot(datetime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power") 
28 

29 dev.off() 
