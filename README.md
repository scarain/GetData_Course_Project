# GetData_Course_Project
Getting and Cleaning Data - Course Project

This run_analysis.R file downloads data from website, then manipulates and cleans the data set to create an independent tidy data set with the average of the mean and standard deviation for each measurement for each activity and each subject.

Raw data is downloaded from url "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" as a zipfile, which is unziped in file path "./project".

Training set in file "train/X_train.txt", training labels (which labels the activity type) in file "train/y_train.txt" and training subjects who performed the activity for each window sample in file "train/subject_train.txt" are read into R and merged together by column to create a training data frame assigned to a variable named training.

Testing set in file "test/X_test.txt", testing labels (which labels the activity type) in file "test/y_test.txt" and testing subjects who performed the activity for each window sample in file "test/subject_test.txt" are read into R and merged together by column to create a testing data frame assigned to a variable named testing.

These two new data frames - training and testing - are merged by row to create a new data frame named dataset, which contains 561 measurements, activity labels and subject for each observation in both training and tesing set.

