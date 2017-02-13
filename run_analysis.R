# run_analysis.R
library(dplyr)

#download files
Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
Zip <- "UCI HAR Dataset.zip"

if (!file.exists(Zip)) {
  download.file(Url, Zip, mode = "wb")
}

# unzip zip file containing data if data directory doesn't already exist
data <- "UCI HAR Dataset"
if (!file.exists(data)) {
  unzip(Zip)
}

###step 1
### Merge the training and the test sets to create one data set.

# read train data
subjects_train <- read.table(file.path(data, "train", "subject_train.txt"))
x_train <- read.table(file.path(data, "train", "X_train.txt"))
y_train <- read.table(file.path(data, "train", "y_train.txt"))

# read test data
subjects_test <- read.table(file.path(data, "test", "subject_test.txt"))
x_test <- read.table(file.path(data, "test", "X_test.txt"))
y_test <- read.table(file.path(data, "test", "y_test.txt"))


x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
subjects <- rbind(subjects_train, subjects_test)


###step 2 
###Extract only the measurements on the mean and standard deviation for each measurement
# read features
features <- read.table(file.path(data,  "features.txt")) 

# get only columns with mean() or std() in their names
need_features <- grep("-(mean|std)\\(\\)", features[, 2])

# subset need columns
x<-x[, need_features]

#set column names
names(x) <- features[need_features, 2]



###step3 
###Use descriptive activity names to name the activities in the data set

# read activity
activities <- read.table(file.path(data, "activity_labels.txt"))
# update activity names
y[, 1] <- activities[y[, 1], 2]

#set column name
names(y) <- "activity"
names(subjects) <- "subject"


### step 4
### Appropriately label the data set with descriptive variable names

result<-cbind(x,y,subjects)


### step 5
### Create a second, independent tidy data set with the average of each variable for each activity and each subject

result2<-aggregate(. ~subject + activity, result, mean)
write.table(result2, file = "tidydata.txt",row.name=FALSE)
