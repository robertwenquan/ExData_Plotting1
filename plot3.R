#!/usr/bin/R -f
#
# R script for Exploratory Data Analysis course project
#
# Robert Wen (robert.wen@nyu.edu)
#

library(dplyr)

# load the data
data <- read.table(file='data/household_power_consumption.txt', sep=';', header=TRUE)

# prepare and filter the data
newdata <- mutate(data, Date = as.Date(Date, '%d/%m/%Y'))
filtered <- filter(newdata, Date == '2007-02-01' | Date == '2007-02-02')
selected <- mutate(filtered, Date = paste(as.character(Date), Time), Sub_metering_1=as.numeric(as.character(Sub_metering_1)), Sub_metering_2=as.numeric(as.character(Sub_metering_2)), Sub_metering_3=as.numeric(as.character(Sub_metering_3))) %>% select(Date, Sub_metering_1, Sub_metering_2, Sub_metering_3)

x1 <- strptime(selected$Date, "%Y-%m-%d %H:%M:%S")
s1 <- selected$Sub_metering_1
s2 <- selected$Sub_metering_2
s3 <- selected$Sub_metering_3

# open drawing device
png(filename='plot3.png', width=480, height=480, bg = "transparent")

# plot the graph
plot(type = 'l', x1, s1, col='black', xlab = '', ylab = 'Energy sub metering')
# add second line with red color
lines(x1, s2, col='red')
# add third line with blue color
lines(x1, s3, col='blue')
# add legends
legend("topright", pch = '__', col = c('black', 'red', 'blue'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))

# close the drawing device
dev.off()

