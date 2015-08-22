#load dplyr
library(dplyr)

#read in feature names
setwd('/Users/michaelleung/Dropbox/datascience/Coursera/Getting and Cleaning Data/UCI HAR Dataset/')
feature_names <- read.table('features.txt', header=FALSE)
names(feature_names) <- c('feature_id', 'feature.name')

#remove brackets 
feature_names$feature.name <- gsub('-','_',gsub('[()]', '', feature_names$feature.name))

#identify the std deviation and mean measures
desired_features_list <- grep('*mean*', feature_names$feature.name)
desired_features_list <- c(desired_features_list, grep('*std*', feature_names$feature.name))
desired_features <- subset(feature_names, feature_id %in% desired_features_list)


#read in test data
setwd('/Users/michaelleung/Dropbox/datascience/Coursera/Getting and Cleaning Data/UCI HAR Dataset/test')
test <- read.table('X_test.txt', header=FALSE)
test <- test[,desired_features$feature_id]
names(test) <- desired_features$feature.name
subject_test <- read.table('subject_test.txt', header=FALSE)
names(subject_test) <- 'subject'

y_test <- read.table('Y_test.txt', header=FALSE)
names(y_test) <- 'activity_id'

#bind columns together
test <- cbind(subject_test, test, y_test)

#read in train data
setwd('/Users/michaelleung/Dropbox/datascience/Coursera/Getting and Cleaning Data/UCI HAR Dataset/train')
train <- read.table('X_train.txt', header=FALSE)
train <- train[,desired_features$feature_id]
names(train) <- desired_features$feature.name
subject_train <- read.table('subject_train.txt', header=FALSE)
names(subject_train) <- 'subject'

y_train <- read.table('Y_train.txt', header=FALSE)
names(y_train) <- 'activity_id'

#bind columns together
train <- cbind(subject_train, train, y_train)

#now bind the datasets together
combined <- rbind(test, train)

#read in activity labels
setwd('/Users/michaelleung/Dropbox/datascience/Coursera/Getting and Cleaning Data/UCI HAR Dataset/')
activity_labels <- read.table('activity_labels.txt', header=FALSE)
names(activity_labels) <- c('activity_id', 'activity_name')

#merge in activity_labels
combined <- merge(combined, activity_labels, by='activity_id', all.x=TRUE)

#clean up environment so we just have combined
rm(list=ls(pattern='[^combined]'))

#reorder columns for neatness (I want activity_id and activity_label to be adjacent)
combined <- combined[,c(1,82,2:81)]

#now average each variable by subject and activity_label
#as a note, I generated the summarise code by writing out the table of variable
#names and then generating the code dynamically in excel
#lazy, slightly inefficient, but it works:)
averaged <- 
  combined %>%
  group_by(subject, activity_name) %>%
  summarise(
    activity_subject_avg__tBodyAcc_mean_X = mean(tBodyAcc_mean_X),
    activity_subject_avg__tBodyAcc_mean_Y = mean(tBodyAcc_mean_Y),
    activity_subject_avg__tBodyAcc_mean_Z = mean(tBodyAcc_mean_Z),
    activity_subject_avg__tBodyAcc_std_X = mean(tBodyAcc_std_X),
    activity_subject_avg__tBodyAcc_std_Y = mean(tBodyAcc_std_Y),
    activity_subject_avg__tBodyAcc_std_Z = mean(tBodyAcc_std_Z),
    activity_subject_avg__tGravityAcc_mean_X = mean(tGravityAcc_mean_X),
    activity_subject_avg__tGravityAcc_mean_Y = mean(tGravityAcc_mean_Y),
    activity_subject_avg__tGravityAcc_mean_Z = mean(tGravityAcc_mean_Z),
    activity_subject_avg__tGravityAcc_std_X = mean(tGravityAcc_std_X),
    activity_subject_avg__tGravityAcc_std_Y = mean(tGravityAcc_std_Y),
    activity_subject_avg__tGravityAcc_std_Z = mean(tGravityAcc_std_Z),
    activity_subject_avg__tBodyAccJerk_mean_X = mean(tBodyAccJerk_mean_X),
    activity_subject_avg__tBodyAccJerk_mean_Y = mean(tBodyAccJerk_mean_Y),
    activity_subject_avg__tBodyAccJerk_mean_Z = mean(tBodyAccJerk_mean_Z),
    activity_subject_avg__tBodyAccJerk_std_X = mean(tBodyAccJerk_std_X),
    activity_subject_avg__tBodyAccJerk_std_Y = mean(tBodyAccJerk_std_Y),
    activity_subject_avg__tBodyAccJerk_std_Z = mean(tBodyAccJerk_std_Z),
    activity_subject_avg__tBodyGyro_mean_X = mean(tBodyGyro_mean_X),
    activity_subject_avg__tBodyGyro_mean_Y = mean(tBodyGyro_mean_Y),
    activity_subject_avg__tBodyGyro_mean_Z = mean(tBodyGyro_mean_Z),
    activity_subject_avg__tBodyGyro_std_X = mean(tBodyGyro_std_X),
    activity_subject_avg__tBodyGyro_std_Y = mean(tBodyGyro_std_Y),
    activity_subject_avg__tBodyGyro_std_Z = mean(tBodyGyro_std_Z),
    activity_subject_avg__tBodyGyroJerk_mean_X = mean(tBodyGyroJerk_mean_X),
    activity_subject_avg__tBodyGyroJerk_mean_Y = mean(tBodyGyroJerk_mean_Y),
    activity_subject_avg__tBodyGyroJerk_mean_Z = mean(tBodyGyroJerk_mean_Z),
    activity_subject_avg__tBodyGyroJerk_std_X = mean(tBodyGyroJerk_std_X),
    activity_subject_avg__tBodyGyroJerk_std_Y = mean(tBodyGyroJerk_std_Y),
    activity_subject_avg__tBodyGyroJerk_std_Z = mean(tBodyGyroJerk_std_Z),
    activity_subject_avg__tBodyAccMag_mean = mean(tBodyAccMag_mean),
    activity_subject_avg__tBodyAccMag_std = mean(tBodyAccMag_std),
    activity_subject_avg__tGravityAccMag_mean = mean(tGravityAccMag_mean),
    activity_subject_avg__tGravityAccMag_std = mean(tGravityAccMag_std),
    activity_subject_avg__tBodyAccJerkMag_mean = mean(tBodyAccJerkMag_mean),
    activity_subject_avg__tBodyAccJerkMag_std = mean(tBodyAccJerkMag_std),
    activity_subject_avg__tBodyGyroMag_mean = mean(tBodyGyroMag_mean),
    activity_subject_avg__tBodyGyroMag_std = mean(tBodyGyroMag_std),
    activity_subject_avg__tBodyGyroJerkMag_mean = mean(tBodyGyroJerkMag_mean),
    activity_subject_avg__tBodyGyroJerkMag_std = mean(tBodyGyroJerkMag_std),
    activity_subject_avg__fBodyAcc_mean_X = mean(fBodyAcc_mean_X),
    activity_subject_avg__fBodyAcc_mean_Y = mean(fBodyAcc_mean_Y),
    activity_subject_avg__fBodyAcc_mean_Z = mean(fBodyAcc_mean_Z),
    activity_subject_avg__fBodyAcc_std_X = mean(fBodyAcc_std_X),
    activity_subject_avg__fBodyAcc_std_Y = mean(fBodyAcc_std_Y),
    activity_subject_avg__fBodyAcc_std_Z = mean(fBodyAcc_std_Z),
    activity_subject_avg__fBodyAcc_meanFreq_X = mean(fBodyAcc_meanFreq_X),
    activity_subject_avg__fBodyAcc_meanFreq_Y = mean(fBodyAcc_meanFreq_Y),
    activity_subject_avg__fBodyAcc_meanFreq_Z = mean(fBodyAcc_meanFreq_Z),
    activity_subject_avg__fBodyAccJerk_mean_X = mean(fBodyAccJerk_mean_X),
    activity_subject_avg__fBodyAccJerk_mean_Y = mean(fBodyAccJerk_mean_Y),
    activity_subject_avg__fBodyAccJerk_mean_Z = mean(fBodyAccJerk_mean_Z),
    activity_subject_avg__fBodyAccJerk_std_X = mean(fBodyAccJerk_std_X),
    activity_subject_avg__fBodyAccJerk_std_Y = mean(fBodyAccJerk_std_Y),
    activity_subject_avg__fBodyAccJerk_std_Z = mean(fBodyAccJerk_std_Z),
    activity_subject_avg__fBodyAccJerk_meanFreq_X = mean(fBodyAccJerk_meanFreq_X),
    activity_subject_avg__fBodyAccJerk_meanFreq_Y = mean(fBodyAccJerk_meanFreq_Y),
    activity_subject_avg__fBodyAccJerk_meanFreq_Z = mean(fBodyAccJerk_meanFreq_Z),
    activity_subject_avg__fBodyGyro_mean_X = mean(fBodyGyro_mean_X),
    activity_subject_avg__fBodyGyro_mean_Y = mean(fBodyGyro_mean_Y),
    activity_subject_avg__fBodyGyro_mean_Z = mean(fBodyGyro_mean_Z),
    activity_subject_avg__fBodyGyro_std_X = mean(fBodyGyro_std_X),
    activity_subject_avg__fBodyGyro_std_Y = mean(fBodyGyro_std_Y),
    activity_subject_avg__fBodyGyro_std_Z = mean(fBodyGyro_std_Z),
    activity_subject_avg__fBodyGyro_meanFreq_X = mean(fBodyGyro_meanFreq_X),
    activity_subject_avg__fBodyGyro_meanFreq_Y = mean(fBodyGyro_meanFreq_Y),
    activity_subject_avg__fBodyGyro_meanFreq_Z = mean(fBodyGyro_meanFreq_Z),
    activity_subject_avg__fBodyAccMag_mean = mean(fBodyAccMag_mean),
    activity_subject_avg__fBodyAccMag_std = mean(fBodyAccMag_std),
    activity_subject_avg__fBodyAccMag_meanFreq = mean(fBodyAccMag_meanFreq),
    activity_subject_avg__fBodyBodyAccJerkMag_mean = mean(fBodyBodyAccJerkMag_mean),
    activity_subject_avg__fBodyBodyAccJerkMag_std = mean(fBodyBodyAccJerkMag_std),
    activity_subject_avg__fBodyBodyAccJerkMag_meanFreq = mean(fBodyBodyAccJerkMag_meanFreq),
    activity_subject_avg__fBodyBodyGyroMag_mean = mean(fBodyBodyGyroMag_mean),
    activity_subject_avg__fBodyBodyGyroMag_std = mean(fBodyBodyGyroMag_std),
    activity_subject_avg__fBodyBodyGyroMag_meanFreq = mean(fBodyBodyGyroMag_meanFreq),
    activity_subject_avg__fBodyBodyGyroJerkMag_mean = mean(fBodyBodyGyroJerkMag_mean),
    activity_subject_avg__fBodyBodyGyroJerkMag_std = mean(fBodyBodyGyroJerkMag_std),
    activity_subject_avg__fBodyBodyGyroJerkMag_meanFreq = mean(fBodyBodyGyroJerkMag_meanFreq)
  )
