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

##  Construct the plot and save it to a PNG file
##  with a width of 480 pixels and a height of 480 pixels.
####################################################################

png("plot2.png", width = 480, height = 480, units = "px")
plot(data$datetime,data$Global_active_power, type = "l", xlab = "", ylab ="Global Active Power (kilowatts)")
dev.off()
