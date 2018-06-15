# TITLE: CourseraDataScienceAssignments\ - ExploratoryDataAnalysis - Week4 
# Peer-graded Assignment: Course Project 2


#QUESTION2: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips=="24510") from 1999 to 2008?
# Use the base plotting system to make a plot answering this question.

rm(list=ls())

# Read data from .rds files

Emissions_Data <- readRDS("./data/summarySCC_PM25.rds")
Code_Table <- readRDS("./data/Source_Classification_Code.rds")

# Check loaded emission data

head(Emissions_Data)
str(Emissions_Data)


# look at the status of total emissions in the Baltimore City

Look_BaltimoreCity <- subset(Emissions_Data, fips == "24510")

png("Plot2.png")

TotalEmission_byYear <- tapply(Look_BaltimoreCity$Emissions, INDEX = Look_BaltimoreCity$year, FUN = sum)
plot(names(TotalEmission_byYear), TotalEmission_byYear,       
     type = "b", #both points and lines
     lty = "dotted",
     col = "blue", 
     lwd = 3, #line width of 3
     main = expression("Total PM2.5 emission in BaltimoreCity by year"),
     xlab = "Year",
     ylab = "Total PM2.5 emissions (tons)")

dev.off()