# Code explanation

The analysis code is seperated in 5 steps

## Step 1: Merging data sets

rbind functions are used to concatenate respective data from test and train to create the next variables:

subject_data
activity_data
x_data

cbind function is then used to combine the subject, y_data (activities) and the x_data:

merged_data

##Step 2: Select only the mean and standard variation features (x_data columns)

After loading the features data, we use regular expression to select only the columns that the name contains "mean" or "std

The variable selected_x_data is created from the x_data by selecting only the columns found with the regular expressions.

We can then create the new data set by combining the columns (subject_data, activity_data and selected_x_data) with cbind:

meanstd_data

##Step 3: Using the activity names

We merge the activity_data variable with the newly loaded activity_label table to create a 2 column data set
Column 1 the ID and 2 the name.

We use only the 2nd column to create the new complete dataset with cbind. The combined column will be Subject, Activity and selected_x_data

##Step 4: Label the data set

We use regular expressions to remove the undesired characters.
We also make sure the Subject and Activity column are approprietly labeled.

##Step 5: Create independent tidy data

We use the ddply function to calculate the mean of every column combined by Activity and Subject.
