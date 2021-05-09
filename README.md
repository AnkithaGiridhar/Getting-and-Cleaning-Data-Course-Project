---
title: "README"
output: 
  html_document: 
    keep_md: yes
---
## 1.Reading and Merging the Datasets
### The Train Data
X_train, y_train and subject_train are read into eponymous dataframes.

```r
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
```
### The Test Data 
X_test, y_test and subject_test are read into eponymous dataframes.

```r
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
```
### The Feature and Activity Data
The 'features' and 'activity_labels' are read into eponymous dataframes.

```r
features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
```
### Merging the datasets
Dataframes X_main,y, and subject are formed from X_train and X_test,y_train and y_test,subject_train and subject_test respectively.

```r
X_main <- rbind(X_train, X_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
```
## 2. Extracting solely the mean and standard deviation measurements.
The columns with mean measurements are read into mean_std_cols and these columns are extracted from X_main, which is then merged with y to form a new dataframe, df.

```r
mean_std_cols <- grep("-(mean|std).*", as.character(features$V2))
X <- X_main[mean_std_cols]
df <- cbind(subject, X, y)
```
## 3. Using descriptive activity names for each activity.
The names of the required columns are read into mean_std_colnames. These names are also cleaned by capitalising 'Mean' and 'Std' and removing unnecessary brackets. 

```r
mean_std_colnames <- features[mean_std_cols, 2]
mean_std_colnames <- gsub("-mean", "Mean", mean_std_colnames)
mean_std_colnames <- gsub("-std", "Std", mean_std_colnames)
mean_std_colnames <- gsub("[-()]", "", mean_std_colnames)
colnames(df) <- c("Subject", mean_std_colnames, "Activity")
```
## 4. Labeling the data with these descriptive activity names.
The column names from mean_std_colnames are used to rename the columns of df.

```r
colnames(df) <- c("Subject", mean_std_colnames, "Activity")
```
## 5. Generating a tidy dataset.
The subject and activity variables are taken as factors. Melting and casting is done on the dataframe to shape it correctly, using the reshape library. The subject and activity columns are taken as constant while melting the dataset, which is then recast.This tidy dataframe is written into Tidy_Data.txt

```r
df$Activity <- factor(df$Activity, levels = activity_labels$V1, labels = activity_labels$V2)
df$Subject <- factor(df$Subject)

library(reshape2)
```

```
## Warning: package 'reshape2' was built under R version 4.0.5
```

```r
df_melt <- melt(df, id = c("Subject", "Activity"), na.rm = TRUE)
tidy_df <- dcast(df_melt, Subject + Activity ~ variable, mean)

write.table(tidy_df, "Tidy_Data.txt", row.names = FALSE, quote = FALSE)
```
