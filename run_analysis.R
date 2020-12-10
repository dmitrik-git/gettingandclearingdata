# Load original data from the source files
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


# 1. Merge the training and the test sets to into one data set
# 1.1 Merge activities
  test_data <- cbind(test_data, test_labels)  
  train_data <- cbind(train_data, train_labels)  

# 1.2 Merge subjects
  test_data <- cbind(test_data, test_subjects)
  train_data <- cbind(train_data, train_subjects)

  # 1.3 Rename two last columns. This is needed to avoid variable name conflict when doing rbind later
  names(test_data)[563] <- "activity"
  names(train_data)[563] <- "activity"
  names(test_data)[564] <- "subject"
  names(train_data)[564] <- "subject"
  
all_data <- rbind (test_data, train_data)

# 4. Appropriately label the data set with descriptive variable names.

  columns <- as.character(features$V2)
  columns <- c(columns, "activity.id", "activity", "subject") # all feature variables plus newly merged
  colnames(all_data) <- columns # rename the columns

# 2. Extract only the measurements on the mean and standard deviation for each measurement

means <-  grep("mean()", columns)
stds <- grep("std()", columns)

mean_data <- all_data[, means]
std_data <- all_data[, stds]
activity_data <- all_data[,"activity"]
subject_data <- all_data[,"subject"]
mean_std_data <- cbind(mean_data, std_data, activity_data, subject_data)

# 2.1 Rename the activity and subject columns
  library(plyr)
  mean_std_data <- rename(mean_std_data, c("activity_data" = "activity", "subject_data" = "subject"))
  

# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

library(reshape2)
dfMelt <- melt(mean_std_data, id=c("activity", "subject"), measure.vars = c(1:length(means)+length(stds)))
mean_summary <- dcast(dfMelt, activity_data + subject_data ~ variable, mean)






