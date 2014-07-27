## run_Analysis.R
The run_Analysis.R code does the following:
* It reads 7 files from the Samsung Galaxy S dataset. It does expect the files to be all in the current working directory (which is an assumption allowed to be made acording to the assignment). It then starts building a dataset from the separate files. 
* Features.txt is used to create columnnames for both 'X' files. 
* The code searches for relevant columns (the ones containing the mean and standard deviation of the raw data) and subsets both X files for just those columns. 
* Column names for both subject lists are changed for mergeability purposes
* The 'y' files are changed from numeric to factor vectors replacing the values with the correct names given in the activity labels file.
* The test X, y and subject object are bound together, the same for train X, y and subject objects.
* Column names for the 'y' columns in both sets are changed for mergeability purposes.
* The resulting test and train objects are bound together to get the base dataset.
* An aggregate function is used to average all variables per subject and activity, resulting in the Tidy Data Set
* Two column names are replaced for tidiness
* The tidy dataset is written away into the working directory as a text file, separated by spaces.