---
title: "Codebook"
output: 
  html_document: 
    keep_md: yes
---



## Getting and Cleaning Data Course Project - Codebook
### Raw Data
The raw data was the Human Activity Recognition Using Smartphones Dataset available at this link: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### Cleaning the Dataset
1. Reading and Merging the datasets.
2. Extracting solely the mean and standard deviation measurements.
3. Using descriptive activity names for each activity.
4. Labeling the data with these descriptive activity names.
5. Generating a tidy dataset.
The script with the work done above is further detailed in the README.md file.

### The Tidy Data
The Tidy_Data.txt file contains the cleaned-up dataset. This is the output of the run_analysis.R file. The data includes 79 variables of measurement for each of six activities for each of 30 subjects.<br/>
The 'Subject' variable identifies the subject, while the 'Activity' variable identifies the activities - "WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"<br/>
The measurements can be understood with the following information:<br/>
1. Each variable name will contain either 'Acc' or 'Gyro', indicating whether an accelerometer or gyrometer was used for measurement.<br/>
2. Most variables have 'Body' in the name, but the 'Acc' signals might have 'Gravity' instead, as the accelerometer signal was derived into the body acceleration signal and gravity acceleration signal.<br/>
3. 'Mean' and 'Std' indicate whether the measurement is a mean or standard deviation value.<br/>
4. The '-XYZ' suffix on some signals indicates the direction of measurement.These 3D signals also have magnitudes calculated in the 'Mag' variables.<br/>
5. The 'MeanFreq' columns contain the weighted averages of the frequency columns.<br/>
6. The body linear acceleration and angular velocity were derived in time to obtain 'Jerk' signals.<br/>
7. The 'f' and 't' prefixes indicate Fast Fourier Transforms and Time Domain signals respectively.
