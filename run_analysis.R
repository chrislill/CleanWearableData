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

# Create a data frame table with a row for each sample
samples.count <- nrow(subject.test)+nrow(subject.train)
samples <- tbl_df(cbind(1:samples.count,
                        rbind(subject.test, subject.train),
                        rbind(y.test, y.train)))
names(samples) <- c("id", "subject", "activity")
samples$activity <- factor(samples$activity, 
                              labels = as.character(activity[,2]))

# Create a data frame for each overall measurement, 
# include a reference to the column for mean and std
features.mean <- features[grep("mean()", features$V2, fixed=TRUE),]
features.std <- features[grep("std()", features$V2, fixed=TRUE),]
features.name <- gsub("-mean()", "", features.mean$V2, fixed=TRUE)
features.col <- data.frame(name = features.name, 
                           mean = features.mean$V1, 
                           std = features.std$V1)

# Create a wide data sets for mean and std
x.mean <- rbind(x.test[, features.col$mean], x.train[, features.col$mean])
x.std <- rbind(x.test[, features.col$std], x.train[, features.col$std])
names(x.mean) <- features.col$name
names(x.std) <- features.col$name

# Join the samples and x.mean datasets, and then gather the measurements
samples <- cbind(samples, x.mean)
measurements <- gather(samples, "measure", "mean", -(id:activity))

# Gather the std measurements, and then join to the main dataset
measurements.std <- gather(x.std, "measure", "std")
measurements <- cbind(measurements, std = measurements.std$std)

# Produce the averages of each measure grouped by activity and subject
averages <- measurements %>%
    group_by(activity, subject, measure) %>%
    summarise(average.mean = mean(mean), average.std = mean(std)) 

# Write the data set out as a text file
write.table(averages, "averages.txt", row.name=FALSE)



