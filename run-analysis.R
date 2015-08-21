## This function reads the various data files provided for the course project
## for Coursera course "Getting and Cleaning Data" and performs the necessary
## transformations to provide a tidy data file.
##
## In order to run the function, you need to first download and extract the raw data
## provided in
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## Working directory needs to be set up to the "UCI HAR Dataset" folder.
run_analysis <- function() {
        
        ## We need dplyr for various data manipulation functions applied here
        library(dplyr)
        
        ## Read names of the measurements from features.txt. Need to state the column
        ## classes, otherwise the names will be a factor variable that we can't
        ## make unique later
        features <- read.table("./features.txt", header=FALSE, colClasses=c("integer", "character"))
        
        ## Similarly, read the activity labels specifying the column classes
        activity_labels <- read.table("./activity_labels.txt", header=FALSE, colClasses=c("integer", "character"))
        ## Give the columns descriptive names
        names(activity_labels) = c("activityid", "activityname")
        ## Remove the underscores from activity names and make them lower case
        activity_labels$activityname <- tolower(gsub("_", " ", activity_labels$activityname))
        
        ## Read the various data tables to variables
        test_data <- read.table("./test/X_test.txt", header=FALSE)
        test_activities <- read.table("./test/Y_test.txt", header=FALSE)
        test_subjects <- read.table("./test/subject_test.txt", header=FALSE)
        train_data <- read.table("./train/X_train.txt", header=FALSE)
        train_activities <- read.table("./train/Y_train.txt", header=FALSE)
        train_subjects <- read.table("./train/subject_train.txt", header=FALSE)
        
        ## Combine test and train measurement data by simply concatenating the rows
        combined_data <- rbind(test_data, train_data)
        ## Set the column names for combined data as a unique set of measurement
        ## names read from features.txt. Need unique here since there are some
        ## duplicates and the select method doesn't work with duplicates for some
        ## reason.
        colnames(combined_data) <- make.unique(features[,2])
        
        ## Read only mean and standard deviation measurements from the combined
        ## data set. These end with -mean() and -std(). 
        selected_data <- select(combined_data, matches("-mean\\(\\)|-std\\(\\)"))
        ## Replace leading "f" with frequency to be more verbal
        colnames(selected_data) <- gsub("^f", "frequency", colnames(selected_data))
        ## Replace leading "t" with time to be more verbal
        colnames(selected_data) <- gsub("^t", "time", colnames(selected_data))
        ## Some measurement names have "Body" twice. Remove the second occurrence.
        colnames(selected_data) <- gsub("BodyBody", "Body", colnames(selected_data))
        ## Replace "Acc" with the full text "Accelerometer"
        colnames(selected_data) <- gsub("Acc", "Accelerometer", colnames(selected_data))
        ## Replace "Gyro" with the full text "Gyroscope"
        colnames(selected_data) <- gsub("Gyro", "Gyroscope", colnames(selected_data))
        ## Replace "Mag" with the full text "Magnitude".
        colnames(selected_data) <- gsub("Mag", "Magnitude", colnames(selected_data))
        ## Replace "-mean()" and "-std()" with "Mean" and "StandardDeviation"
        colnames(selected_data) <- gsub("-mean\\(\\)", "Mean", colnames(selected_data))
        colnames(selected_data) <- gsub("-std\\(\\)", "StandardDeviation", colnames(selected_data))
        ## Replace ending -X/-Y/-Z with simple X/Y/Z
        colnames(selected_data) <- gsub("-X$", "X", colnames(selected_data))
        colnames(selected_data) <- gsub("-Y$", "Y", colnames(selected_data))
        colnames(selected_data) <- gsub("-Z$", "Z", colnames(selected_data))
        
        ## Combine activity and subject lists for test and train data sets similarly
        ## as the measurement data was combined
        combined_activities <- rbind(test_activities, train_activities)
        combined_subjects <- rbind(test_subjects, train_subjects)
        ## Set the headers of the character vectors to be more descriptive
        names(combined_activities) = "activityid"
        names(combined_subjects) = "subjectid"
        
        ## Merge the activity vector with a data frame containing the labels
        ## for the activities to give the result table full activity names instead
        ## of id numbers.
        activities_with_name <- merge(combined_activities, activity_labels, by="activityid")
        
        ## Combine the result data by combining lists of subjects, activity names and
        ## measurement data
        result_data <- cbind(combined_subjects, activities_with_name[,2], selected_data)
        ## Fix the name of the activity column which for some reason wasn't read
        ## from the data frame.
        names(result_data)[2] <- "activity"
        
        ## Prepare a summary report by grouping the tidy data on subject id and
        ## activity name and then summarising the data using summarise_each
        ## that calculates the mean for all the remaining columns.
        data_groups <- group_by(result_data, subjectid, activity)
        summary_report <- summarise_each(data_groups, "mean")
        
        ## Write the summary report to a text file as the assignment instructed
        write.csv(summary_report, file="summary_report.txt", row.names=FALSE)
}