powerConsumptionData <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character', 'character', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric'))
powerConsumptionData$Date <- as.Date(powerConsumptionData$Date, "%d/%m/%Y")
powerConsumptionData <- subset(powerConsumptionData, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
powerConsumptionData <- powerConsumptionData[complete.cases(powerConsumptionData),]
dateTime <- setNames(paste(powerConsumptionData$Date, powerConsumptionData$Time), "DateTime")
powerConsumptionData <- powerConsumptionData[ ,!(names(powerConsumptionData) %in% c("Date","Time"))]
powerConsumptionData <- cbind(dateTime, powerConsumptionData)
powerConsumptionData$dateTime <- as.POSIXct(dateTime)

## Create the plot
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(powerConsumptionData, {
  plot(Global_active_power~dateTime, xlab="", ylab="Global Active Power", type="l")
  plot(Voltage~dateTime, xlab="datetime", ylab="Voltage", type="l", ylim=c(234, 246))
  plot(Sub_metering_1~dateTime, xlab="", ylab="Energy sub metering", type="l")
  lines(Sub_metering_2~dateTime, col='Red')
  lines(Sub_metering_3~dateTime, col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, xlab="datetime", ylab="Global_rective_power", type="l", ylim=c(0.0, 0.5))
})

## Save the plot in a file and close the device
dev.copy(png, "plot4.png", height = 480, width = 480)
dev.off()
