########## run_analysis ###########
# ! initial folder is supposed to be in the wd

#1. Merge the training and the test sets to create one data set.
dt<-read.table("UCI HAR Dataset/train/X_train.txt")
dt2<-read.table("UCI HAR Dataset/test/X_test.txt")
dt<-rbind(dt,dt2)
rm(dt2)#clean workspace

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
##### I think that meanFreq() is also a measurement on the mean. 
##### Otherwise we would be asked of just "mean an std of measurement".
##### So the scrip looks for "mean", not "mean()"
##### grepl ignores case by default, so irrelevant things like "angle(Y,gravityMean)" are sorted out

#load the list of features (i.e. column names of the set)
features_list<-read.table("UCI HAR Dataset/features.txt", col.names = c("id","feature"))
#find indeces of columns with "mean" and "std" in name
mean_std_columns_indeces<-features_list[grepl("mean", features_list$feature)|grepl("std", features_list$feature),"id"]
#remove irrelevant columns
dt<-subset(dt, select = mean_std_columns_indeces)
#clean workspace later

#3. Uses descriptive activity names to name the activities in the data set
#add subjects first
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
subject_list<-rbind(subject_train,subject_test)
dt$subjects<-subject_list$V1
rm(subject_train,subject_test,subject_list)#clean workspace
#add activities
y_train<-read.table("UCI HAR Dataset/train/y_train.txt")
y_test<-read.table("UCI HAR Dataset/test/y_test.txt")
activity_list<-rbind(y_train,y_test)
dt$activity_id<-activity_list$V1
rm(y_train, y_test, activity_list)#clean workspace
#add labels for activities
activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activity_id", "activity_label"))
dt<-merge(dt, activity_labels, sort = FALSE)
dt$activity_id<-NULL

#dt$activity_names<-all_activity_labels$V2
rm(activity_labels) #clean workspace

#4. Appropriately labels the data set with descriptive variable names. 
##### I decided not to change initial names. Indexing works fine.
mean_std_columns_names<-as.character(features_list[mean_std_columns_indeces,"feature"])
colnames(dt)[1:79]<-mean_std_columns_names

#5. From the data set in step 4, creates a second, independent tidy data set 
#   with the average of each variable for each activity and each subject.
tidy_dataset<-aggregate(dt[mean_std_columns_names], dt[,80:81], FUN = mean)
#add "Mean_of_" to names of those columns we aggregated
colnames(tidy_dataset)[3:81]<-paste("Mean_of_", mean_std_columns_names, sep = "")
rm(dt,features_list, mean_std_columns_indeces, mean_std_columns_names)#clean workspace

#6. Write tidy data set in txt
write.table(tidy_dataset, "tidy_dataset.txt", row.name=FALSE)
rm(tidy_dataset)#clean workspace

#how to read again the stored tide dataset
#tidy_dataset<-read.table("tidy_dataset.txt", header = TRUE)