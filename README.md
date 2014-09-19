Course Project I : Getting and Cleaning Data.
=============================================
---------------------------------
The assignment with library plyr
---------------------------------
The purpose of this project is to demonstrate your ability to collect, work with, and 
clean a data set. The goal is to prepare tidy data that can be used for later analysis. 
You will be graded by your peers on a series of yes/no questions related to the project. 
You will be required to submit: 1) a tidy data set as described below, 2) a link to a 
Github repository with your script for performing the analysis, and 3) a code book that 
describes the variables, the data, and any transformations or work that you performed to 
clean up the data called CodeBook.md. You should also include a README.md in the repo 
with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see 
for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop 
the most advanced algorithms to attract new users. The data linked to from the course website 
represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

You should create one R script called run_analysis.R that does the following. 
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
From the data set in step 4, creates a second, independent tidy data set with the average 
of each variable for each activity and each subject.

---------------------
Results of assignment
---------------------
You will find in your current working directory a
compressed file called getdata-projectfiles-UCI HAR Dataset.zip
which is the original downloaded file, and a file UCI HAR Dataset
its unzipped (uncompressed) counterpart containing all relevant
datasets. Additionally, in file UCI Results you will find datasets
built by run_analysis.R script. Those labeled 1 to 5 are datasets
built in answer to questions of corresponding number of the project
as for the rest they are transitionary datasets not of interest here.
<br>**The end dataset of interest is called 5) tidy.txt**

--------------------------
R script : run_analysis.R
--------------------------
The R script is intitled run_analysis.R and here is a brief description of it.
The whole script needs about two to three minutes to run depending on internet
connection speed.

The script itself is divided in 4 main part.
Part I and IV are completely self-explanatory.
Instead this document first will focus on describing the internal functioning of fun-
ctions `readdata` in part II and `collage` in part II.

	`readdata`
The function readdata accepts four values: "activity_labels.txt" "features.txt"
"test" or "train". Input of any value different than these will end up in an 
end of the function with an error message "No such file or directory." as can
be gathered from line 66 of the function.

Line 22 observes if names entered end by .txt and if such file is found in 
UCI HAR Dataset folder in current working directory. This file should have been
created during uncompression in the current working directory. However if the 
above criterias are not met the function looks if the name provided is a file 
name in UCI HAR Dataset folder at line 54. If both criterias are not met then
the error message at line 22 is run.

If dataname entered is of type .txt, then the function reads the table directly
renames the columns num and labels, as both .txt files have only two columns
comtaining number id and labels in that order. Then makes some observation on data
structure of lines 28 to 31, if NAs exist in line 33 to 34 and a small nested if
looks at if some values for labels column are repeated and how often on line 37 to
49. In the end this observation are printed on console.

If dataname entered is a file name in UCI HAR Dataset folder, then the function at
line 54 looks for files ending with .txt in the entered folder [not sub folders], 
creates a1 a2 a3 indexed variables and assigns to them the three different files
in the folder. Then a1 a2 a3 are loaded on line 60 and binded together by column
using c bind command in line 62.

Then the function looks at if a file called UCI Results exists in current working
directory and creates it if not, at line 70. In the end data created by one of the
two methods described above are saved in UCI Results file under the name 
dataname_data.csv So ones all files needed are readdata we will have "activity_labels.txt_data"
"features.txt_data" "test_data" and "train_data" datasets saved in UCI Results file.
These are transitionary files used in the next function only not of interest for
the assignment.

	`collage`
The function collage accepts only one value called "all". If any other value is entered,
the function stops process and prints error message "Please enter valid command : collage(all)"
at line 123 of our script.
First the function looks at if in file UCI Results "activity_labels.txt_data"
"features.txt_data" "test_data" and "train_data" datasets exist. If not, the function
will print error message "Please readdata all files: `activity_labels.txt`, `features.txt`, 
`test` and `train`." on line 121.
Then the above four files are loaded and named one two three four respectively, on lines
90 to 93, the first column of each is removed because they represent rownames column
leftover of the `readdata` function. Then two new lines having values of "id" and
"activity" for both variables are added in the begining and end respectively of features.txt_data
dataset on line 99 to 103. Next on line 105 & 106 the labels column of features.txt_data
is used to label both "test_data" and "train_data" datasets. 

These two datasets then are joined by row using rbind, put into data.frame mode and saved in 
UCI Results file labeled "1)rbinded.csv" this creates dataset asked for in question 1 of the 
assignment.

Next, "id", "activity" columns and columns containing the word mean or std in their names
are extracted. The resulting dataset is saved under "2)extract.csv" in UCI Results file.
This file is built in answer to question 2 of assignment.

Next, on lines 113 to 114 the function uses factor function to paste descriptive activity 
names to name the activities in the data set, and appropriately labels the data set with 
descriptive variable names. The resulting dataset is saved under 3)and4)labeled.csv in
UCI Results file in answer to questions 3 and 4 of assignment.

then lines 116 to 118 of the function creates a last, independent tidy data set with the 
average of each variable for each activity and each subject using ddply function of plyr
library. Then columns of dataset are relabeled by adding "_mean" suffix to there already
existing names, except for the columns id and activity. The resulting tidy dataset is
saved under "5)tidy.txt" in UCI Results file in answer to question 5 of assignment.

	`Part I`
The first part of the R script 1) Directely downloads data called getdata-projectfiles-UCI HAR Dataset.zip 
from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" to current 
working directory. Then uncompresses this file creating file UCI HAR Dataset in current working directory. 
And loads library plyr.

	`Part IV`
The last part use readdata function to read data "activity_labels.txt", "features.txt" and all
data contained in "test" or "train" files in UCI HAR Dataset. Then uses collage function to create
different datasets as described above.
Read "Results of assignment" part above for descritpion of resulting datasets.


                        