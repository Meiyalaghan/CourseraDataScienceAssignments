# TITLE: CourseraDataScienceAssignments\ - ExploratoryDataAnalysis - Week4 
# Peer-graded Assignment: Course Project 2



# QUESTION5: 
#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

rm(list=ls())

#load required libraries
library(ggplot2)
library(magrittr) #required to use the pipe (%>%) operator
library(plyr)
library(dplyr)
library(tidyr)
library(data.table)

# Read data from .rds files
Emissions_Data <- readRDS("./data/summarySCC_PM25.rds")
Source_Code <- readRDS("./data/Source_Classification_Code.rds")


#check loaded data
head(Source_Code)
head(Emissions_Data)


#filter df based on strings "Vehicles"
SourceCode_Vehicles <- dplyr::filter(Source_Code, grepl("Vehicles", EI.Sector))

#look at Vehicles related in EI.Sector
unique(SourceCode_Vehicles$EI.Sector)



#Find the emissions due to motor vehicles
EmissionsData_Vehicle <- Emissions_Data[which(Emissions_Data$SCC %in% SourceCode_Vehicles$SCC), ]


png("Plot5.png", 600, 600)

EmissionsData_Vehicle %>% 
  subset(fips=="24510") %>% #find the emissions due to motor vehicles in Baltimore City
  na.omit() %>%  
  dplyr::select(Emissions, year) %>% 
  group_by(year) %>% 
  summarise_all(funs(sum)) %>% 
  ggplot(aes(x = year, y = Emissions)) +
  geom_line()+
  geom_point(col = "black") +
  labs(x = "Year", y = "Total PM2.5emissions (tons)",
       title = expression("PM2.5 emissions by motor vehicles in Baltimore City"))

dev.off()

