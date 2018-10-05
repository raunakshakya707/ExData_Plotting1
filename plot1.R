powerConsumptionData <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character', 'character', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric'))
powerConsumptionData$Date <- as.Date(powerConsumptionData$Date, "%d/%m/%Y")
powerConsumptionData <- subset(powerConsumptionData, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
powerConsumptionData <- powerConsumptionData[complete.cases(powerConsumptionData),]
dateTime <- setNames(paste(powerConsumptionData$Date, powerConsumptionData$Time), "DateTime")
powerConsumptionData <- powerConsumptionData[ ,!(names(powerConsumptionData) %in% c("Date","Time"))]
powerConsumptionData <- cbind(dateTime, powerConsumptionData)
powerConsumptionData$dateTime <- as.POSIXct(dateTime)

## Create the histogram
hist(powerConsumptionData$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red", ylim=c(0, 1200))

## Save histogram in a file and close the device
dev.copy(png, "plot1.png", height=480, width=480)
dev.off()
