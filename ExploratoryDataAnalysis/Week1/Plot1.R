#TITLE: CourseraDataScienceAssignments\ - xploratoryDataAnalysis - Week1 - Course Project 1

#Generating plot 1
##################################################
#first remove all objects from the environment
rm(list=ls())

#load the required library 
library(data.table)

#load file
FileGetDir <- "C:/CourseraDataScienceAssignments/Data/"

AllData <- fread(paste0(FileGetDir,"household_power_consumption.txt"), header=T, sep=";", na.strings="?")

## Filter data based on date 
FilteredData <- AllData[AllData$Date %in% c("1/2/2007","2/2/2007"), ]


#check variables class
sapply(FilteredData, class)


#convert the Date and Time variables to Date/Time classes 

## Converting dates

Set_DateTime <- strptime(paste(FilteredData$Date, FilteredData$Time, sep=" "),"%d/%m/%Y %H:%M:%S")

FilteredData <- cbind(Set_DateTime, FilteredData)

#Plot1

hist(FilteredData$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")


# Save png file and close device that creates the PNG file
#--------------------------------------------------------
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()
