# Plot 1 - Source code for creating plot 1
# Please make sure household_power_consumption.txt is in your working directory
plot1 <- function(x="household_power_consumption.txt") {
  
# List of packages for session
message("Loading required packages...")
pkgList = c("data.table")

# Install CRAN packages (if not already installed)

instPkgs <- pkgList %in% installed.packages()
if(length(pkgList[!instPkgs]) > 0) install.packages(pkgList[!instPkgs])

# Load packages into session 
lapply(pkgList, library, character.only=TRUE)


# Read file
columns <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
powerData <- fread(x, sep = ";", skip="1/2/2007", na.strings = "?", col.names = columns, nrows=2880)

# Create histogram
par(mfrow = c(1, 1))
hist(powerData$Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

#save it to file
dev.copy(png,'plot1.png')
dev.off()

message(paste("Plot saved in ", file.path(getwd(), "plot1.png")))

}


