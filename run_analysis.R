library(dplyr)
library(tidyr)

# Download project data if it doesn't already exist
if (!file.exists("UCI HAR Dataset")) {
zip.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(zip.url, "HarDataset.zip")
    date.downloaded = Sys.Date()
    unzip("HarDataset.zip")
}

# Read in the data we need
activity <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")
subject.test <- read.table("UCI HAR Dataset/test/subject_test.txt")
x.test <- read.table("UCI HAR Dataset/test/X_test.txt")
y.test <- read.table("UCI HAR Dataset/test/Y_test.txt")
subject.train <- read.table("UCI HAR Dataset/train/subject_train.txt")
x.train <- read.table("UCI HAR Dataset/train/X_train.txt")
y.train <- read.table("UCI HAR Dataset/train/Y_train.txt")

# Create a data frame with a row for each sample
samples.count <- nrow(subject.test)+nrow(subject.train)
samples <- cbind(1:samples.count,
                     rbind(subject.test, subject.train),
                     rbind(y.test, y.train))
names(samples) <- c("id", "subject", "activity")
samples$activity <- factor(samples$activity, 
                              labels = as.character(activity[,2]))

# Create a data frame for each overall measurement, 
# include a reference to the column for mean and std
features.mean <- features[grep("mean()", features$V2, fixed=TRUE),]
features.std <- features[grep("std()", features$V2, fixed=TRUE),]
features.name <- gsub("-mean()", "", features.mean$V2, fixed=TRUE)
features.col <- data.frame(features.name, features.mean$V1, features.std$V1)
names(features.col) <- c("name", "mean", "std")

# Gather the mean values for each sample
#measurements <- gather(x.test, "feature", "mean", features.col$mean)
#unique(measurements$feature)
