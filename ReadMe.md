==================================================================
Getting and Cleaning Data Course Project 
==================================================================

The finished product of this assignment was saved into two separate text format files which are delimited in tabs: 

tidydata-activity.txt
tidydata-subject.txt

This tidy data set contains averages and standard deviations of various test measures put together separately by activity and subject.


==================================================================
How to use the script(run_analysis.R):
==================================================================

1. Source the script in R console: >source("run_analysis.R")
2. Run the command : > run_analysis()
3. Resulting tidy data files will be saved in your working directory as "tidydata-activity.txt" and "tidydata-subject.txt"


==================================================================
The dataset was constructed by:
==================================================================

- Reading raw data files into R and rearraging them

- Following data files from the UCI HAR Dataset has been used: 

	- 'features.txt': List of all features.
	- 'activity_labels.txt': Links the class labels with their activity name.
	- 'train/X_train.txt': Training set.
	- 'train/y_train.txt': Training labels.
	- 'test/X_test.txt': Test set.
	- 'test/y_test.txt': Test labels.
	- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
	- 'train/subject_test.txt : Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

- Following data files were NOT used:

	- 'train/Inertial Signals/total_acc_x_train.txt'
	- 'train/Inertial Signals/body_acc_x_train.txt'
	- 'train/Inertial Signals/body_gyro_x_train.txt'


==========================================================================================
The script(run_analysis.R) which automatically creates the dataset does the following:
==========================================================================================

1. Reads all the files used in the analysis(see above)
2. 'cbind' 'X_train','y_train' and 'subject_train' 
3. 'cbind' 'X_test','y_test' and 'subject_test' 
4. 'rbind' the result of (2) and (3)
5. After sorting and ordering the dataset of (4), extract the required "mean" and "std" variables to construct a narrower dataset
6. Use 'tapply' to calculate "mean" and "std" by activity/subject and store results in separate data frames
7. 'write.table' to return the results and write them into a tab-delimited file format

