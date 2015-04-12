library(dplyr)
library(data.table)

download_data = function() {
  if (!file.exists("household_power_consumption.txt")) {
    download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                  destfile="household_power_consumption.zip", method = "curl")
    unzip(zipfile="household_power_consumption.zip")
  }
}

data = fread("household_power_consumption.txt", sep = ";", header = T, na.strings = "?")

filtered = filter(data, as.Date(Date , "%d/%m/%Y") %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")) )

filtered$DateTime = with(filtered, as.POSIXct(paste(Date, Time, sep="-" ), format = "%d/%m/%Y-%T"))

png("plot1.png", width=480, height = 480)
with(filtered, hist(as.numeric(Global_active_power), col="red", main = "Global active power", xlab = "Global active power (kilowatts)"))
dev.off()