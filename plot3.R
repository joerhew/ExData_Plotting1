## Download the zip file into a temp file (on a Mac)
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp, method = "curl")

## Extract the data from the temp file into "full_data" and then unlink the temp file
full_data <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, sep = ";", na.strings = "?")
unlink(temp)

# Combine the Date and Time columns into "date"
date <- strptime(paste(full_data$Date,full_data$Time), format = "%d/%m/%Y %H:%M:%S")

# Create a new column in full_data that shows the full combined date and time
full_data$Datetime <- date

# Assign the period for which we will be plotting, between Feb 1 2007 and Feb 2 2007 
plot_period <- full_data[full_data$Datetime < "2007-02-02 23:59:59" & full_data$Datetime > "2007-02-01 00:00:00", ]

# Call PNG device, with width and height at 480px
png(file="plot3.png", width = 480, height = 480)

# Set up the plot region
plot(plot_period$Datetime, plot_period$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")

# Draw the lines for each of the sub meters
lines(plot_period$Datetime, as.numeric(as.character(plot_period$Sub_metering_1)), type = "l")
lines(plot_period$Datetime, as.numeric(as.character(plot_period$Sub_metering_2)), type = "l", col="red")
lines(plot_period$Datetime, as.numeric(as.character(plot_period$Sub_metering_3)), type = "l", col="blue")

# Populate the legend
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black", "red", "blue"), lty = "solid")

# Finish drawing the plot in the PNG file
dev.off()