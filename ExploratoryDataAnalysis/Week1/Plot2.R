#TITLE: CourseraDataScienceAssignments\ - xploratoryDataAnalysis - Week1 - Course Project 1

#Generating plot 2
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

#Plot2


plot(FilteredData$Global_active_power ~ FilteredData$Set_DateTime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")


# Save png file and close device that creates the PNG file
#--------------------------------------------------------
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()

#Option2
###########

file<-"./data/household_power_consumption.txt"
data<-read.table(file,header=TRUE, sep=";")
data1<-subset(data,Date %in% c("1/2/2007","2/2/2007"))

datetime <- strptime(paste(data1$Date, data1$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
GlAcPw<-as.numeric(as.character(data1$Global_active_power))
png(file="plot 2.png")
plot(datetime,GlAcPw,type="l",xlab="",ylab="Global Active Power (kilowatts)")
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

datetime <- strptime(paste(subdataInit$Date, subdataInit$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

png("plot2.png", width=480, height=480)

plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()

#Option4
######

data_full <- read.csv("./data/household_power_consumption.txt", header=T, sep=';', na.strings="?", nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data1 <- subset(data_full, Date %in% c("1/2/2007","2/2/2007"))
data1$Date <- as.Date(data1$Date, format="%d/%m/%Y")
datetime <- paste(as.Date(data1$Date), data1$Time)
data1$Datetime <- as.POSIXct(datetime)
png("plot2.png", width=480, height=480)
## Plot 2
with(data1, {
  plot(Global_active_power~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
})
dev.off()