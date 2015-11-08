filename <- "household_power_consumption.txt"

if(!file.exists(filename))
{
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                  "household_power_consumption.zip")
    unzip("household_power_consumption.zip")
}

consumptionColClass <- c("character", "character", rep("numeric",7))
household_Data <- read.table(filename, header = TRUE, sep = ";", na.strings = "?", colClasses = consumptionColClass ,comment.char = "")

filter_Data <- na.omit(household_Data[, c(1,3)])
requiredData <- c(as.Date("2007-02-01"),as.Date("2007-02-02"))

Feb_Data <- filter_Data[which(as.Date(filter_Data$Date,"%d/%m/%Y") %in% requiredData), 2]

png(filename="plot1.png", width=480, height=480, units="px")
hist(Feb_Data, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()