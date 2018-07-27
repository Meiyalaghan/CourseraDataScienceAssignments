# TITLE: CourseraDataScienceAssignments\ - ExploratoryDataAnalysis - Week4 
# Peer-graded Assignment: Course Project 2

#QUESTION 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008

rm(list=ls())

# Read data from .rds files

Emissions_Data <- readRDS("./data/summarySCC_PM25.rds")
Code_Table <- readRDS("./data/Source_Classification_Code.rds")

# Check loaded emission data

head(Emissions_Data)
str(Emissions_Data)
range(Emissions_Data$year)
unique(Emissions_Data$year)



png("Plot1.png")

TotalEmission_byYear <- tapply(Emissions_Data$Emissions, INDEX = Emissions_Data$year, FUN = sum)
plot(names(TotalEmission_byYear), TotalEmission_byYear,       
   type = "b", #both points and lines
          lty = "dotted",
          col = "blue", 
          lwd = 3, #line width of 3
          main = expression("Total PM2.5 emission in US by year"),
          xlab = "Year",
          ylab = "Total PM2.5 emissions (tons)")

dev.off()

