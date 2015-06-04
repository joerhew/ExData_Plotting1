## Download the zip file into a temp file (on a Mac)
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp, method = "curl")

## Extract the data from the temp file into "full_data" and then unlink the temp file
full_data <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, sep = ";", na.strings = "?")
unlink(temp)

# Combine the Date and Time columns into "date"
date <- strptime(paste(full_data$Date,full_data$Time), format = "%d/%m/%Y %H:%M:%S")

# Assign the period for which we will be plotting, between Feb 1 2007 and Feb 2 2007 
plot_period <- full_data[date < "2007-02-02 23:59:59" & date > "2007-02-01 00:00:00", ]

#Call PNG device, with width and height at 480px
png(file="plot1.png", width = 480, height = 480)

# Convert Global_active_power into character and then numeric, then draw a histogram
hist(as.numeric(as.character(plot_period$Global_active_power)), col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

# Finish drawing the plot in the PNG file
dev.off()