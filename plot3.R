powerConsumptionData <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character', 'character', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric'))
powerConsumptionData$Date <- as.Date(powerConsumptionData$Date, "%d/%m/%Y")
powerConsumptionData <- subset(powerConsumptionData, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
powerConsumptionData <- powerConsumptionData[complete.cases(powerConsumptionData),]
dateTime <- setNames(paste(powerConsumptionData$Date, powerConsumptionData$Time), "DateTime")
powerConsumptionData <- powerConsumptionData[ ,!(names(powerConsumptionData) %in% c("Date","Time"))]
powerConsumptionData <- cbind(dateTime, powerConsumptionData)
powerConsumptionData$dateTime <- as.POSIXct(dateTime)

## Create the plot
with(powerConsumptionData, {
  plot(Sub_metering_1~dateTime, xlab="", ylab="Energy sub metering", type="l")
  lines(Sub_metering_2~dateTime, col='Red')
  lines(Sub_metering_3~dateTime, col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Save the plot in a file and close the device
dev.copy(png, "plot3.png", height = 480, width = 480)
dev.off()
