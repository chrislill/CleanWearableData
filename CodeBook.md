# Getting and Cleaning Data - Course Project
## Introduction
This script produces a summary of the Human Activity Recognition Using Smartphones Dataset. It calculates the mean and standard deviation values for 33 different variables derived from this data, averaging them for each activity and each subject. 

It is a submission for a getting and cleaning data course project on Coursera. 

The original dataset is described in the following publication:
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Code Book
### activity
The activity that the subject was performing during this measurement.

1. WALKING
1. WALKING_UPSTAIRS
1. WALKING_DOWNSTAIRS
1. SITTING
1. STANDING
1. LAYING

### subject
Integer Id for the person performing the activity. There are 30 subjects.

### measure
The type of measurement derived from the smartphone sensor data.

1. tBodyAcc1.X
1. tBodyAcc1.Y
1. tBodyAcc1.Z
1. tGravityAcc1.X
1. tGravityAcc1.Y
1. tGravityAcc1.Z
1. tBodyAccJerk1.X
1. tBodyAccJerk1.Y
1. tBodyAccJerk1.Z
1. tBodyGyro1.X
1. tBodyGyro1.Y
1. tBodyGyro1.Z
1. tBodyGyroJerk1.X
1. tBodyGyroJerk1.Y
1. tBodyGyroJerk1.Z
1. tBodyAccMag
1. tGravityAccMag
1. tBodyAccJerkMag
1. tBodyGyroMag
1. tBodyGyroJerkMag
1. fBodyAcc1.X
1. fBodyAcc1.Y
1. fBodyAcc1.Z
1. fBodyAccJerk1.X
1. fBodyAccJerk1.Y
1. fBodyAccJerk1.Z
1. fBodyGyro1.X
1. fBodyGyro1.Y
1. fBodyGyro1.Z
1. fBodyAccMag
1. fBodyBodyAccJerkMag
1. fBodyBodyGyroMag
1. fBodyBodyGyroJerkMag

### average.mean
The mean of this measure for each activity and each subject. These values are normalized and bounded within [-1,1].

### average.std
The mean of the standard deviation of this measure for each activity and each subject. These values are normalized and bounded within [-1,1].

## Modifications to DataSet
Production of this summary dataset followed these high level steps:

1. Load the data
1. Merge the test and training data sets
1. Produce summary data for each sample - id, subject and activity
1. Select the columns in the original data corresponding to mean or standard deviation measurements
1. Gather values together for the mean and standard deviation of each measurement for each sample. This is produced in a long dataset with a separate row for each measurement
1. Average the mean and standard deviation values for each activity and each subject.
1. Write the file as a table to averages.txt

To open the data in R, use `read.table("averages.txt")`

## Study Design
This information is copied from the original dataset at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
