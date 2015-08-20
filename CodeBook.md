# Getting and Cleaning Data
# Course Project

# CodeBook
## Written by: Antti Manninen, 20/8/2015

# Contents
This code book contains <insert here>

# Study design
## The raw data
Raw data for this project was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. When extracted, this data set contains a number of source files, where the important files are
* Test data
  * _test/X_test.txt_ containing 561 measurements of test data for each record
  * _test/Y_test.txt_ containing the activity ids for each record in the test data
  * _test/subject_test.txt_ containing the subject ids for each record in the test data
* Train data
  * _train/X_train.txt_ containing 561 measurements of training data for each record
  * _train/Y_train.txt_ containing the activity ids for each record in the training data
  * _train/subject_train.txt_ containing the subject ids for each record in the training data
* General data
  * _activity_labels.txt_ containing the description of each activity
  * _features.txt_ containing the descriptions of the 561 measurements

Since the data in test and training data is exactly the same (it is stated in the data set information in http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones that 70% of the data was randomly selected as the training data and 30% as the test data), the two data sets have been combined in this analysis.

The full process for data transformation is follows:
1. Read the measurement descriptions from features.txt
2. Read the activity descriptions from activity_labels.txt
3. Remove underscores from the activity labels and turn them lowercase to improve readability
4. Read the test measurement data from X_test.txt
5. Read the test activity ids from Y_test.txt
6. Read the test subject ids from subject_test.txt
7. Read the training measurement data from X_train.txt
8. Read the training activity ids from Y_train.txt
9. Read the training subject ids from subject_train.txt
10. Combine test measurement data (4.) and training measurement data (7.)
11. Make the measurement descriptions (1.) unique and use them as column names for measurement data
12. Select only measurements that are related to mean and standard deviation of values for the analysis. These are identified as having endings "-mean()" and "-std()" in the measurement descriptions. Other measurements containing words mean or std are not included as they are not deemed to be pure mean or standard deviation measurements.
13. Perform readability improvements to the measurement descriptions:
    * In case measurement starts with "f", replace that with "frequency"
    * In case measurement starts with "t", replace that with "time"
    * Some measurements have word "Body" twice - remove the second occurrence
    * Replace "Acc" with the full text "Accelerometer"
    * Replace "Gyro" with the full text "Gyroscope"
    * Replace "Mag" with the full text "Magnitude"
    * Replace "-mean()" and "-std()" with "Mean" and "StandardDeviation"
    * Replace ending -X/-Y/-Z with simple X/Y/Z


Thorough description of how you collected the data. From source data to end result.

# Code book
Describe each variable and its units