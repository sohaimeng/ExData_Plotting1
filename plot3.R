filename <- "household_power_consumption.txt"

if(!file.exists(filename))
{
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                  "household_power_consumption.zip")
    unzip("household_power_consumption.zip")
}

consumptionColClass <- c("character", "character", rep("numeric",7))
household_Data <- read.table(filename, header = TRUE, sep = ";", na.strings = "?", colClasses = consumptionColClass ,comment.char = "")

filter_Data <- na.omit(household_Data[, c(1:2,7:9)])
requiredData <- c(as.Date("2007-02-01"),as.Date("2007-02-02"))
Feb_Data <- filter_Data[which(as.Date(filter_Data$Date,"%d/%m/%Y") %in% requiredData),]
times_Data <- (strptime(paste(Feb_Data$Date, Feb_Data$Time, sep = " "),format = "%d/%m/%Y %H:%M:%S"))

png(filename="plot3.png",width=480, height=480, units = "px")
plot(times_Data,Feb_Data$Sub_metering_1, type="l",xlab="",ylab="Energy sub metering")
lines(times_Data,Feb_Data$Sub_metering_2, type="l",xlab="",col="red")
lines(times_Data,Feb_Data$Sub_metering_3, type="l",xlab="",col="blue")
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()