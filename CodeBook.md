# Peer-graded Assignment: Getting and Cleaning Data Course Project

1. Merging the training and the test sets.
2. Extracts mean and standard deviation.
3. Using descriptive activity names.
4. Appropriately labeling.
5. Creating second tidy dataset for average.

## About Varibles

*x_train*, *y_train*, *x_test*, *y_test* are the variables which contain the train and test datasets.

*merged_train* contains the merge table of train dataset and *subject_train* using cbind(). Similarly for *merged_test*

*entire_data* formed by merging *merged_train* and *merged_test* using rbind().

*mean_std_data* formed by patterning match the columns which contains mean, std, subID, actID in it.



