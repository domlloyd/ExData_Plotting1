# This R programme has been created by Dominic Lloyd
# as part of the Coursera Module - Exploratory Data Analysis - August 2015

# It takes a raw data set of Individual Houselhold Electric Power Consumption
# from the UC Irvine Machine Learning Repository
# It then only takes the consumption for 2007-02-01 and 2007-02-02 (2 days)

# This is the link to download the dataset
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

# This link describes how the dataset was produced
# http://archive.ics.uci.edu/ml


# This script uses:
# - the "readr" library for fast reading of files using read_table
library("readr")

# the raw data has been unzipped to our RProject directory
# We setwd to the project directory we have forked. 
# NB If running this program make sure the raw data file
# household_power_consumption.txt hs been unzipped and put in to the
# working directory shown below.

setwd("..//ExData_Plotting1")


# clear the workspace - I do this for ease of seeing which variables have been generated. 
rm(list=ls())

# read the household power consumption data
consumption_obs_all <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

# convert Date field from chr to POSIXlt
consumption_obs_all$Date <- strptime(consumption_obs_all$Date,'%d/%m/%Y')

# select only the dates we need - 2007-02-01 and 2007-02-02
consumption_obs_req <- consumption_obs_all[which(consumption_obs_all$Date == '2007-02-01' 
                                                 | consumption_obs_all$Date == '2007-02-02'), ]  

png(filename = 'plot4.png', width = 480, height = 480)

# use the par function to create a 2x2 grid to hold the 4 charts
par(mfcol = c(2,2))

# do the first chart (top left)

# x access needs to be timestamp to give time in day plotting
# join date to time to give YYYY-MM-DD HH:MM:SS
# then use strptime to put it in the correct posixlt format
date_time <- paste(consumption_obs_req$Date, consumption_obs_req$Time)
x <- strptime(date_time, '%Y-%m-%d %H:%M:%S')

# get y access of Global Active Power as a numeric
y <- as.numeric(consumption_obs_req$Global_active_power)
plot(x, y, type = 'l', ylab = 'Global Active Power', xlab = '')


# do the second chart (bottom left)
# x access is same as first chart above

# get y access of Sub metering 1, 2 and 3 to y1, y2, y3
y1 <- as.numeric(consumption_obs_req$Sub_metering_1)
y2 <- as.numeric(consumption_obs_req$Sub_metering_2)
y3 <- as.numeric(consumption_obs_req$Sub_metering_3)


# plot the line chart as required by the assignment, do y1 first followed by y2,y3
plot(x, y1, type = 'S', ylab = 'Energy sub metering', xlab = '')
lines(x, y2, type = 'S', col = 'red')
lines(x, y3, type = 'S', col = 'blue')

# add a legend (with no outline box)
legend_text <- c('Sub_metering_1', 'Sub_Metering_2', 'Sub_Metering_3')
legend_colours <- c('black', 'red', 'blue')
legend('topright', legend = legend_text, col = legend_colours, lty = 1, bty = 'n')


# do the third chart (top right)
# x access is same as first chart above
y <- as.numeric(consumption_obs_req$Voltage)
plot(x, y, type = 'l', xlab = 'datetime', ylab = 'Voltage')


# do the fourth chart (bottom right)
# x access is same as first chart above
y <- as.numeric(consumption_obs_req$Global_reactive_power)
plot(x, y, type = 'l', xlab = 'datetime', ylab = 'Global_reactive_power')



# close the png file after writing
dev.off()
 
