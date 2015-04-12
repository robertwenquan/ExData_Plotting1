#!/usr/bin/R -f

library(dplyr)

data <- read.table(file='data/household_power_consumption.txt', sep=';', header=TRUE)

newdata <- mutate(data, Date = as.Date(Date, '%d/%m/%Y'))

filtered <- filter(newdata, Date == '2007-02-01' | Date == '2007-02-02')

png(filename='plot1.png', width=480, height=480)
hist(as.numeric(as.character(filtered$Global_active_power)), col = 'red', xlab = 'Global Active Power (kilowatts)', ylab = 'Frequency', main = 'Global Active Power')
dev.off()

