#TITLE: CourseraDataScienceAssignments\ - xploratoryDataAnalysis - Week1 - Course Project 1

#Generating plot 4
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

#Plot4

par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(FilteredData, {
  plot(Global_active_power ~ Set_DateTime, type = "l", ylab = "Global Active Power", xlab = "")
  plot(Voltage ~ Set_DateTime, type = "l", ylab = "Voltage", xlab = "datetime")
  plot(Sub_metering_1 ~ Set_DateTime, type = "l", ylab = "Energy sub metering", xlab = "")
  lines(Sub_metering_2 ~ Set_DateTime, col = 'Red')
  lines(Sub_metering_3 ~ Set_DateTime, col = 'Blue')
  legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
         bty = "n",
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power ~ Set_DateTime, type = "l", 
       ylab = "Global_rective_power", xlab = "datetime")
})

# Save png file and close device that creates the PNG file
#--------------------------------------------------------
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()


#Option2

file<-"./data/household_power_consumption.txt"
data<-read.table(file,header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
data1<-subset(data,Date %in% c("1/2/2007","2/2/2007"))

datetime <- strptime(paste(data1$Date, data1$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
GlAcPw<-as.numeric(as.character(data1$Global_active_power))
Sub1<-as.numeric(data1$Sub_metering_1)
Sub2<-as.numeric(data1$Sub_metering_2)
Sub3<-as.numeric(data1$Sub_metering_3)
Voltage<-as.numeric(as.character(data1$Voltage))
Global_reactive_power<-as.numeric(as.character(data1$Global_reactive_power))

png(file="plot 4.png")
par(mfrow=c(2,2))
plot(datetime,GlAcPw,type="l",xlab="",ylab="Global Active Power")
plot(datetime,Voltage,type="l",xlab="datetime",ylab="Voltage") 
plot(datetime,Sub1,type="l",xlab="",ylab="Energy sub metering")
lines(datetime,Sub2,type="l",col="red")
lines(datetime,Sub3,type="l",col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2,bty="n", col=c("black", "red", "blue")) 
plot(datetime,Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")

dev.off()


#Option3

data<-read.table("household_power_consumption.txt",sep=";",header=TRUE,colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),na.strings="?")
data$Date<-as.Date(data$Date,"%d/%m/%Y")
dataPlot<-data[data$Date%in%as.Date(c("2007-02-01","2007-02-02")),]
dataPlot$datetime<-strptime(paste(dataPlot$Date, dataPlot$Time), "%Y-%m-%d %H:%M:%S")

# 4 graphs in 2 rows and 2 cols
par(mfrow=c(2,2),mar=c(4,4,2,1),oma=c(0,0,2,0))

# time series graph of Global active power
plot(dataPlot$datetime,dataPlot$Global_active_power,type="n",xlab=NA,ylab="Global Active Power") 
lines(dataPlot$datetime,dataPlot$Global_active_power)

# time series graph of Voltage
plot(dataPlot$datetime,dataPlot$Voltage,type="n",xlab="datetime",ylab="Voltage") 
lines(dataPlot$datetime,dataPlot$Voltage)

# time series graph of Energy sub metering
plot(dataPlot$datetime,dataPlot$Sub_metering_1,type="n",xlab=NA,ylab="Energy sub metering")
lines(dataPlot$datetime,dataPlot$Sub_metering_1,col="black")
lines(dataPlot$datetime,dataPlot$Sub_metering_2,col="red")
lines(dataPlot$datetime,dataPlot$Sub_metering_3,col="blue")
legend("topright",lty=1,bty="n",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# time series graph of Global reactive power
plot(dataPlot$datetime,dataPlot$Global_reactive_power,type="n",xlab="datetime",ylab="Global_reactive_power") 
lines(dataPlot$datetime,dataPlot$Global_reactive_power)

# save plot to png file
dev.copy(png,file="plot4.png")
dev.off()


#Option3
#####################

#Data File Path
dataFile <- "./data/household_power_consumption.txt"

#Read Data
dataInit <- read.table(dataFile, header= TRUE,stringsAsFactors = FALSE, sep =";" )

#Select only data from the dates 2007-02-01 and 2007-02-02
subdataInit <- subset(dataInit,dataInit$Date=="1/2/2007" | dataInit$Date =="2/2/2007")

datetime <- strptime(paste(subdataInit$Date, subdataInit$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

#Convert to numeric
global_Active_Power <- as.numeric(subdataInit$Global_active_power)
global_Reactive_Power <- as.numeric(subdataInit$Global_reactive_power)
voltage <- as.numeric(subdataInit$Voltage)

#Convert to numeric
sub_Metering1 <- as.numeric(subdataInit$Sub_metering_1)
sub_Metering2 <- as.numeric(subdataInit$Sub_metering_2)
sub_Metering3 <- as.numeric(subdataInit$Sub_metering_3)

#plot Data
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

plot(datetime, global_Active_Power, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")

plot(datetime, sub_Metering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, sub_Metering2, type="l", col="red")
lines(datetime, sub_Metering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(datetime, global_Reactive_Power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()


