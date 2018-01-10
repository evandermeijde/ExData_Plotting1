require(tidyverse)
require(caret)
require(swirl)
require(lubridate)
swirl()

Sys.setlocale(category = "LC_ALL", locale = "")
Sys.setlocale(category = "LC_ALL", locale = "en_US.UTF-8")
Sys.setlocale(category = "LC_ALL", locale = "English_United States.1252")

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip" , mode="wb")
unzip("household_power_consumption.zip")
list.files()
hpc <- read.table("household_power_consumption.txt")
hpc <- read.table("household_power_consumption.zip")
hpc <- read.csv2("household_power_consumption.txt")
data <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
summary(hpc)
?replace
replace(hpc$Global_active_power,hpc$Global_active_power=="?",NA)

date <- as.Date(hpc$Date, format="%d/%m/%Y")
date <- dmy(hpc$Date)
time <- as.POSIXct(strptime(hpc$Time[1:10], format="%H:%M:%S"))
time <- hms(hpc$Time)
gap <- as.numeric(as.character(hpc$Global_active_power))
grp <- as.numeric(as.character(hpc$Global_reactive_power))
volt <- as.numeric(as.character(hpc$Voltage))
gi <- as.numeric(as.character(hpc$Global_intensity))
sm1 <- as.numeric(as.character(hpc$Sub_metering_1))
sm2 <- as.numeric(as.character(hpc$Sub_metering_2))
sm3 <- as.numeric(as.character(hpc$Sub_metering_3))

hpc$Date <- date
hpc$Time <- time
hpc$Global_active_power <- gap
hpc$Global_reactive_power <- grp
hpc$Voltage <- volt
hpc$Global_intensity <- gi
hpc$Sub_metering_1 <- sm1
hpc$Sub_metering_2 <- sm2
hpc$Sub_metering_3 <- sm3

summary(hpc)
hpc <- as.tibble(hpc)
hpc
summary(hpc)

?strptime
?as.Date

png("plot1.png", width=480, height=480)

# png plot
dev.off()
hist(selection_hpc$Global_active_power, col="red", 
     main="Global Active Power", xlab="Global Active Power (kilowatts")
selection_hpc <- filter(hpc, Date=="2007-02-01" | Date=="2007-02-02")

hist(selection_hpc$Global_active_power, col="red", 
     main="Global Active Power", xlab="Global Active Power (kilowatts")
plot(selection_hpc$Global_active_power, type="line", 
     xlab="", ylab="Global Active Power (kilowatts)")
?axis
axis(1,at=wday(selection_hpc$Date, label = TRUE))
cex=wday(selection_hpc$Date, label = TRUE)
?plot

dataFile <- "./data/household_power_consumption.txt"
data <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
subSetData <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]

#str(subSetData)
selection_hpc$datetime <- strptime(paste(selection_hpc$Date, selection_hpc$Time, sep=" "), "%Y-%m-%d %H:%M:%S") 
globalActivePower <- as.numeric(subSetData$Global_active_power)
png("plot2.png", width=480, height=480)
plot(selection_hpc$datetime, selection_hpc$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

png("plot2.png", width=480, height=480)
plot(selection_hpc$datetime, selection_hpc$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

plot(selection_hpc$datetime, selection_hpc$Sub_metering_1, type='l', xlab="", ylab= "Energy sub metering")
lines(selection_hpc$datetime, selection_hpc$Sub_metering_2, type='l', col="red")
lines(selection_hpc$datetime, selection_hpc$Sub_metering_3, type='l', col="blue")
legend("topright",legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
       col=c("black", "red", "blue"), lty=c(1,1,1), cex=0.8)
?legend

plot(selection_hpc$datetime, selection_hpc$Voltage, type='l', xlab="", ylab= "Voltage")
plot(selection_hpc$datetime, selection_hpc$Global_reactive_power, type='l', xlab="", ylab= "Global_reactive_power")
