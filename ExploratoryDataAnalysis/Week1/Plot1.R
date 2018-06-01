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

#Option 2
file<-"./data/household_power_consumption.txt"
data<-read.table(file,header=TRUE, sep=";")
data1<-subset(data,Date %in% c("1/2/2007","2/2/2007"))
GlAcPw<-as.numeric(as.character(data1$Global_active_power))
png(file="plot 1.png")
hist(GlAcPw,col="red",main="Global Active Power", xlab="Global Active power (kilowatts)", ylab="Frequency")
dev.off()


#Option3
#####################
#Data File Path
dataFile <- "./data/household_power_consumption.txt"

#Read Data
dataInit <- read.table(dataFile, header= TRUE,stringsAsFactors = FALSE, sep =";" )

#Select only data from the dates 2007-02-01 and 2007-02-02
subdataInit <- subset(dataInit,dataInit$Date=="1/2/2007" | dataInit$Date =="2/2/2007")

#Convert Global_active_power column data to numeric
globalActivePower <- as.numeric(subdataInit$Global_active_power)

png("plot1.png", width=480, height=480)

hist(globalActivePower, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

dev.off()

