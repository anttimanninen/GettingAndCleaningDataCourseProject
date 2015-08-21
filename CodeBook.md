# Getting and Cleaning Data
### Course Project

### CodeBook


Written by: Antti Manninen, 20/8/2015

# Contents
This code book contains description on how the R script run-analysis.R transforms the raw data to tidy data. It also describes what the tidy data produced by the script contains.

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
11. Make the measurement descriptions (1.) unique and use them as column names for measurement data (10.)
12. Select only measurements (11.) that are related to mean and standard deviation of values for the analysis. These are identified as having endings "-mean()" and "-std()" in the measurement descriptions. Other measurements containing words mean or std are not included as they are not deemed to be pure mean or standard deviation measurements.
13. Perform readability improvements to the measurement descriptions (12.):
    * In case measurement starts with "f", replace that with "frequency"
    * In case measurement starts with "t", replace that with "time"
    * Some measurements have word "Body" twice - remove the second occurrence
    * Replace "Acc" with the full text "Accelerometer"
    * Replace "Gyro" with the full text "Gyroscope"
    * Replace "Mag" with the full text "Magnitude"
    * Replace "-mean()" and "-std()" with "Mean" and "StandardDeviation"
    * Replace ending -X/-Y/-Z with simple X/Y/Z
14. Combine test activity ids (5.) and training activity ids (8.)
15. Combine test subject ids (6.) and training subject ids (9.)
16. Set the headers of the activity and subject id lists (14. and 15.) to more descriptive values ("activityid" and "subjectid" respectively)
17. Merge the activity id list (16.) with the activity description data (2.) to give the result table full activity name instead of id numbers
18. Combine the result data by combining lists of subjects (15.), activities (17.) and the measurement data (13.)
19. Set the activity column name to "activity"
20. Group the data set (19.) by subject id and activity description and calculate the means of measurements on this split

After this step the script writes a file called "summary_report.txt" that contains the summary report from step 20.

# Code book

Variables in summary_report.txt
* subjectid: identifier for the subject for which measurements were taken (1-30)
* activity: one of six measured activities (walking, walking upstairs, walking downstairs, sitting, standing, laying)
* time variables (From "features_info.txt" in the dataset: "The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise.")
  * accelerometer variables (from "features_info.txt": "the acceleration signal was then separated into body and gravity acceleration signals"), split to X, Y, and Z components
    * timeBodyAccelerometerMeanX
    * timeBodyAccelerometerMeanY
    * timeBodyAccelerometerMeanZ
    * timeBodyAccelerometerStandardDeviationX
    * timeBodyAccelerometerStandardDeviationY
    * timeBodyAccelerometerStandardDeviationZ
  * gravity acceleration variables, split to X, Y, and Z components
    * timeGravityAccelerometerMeanX
    * timeGravityAccelerometerMeanY
    * timeGravityAccelerometerMeanZ
    * timeGravityAccelerometerStandardDeviationX
    * timeGravityAccelerometerStandardDeviationY
    * timeGravityAccelerometerStandardDeviationZ
  * accelerometer jerk variables (from "features_info.txt": "Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals"), split to X, Y, and Z components
    * timeBodyAccelerometerJerkMeanX
    * timeBodyAccelerometerJerkMeanY
    * timeBodyAccelerometerJerkMeanZ
    * timeBodyAccelerometerJerkStandardDeviationX
    * timeBodyAccelerometerJerkStandardDeviationY
    * timeBodyAccelerometerJerkStandardDeviationZ
  * gyroscope variables, split to X, Y, and Z components
    * timeBodyGyroscopeMeanX
    * timeBodyGyroscopeMeanY
    * timeBodyGyroscopeMeanZ
    * timeBodyGyroscopeStandardDeviationX
    * timeBodyGyroscopeStandardDeviationY
    * timeBodyGyroscopeStandardDeviationZ
  * gyroscope jerk variables, split to X, Y, and Z components
    * timeBodyGyroscopeJerkMeanX
    * timeBodyGyroscopeJerkMeanY
    * timeBodyGyroscopeJerkMeanZ
    * timeBodyGyroscopeJerkStandardDeviationX
    * timeBodyGyroscopeJerkStandardDeviationY
    * timeBodyGyroscopeJerkStandardDeviationZ
  * accelerometer magnitude variables (from "features_info.txt": "Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm")
    * timeBodyAccelerometerMagnitudeMean
    * timeBodyAccelerometerMagnitudeStandardDeviation
    * timeGravityAccelerometerMagnitudeMean
    * timeGravityAccelerometerMagnitudeStandardDeviation
    * timeBodyAccelerometerJerkMagnitudeMean
    * timeBodyAccelerometerJerkMagnitudeStandardDeviation
  * gyroscope magnitude variables
    * timeBodyGyroscopeMagnitudeMean
    * timeBodyGyroscopeMagnitudeStandardDeviation
    * timeBodyGyroscopeJerkMagnitudeMean
    * timeBodyGyroscopeJerkMagnitudeStandardDeviation
* frequency variables (from "features_info.txt": "Finally a Fast Fourier Transform (FFT) was applied to some of these signals"), split to X, Y and Z components
  * frequencyBodyAccelerometerMeanX
  * frequencyBodyAccelerometerMeanY
  * frequencyBodyAccelerometerMeanZ
  * frequencyBodyAccelerometerStandardDeviationX
  * frequencyBodyAccelerometerStandardDeviationY
  * frequencyBodyAccelerometerStandardDeviationZ
  * frequencyBodyAccelerometerJerkMeanX
  * frequencyBodyAccelerometerJerkMeanY
  * frequencyBodyAccelerometerJerkMeanZ
  * frequencyBodyAccelerometerJerkStandardDeviationX
  * frequencyBodyAccelerometerJerkStandardDeviationY
  * frequencyBodyAccelerometerJerkStandardDeviationZ
  * frequencyBodyGyroscopeMeanX
  * frequencyBodyGyroscopeMeanY
  * frequencyBodyGyroscopeMeanZ
  * frequencyBodyGyroscopeStandardDeviationX
  * frequencyBodyGyroscopeStandardDeviationY
  * frequencyBodyGyroscopeStandardDeviationZ
  * frequencyBodyAccelerometerMagnitudeMean
  * frequencyBodyAccelerometerMagnitudeStandardDeviation
  * frequencyBodyAccelerometerJerkMagnitudeMean
  * frequencyBodyAccelerometerJerkMagnitudeStandardDeviation
  * frequencyBodyGyroscopeMagnitudeMean
  * frequencyBodyGyroscopeMagnitudeStandardDeviation
  * frequencyBodyGyroscopeJerkMagnitudeMean
  * frequencyBodyGyroscopeJerkMagnitudeStandardDeviation
