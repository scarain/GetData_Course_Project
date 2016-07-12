# GetData_Course_Project
Getting and Cleaning Data - Course Project

This run_analysis.R file downloads data from website, then manipulates and cleans the data set to create an independent tidy data set with the average of the mean and standard deviation for each measurement for each activity and each subject.

Raw data is downloaded from url "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" as a zipfile, which is unziped in directory "./project".

Training set in file "train/X_train.txt", training labels (which labels the activity type) in file "train/y_train.txt" and training subjects who performed the activity for each window sample in file "train/subject_train.txt" are read into R and merged together by column to create a training data frame assigned to a variable named training.

Testing set in file "test/X_test.txt", testing labels (which labels the activity type) in file "test/y_test.txt" and testing subjects who performed the activity for each window sample in file "test/subject_test.txt" are read into R and merged together by column to create a testing data frame assigned to a variable named testing.

These two new data frames - training and testing - are merged by row to create a new data frame named dataset, which contains 561 features' variables, activity labels and subject for each observation in both training and tesing set.

The names of 561 features are extracted from the second column of file "features.txt", and the last two columns are named "activity" and "subject".

To extract only the measurements on the mean and standard deviation for each measurement, only the columns with "mean()" or "std()" in their names are selected among the first 561 columns to construct the subset named subData. The last two columns of "activity" and "subject" are kept along with the selected columns to subData.

The raw data of activity variable is given as class labels from 1 to 6. To use descriptive activity names to name the activities, here I used the function factor to replace each label with its corresponding descriptive name as given in file "activity_labels.txt".

All "()" is removed, all abbreviations are replaced with their full names, all "-" are replaced with "_", and all words are seperated with "_" in the column names to appropriately label the data set subData with descriptive variable names.

At the end of script run_analysis.R, subData is grouped by two variables - "subject" and "activity", and mean value of each variable is calculated for each combination of "subject" and "activity" (meaning the average of feature measurement when a certain volunteer is performing one kind of activities). The grouped data is assigned to variable groupData, and written in a text file with file path "./project/group_data.txt"

The grouped data set can be read into R using following code:
data <- read.table("./project/group_data.txt", header = TRUE) 
View(data)
