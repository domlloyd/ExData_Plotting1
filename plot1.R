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
# - the "dplyr" library for selecting from the data set
# - the "readr" library for fast reading of files using read_table
# - the "ggplot2" library for plotting graphs
# library("dplyr")
library("readr")
# library("ggplot2")

# the raw data has been unzipped to our RProject directory
# We sill setwd to the project directory we have forked. 
# NB our working directory sits one level up from our R working directory
setwd("..//ExData_Plotting1")
# If running this program make sure the raw data file
# household_power_consumption.txt hs been unzipped and put in to the
# working directory shown above.

# clear the workspace
rm(list=ls())


consumption_obs_all <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

# convert Date field from chr to POSIXlt
consumption_obs_all$Date <- strptime(consumption_obs_all$Date,'%d/%m/%Y')

# select only the dates we need
consumption_obs_req <- consumption_obs_all[which(consumption_obs_all$Date == '2007-02-01' 
                                                 | consumption_obs_all$Date == '2007-02-02'), ]  

# open the png file
png(filename = 'plot1.png', width = 480, height = 480)
# plot the histogram
hist(as.numeric(consumption_obs_req$Global_active_power), col='red', main='Global Active Power',
        xlab = 'Global Active Power (kilowatts)')
# close the device
dev.off()
 
