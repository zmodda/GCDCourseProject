==============================================================================
This codebook is a reference for the description of the variables, data, the transformations or work I performed to clean up the data.
==============================================================================

The script is documented, but I'll go over the general idea here.

1. As said in the ReadMe, this program assumes that you have the needed files in your working directory.
If not, you can download them here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
And then save them to your working directory.

Once you have saved them, set your directory to where you unzipped the UCI HAR Dataset zip is by putting the path in setwd:
setwd("C:\\Users\\adriana dominguez\\Documents\\CourseraDataScience\\GCData\\UCI HAR Dataset")

2. We retrieve the train and test sets from the folder, and save them as dsTrain and dsTest so that the original datasets (training Set and testSet) are not touched (I do this in case of mistakes).

3. Now we get the features (labels of the whole data set). These features are the labels of the training and test datasets.

4. The subjects are the people who were studied, and this information is taken from subject_train and subject_test. We label each of these columns as 'subject' to later stick them to the whole datasets (dsTrain and dsTest).

5. The activities that the subjects did are walking, walking upstairs, walking downstairs, sitting, standing, and laying. We get these from y_train and y_test, and once we read them, we translate the activites (they are originally in number form) to words such as 'walking' or 'walking.upstairs'. Then, we stick it (columnwise) onto each respective dataset (dsTrain and dsTest).

6. Once we have each training and test set with their activities, subjects and features, we stick these two huge sets together row-wise into 'mydata'.

7. We only focus on those columns that are about mean or standard deviation, so we use grep for this. I included meanFreq because I didn't know how else to avoid it, and didn't want to make a mess. There was a small discussion about this in the forums, so I decided to include it anyway.

stdSubset is the subset of mydata that only includes columns with the work 'std' in it.
promSubset is the subset of mydata that includes 'mean' in the name.

8. We create 'cleandata' which is stdSubset + promSubset + subjects + activities

9. Change the labels of the variables of those that have () or - to just names that have nothing between the words. I didn't change all the labels to lowercase because I wanted to be able to read them somehow. There was also some discussion of this in the forums, but I left a mix of capital and lowercase letters because I didn't want to include '.' in these names. You can change this with lower(). I also didn't change the names to something more English-like because I couldn't find the whole descriptions of the variables.

10. We make a table to confirm our activity a subject data, and we see that each subject did each of the activities.

11. Finally, we melt and dcast the data to have a last dataset where each row will correspond to a combination of a subject and activity. The melted data will be in meltedData, and the final dataset will be tidyData.

12. We save the tidyData set to tidyData.txt and find it in our working directory path. Yay!

=====================================================================================
Variables in the run_analysis script
=====================================================================================
The variables used in the script are (in order of their appearance):

trainingSet: contains the dataset X_train.txt from the zip

testSet: contains the dataset X_test.txt from the zip

features: contains the features.txt from the zip (table of 561x2)

featureLabels: contains the second column of the features table

dsTrain: copy of trainingSet

dsTest: copy of testSet

subjectTrain: contains the subject_train.txt set from the zip

subjectTest: contains the subject_test.txt from the zip

activity: vector that contains the translation of the numeric activities to words. This variable is used for both the dsTrain and dsTest sets.

mydata: is the whole merged dataset, with dsTrain, dsTest, subjects and activities. It's a dataset of 10299x563.

stdSubset: subset of mydata that contains only those columns with 'std' in their name.

promSubset: subset of mydata that contains only those columns with 'mean' in their name. This includes meanFreq because it can also be understood that way. MeanFreq is the weighted average of the frequency components to obtain a mean frequency.

cleandata: subset of mydata that contains stdSubset, promSubset, subject and activity from mydata (mydata$subject, and mydata$activity).

meltedData: melted data of cleandata, with respect to subject and activities of cleandata. This is a dataset of 83621x4.

tidyData: dcast of meltedData and with the aggregate function being mean. This is our final tidy data set that is then saved to a txt. This is a dataset of 180x81.

=====================================================================================
Variables in the Datasets
=====================================================================================

****The variables in the actual datasets are the following: (taken directly from the features.txt in the zip).****

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'
=====================================================================================
