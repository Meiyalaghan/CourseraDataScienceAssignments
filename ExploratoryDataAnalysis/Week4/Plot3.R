# TITLE: CourseraDataScienceAssignments\ - ExploratoryDataAnalysis - Week4 
# Peer-graded Assignment: Course Project 2

#QUESTION3
#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
#Which have seen increases in emissions from 1999–2008? 
#Use the ggplot2 plotting system to make a plot answer this question.

rm(list=ls())

## load required libraries 
library(ggplot2)
library(magrittr) #required to use the pipe (%>%) operator
library(plyr)
library(dplyr)
library(tidyr)
library(data.table)


# Read data from .rds file
Emissions_Data <- readRDS("./data/summarySCC_PM25.rds")

# Check loaded emission data

head(Emissions_Data)
str(Emissions_Data)

# Plot the total PM2.5 for Baltimor City, Maryland separately for each type of source


png("Plot3.png")

Emissions_Data %>% 
  subset(fips=="24510") %>% 
  na.omit() %>% 
  dplyr::select(Emissions, type, year) %>% 
  group_by(type, year) %>% 
  summarise_all(funs(sum)) %>% 
  ggplot(aes(x = year, y = Emissions)) +
  geom_line(aes(colour = type)) +
  geom_point(col = "black") +
  labs(x = "Year", y = "Total PM2.5 emissions (tons)",
       title = expression('Total PM2.5 emission in Baltimor City - Maryland'))

dev.off()