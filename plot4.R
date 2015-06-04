## Read in the full data from the text file
full_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

# Combine the Date and Time columns into "date"
date <- strptime(paste(full_data$Date,full_data$Time), format = "%d/%m/%Y %H:%M:%S")

# Create a new column in full_data that shows the full combined date and time
full_data$Datetime <- date

# Assign the period for which we will be plotting, between Feb 1 2007 and Feb 2 2007 
plot_period <- full_data[full_data$Datetime < "2007-02-02 23:59:59 KST" & full_data$Datetime > "2007-02-01 00:00:00 KST", ]

# Call PNG device, with width and height at 480px
png(file="plot4.png", width = 480, height = 480)

# Set up a 2-by-2 plot structure
par(mfrow = c(2, 2))

# Draw PLOT 1
# Convert Global_active_power into character and then numeric, then draw a line graph
plot(plot_period$Datetime, as.numeric(as.character(plot_period$Global_active_power)), type ="l", ylab = "Global Active Power", xlab ="")

# Draw PLOT 2
# Draw a line graph for voltage
plot(plot_period$Datetime, plot_period$Voltage, type ="l", ylab = "Voltage", xlab ="datetime")

# Draw PLOT 3
# Set up the plot region
plot(plot_period$Datetime, plot_period$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")
# Draw the lines for each of the sub meters
lines(plot_period$Datetime, as.numeric(as.character(plot_period$Sub_metering_1)), type = "l")
lines(plot_period$Datetime, as.numeric(as.character(plot_period$Sub_metering_2)), type = "l", col="red")
lines(plot_period$Datetime, as.numeric(as.character(plot_period$Sub_metering_3)), type = "l", col="blue")
# Populate the legend
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black", "red", "blue"), lty = "solid", bty = "n")

# Draw PLOT 4
# Draw a line graph for Global reactive power
plot(plot_period$Datetime, plot_period$Global_reactive_power, type ="l", ylab = "Global_reactive_power", xlab ="datetime")

# Finish drawing the plot in the PNG file
dev.off()