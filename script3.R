require(tidyverse)
require(lubridate)

Sys.setlocale(category = "LC_ALL", locale = "English_United States.1252")

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip" , mode="wb")
dataFile <- unzip("household_power_consumption.zip")
hpc <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

hpc$Date <- dmy(hpc$Date)
hpc$Global_active_power <- as.numeric(as.character(hpc$Global_active_power))
hpc$Global_reactive_power <- as.numeric(as.character(hpc$Global_reactive_power))
hpc$Voltage <- as.numeric(as.character(hpc$Voltage))
hpc$Global_intensity <- as.numeric(as.character(hpc$Global_intensity))
hpc$Sub_metering_1 <- as.numeric(as.character(hpc$Sub_metering_1))
hpc$Sub_metering_2 <- as.numeric(as.character(hpc$Sub_metering_2))
hpc$Sub_metering_3 <- as.numeric(as.character(hpc$Sub_metering_3))

selection_hpc <- filter(hpc, Date=="2007-02-01" | Date=="2007-02-02")

datetime <- strptime(paste(selection_hpc$Date, selection_hpc$Time, sep=" "), "%Y-%m-%d %H:%M:%S")

png("plot3.png", width=480, height=480)
plot(datetime, selection_hpc$Sub_metering_1, type='l', xlab="", ylab= "Energy sub metering")
lines(datetime, selection_hpc$Sub_metering_2, type='l', col="red")
lines(datetime, selection_hpc$Sub_metering_3, type='l', col="blue")
legend("topright",legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
       col=c("black", "red", "blue"), lty=c(1,1,1), cex=0.8)
dev.off()