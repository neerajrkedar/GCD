Getting and Cleaning Data - Course Project

Summary

The course project requires a dataset divided in to several txt files to be brought together, sorted, cleaned up and summarised in order to produce a final tidy dataset.

Step by step

1. Read the txt files in to R objects. The data is now in 8 different data frames.

2. Merge columns of test data files in to one data frame. So you now have a data frame of 563 columns. Do the same with training data files.

3. Merge rows of the two data frames obtained from above step. You now have a single data frame with 10299 rows and 563 columns. Call the data frame 'alldata'.

4. Rename 1st and 2nd column of alldata to 'subject' and 'activity' respectively.

5. Sort the data frame 'alldata' first by the first column 'subject' and then by the second column 'activity'. This is done using function 'order'.

6. Using function 'gsub', replace integer entries in the 'activity' column of 'alldata' with the relevant activity entries. For example, '1' is replaced with 'walking' etc.

7. Rename the columns 3-563 of 'alldata' with the character values in the 'features' object.

8. Extract subset of data frame by column names which include the string 'mean' and 'std' using function 'grep'. Since this step eliminates columns 1 and 2, create a new data frame called 'alldatas' and cbind the first two columns of 'alldata' on to new data frame.

9. To complete the final step, it is important to extract the proper subset of the data frame 'alldatas' so as to calculate means. For this purpose, the activity column is converted to six factor levels. The data frame must be subset based on subject id and activity id taken together. In this step a data frame is created for a particular subject id and particular activity.

10. The column means are calculated using lapply and further, using cbind and rbind the relevant data frame called 'final' is created.

11. The last step in the process is to rename the column names of 'final' according to tidy data requirements. Camelcase is used in naming variables to improve readability.
