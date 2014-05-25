GCDCourseProject
================

Course Project for Getting and Cleaning Data of the JH Data Science Coursera Specialization Track.

=====================================================================================
Hello, peer grader. I hope you also got a kick out of this assignment! Haha! But hey, we've made it this far, so let's get to grading!!

This ReadMe contains the general information on my course project. 
First, here are the complete instructions for this project (directly from the website):
=====================================================================================
General instructions for this project
=====================================================================================
"The purpose of this project is to demonstrate your ability to collect, work with, and clean 
a data set. The goal is to prepare tidy data that can be used for later analysis. You will 
be graded by your peers on a series of yes/no questions related to the project. You will be 
required to submit: 1) a tidy data set as described below, 2) a link to a Github repository 
with your script for performing the analysis, and 3) a code book that describes the variables, 
the data, and any transformations or work that you performed to clean up the data called 
CodeBook.md. You should also include a README.md in the repo with your scripts. This repo 
explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see 
for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop 
the most advanced algorithms to attract new users. The data linked to from the course website 
represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full 
description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

 You should create one R script called run_analysis.R that does the following. 
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive activity names. 
Creates a second, independent tidy data set with the average of each variable for each 
activity and each subject. 
Good luck!"
=====================================================================================
=====================================================================================
Now then,

As said above, the information needed to run the run_analysis.R code can be downloaded
here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

'run_analysis.R', is the code that does the required assignment, including creating the 
final txt file with the tidy dataset.This script assumes that the needed files are in 
the working directory. Once you have downloaded the folder with all the necessary files,
you just type in your working directory in setwd() that I have placed in the code.

'tidyData.txt' is the final dataset that I obtained with 'run_analysis.R'. It is file of 180
rows and 81 columns. The 180 rows refer to each subject (30) and each activity they did
(each subject did 6 activities), thus leading to 30*6 = 180 different rows. The columns
refer to each measurement that was taken. There are a total of 79 measurements, and the
other two columns are for Subject and Activity.

'CodeBook.md' contains the descriptions of the variables. You can go here to see what each
variable refers to, although I did not rename the variables to something more English-like
because I could not find where to find these. The original variables had a format with '-()'
and that was taken out for the final dataset.

=====================================================================================


