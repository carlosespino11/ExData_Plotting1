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

png("plot4.png", width=480, height = 480)
par(mfrow=c(2, 2))
with(filtered, plot(y = as.numeric(Global_active_power), x= DateTime, type="line", ylab = "Global active power", xlab= NA))

with(filtered, plot(y = Voltage, x= DateTime, type="line", xlab = "datetime"))

with(filtered, plot(y = Sub_metering_1, x= DateTime, type="line", ylab = "Energy sub metering", xlab= NA))
with(filtered, lines(y = Sub_metering_2, x= DateTime, col="red"))
with(filtered, lines(y = Sub_metering_3, x= DateTime, col="blue"))
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black", "red", "blue"), lwd=1, bty="n")

with(filtered, plot(y = as.numeric(Global_reactive_power), x= DateTime, type="line", ylab = "Global_reactive_power", xlab= "datetime"))
dev.off()