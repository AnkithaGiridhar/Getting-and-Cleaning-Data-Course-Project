X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
                            
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

X_main <- rbind(X_train, X_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)

mean_std_cols <- grep("-(mean|std).*", as.character(features$V2))
X <- X_main[mean_std_cols]
df <- cbind(subject, X, y)

mean_std_colnames <- features[mean_std_cols, 2]
mean_std_colnames <- gsub("-mean", "Mean", mean_std_colnames)
mean_std_colnames <- gsub("-std", "Std", mean_std_colnames)
mean_std_colnames <- gsub("[-()]", "", mean_std_colnames)
colnames(df) <- c("Subject", mean_std_colnames, "Activity")

df$Activity <- factor(df$Activity, levels = activity_labels$V1, labels = activity_labels$V2)
df$Subject <- factor(df$Subject)

library(reshape2)
df_melt <- melt(df, id = c("Subject", "Activity"), na.rm = TRUE)
tidy_df <- dcast(df_melt, Subject + Activity ~ variable, mean)

write.table(tidy_df, "Tidy_Data.txt", row.names = FALSE, quote = FALSE)