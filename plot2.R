library(dplyr)
library(data.table)

source("download_data.R")
download_data()

data = fread("household_power_consumption.txt", sep = ";", header = T, na.strings = "?")

filtered = filter(data, as.Date(Date , "%d/%m/%Y") %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")) )

filtered$DateTime = with(filtered, as.POSIXct(paste(Date, Time, sep="-" ), format = "%d/%m/%Y-%T"))

png("plot2.png", width=480, height = 480)
with(filtered, plot(y = as.numeric(Global_active_power), x= DateTime, type="line", ylab = "Global active power (kilowatts)", xlab= NA))
dev.off()