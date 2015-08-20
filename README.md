# GettingAndCleaningDataCourseProject
This repo contains two files in addition to this README:
* run-analysis.R
* CodeBook.md

## run-analysis.R
This R script reads the data from the various raw data files provided in the course project, combines them into a tidy data set and creates a summary report. The tidy data set and the summary report are stored as text files in the end of
the script.

Note that in order to run the script successfully you need to perform these steps:
* Install dplyr package
* Download and extract the data set from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Set the working directory to the "UCI HAR Dataset" folder in the extracted structure

## CodeBook.md
This file contains the code book describing the variables, the data, and all transformations performed to clean up the data.