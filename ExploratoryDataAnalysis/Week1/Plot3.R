#TITLE: CourseraDataScienceAssignments\ - xploratoryDataAnalysis - Week1 - Course Project 1

#Generating plot 3
##################################################
#first remove all objects from the environment
rm(list=ls())

#load the required library 
library(data.table)

#load file
FileGetDir <- "./Data/"


AllData <- fread(paste0(FileGetDir,"household_power_consumption.txt"), header=T, sep=";", na.strings="?")

## Filter data based on date 
FilteredData <- AllData[AllData$Date %in% c("1/2/2007","2/2/2007"), ]


#check variables class
sapply(FilteredData, class)


#convert the Date and Time variables to Date/Time classes 

## Converting dates

Set_DateTime <- strptime(paste(FilteredData$Date, FilteredData$Time, sep=" "),"%d/%m/%Y %H:%M:%S")


#Plot3

Sub_met1 <- as.numeric(FilteredData$Sub_metering_1)
Sub_met2 <- as.numeric(FilteredData$Sub_metering_2)
Sub_met3 <- as.numeric(FilteredData$Sub_metering_3)

png(file="Plot3.png")

plot(Set_DateTime, Sub_met1, type="l", xlab = "", ylab="Energy sub metering")
lines(Set_DateTime, Sub_met2, type="l", col = "red")
lines(Set_DateTime, Sub_met3, type="l", col = "blue")


legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

dev.off()

