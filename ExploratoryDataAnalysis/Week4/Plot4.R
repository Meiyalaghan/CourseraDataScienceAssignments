# TITLE: CourseraDataScienceAssignments\ - ExploratoryDataAnalysis - Week4 
# Peer-graded Assignment: Course Project 2

rm(list=ls())

# QUESTION4: 
# Across the United States, how have emissions from coal combustion-related
# sources changed from 1999–2008?

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



#look at  unique coal related in EI.Sector
unique(Source_Code$EI.Sector)

#filter df based on strings "Coal"
SourceCode_EI.Sector_Coal <- dplyr::filter(Source_Code, grepl("Coal", EI.Sector))

#Find coal combustion-related data that match to scc digit strings related to "coal" sources
EmissionsData_Coal <- Emissions_Data[which(Emissions_Data$SCC %in% SourceCode_EI.Sector_Coal$SCC), ]


png("Plot4.png", 600, 600)

EmissionsData_Coal %>% 
  na.omit() %>% 
  dplyr::select(Emissions, type, year) %>% 
  group_by(type, year) %>% 
  summarise_all(funs(sum)) %>% 
  ggplot(aes(x = year, y = Emissions)) +
  geom_line(aes(colour = type)) +
  geom_point(col = "black") +
  labs(x = "Year", y = "Total PM2.5emissions (tons)",
       title = expression("PM2.5 emissions in US from Coal combustion-related sources by tyoe and year"))
dev.off()

