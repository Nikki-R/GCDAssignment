## Analysis Description

The run_analysis.R script completes the following tasks:

1.Merges the training and the test sets to create one data set.

2.Extracts only the measurements on the mean and standard deviation for each measurement.

3.Uses descriptive activity names to name the activities in the data set.

4.Appropriately labels the data set with descriptive variable names. 

5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

# Script outputs

The script creates two key tables: mergedlab and tidy.

mergedlab fulfils steps 1-4 (is the merged data with mean() and std() columns for each measure).
Note that meanFreq() columns were excluded from this - only those displaying either mean() or std() were selected in step 2.

tidy fulfils step 5, and shows the mean, grouped by subject and activity, for each of the other 66 variables in mergedlab.

The codebook.Rmd file lists and explains the variables in the 'tidy' table.
