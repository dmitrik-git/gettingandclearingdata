# Load data from the source files
test_data <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
test_labels <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
train_data <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
train_labels <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
features <- read.table("./data/UCI HAR Dataset/features.txt")
activities <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
# test_subjects <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")


# 3. Use descriptive activity names to name the activities in the data set

for (i in 1:nrow(activities)){
test_labels <- gsub(i, activities[i, 2], test_labels)
train_labels <- gsub(i, activities[i, 2], train_labels)
}

# 1. Merge the training and the test sets to into one data set
# 1.1 Merge activities
  test_data <- cbind(test_data, test_labels)  
  train_data <- cbind(train_data, train_labels)  

all_data <- rbind (test_data, train_data)

# 4. Appropriately label the data set with descriptive variable names.

  columns <- as.character(features$V2)
  columns <- c(columns, "activity") # not to forget the activity variable
  colnames(all_data) <- columns

# 2. Extract only the measurements on the mean and standard deviation for each measurement
  
means <-  grep("mean()", columns)
stds <- grep("std()", columns)

mean_data <- all_data[, means]
std_data <- all_data[, stds]
activity_data <- all_data[,"activity"]
mean_std_data <- cbind(mean_data, std_data, activity_data)

# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.








