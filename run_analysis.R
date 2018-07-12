##run_analysis.R

##Create Directory and Download Zip File
if(!file.exists("./data")){dir.create("./data")}
projecturl<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(projecturl, destfile = "./data/ProjectData.zip")

##Unzip File into directory
unzip("./data/ProjectData.zip", exdir = "./data")

## 1.Merging all datasets
##Training Tables
X_train_table<- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train_table<- read.table("./data/UCI HAR Dataset/train/y_train.txt")
training_subjects<- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

##Testing Tables
X_test_table<- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test_table<- read.table("./data/UCI HAR Dataset/test/y_test.txt")
testing_subjects<- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

##Variable tables
features<- read.table("./data/UCI HAR Dataset/features.txt")
activities<- read.table("./data/UCI HAR Dataset/activity_labels.txt")

##Organizing the tables with column names using variable tables
colnames(X_train_table)<- features[,2]
colnames(y_train_table)<- "activityID"
colnames(training_subjects)<- "subjectID"
colnames(X_test_table)<- features[,2]     ##Same as above for merging
colnames(y_test_table)<- "activityID"     ##Same as above for merging
colnames(testing_subjects)<- "subjectID" ##Same as above for merging
colnames(activities)<- c("activityID", "activityType")

##Complete but Separate Training and Testing Tables
complete_training_table<- cbind(y_train_table, training_subjects, X_train_table)
complete_testing_table<- cbind(y_test_table, testing_subjects, X_test_table)

##Complete Dataset (combined training and testing)
CompleteData<- rbind(complete_training_table, complete_testing_table)

## 2.Extracting Mean and Std Variables into a Subset
##Logical vector describing whether the variables contain and mean or std
m_s_vector<- (grepl("activityID", colnames(CompleteData))) | 
        (grepl("subjectID", colnames(CompleteData))) | 
        (grepl("mean..", colnames(CompleteData))) | 
        (grepl("std...", colnames(CompleteData)))

##Subsetting to make a table of means and stds
Mean_Std_Data<- CompleteData[, m_s_vector == TRUE]

## 3. Naming activities on the dataset
Mean_Std_Data_ActivityLabeled<- merge(Mean_Std_Data, activities, 
                                      by = "activityID",
                                      all.x = TRUE) ##Because rows don't match


## 5. Creating second dataset with averages of each variable for each activity 
##      and subject.
Second_Dataset<- aggregate(. ~subjectID + activityID, 
                           Mean_Std_Data_ActivityLabeled, 
                           mean)
Second_Dataset<- Second_Dataset[order(Second_Dataset$subjectID, 
                                      Second_Dataset$activityID), ]

##Writing the Second Dataset to a text file to the Working Directory
write.table(Second_Dataset, file = "SecondDataset.txt", row.names = FALSE)


