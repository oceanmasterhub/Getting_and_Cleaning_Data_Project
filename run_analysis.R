# -------------------------------------------------------------------------------------------------
# 1. DOWNLOAD FILES FROM SOURCE
# -------------------------------------------------------------------------------------------------

# Data source
zipURL <- "http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip"

# Download from source and unzip files into local folder
if (!file.exists("UCI HAR Dataset.zip")) {
  download.file(url= zipURL, destfile = "UCI HAR Dataset.zip") }

if (!dir.exists("UCI HAR Dataset")) {
  unzip(zipfile = "UCI HAR Dataset.zip", exdir = ".", unzip = "internal") }

# -------------------------------------------------------------------------------------------------
# 2. READ DATA FILES OF INTEREST
# -------------------------------------------------------------------------------------------------

# Read feature labels
label_feature <- read.table(
  file       = "./UCI HAR Dataset/features.txt",
  col.names  = c("feature_int","feature_chr"), stringsAsFactors = FALSE)

# Read activity labels
label_activity <- read.table(
  file       = "./UCI HAR Dataset/activity_labels.txt",
  col.names  = c("activity_int", "activity_chr"), stringsAsFactors = FALSE)

# Read train files
train_x       <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_y       <- read.table("./UCI HAR Dataset/train/y_train.txt")
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# Read test files
test_x       <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_y       <- read.table("./UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# -------------------------------------------------------------------------------------------------
# 3. MERGE DATA INTO A SINGLE DATASET
# -------------------------------------------------------------------------------------------------

# Merge train and test data
data_subject  <- rbind(train_subject, test_subject)
data_activity <- rbind(train_y, test_y)
data_feature  <- rbind(train_x, test_x)

# Set column names
names(data_subject)  <- "subject"
names(data_activity) <- "activity"
names(data_feature)  <- label_feature$feature_chr

# Merge subject, activity and feature data
dataset <- cbind(data_subject, data_activity)
dataset <- cbind(dataset, data_feature)

# -------------------------------------------------------------------------------------------------
# 4. EXTRACT ONLY "MEAN" AND "STD" MEASUREMENTS
# -------------------------------------------------------------------------------------------------

# Subset "mean" and "std" measurements
feature_subset <- label_feature$feature_chr[grep("mean\\(\\)|std\\(\\)", label_feature$feature_chr)]
dataset        <- subset(dataset, select = c("subject", "activity", feature_subset))

# -------------------------------------------------------------------------------------------------
# 5. SET DESCRIPTIVE ACTIVITY AND FEATURE NAMES
# -------------------------------------------------------------------------------------------------

# Descriptive activity names
dataset$activity <- factor(dataset$activity,
                           levels = sort(unique(dataset$activity)),
                           labels = label_activity$activity_chr)

# Descriptive feature names
names(dataset) <- gsub("^t"       , "time-"         , names(dataset))
names(dataset) <- gsub("^f"       , "freq-"         , names(dataset))
names(dataset) <- gsub("BodyBody" , "Body-"         , names(dataset))
names(dataset) <- gsub("Body"     , "Body-"         , names(dataset))
names(dataset) <- gsub("Gravity"  , "Gravity-"      , names(dataset))
names(dataset) <- gsub("Acc"      , "Accelerometer-", names(dataset))
names(dataset) <- gsub("Gyro"     , "Gyroscope-"    , names(dataset))
names(dataset) <- gsub("Mag"      , "Magnitude-"    , names(dataset))
names(dataset) <- gsub("Jerk"     , "Jerk-"         , names(dataset))
names(dataset) <- gsub("--"       , "-"             , names(dataset))

# -------------------------------------------------------------------------------------------------
# 6. CREATE AND EXPORT A TIDY DATA SET OF AVERAGED FEATURE VALUES
# -------------------------------------------------------------------------------------------------

# Create second dataset with averaged feature values
meanset           <- stats::aggregate(. ~ subject + activity, dataset, mean)
meanset           <- meanset[order(meanset$subject, meanset$activity), ]
rownames(meanset) <- 1:nrow(meanset)

# Use a tidy 4-column scheme: "subject-activity-feature-average"
tidyset           <- tidyr::gather(meanset, feature, average, 3:68)
tidyset           <- tidyset[order(tidyset$subject, tidyset$activity),]
tidyset$feature   <- factor(tidyset$feature, levels = unique(tidyset$feature))
rownames(tidyset) <- 1:nrow(tidyset)

# Export "tidyset" as text file
write.table(tidyset, file = "tidydataset.txt", row.names = FALSE)

# -------------------------------------------------------------------------------------------------
# END