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

y_test <- read.table('subject_test.txt', header=FALSE)
names(y_test) <- 'activity_id'

#bind columns together
test <- cbind(subject_test, test, y_test)
test$dataset <- 'test'

#read in train data
setwd('/Users/michaelleung/Dropbox/datascience/Coursera/Getting and Cleaning Data/UCI HAR Dataset/train')
train <- read.table('X_train.txt', header=FALSE)
train <- train[,desired_features$feature_id]
names(train) <- desired_features$feature.name
subject_train <- read.table('subject_train.txt', header=FALSE)
names(subject_train) <- 'subject'

y_train <- read.table('subject_train.txt', header=FALSE)
names(y_train) <- 'activity_id'

#bind columns together
train <- cbind(subject_train, train, y_train)
train$dataset <- 'train'

#now bind the datasets together
combined <- rbind(test, train)
