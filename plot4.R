# Plot 4 - Source code for creating plot 4
# Please make sure household_power_consumption.txt is in your working directory
plot4 <- function(x="household_power_consumption.txt") {
  
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
  
  # Convert column to date type
  datetime <- paste(powerData$Date, powerData$Time)
  powerData$DateTime <- as.POSIXct(datetime, format = "%d/%m/%Y %H:%M:%S")
  
  # Create plots
  par(mfrow = c(2, 2), mar = c(4, 4, 1, 1))
  
  # plot 1
  with(powerData, plot(DateTime, Global_active_power, type="l", xlab = "", ylab = "Global Active Power"))
  
  # plot 2
  with(powerData, plot(DateTime, Voltage, type="l", ylab = "Voltage"))

  # plot 3
  with(powerData, plot(DateTime, Sub_metering_1, type="l", ylab = "Energy sub metering", xlab=""))
  lines(powerData$DateTime, powerData$Sub_metering_2, type="l", col="red")
  lines(powerData$DateTime, powerData$Sub_metering_3, type="l", col="blue")
  legend("topright", pch="-", col=c("black", "blue", "red"), legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), cex=0.8)
  
  # plot 4
  with(powerData, plot(DateTime, Global_reactive_power, type="l"))
  
  #save it to file
  dev.copy(png,'plot4.png')
  dev.off()
  
  message(paste("Plot saved in ", file.path(getwd(), "plot4.png")))
  
}