Code Book
=============================================
----------------
Transformations
----------------
The run_analysis.R script process can be described as follows:

1) Directely downloads data called getdata-projectfiles-UCI HAR Dataset.zip from 
"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
to current working directory. Then uncompresses this file creating file UCI HAR Dataset
in current working directory. And loads library `plyr`.

2) Loads and bind by column datasets in **test** and **train** files called `X_°°°.txt`, 
`y_°°°.txt`, `subject_°°°.txt`; replacing °°° by test or train respectively depending on file.

- `subject_°°°` contains data pretaining to subjects id

- `X_°°°` contains time and frequency domain variables such as Triaxial acceleration or angular 
	  velocity from the gyroscope carried by subjects and the estimated body acceleration.
	  Read the readme file in UCI HAR Dataset for details.
	
- `y_°°°` contains data related to activity accomplished by subject


At the end datasets `test_data.csv` and `train_data.csv` coming of column binds of files described 
above in test and train files in UCI HAR Datasets respectively are saved in UCI Result file 
created for the purpose of containing resulting datasets.

3) Loads and relabels columns one and two of both `features.txt` and `activity_labels.txt`
*num* and *labels* respectively and renames these datasets `features.txt_data.csv` and 
`activity_labels.txt_data.csv` respectively. Adding two rows whose values for both variables are
identical and called "id" and "activity". Added in beging and in the end of `features.txt_data.csv`
datasets respectively. [found in UCI Result folder]

- `features.txt_data.csv` contains the labels of columns of `X_test` and `X_train` datasets.
-`activity_labels.txt_data.csv` contains descriptive activity names matching coded ones in
				`Y_test` and `Y_train`

4) Then `features.txt_data.csv` is used on both `test_data.csv` and `train_data.csv` datasets to 
rename columns in a descriptive way.

5) Next `test_data.csv` and `train_data.csv` datasets are joined bind by row. A new dataset called
`1) rbinded.csv` is created. [found in UCI Result folder]

6) However, data pretaining only to mean and std of each measurement is retained. So data with
column names containing string of character mean or std is extracted. The resulting dataset is
called `2) extract.csv` [found in UCI Result folder]

7) Then `activity_labels.txt_data.csv` is used to relabel activities accomplished by each subject
in a descriptive way. The resulting dataset is called `3)and 4) labeled.csv`
[found in UCI Result folder]

8) Last it creates a second, independent tidy data set with the average of each variable for each 
activity and each subject. Appends the suffix _mean to each column of dataset except id and activity 
columns. The resulting dataset is called `5) tidy.txt` [found in UCI Result folder].

**5) tidy.txt dataset is the dataset of interest here.**

----------------
5) tidy.txt
----------------

The tidy dataset contains 180 rows over 81 columns.
Each record corresponds to average over activities and subjects of mean and standard deviation of different
Triaxial acceleration or angular velocity from the gyroscope carried by subjects and the estimated body 
acceleration while doing activities described in activity column.

The dataset has no NAs and names of columns are:

"id"                                   "activity"                             "tBodyAcc.std...X_mean"                "tBodyAcc.std...Y_mean"               
"tBodyAcc.std...Z_mean"                "tGravityAcc.std...X_mean"             "tGravityAcc.std...Y_mean"             "tGravityAcc.std...Z_mean"            
"tBodyAccJerk.std...X_mean"            "tBodyAccJerk.std...Y_mean"            "tBodyAccJerk.std...Z_mean"            "tBodyGyro.std...X_mean"              
"tBodyGyro.std...Y_mean"               "tBodyGyro.std...Z_mean"               "tBodyGyroJerk.std...X_mean"           "tBodyGyroJerk.std...Y_mean"          
"tBodyGyroJerk.std...Z_mean"           "tBodyAccMag.std.._mean"               "tGravityAccMag.std.._mean"            "tBodyAccJerkMag.std.._mean"          
"tBodyGyroMag.std.._mean"              "tBodyGyroJerkMag.std.._mean"          "fBodyAcc.std...X_mean"                "fBodyAcc.std...Y_mean"               
"fBodyAcc.std...Z_mean"                "fBodyAccJerk.std...X_mean"            "fBodyAccJerk.std...Y_mean"            "fBodyAccJerk.std...Z_mean"           
"fBodyGyro.std...X_mean"               "fBodyGyro.std...Y_mean"               "fBodyGyro.std...Z_mean"               "fBodyAccMag.std.._mean"              
"fBodyBodyAccJerkMag.std.._mean"       "fBodyBodyGyroMag.std.._mean"          "fBodyBodyGyroJerkMag.std.._mean"      "tBodyAcc.mean...X_mean"              
"tBodyAcc.mean...Y_mean"               "tBodyAcc.mean...Z_mean"               "tGravityAcc.mean...X_mean"            "tGravityAcc.mean...Y_mean"           
"tGravityAcc.mean...Z_mean"            "tBodyAccJerk.mean...X_mean"           "tBodyAccJerk.mean...Y_mean"           "tBodyAccJerk.mean...Z_mean"          
"tBodyGyro.mean...X_mean"              "tBodyGyro.mean...Y_mean"              "tBodyGyro.mean...Z_mean"              "tBodyGyroJerk.mean...X_mean"         
"tBodyGyroJerk.mean...Y_mean"          "tBodyGyroJerk.mean...Z_mean"          "tBodyAccMag.mean.._mean"              "tGravityAccMag.mean.._mean"          
"tBodyAccJerkMag.mean.._mean"          "tBodyGyroMag.mean.._mean"             "tBodyGyroJerkMag.mean.._mean"         "fBodyAcc.mean...X_mean"              
"fBodyAcc.mean...Y_mean"               "fBodyAcc.mean...Z_mean"               "fBodyAcc.meanFreq...X_mean"           "fBodyAcc.meanFreq...Y_mean"          
"fBodyAcc.meanFreq...Z_mean"           "fBodyAccJerk.mean...X_mean"           "fBodyAccJerk.mean...Y_mean"           "fBodyAccJerk.mean...Z_mean"          
"fBodyAccJerk.meanFreq...X_mean"       "fBodyAccJerk.meanFreq...Y_mean"       "fBodyAccJerk.meanFreq...Z_mean"       "fBodyGyro.mean...X_mean"             
"fBodyGyro.mean...Y_mean"              "fBodyGyro.mean...Z_mean"              "fBodyGyro.meanFreq...X_mean"          "fBodyGyro.meanFreq...Y_mean"         
"fBodyGyro.meanFreq...Z_mean"          "fBodyAccMag.mean.._mean"              "fBodyAccMag.meanFreq.._mean"          "fBodyBodyAccJerkMag.mean.._mean"     
"fBodyBodyAccJerkMag.meanFreq.._mean"  "fBodyBodyGyroMag.mean.._mean"         "fBodyBodyGyroMag.meanFreq.._mean"     "fBodyBodyGyroJerkMag.mean.._mean"    
"fBodyBodyGyroJerkMag.meanFreq.._mean"