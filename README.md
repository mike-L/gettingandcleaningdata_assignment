#Readme - Getting and Cleaning Data Course Project
This github respository has been created as part of the course project for the JHU Coursera class 'Getting and Cleaning Data'. This project has been performed on on smartphone activity data provided by the UCI Machine Learning Repository (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#). The aim of this project is to generate a tidy dataset that:

- Isolates the mean and std deviations of all measurements from the smartphones data
- Summarises the identified measurements by subject (participant) and activity
- Provides descriptive labels for each activity
- Provides a descriptive name for each variable

Contained in this repository are three files:
* tidy_dataset.txt - the summary of the requested measurments, summarised by subject and activity
* Codebook.md - A document describing the fields in tidy_dataset.txt
* run_analysis.R - the R script used to collate and clean the raw data

##How to recreate this dataset using run_analysis.R
1. Download and unzip the files from the following link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
2. Place the following files in your working directory:
* features.txt
* activity_labels.txt
* test/subject_text.txt
* test/X_test.txt
* test/y_test.txt
* train/subject_text.txt
* train/X_test.txt
* train/y_test.txt
3. Run the run_analysis.R file

##What the run_analysis.R script does (in a nutshell)
run_analysis.R performs the following steps to collage the data:

1. Read in the features list (features.txt) into a dataframe

2. Cleans the feature names of commas, dashes and brackets

3. Identifies all mean and standard deviation measurements. For the purposes of this assignment, this is defined as all feature names containing the words 'mean', 'Mean', 'Std' or 'std'.

4. For the test and train data, we then:
* Read in the X data (X_train.txt,  X_test.txt)
* Isolate the desired features in the data (Mean and Std Deviation measures)
* Read in the subject records (subject_test/train.txt), naming the subject vector 'subject_id'
* Read in the activity id records, naming the activity vector 'activity_id'
* Bind the subject, X and activity data together in one dataframe

5. Binds together the test and train data into one dataframe

6. Merges in the activity labels to provide better descriptions of the activity

7. Summarises all the measures by subject and activity level. The summarisation function used is mean().

8. Outputs the resulting dataframe as 'tidy_data.txt' using write.table()

##Why we can consider tidy_dataset.txt to be tidy

1. One observation per row

2. One variable per column

3. Every variable has a name and it is clear that each is a summary of the original data

4. Activity labels are descriptive