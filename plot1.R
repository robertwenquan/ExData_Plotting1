#!/usr/bin/R -f
#
# R script for Exploratory Data Analysis course project
#
# Robert Wen (robert.wen@nyu.edu)
#

library(dplyr)

# load the data
data <- read.table(file='data/household_power_consumption.txt', sep=';', header=TRUE)

# preare and filter the data
newdata <- mutate(data, Date = as.Date(Date, '%d/%m/%Y'))
filtered <- filter(newdata, Date == '2007-02-01' | Date == '2007-02-02')

# open drawing device
png(filename='plot1.png', width=480, height=480, bg = "transparent")

# plot the histogram
hist(as.numeric(as.character(filtered$Global_active_power)), col = 'red', xlab = 'Global Active Power (kilowatts)', ylab = 'Frequency', main = 'Global Active Power')

# close the drawing device
dev.off()

