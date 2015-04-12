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
selected <- mutate(filtered, Date = paste(as.character(Date), Time), Global_active_power=as.numeric(as.character(Global_active_power))) %>% select(Date, Global_active_power)

x1 <- strptime(selected$Date, "%Y-%m-%d %H:%M:%S")
x2 <- selected$Global_active_power

# open drawing device
png(filename='plot2.png', width=480, height=480, bg = "transparent")

# plot the graph
plot(type='l', x1, x2, xlab = '', ylab = 'Global Active Power (kilowatts)')

# close the drawing device
dev.off()

