# Load data from the source files
test_data <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
test_labels <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
train_data <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
train_labels <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
features <- read.table("./data/UCI HAR Dataset/features.txt")
activities <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
test_subjects <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
train_subjects <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")


# 3. Use descriptive activity names to name the activities in the data set

library(plyr)
test_labels <- merge (test_labels, activities, by.x="V1", by.y="V1")
train_labels <- merge (train_labels, activities, by.x="V1", by.y="V1")

for (i in 1:nrow(activities)){
test_labels <- gsub(i, activities[i, 2], test_labels)
train_labels <- gsub(i, activities[i, 2], train_labels)
}

# 1. Merge the training and the test sets to into one data set
# 1.1 Merge activities
  test_data <- cbind(test_data, test_labels)  
  train_data <- cbind(train_data, train_labels)  

# 1.2 Merge subjects
  test_data <- cbind(test_data, test_subjects)  # NB! need to fix the name of the last column
  train_data <- cbind(train_data, train_subjects) # NB! need to fix the name of the last column 
# 1.3 Rename two last columns
  names(test_data)[562] <- "activities"
  names(train_data)[562] <- "activities"
  names(test_data)[563] <- "subjects"
  names(train_data)[563] <- "subjects"
  
all_data <- rbind (test_data, train_data)

# 4. Appropriately label the data set with descriptive variable names.

  columns <- as.character(features$V2)
  columns <- c(columns, "activity", "subject") # not to forget the activity variable
  colnames(all_data) <- columns

# 2. Extract only the measurements on the mean and standard deviation for each measurement

means <-  grep("mean()", columns)
stds <- grep("std()", columns)

mean_data <- all_data[, means]
std_data <- all_data[, stds]
activity_data <- all_data[,"activity"]
subject_data <- all_data[,"subject"]
mean_std_data <- cbind(mean_data, std_data, activity_data, subject_data)

print (head(mean_std_data, n = 2))

# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

dfMelt <- melt(mean_std_data, id=c("activity_data", "subject_data"), measure.vars = c(1:79))
dfCast <- dcast(dfMelt, activity_data + subject_data ~ variable, mean)






