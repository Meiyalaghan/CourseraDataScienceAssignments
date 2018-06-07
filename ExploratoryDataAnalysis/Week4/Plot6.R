# TITLE: CourseraDataScienceAssignments\ - ExploratoryDataAnalysis - Week4 
# Peer-graded Assignment: Course Project 2



# QUESTION6: 
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
# in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

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

head(Emissions_Data)
head(Source_Code)

#filter df based on strings "Vehicles"
SourceCode_Vehicles <- dplyr::filter(Source_Code, grepl("Vehicles", EI.Sector))

#look at Vehicles related in EI.Sector
unique(SourceCode_Vehicles$EI.Sector)



#Find the emissions due to motor vehicles
EmissionsData_Vehicle <- Emissions_Data[which(Emissions_Data$SCC %in% SourceCode_Vehicles$SCC), ]

#check
head(EmissionsData_Vehicle)

png("Plot6.png", 600, 600)

EmissionsData_Vehicle %>% 
  subset(fips=="24510" | fips=="06037") %>% #find in Baltimore City & Los Angeles County, California
  na.omit() %>%  
  mutate(county=factor(fips)) %>% #make variable 'fips'  under the name of 'county' with factor level
  mutate(county = factor(county, levels=c("24510", "06037"),
                       labels=c("Baltimore City","Los Angeles County")))  %>% #rename the factor levels
  dplyr::select(Emissions, county, year) %>% 
  group_by(county, year) %>% 
  summarise_all(funs(sum)) %>% 
  ggplot(aes(x = year, y = Emissions)) +
  geom_line(aes(colour = county)) +
     scale_color_manual(values = c("Baltimore City" = "red", "Los Angeles County" = "blue")) +
  geom_point(col = "black") +
  labs (x = "Year", y = "Total PM2.5emissions (tons)",
       title = expression(bold("Comparision of PM2.5 emissions from motor vehicles between two cities")))

dev.off()
