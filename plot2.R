
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

# plot global power by days/time

png(filename = "plot2.png", width = 480, height = 480)

plot(days$Global_active_power~days$DateTime, type="l", 
     ylab= "Global Active Power (kilowatts)", xlab="")

dev.off()

