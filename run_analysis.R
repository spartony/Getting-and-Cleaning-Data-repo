# Source of data for this project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# This R script does the following:

# Download the zip file from the given URL in your work directory and unzip its content in a directory
# called "./UCI HAR Dataset"
fileURL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
localZipFile <- "./getdata-projectfiles-UCI-HAR-Dataset.zip"
dirFile <- "./UCI HAR Dataset"

# if not in your wd, it download the dataset (. ZIP)
if (file.exists(localZipFile) == FALSE) {
    download.file(fileURL, destfile = localZipFile)
}

# check if UCI HAR Dataset direcotry exists, if not it Uncompress the zip file in this directory
if (file.exists(dirFile) == FALSE) {
    unzip(localZipFile)
}


# 1. Merges the training and the test sets to create one data set.

tmp1 <- read.table("UCI HAR Dataset/train/X_train.txt")
tmp2 <- read.table("UCI HAR Dataset/test/X_test.txt")
X <- rbind(tmp1, tmp2)

tmp1 <- read.table("UCI HAR Dataset/train/subject_train.txt")
tmp2 <- read.table("UCI HAR Dataset/test/subject_test.txt")
S <- rbind(tmp1, tmp2)

tmp1 <- read.table("UCI HAR Dataset/train/y_train.txt")
tmp2 <- read.table("UCI HAR Dataset/test/y_test.txt")
Y <- rbind(tmp1, tmp2)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# Read features labels
features <- read.table("UCI HAR Dataset/features.txt")
# Search for matches to argument mean or standard deviation (sd)  within each element of character vector
indexFeatures <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
X <- X[, indexFeatures]
names(X) <- features[indexFeatures, 2]
# Replaces all matches of a string features 
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))

# 3. Uses descriptive activity names to name the activities in the data set.
# 4. Appropriately labels the data set with descriptive variable names. 
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
Y[,1] = activities[Y[,1], 2]
names(Y) <- "activity"
names(S) <- "subject"

# Combines data table by columns
cleaned <- cbind(S, Y, X)
#write.table(cleaned, "merged_clean_data.txt")

# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.

    p <- cleaned[, 3:dim(cleaned)[2]] 
result <- aggregate(p,list(cleaned$subject, cleaned$activity), mean)

# Activity and Subject name of columns 
names(result)[1] <- "subject"
names(result)[2] <- "activity"

result <-result[order(result$subject),]

write.table(result, "tidy_data_set_with_averages.txt", row.name=FALSE)
