---
title: <span style="color:steelblue"> Getting and Cleaning Data </span>
subtitle: <span style="color:lightblue"> Course Project - Version 1.0 (May, 2020) </span>
output: html_document
---

***
### <span style="color:orange"> README </span>
***

**INFO** -- The script file `run_analysis.R` performs the following tasks:

  1. Download data files from online source and unzip into working directory
  2. Read features and activity names, train and test data from unzipped files
  3. Merge train and test data parts together into a single dataset
  4. Extract only "mean" and "std" measurements
  5. Set descriptive activity and feature names
  6. Create and export a tidy dataset of averaged feature values
  
**OUTPUT** -- A text file named *"tidydataset.txt"* is created in default local folder

***

<span style="color:blue"> Reference: </span> <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

<span style="color:blue"> Data: </span> <http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip>

***

