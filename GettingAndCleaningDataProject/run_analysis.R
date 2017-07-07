# Peer-graded Assignment: Getting and Cleaning Data Course Project - Coursera


##Check and create directory,if it doesn't already exists, to download the zip file
getwd()

if (!dir.exists("data")) {
  dir.create("data")
}
list.dirs()

setwd("./data")


## removing all objects from the environment
rm(list = ls(all = TRUE))

## loading require packages

library(plyr)
library(data.table)
library(dplyr) 


## Download the datafile if it doesn't already exists in the folder

filename <- "dataset.zip"

if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

list.files() # just to make sure the existence of downloaded file 

unzip(filename, list = TRUE) # to list a zip archive. This helps to choose the applicable data set



# Step 1 - Merges the training and the test sets to create one data set 
#============================================================================

datasetfile <- file.path(getwd(), filename)

#Load the test and train datasets
x_train <- read.table(unzip(datasetfile, "UCI HAR Dataset/train/X_train.txt"))
activities_train <- read.table(unzip(datasetfile, "UCI HAR Dataset/train/y_train.txt"))
subject_train <- read.table(unzip(datasetfile,"UCI HAR Dataset/train/subject_train.txt"))

x_test <- read.table(unzip(datasetfile, "UCI HAR Dataset/test/X_test.txt"))
activities_test <- read.table(unzip(datasetfile, "UCI HAR Dataset/test/y_test.txt"))
subject_test <- read.table(unzip(datasetfile, "UCI HAR Dataset/test/subject_test.txt"))

      
## makes one data.table for measurements data from a list of two data.tables i.e. x_train &  x_test 

x_data <- rbind(x_train, x_test)

## makes one 'data.table for activities data
activities_data <- rbind(activities_train, activities_test)

## makes one data.table for subject data
subject_data <- rbind(subject_train, subject_test)



# Step 2: Extract only the measurements on the mean and standard deviation for each measurement
#===================================================================================================

## Load the features dataset
features <- read.table(unzip(datasetfile, "UCI HAR Dataset/features.txt"))

## ensure feature names in the 2nd col as character vector before pattern matching
features[,2] <- as.character(features[,2])

## Extract each row that reflect a mean or standard deviation
wanted_features <- grep("-(mean|std)", features[,2])


## subset the wanted mean and standard deviation columns
  ##i.e.keeping only those columns which reflect a mean or standard deviation
x_data <- x_data[, wanted_features]


# Step 3: Use descriptive activity names to name the activities in the data set
#====================================================================================

## Load activity labels
activity_labels <- read.table(unzip(datasetfile, "UCI HAR Dataset/activity_labels.txt"))

## assign the right  activity labels to each value 
activities_data[, 1] <- activity_labels[activities_data[, 1], 2]

## set the name as "Activity"
names(activities_data) <- "Activity"


# Step 4: Appropriately label the data set with descriptive variable names
#===============================================================================

## list the extracted features names
wanted_features_names <- features[wanted_features,2]

  ## Replacement of all matches to look features names nicer
  wanted_features_names = gsub("-mean", "Mean", wanted_features_names)
  wanted_features_names = gsub("-std", "Std", wanted_features_names)
  wanted_features_names <- gsub("[-()]", "", wanted_features_names)

## label the columns which reflect a mean or standard deviation 
colnames(x_data) <- c(wanted_features_names)

# set the name as "Subject"
names(subject_data) <- "Subject"

## bind all the data set in a single data set. Note that last two columns are Activity & Subject
all_data <- cbind(x_data, activities_data, subject_data)


# Step 5: Create a second, independent tidy data set with the average of each variable for each activity and each subject
#==============================================================================================================================

## Split data frame by variables 'Subject' and 'Activity' then calculate average ((1-79 col measurement data) 
    #to each piece then combine results into a data frame
all_data_mean <- ddply(all_data, .(Subject, Activity), function(x) colMeans(x[, 1:79]))

## write the data output to a file
write.table(all_data_mean, "tidy_all_data_mean.txt", row.name=FALSE, quote = FALSE)


