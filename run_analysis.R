
# ------------------------- 1. MERGING TRAIN AND TEST DATASET --------------------------------------

## Assigning data frames for x_train, y_train, x_test, y_test, sub_train, sub_test and features list.

x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

feature <- read.table("UCI HAR Dataset/features.txt")
#head(feature)

## Assigning columm names for the unknown column data
colnames(x_train) <- feature[,2]
colnames(x_test)  <- feature[,2]
colnames(y_train) <- c("actID")
colnames(y_test) <- c("actID")
#colnames(x_train)

colnames(subject_train) <- c("subID")
colnames(subject_test) <- c("subID")
#head(subject_test)

activity <- read.table("UCI HAR Dataset/activity_labels.txt")
colnames(activity) <- c('actID','actLabel')

## Merging train and test dataset
merged_train <- cbind(x_train, subject_train, y_train)
#head(merged_train)

merged_test <- cbind(x_test, subject_test, y_test)
#head(merged_test)

entire_data <- rbind(merged_train, merged_test)


# ------------------------- 2. EXTRACTING MEAN AND STANDARD DEVIATION ---------------------------
colnames(entire_data)

mean_std <- (grepl("mean",colnames(entire_data)) | grepl("std",colnames(entire_data)) | grepl("actID",colnames(entire_data)) | grepl("subID",colnames(entire_data)))
mean_std_data <- entire_data[,mean_std]
str(mean_std_data)

# ------------------------- 3. USING DESCRIPTIVE ACTIVITY NAME ----------------------------------

new_merge <- merge(activity, mean_std_data, by='actID')
names(new_merge)


# ------------------------- 4. APPROPIATELY LABELING --------------------------------------------

names(new_merge) <- gsub("^t","Time", names(new_merge))
names(new_merge) <- gsub("^f","Frequency", names(new_merge))
names(new_merge) <- gsub("Acc","Accelerometer", names(new_merge))
names(new_merge) <- gsub("Gyro", "Gyroscope", names(new_merge))
names(new_merge) 

# ------------------------- 5. SECOND TIDY DATASET FOR AVERAGE ----------------------------------

second_tidy <- new_merge

second_tidy <-aggregate(.~subID + actID, second_tidy, mean)
second_tidy <- second_tidy[order(second_tidy$subID, second_tidy$actID),]
second_tidy$actLabel <- NULL
write.table(second_tidy, "second_tidy.txt", row.name = FALSE)
