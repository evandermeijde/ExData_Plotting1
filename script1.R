require(tidyverse)
require(lubridate)

Sys.setlocale(category = "LC_ALL", locale = "English_United States.1252")

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip" , mode="wb")
dataFile <- unzip("household_power_consumption.zip")
hpc <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

hpc$Date <- dmy(hpc$Date)
hpc$Time <- hms(hpc$Time)
hpc$Global_active_power <- as.numeric(as.character(hpc$Global_active_power))
hpc$Global_reactive_power <- as.numeric(as.character(hpc$Global_reactive_power))
hpc$Voltage <- as.numeric(as.character(hpc$Voltage))
hpc$Global_intensity <- as.numeric(as.character(hpc$Global_intensity))
hpc$Sub_metering_1 <- as.numeric(as.character(hpc$Sub_metering_1))
hpc$Sub_metering_2 <- as.numeric(as.character(hpc$Sub_metering_2))
hpc$Sub_metering_3 <- as.numeric(as.character(hpc$Sub_metering_3))

selection_hpc <- filter(hpc, Date=="2007-02-01" | Date=="2007-02-02")

png("plot1.png", width=480, height=480)
hist(selection_hpc$Global_active_power, col="red", 
     main="Global Active Power", xlab="Global Active Power (kilowatts")
dev.off()