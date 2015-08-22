#load dplyr
library(dplyr)

#set working directory (please set to the directory where you have downloaded the data)
#setwd('/Users/michaelleung/Dropbox/datascience/Coursera/Getting and Cleaning Data/Getting_and_Cleaning_Data_Assignment')

#read in feature names
feature_names <- read.table('features.txt', header=FALSE)
names(feature_names) <- c('feature_id', 'feature.name')

#Save original feature names for codebook
feature_names$original.feature.name <- feature_names$feature.name

#remove commas, brackets and hyphens in feature names, replace with underscore
feature_names$feature.name <- gsub(',', '_', gsub('-','_',gsub('[()]', '', feature_names$feature.name)))


#identify the std deviation and mean measures
desired_features_list <- grep('[Mm]ean', feature_names$feature.name)
desired_features_list <- c(desired_features_list, grep('[Ss]td', feature_names$feature.name))
desired_features <- subset(feature_names, feature_id %in% desired_features_list)

#Expand abbreviated names to make them more descriptive
desired_features$feature.name <- gsub('BodyBody', 'Body',gsub('Mag','Magnitude', gsub('Gyro', 'Gyroscope', gsub('Acc', 'Acceleration', desired_features$feature.name))))

#read in test data
test <- read.table('X_test.txt', header=FALSE)

#isolate the desired features
test <- test[,desired_features$feature_id]
names(test) <- desired_features$feature.name

#read in subjects
subject_test <- read.table('subject_test.txt', header=FALSE)
names(subject_test) <- 'subject'

#read in activity ids
y_test <- read.table('Y_test.txt', header=FALSE)
names(y_test) <- 'activity_id'

#bind columns together
test <- cbind(subject_test, test, y_test)

#read in train data
train <- read.table('X_train.txt', header=FALSE)

#isolate the desired features
train <- train[,desired_features$feature_id]
names(train) <- desired_features$feature.name

#read in subjects
subject_train <- read.table('subject_train.txt', header=FALSE)
names(subject_train) <- 'subject'

#read in activity ids
y_train <- read.table('Y_train.txt', header=FALSE)
names(y_train) <- 'activity_id'

#bind columns together
train <- cbind(subject_train, train, y_train)

#now bind the datasets together
combined <- rbind(test, train)

#read in activity labels
activity_labels <- read.table('activity_labels.txt', header=FALSE)
names(activity_labels) <- c('activity_id', 'activity_name')

#merge in activity_labels
combined <- merge(combined, activity_labels, by='activity_id', all.x=TRUE)

#clean up environment so we just have combined
rm(list=ls(pattern='[^combined]'))

#reorder columns for neatness (I want activity_id and activity_label to be adjacent)
combined <- combined[,c(1,89,2:88)]

#now average each variable by subject and activity_label
averaged <- 
  combined %>%
  group_by(subject, activity_name) %>%
  summarise(
    activity_subject_avg__tBodyAcceleration_mean_X = mean(tBodyAcceleration_mean_X),
    activity_subject_avg__tBodyAcceleration_mean_Y = mean(tBodyAcceleration_mean_Y),
    activity_subject_avg__tBodyAcceleration_mean_Z = mean(tBodyAcceleration_mean_Z),
    activity_subject_avg__tBodyAcceleration_std_X = mean(tBodyAcceleration_std_X),
    activity_subject_avg__tBodyAcceleration_std_Y = mean(tBodyAcceleration_std_Y),
    activity_subject_avg__tBodyAcceleration_std_Z = mean(tBodyAcceleration_std_Z),
    activity_subject_avg__tGravityAcceleration_mean_X = mean(tGravityAcceleration_mean_X),
    activity_subject_avg__tGravityAcceleration_mean_Y = mean(tGravityAcceleration_mean_Y),
    activity_subject_avg__tGravityAcceleration_mean_Z = mean(tGravityAcceleration_mean_Z),
    activity_subject_avg__tGravityAcceleration_std_X = mean(tGravityAcceleration_std_X),
    activity_subject_avg__tGravityAcceleration_std_Y = mean(tGravityAcceleration_std_Y),
    activity_subject_avg__tGravityAcceleration_std_Z = mean(tGravityAcceleration_std_Z),
    activity_subject_avg__tBodyAccelerationJerk_mean_X = mean(tBodyAccelerationJerk_mean_X),
    activity_subject_avg__tBodyAccelerationJerk_mean_Y = mean(tBodyAccelerationJerk_mean_Y),
    activity_subject_avg__tBodyAccelerationJerk_mean_Z = mean(tBodyAccelerationJerk_mean_Z),
    activity_subject_avg__tBodyAccelerationJerk_std_X = mean(tBodyAccelerationJerk_std_X),
    activity_subject_avg__tBodyAccelerationJerk_std_Y = mean(tBodyAccelerationJerk_std_Y),
    activity_subject_avg__tBodyAccelerationJerk_std_Z = mean(tBodyAccelerationJerk_std_Z),
    activity_subject_avg__tBodyGyroscope_mean_X = mean(tBodyGyroscope_mean_X),
    activity_subject_avg__tBodyGyroscope_mean_Y = mean(tBodyGyroscope_mean_Y),
    activity_subject_avg__tBodyGyroscope_mean_Z = mean(tBodyGyroscope_mean_Z),
    activity_subject_avg__tBodyGyroscope_std_X = mean(tBodyGyroscope_std_X),
    activity_subject_avg__tBodyGyroscope_std_Y = mean(tBodyGyroscope_std_Y),
    activity_subject_avg__tBodyGyroscope_std_Z = mean(tBodyGyroscope_std_Z),
    activity_subject_avg__tBodyGyroscopeJerk_mean_X = mean(tBodyGyroscopeJerk_mean_X),
    activity_subject_avg__tBodyGyroscopeJerk_mean_Y = mean(tBodyGyroscopeJerk_mean_Y),
    activity_subject_avg__tBodyGyroscopeJerk_mean_Z = mean(tBodyGyroscopeJerk_mean_Z),
    activity_subject_avg__tBodyGyroscopeJerk_std_X = mean(tBodyGyroscopeJerk_std_X),
    activity_subject_avg__tBodyGyroscopeJerk_std_Y = mean(tBodyGyroscopeJerk_std_Y),
    activity_subject_avg__tBodyGyroscopeJerk_std_Z = mean(tBodyGyroscopeJerk_std_Z),
    activity_subject_avg__tBodyAccelerationMagnitude_mean = mean(tBodyAccelerationMagnitude_mean),
    activity_subject_avg__tBodyAccelerationMagnitude_std = mean(tBodyAccelerationMagnitude_std),
    activity_subject_avg__tGravityAccelerationMagnitude_mean = mean(tGravityAccelerationMagnitude_mean),
    activity_subject_avg__tGravityAccelerationMagnitude_std = mean(tGravityAccelerationMagnitude_std),
    activity_subject_avg__tBodyAccelerationJerkMagnitude_mean = mean(tBodyAccelerationJerkMagnitude_mean),
    activity_subject_avg__tBodyAccelerationJerkMagnitude_std = mean(tBodyAccelerationJerkMagnitude_std),
    activity_subject_avg__tBodyGyroscopeMagnitude_mean = mean(tBodyGyroscopeMagnitude_mean),
    activity_subject_avg__tBodyGyroscopeMagnitude_std = mean(tBodyGyroscopeMagnitude_std),
    activity_subject_avg__tBodyGyroscopeJerkMagnitude_mean = mean(tBodyGyroscopeJerkMagnitude_mean),
    activity_subject_avg__tBodyGyroscopeJerkMagnitude_std = mean(tBodyGyroscopeJerkMagnitude_std),
    activity_subject_avg__fBodyAcceleration_mean_X = mean(fBodyAcceleration_mean_X),
    activity_subject_avg__fBodyAcceleration_mean_Y = mean(fBodyAcceleration_mean_Y),
    activity_subject_avg__fBodyAcceleration_mean_Z = mean(fBodyAcceleration_mean_Z),
    activity_subject_avg__fBodyAcceleration_std_X = mean(fBodyAcceleration_std_X),
    activity_subject_avg__fBodyAcceleration_std_Y = mean(fBodyAcceleration_std_Y),
    activity_subject_avg__fBodyAcceleration_std_Z = mean(fBodyAcceleration_std_Z),
    activity_subject_avg__fBodyAcceleration_meanFreq_X = mean(fBodyAcceleration_meanFreq_X),
    activity_subject_avg__fBodyAcceleration_meanFreq_Y = mean(fBodyAcceleration_meanFreq_Y),
    activity_subject_avg__fBodyAcceleration_meanFreq_Z = mean(fBodyAcceleration_meanFreq_Z),
    activity_subject_avg__fBodyAccelerationJerk_mean_X = mean(fBodyAccelerationJerk_mean_X),
    activity_subject_avg__fBodyAccelerationJerk_mean_Y = mean(fBodyAccelerationJerk_mean_Y),
    activity_subject_avg__fBodyAccelerationJerk_mean_Z = mean(fBodyAccelerationJerk_mean_Z),
    activity_subject_avg__fBodyAccelerationJerk_std_X = mean(fBodyAccelerationJerk_std_X),
    activity_subject_avg__fBodyAccelerationJerk_std_Y = mean(fBodyAccelerationJerk_std_Y),
    activity_subject_avg__fBodyAccelerationJerk_std_Z = mean(fBodyAccelerationJerk_std_Z),
    activity_subject_avg__fBodyAccelerationJerk_meanFreq_X = mean(fBodyAccelerationJerk_meanFreq_X),
    activity_subject_avg__fBodyAccelerationJerk_meanFreq_Y = mean(fBodyAccelerationJerk_meanFreq_Y),
    activity_subject_avg__fBodyAccelerationJerk_meanFreq_Z = mean(fBodyAccelerationJerk_meanFreq_Z),
    activity_subject_avg__fBodyGyroscope_mean_X = mean(fBodyGyroscope_mean_X),
    activity_subject_avg__fBodyGyroscope_mean_Y = mean(fBodyGyroscope_mean_Y),
    activity_subject_avg__fBodyGyroscope_mean_Z = mean(fBodyGyroscope_mean_Z),
    activity_subject_avg__fBodyGyroscope_std_X = mean(fBodyGyroscope_std_X),
    activity_subject_avg__fBodyGyroscope_std_Y = mean(fBodyGyroscope_std_Y),
    activity_subject_avg__fBodyGyroscope_std_Z = mean(fBodyGyroscope_std_Z),
    activity_subject_avg__fBodyGyroscope_meanFreq_X = mean(fBodyGyroscope_meanFreq_X),
    activity_subject_avg__fBodyGyroscope_meanFreq_Y = mean(fBodyGyroscope_meanFreq_Y),
    activity_subject_avg__fBodyGyroscope_meanFreq_Z = mean(fBodyGyroscope_meanFreq_Z),
    activity_subject_avg__fBodyAccelerationMagnitude_mean = mean(fBodyAccelerationMagnitude_mean),
    activity_subject_avg__fBodyAccelerationMagnitude_std = mean(fBodyAccelerationMagnitude_std),
    activity_subject_avg__fBodyAccelerationMagnitude_meanFreq = mean(fBodyAccelerationMagnitude_meanFreq),
    activity_subject_avg__fBodyAccelerationJerkMagnitude_mean = mean(fBodyAccelerationJerkMagnitude_mean),
    activity_subject_avg__fBodyAccelerationJerkMagnitude_std = mean(fBodyAccelerationJerkMagnitude_std),
    activity_subject_avg__fBodyAccelerationJerkMagnitude_meanFreq = mean(fBodyAccelerationJerkMagnitude_meanFreq),
    activity_subject_avg__fBodyGyroscopeMagnitude_mean = mean(fBodyGyroscopeMagnitude_mean),
    activity_subject_avg__fBodyGyroscopeMagnitude_std = mean(fBodyGyroscopeMagnitude_std),
    activity_subject_avg__fBodyGyroscopeMagnitude_meanFreq = mean(fBodyGyroscopeMagnitude_meanFreq),
    activity_subject_avg__fBodyGyroscopeJerkMagnitude_mean = mean(fBodyGyroscopeJerkMagnitude_mean),
    activity_subject_avg__fBodyGyroscopeJerkMagnitude_std = mean(fBodyGyroscopeJerkMagnitude_std),
    activity_subject_avg__fBodyGyroscopeJerkMagnitude_meanFreq = mean(fBodyGyroscopeJerkMagnitude_meanFreq),
    activity_subject_avg__angletBodyAccelerationMean_gravity = mean(angletBodyAccelerationMean_gravity),
    activity_subject_avg__angletBodyAccelerationJerkMean_gravityMean = mean(angletBodyAccelerationJerkMean_gravityMean),
    activity_subject_avg__angletBodyGyroscopeMean_gravityMean = mean(angletBodyGyroscopeMean_gravityMean),
    activity_subject_avg__angletBodyGyroscopeJerkMean_gravityMean = mean(angletBodyGyroscopeJerkMean_gravityMean),
    activity_subject_avg__angleX_gravityMean = mean(angleX_gravityMean),
    activity_subject_avg__angleY_gravityMean = mean(angleY_gravityMean),
    activity_subject_avg__angleZ_gravityMean = mean(angleZ_gravityMean)
  )

#output data to text file
write.table(averaged, 'tidy_dataset.txt', row.names=FALSE)
