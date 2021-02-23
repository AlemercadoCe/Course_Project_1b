# read and asign classes to columns

epc <- read.csv("./household_power_consumption.txt", header=TRUE, sep = ";", 
                na.strings = "?", colClasses = c('character','character',
                                                 'numeric','numeric','numeric',
                                                 'numeric','numeric','numeric',
                                                 'numeric'))
# date format to subset dataframe, remove NAs

epc$Date <- as.Date(epc$Date, format = "%d/%m/%Y")

days <- subset(epc, epc$Date >= "2007-02-01" &  epc$Date <= "2007-02-02")

days <- days[complete.cases(days),]

# put in one column Date and Time, name the new collumn

DateTime <- paste(days$Date, days$Time)

DateTime <- setNames(DateTime, "DateTime")

# bind new column with the dataframe

days <- cbind(DateTime, days)

# format new column as POSIXct

days$DateTime <- as.POSIXct(DateTime)

# plot energy sub metering by days/time

png(filename = "plot3.png", width = 480, height = 480)

#line 1
sb1 <- days$Sub_metering_1~days$DateTime


plot(sb1, type="l", ylab= "Energy sub metering",
     xlab="")

# line 2
sb2 <- days$Sub_metering_2~days$DateTime
lines(sb2, type="l", col="red")

# line3
sb3 <- days$Sub_metering_3 ~days$DateTime
lines(sb3, type="l", col="blue")

# add legend
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, lwd=2, col=c("black", "red", "blue"))

dev.off()
