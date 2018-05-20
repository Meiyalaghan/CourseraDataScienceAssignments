#TITLE: CourseraDataScienceAssignments\ - xploratoryDataAnalysis - Week1 - Course Project 1

#Generating plot 3
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

#Plot3

with(FilteredData, {
  plot(Sub_metering_1 ~ Set_DateTime, type = "l", 
       ylab = "Global Active Power (kilowatts)", xlab = "")
  lines(Sub_metering_2 ~ Set_DateTime, col = 'Red')
  lines(Sub_metering_3 ~ Set_DateTime, col = 'Blue')
}) 
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


# Save png file and close device that creates the PNG file
#--------------------------------------------------------
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()
