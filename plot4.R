#!/usr/bin/R -f

library(dplyr)

# load the data
data <- read.table(file='data/household_power_consumption.txt', sep=';', header=TRUE)

# prepare and filter the data
newdata <- mutate(data, Date = as.Date(Date, '%d/%m/%Y'))
filtered <- filter(newdata, Date == '2007-02-01' | Date == '2007-02-02')

# open drawing device
png(filename='plot4.png', width=480, height=480)

# set multiple plot, to 2 per row and 2 per column, fill column first
par(mfcol=c(2,2))

# prepare data for graph1
selected <- mutate(filtered, Date = paste(as.character(Date), Time), Global_active_power=as.numeric(as.character(Global_active_power))) %>% select(Date, Global_active_power)
x1 <- strptime(selected$Date, "%Y-%m-%d %H:%M:%S")
x2 <- selected$Global_active_power

# plot graph1
plot(type='l', x1, x2, xlab = '', ylab = 'Global Active Power')

# prepare data for graph2
selected2 <- mutate(filtered, Date = paste(as.character(Date), Time), Sub_metering_1=as.numeric(as.character(Sub_metering_1)), Sub_metering_2=as.numeric(as.character(Sub_metering_2)), Sub_metering_3=as.numeric(as.character(Sub_metering_3))) %>% select(Date, Sub_metering_1, Sub_metering_2, Sub_metering_3)

x1 <- strptime(selected2$Date, "%Y-%m-%d %H:%M:%S")
s1 <- selected2$Sub_metering_1
s2 <- selected2$Sub_metering_2
s3 <- selected2$Sub_metering_3

# plot graph2
plot(type = 'l', x1, s1, col='black', xlab = '', ylab = 'Energy sub metering')
lines(x1, s2, col='red')
lines(x1, s3, col='blue')
legend("topright", pch = '__', col = c('black', 'red', 'blue'), box.lwd = 0, legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))

# prepare data for graph3
selected3 <- mutate(filtered, Date = paste(as.character(Date), Time), Voltage=as.numeric(as.character(Voltage))) %>% select(Date, Voltage)
x1 <- strptime(selected3$Date, "%Y-%m-%d %H:%M:%S")
x2 <- selected3$Voltage

# plot graph3
plot(type='l', x1, x2, xlab = 'datetime', ylab = 'Voltage')

# prepare data for graph4
selected4 <- mutate(filtered, Date = paste(as.character(Date), Time), Global_reactive_power=as.numeric(as.character(Global_reactive_power))) %>% select(Date, Global_reactive_power)
x1 <- strptime(selected4$Date, "%Y-%m-%d %H:%M:%S")
x2 <- selected4$Global_reactive_power

# plot graph4
plot(type='l', x1, x2, xlab = 'datetime', ylab = 'Global_reactive_power')

# close the drawing device
dev.off()

