# set working directory and download file
if (!file.exists("./project")) {dir.create("./project")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./project/run.zip")

# unzip the file
unzip("./project/run.zip", exdir = "./project")

# read data into R
train_x <- read.table("./project/UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("./project/UCI HAR Dataset/train/Y_train.txt")
train_subject <- read.table("./project/UCI HAR Dataset/train/subject_train.txt")
test_x <- read.table("./project/UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("./project/UCI HAR Dataset/test/Y_test.txt")
test_subject <- read.table("./project/UCI HAR Dataset/test/subject_test.txt")

# 1. Merges the training and the test sets to create one data set.
training <- cbind(train_x, train_y, train_subject)
testing <- cbind(test_x, test_y, test_subject)
dataset <- rbind(training, testing)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# add column names
names <- as.character(read.table("./project/UCI HAR Dataset/features.txt")[,2])
names <- c(names, "activity", "subject")
colnames(dataset) <- names

# search for key words "mean()" and "std()"
subNames <- c(grep("mean\\(\\)|std\\(\\)", names, value = TRUE), "activity", "subject")
subData <- subset(dataset, select = subNames)

# 3. Uses descriptive activity names to name the activities in the data set
activityLabel <- read.table("./project/UCI HAR Dataset/activity_labels.txt")
subData$activity <- factor(subData$activity, levels = activityLabel[,1], labels = activityLabel[,2])

# 4. Appropriately labels the data set with descriptive variable names
subNames <- gsub("\\(\\)", "", subNames)
subNames <- gsub("-", "_", subNames)
subNames <- gsub("^t", "Time_", subNames)
subNames <- gsub("^f", "Frequency_", subNames)
subNames <- gsub("Acc", "_Accelerometer", subNames)
subNames <- gsub("Gyro", "_Gyroscope", subNames)
subNames <- gsub("Mag", "_Magnitude", subNames)
subNames <- gsub("Jerk", "_Jerk", subNames)
subNames <- gsub("BodyBody", "Body", subNames)

colnames(subData) <- subNames

# 5. From the data set in step 4, creates a second, independent tidy data set with the average 
# of each variable for each activity and each subject
library(dplyr)
groupData <- subData %>%
  group_by(subject, activity) %>%
  summarise_each(funs(mean))
write.table(groupData, file = "./project/group_data.txt")