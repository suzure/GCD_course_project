# GCD_course_project
Getting and Cleaning Data Course Project

These are the steps the script performs on the initial data (initial data folder is supposed to be in the wd)

###1. Load and merge the training and the test sets to create one data set. 
Here and further first comes the "train" data and then "test" data. Training and test sets come from "UCI HAR Dataset/train/X_train.txt" and "UCI HAR Dataset/test/X_test.txt". 

###2. Extract only the measurements on the mean and standard deviation for each measurement by selecting columns with names that include "mean" and "std". 

I think that meanFreq() is also a measurement on the mean. So the scrip looks for "mean", not "mean()". Function grepl ignores case by default, so irrelevant things like "angle(Y,gravityMean)" are sorted out.

Column names are taken from "UCI HAR Dataset/features.txt". Column name = feature.

###3. Use descriptive activity names to name the activities in the data set. 
This means adding subject and activity label to each observation. 
Subjects are taken from "UCI HAR Dataset/train/subject_train.txt" and "UCI HAR Dataset/test/subject_test.txt". 
Activity ids are taken from "UCI HAR Dataset/train/y_train.txt" and "UCI HAR Dataset/test/y_test.txt"
Then the script substitutes activity id with label. id-label correspondence is taken from "UCI HAR Dataset/activity_labels.txt

###4. Appropriately labels the data set with descriptive variable names. 
I decided not to change initial names. Indexing works fine. Variable (i.e. column) names are taken from "UCI HAR Dataset/features.txt"

###5. From the data set in step 4, create a second, independent tidy data set.
This means counting the average of each variable for each activity and each subject. Then the script adds "Mean_of_" to names of those columns it aggregated.

###6. Write tidy data set in txt
Right in the wd.

## Clean workspace

how to read again the stored tide dataset
tidy_dataset<-read.table("tidy_dataset.txt", header = TRUE)
