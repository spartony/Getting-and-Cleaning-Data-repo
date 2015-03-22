# Getting-and-Cleaning-Data-repo
Repo created for the peer assessment of the Getting and Cleaning Data Course Project, for the Getting and Cleaning Data MOOC provided by John Hopkins University on Coursera platform.

## Course Project
All project-related materials are in the UCI HAR Dataset directory.

Follow the instructions:

1. In R, set your Working Directory: setwd("<..your..path..>")

2. copy the run_analysis.R file in your wd

3. load the script with the source command in your R environment: source("run_analysis.R"). It will take more o less 15 seconds(it depends by the characteristics of your system  )

4. the script will automatically create the .txt file required (i.e. a tidy data set with the average of each variable for each activity and each subject) in the same directory. This file will be named "tidy_data_set_with_averages.txt" and it will be created in your wd directory.

5. You can use read.table("tidy_data_set_with_averages.txt") to read the data in R. It is a 180x68 table because there are 30 subjects and 6 activities, thus 30 * 6 = 180 rows, and 66 variables (plus subject and activity colums). 

The script will check if the original "getdata-projectfiles-UCI-HAR-Dataset.zip"" file is in your wd, if not it will download it. Then it will check if "UCI HAR Dataset" folder exist, if not it will unzip the zip file contents in a new directory with that name. Then the script will perform calculation and will produce the desired output file. Note that the provided R script has no assumptions on numbers of records, only on locations of files.