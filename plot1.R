epc <- read.csv("./household_power_consumption.txt", sep = ";")

epc$Date <- as.Date(epc$Date, format = "%d/%m/%Y")

days <- subset(epc, epc$Date >= "2007-02-01" &  epc$Date <="2007-02-02")

days$Global_active_power <- as.numeric(days$Global_active_power)

hist(days$Global_active_power, col = "red", main = "Gobal Active Power", xlab =
       "Global Active Power (Kilowatts)")

png(filename = "plot1.png", width = 480, height = 480)


dev.off()

