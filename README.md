# Getting-and-Cleaning-Data-Course-Project

## Description of run_analysis.R
* First the code creates a directory called "data" in the working directory.
* Then it downloads the zip file of the data from the url into the "data" directory.
* It then unzips the file into the "data" directory.
* It then assigns tables to the raw data by reading the data into R using read.table.
* It then assigns the column names of the created tables. These are descriptive Variable Names.
* Then, the code combines the data for the "training" observations and the "test observations using cbind.
* These tables are then combined using rbind to form the "CompleteData" table. 
* To extract the means and stds from the CompleteData table, it starts by creating a logical vector of whether the column names contain the words "activityID", "subjectID", "mean" (followed by any character), or "std.." (followed by any character). 
* It then subsets the CompleteData table using the Mean and Std logical vector as a TRUE conditional for its columns. This is the extracted table of means and stds.
* It then names the activities in the Mean and Std table by merging this table with the table created previoulsy called "activities" by the column "activityID"
* The code then creates a second dataset called "Second_Dataset" by using the "aggregate" command to group the labeled mean and std table by the subjectID and activity ID and taking the mean of each variable. It is then ordered first by subject and then by activity.
* The final action completed is the writing of a text file called "SecondDataset.txt" to the working directory. This is the tidy dataset.
  

