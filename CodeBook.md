Introduction

The script run_analysis.Rperforms the 5 steps described in the course project's definition.

First, all data are merged into one table both for test and train results.
Then, only columns with the mean and standard deviation measures are taken from the whole dataset. Then they are named properly (with names from features.txt).
Then, activityID is replaced with the proper name from activity_labels.txt
Finally, independent tidy data set  is generated using aggregate funcion  

Variables
x_train, y_train, x_test, y_test, subjects_train and subjects_test contain the data from the downloaded files.
x, y, subjects merge the previous datasets to further analysis.
features contains the correct names for the x_data dataset, which are applied to the column names stored in 
need_features contains the vector of desired data (mean or std) 
activity is the the vector activities variable.
result merges subjects, y,  and x  in a one dataset.
Finally,result2  contains then result tidy data set
