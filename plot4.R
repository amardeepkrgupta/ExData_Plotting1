##  Read the data from the file, assuming file is present
##  in the current directory
####################################################################

data <- read.table("household_power_consumption.txt", sep = ";", header = T, stringsAsFactors = F)
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

##  Filter required data and format the columns
####################################################################

data <- data[(data$Date >= "2007-02-01" & data$Date <= "2007-02-02"),]
data$datetime <- strptime(paste(data$Date,data$Time), "%Y-%m-%d %H:%M:%S")
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

##  Construct the plot and save it to a PNG file
##  with a width of 480 pixels and a height of 480 pixels.
####################################################################

png("plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2, 2))
# Top right
plot(data$datetime,data$Global_active_power, type = "l", xlab = "", ylab ="Global Active Power")

# Top left
plot(data$datetime,data$Voltage, type = "l", xlab = "datetime", ylab ="Voltage")

# Bottom left
plot(data$datetime,data$Sub_metering_1, col="black", type = "l", xlab = "", ylab ="Energy sub metering")
lines(data$datetime,data$Sub_metering_2, col ="red" )
lines(data$datetime,data$Sub_metering_3, col ="blue" )
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty = "n",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Bottom right
plot(data$datetime,data$Global_reactive_power, type = "l", xlab = "datetime", ylab ="Global_reactive_power")

dev.off()
