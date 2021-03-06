library(dplyr)
library(data.table)

if (!file.exists("household_power_consumption.txt")) {
  download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                destfile="household_power_consumption.zip", method = "curl")
  unzip(zipfile="household_power_consumption.zip")
}

data = fread("household_power_consumption.txt", sep = ";", header = T, na.strings = "?")

filtered = filter(data, as.Date(Date , "%d/%m/%Y") %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")) )

filtered$DateTime = with(filtered, as.POSIXct(paste(Date, Time, sep="-" ), format = "%d/%m/%Y-%T"))

png("plot3.png", width=480, height = 480)
with(filtered, plot(y = Sub_metering_1, x= DateTime, type="line", ylab = "Energy sub metering", xlab= NA))
with(filtered, lines(y = Sub_metering_2, x= DateTime, col="red"))
with(filtered, lines(y = Sub_metering_3, x= DateTime, col="blue"))
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black", "red", "blue"), lwd=1)
dev.off()
