########################################################################
##### Course Project #### Getting and Cleaning Data  #### May 2014 #####
########################################################################

## The purpose of this project is to demonstrate your ability to collect, 
## work with, and clean a data set. The goal is to prepare tidy data 
## that can be used for later analysis. You will be graded by your peers 
## on a series of yes/no questions related to the project. You will be 
## required to submit: 
##   1) a tidy data set as described below, 
##   2) a link to a Github repository with your script for performing 
##      the analysis, and 
##   3) a code book that describes the variables, the data, and any 
##      transformations or work that you performed to clean up the data 
##      called CodeBook.md. You should also include a README.md in the 
##      repo with your scripts. This repo explains how all of the 
##      scripts work and how they are connected.  

## Here are the data for the project: 
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## You should create one R script called run_analysis.R that does the following. 
##   1. Merges the training and the test sets to create one data set.
##   2. Extracts only the measurements on the mean and standard deviation for 
##      each measurement. 
##   3. Uses descriptive activity names to name the activities in the data set
##   4. Appropriately labels the data set with descriptive activity names. 
##   5. Creates a second, independent tidy data set with the average of each 
##      variable for each activity and each subject. 
## Good luck!
########################################################################

## This program assumes that you have the needed files in your working directory.
## If not, you can download them here:
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## And then save them to your working directory.

## Set your directory to where you unzipped the UCI HAR Dataset zip.
setwd("C:\\Users\\adriana dominguez\\Documents\\CourseraDataScience\\GCData\\UCI HAR Dataset")

#### Get the train and test sets from the folder.
trainingSet <- read.table(".\\train\\X_train.txt",stringsAsFactors=FALSE,header=FALSE)
testSet <-  read.table(".\\test\\X_test.txt",stringsAsFactors=FALSE,header=FALSE)
dim(trainingSet)
dim(testSet)

##> dim(trainingSet)
##[1] 7352  561
##> dim(testSet)
##[1] 2947  561

#### Get the features (labels of the whole data set).
features <- read.table(".\\features.txt",stringsAsFactors=FALSE,header=FALSE)
head(features)
dim(features)
##> dim(features)
##[1] 561   2
featureLabels <- features[,2]

## dsTrain and dsTest will be the same as trainingSet and testSet
## That way, if we mess up, we have the originals safe.
dsTrain <- trainingSet
dsTest <- testSet
names(dsTrain) <- featureLabels
names(dsTest) <- featureLabels

#### Get the subjects.
subjectTrain <- read.table(".\\train\\subject_train.txt",stringsAsFactors=FALSE,header=FALSE)
subjectTest <-  read.table(".\\test\\subject_test.txt",stringsAsFactors=FALSE,header=FALSE)
names(subjectTrain) <- c("subject")
names(subjectTest) <- c("subject")
dim(subjectTrain)
dim(subjectTest)
##> dim(subjectTrain)
##[1] 7352    1
##> dim(subjectTest)
##[1] 2947    1

#### Put subject data in each dataset (train and test)
dsTrain <- cbind(dsTrain,subjectTrain)
dsTest <- cbind(dsTest,subjectTest)

#### Get the activities.
trainingNames <- read.table(".\\train\\y_train.txt",stringsAsFactors=FALSE,header=FALSE)
testNames <-  read.table(".\\test\\y_test.txt",stringsAsFactors=FALSE,header=FALSE)
activity <- c()

## activity is the same as trainingNames, but with actual names
for (i in 1:nrow(trainingNames)) {
	if (trainingNames[i,] == 1) activity[i] <- "walking"
	if (trainingNames[i,] == 2) activity[i] <- "walking.upstairs"
	if (trainingNames[i,] == 3) activity[i] <- "walking.downstairs"
	if (trainingNames[i,] == 4) activity[i] <- "sitting"
	if (trainingNames[i,] == 5) activity[i] <- "standing"
	if (trainingNames[i,] == 6) activity[i] <- "laying"
}
## Put activities in training data set
dsTrain <- cbind(dsTrain,activity)

activity <- c()
## activity is the same as testNames, but with actual names
for (i in 1:nrow(testNames)) {
	if (testNames[i,] == 1) activity[i] <- "walking"
	if (testNames[i,] == 2) activity[i] <- "walking.upstairs"
	if (testNames[i,] == 3) activity[i] <- "walking.downstairs"
	if (testNames[i,] == 4) activity[i] <- "sitting"
	if (testNames[i,] == 5) activity[i] <- "standing"
	if (testNames[i,] == 6) activity[i] <- "laying"
}
## Put activities in test data set
dsTest <- cbind(dsTest,activity)

## Combine the datasets dsTrain and dsTest
mydata <- rbind(dsTrain,dsTest)

## mydata is the raw combined data set
dim(mydata)
##> dim(mydata)
##[1] 10299   563

## Take out the columns that contain only 'std' or something with 'mean'
## in their name (this includes meanFreq)
stdSubset <- mydata[,grep(c("std()"), colnames(mydata))]
promSubset <- mydata[,grep(c("mean()"), colnames(mydata))]

## Put together the clean dataset that contains only those columns with
## std or mean, and of course the subjects and activities
cleandata <- cbind(stdSubset,promSubset,subject=mydata$subject,activity=mydata$activity)

## Change the names of the variables (take out the ())
names(cleandata) <- gsub("-", "", names(cleandata)) # take out '-' from the names and replace with ""
names(cleandata) <- gsub("mean", "avg", names(cleandata)) # replace 'mean' with 'avg' because 'mean' was giving me trouble
names(cleandata) <- gsub("\\()", "", names(cleandata)) # take out the () and replace with ""
head(cleandata)
##> head(cleandata)
##  tBodyAccstdX tBodyAccstdY tBodyAccstdZ tGravityAccstdX tGravityAccstdY
##1   -0.9952786   -0.9831106   -0.9135264      -0.9852497      -0.9817084
##2   -0.9982453   -0.9753002   -0.9603220      -0.9974113      -0.9894474
##3   -0.9953796   -0.9671870   -0.9789440      -0.9995740      -0.9928658
##4   -0.9960915   -0.9834027   -0.9906751      -0.9966456      -0.9813928
##5   -0.9981386   -0.9808173   -0.9904816      -0.9984293      -0.9880982
##6   -0.9973350   -0.9904868   -0.9954200      -0.9989793      -0.9867539

table(cleandata$subject,cleandata$activity)
##> table(cleandata$subject,cleandata$activity)
##    
##     laying sitting standing walking walking.downstairs walking.upstairs
##  1      50      47       53      95                 49               53
##  2      48      46       54      59                 47               48
##  3      62      52       61      58                 49               59
##  4      54      50       56      60                 45               52
##  5      52      44       56      56                 47               47
##  6      57      55       57      57                 48               51
##  7      52      48       53      57                 47               51
##  8      54      46       54      48                 38               41
##  9      50      50       45      52                 42               49
##  10     58      54       44      53                 38               47
##  11     57      53       47      59                 46               54
##  12     60      51       61      50                 46               52
##  13     62      49       57      57                 47               55
##  14     51      54       60      59                 45               54
##  15     72      59       53      54                 42               48
##  16     70      69       78      51                 47               51
##  17     71      64       78      61                 46               48
##  18     65      57       73      56                 55               58
##  19     83      73       73      52                 39               40
##  20     68      66       73      51                 45               51
##  21     90      85       89      52                 45               47
##  22     72      62       63      46                 36               42
##  23     72      68       68      59                 54               51
##  24     72      68       69      58                 55               59
##  25     73      65       74      74                 58               65
##  26     76      78       74      59                 50               55
##  27     74      70       80      57                 44               51
##  28     80      72       79      54                 46               51
##  29     69      60       65      53                 48               49
##  30     70      62       59      65                 62               65

## Melt and dcast the data to create the last dataset format that we want
## (one row per subject * activity) which will lead to a total of 180 rows
## because each subject (30 in total) did each activity (6).
## We need two libraries for this part:
library(reshape2)
library(plyr)

meltedData <- melt(cleandata, id.vars = c("subject", "activity"))
tidyData <- dcast(meltedData, subject + activity~variable,mean) ## Our final dataset!
dim(tidyData)
head(tidyData)

## Some results:
## > dim(tidyData)
## [1] 180  81
## > head(tidyData)
##  subject           activity tBodyAccstdX tBodyAccstdY tBodyAccstdZ tGravityAccstdX
##1       1             laying  -0.92805647 -0.836827406  -0.82606140      -0.8968300
##2       1            sitting  -0.97722901 -0.922618642  -0.93958629      -0.9684571
##3       1           standing  -0.99575990 -0.973190056  -0.97977588      -0.9937630
##4       1            walking  -0.28374026  0.114461337  -0.26002790      -0.9766096
##5       1 walking.downstairs   0.03003534 -0.031935943  -0.23043421      -0.9505598
##6       1   walking.upstairs  -0.35470803 -0.002320265  -0.01947924      -0.9563670
##  tGravityAccstdY tGravityAccstdZ tBodyAccJerkstdX tBodyAccJerkstdY tBodyAccJerkstdZ
##1      -0.9077200      -0.8523663      -0.95848211       -0.9241493       -0.9548551
##2      -0.9355171      -0.9490409      -0.98643071       -0.9813720       -0.9879108
##3      -0.9812260      -0.9763241      -0.99460454       -0.9856487       -0.9922512
##4      -0.9713060      -0.9477172      -0.11361560        0.0670025       -0.5026998
##5      -0.9370187      -0.8959397      -0.01228386       -0.1016014       -0.3457350
##6      -0.9528492      -0.9123794      -0.44684389       -0.3782744       -0.7065935

## Write the tidyData set to a txt file called 'tidyData'
write.csv(tidyData,file='tidyData.txt')
## You should see this file in your working directory.

####### You can use this to clean the workspace, and have a fresh start.
rm(list=ls())

