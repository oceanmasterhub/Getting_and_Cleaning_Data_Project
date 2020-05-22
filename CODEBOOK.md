---
title: <span style="color:steelblue"> Getting and Cleaning Data </span>
subtitle: <span style="color:lightblue"> Course Project - Version 1.0 (May, 2020) </span>
output: html_document
---

***
### <span style="color:orange"> CODEBOOK </span>
***

**INFO** -- The script file `run_analysis.R` performs the following tasks:

**1. Download files from source:** "UCI HAR Dataset.zip" file is downloaded from the following online source and unzipped into the default local folder (a.k.a. working directory): <http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip>

**2. Read data files of interest:** The following files are loaded for the purpose of this script [rows, columns]

  * **'x_train.txt'** [7352 x 561] -- Training data
  * **'y_train.txt'** [7352 x 1] -- Training set labels
  * **'subject_train.txt'** [7352 x 1] -- Subject identifier for training set
  
  * **'x_test.txt'** [2947 x 561] -- Test data
  * **'y_test.txt'** [2947 x 1] -- Test set labels
  * **'subject_test.txt'** [2947 x 1] -- Subject identifier for test set

  * **'features.txt'** [561 x 2] -- Links feature identifiers with feature names
  * **'activity_labels.txt'** [6 x 2] -- Links activity identifier with activity names

**3. Merge data into a single dataset:** Loaded data files of both *train* and *test* data are appropriately combined by rows and columns into a single object called "dataset", whose first two columns are termed "subject" and "activity" and followed by 561 columns with feature values:

  * **dataset** [10299 x 563]

**4. Extract only "mean" and "std" measurements:** Feature names are scanned to find and keep only those variables containing measurements of mean `[mean()]` and standard deviation `[std()]` values. The *dataset* dataframe is then reduced from 563 to 68 columns:

  * **dataset** [10299 x 68]

**5. Set descriptive activity and feature names:** Activity labels are converted to cualitative factor levels, whereas feature names are modified to improve readability avoiding abbreviations (e.g.: "Acc" translates into "Accelerometer"). See original source files for more information.

**6. Create and export a tidy data set of averaged feature values:** A summary dataset is created by computing the average (mean) of every feature value grouping by common subject-activity pairs, which reduces the *dataset* from 10299 to 180 rows.

  * **meanset** [180 x 68] -- Second dataset with averaged feature values by subject-activity pairs

This yields a unique row each for every combination of activity (N=6) and a subject identifier (N=30). A final step is then to create a tidy dataset with a simple 4-column scheme by converting all feature columns into a column pair of "feature name" vs. "feature value":

  * **tidyset** [11880 x 4] -- Tidy dataset with simple 4-column scheme: "subject (int) -- activity (chr) -- feature (chr) -- average (num)"

**OUTPUT** -- The *tidyset* dataframe is then exported as text file (847 KB) in the working directory named as "tidydataset.txt".

***
NOTE: *For further details, visit the README and related INFO files in the online source above*
***