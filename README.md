README
========
###Getting and Cleaning Data - Course Project

The first thing i did was analyze the data provided. I uploaded the data in RStudio and viewed how the data looks like. I also used "str" function to check further specifications. 

I worked on part 1 and 2 of the project together as i though it might take less time in subsetting the data in this manner. First i uploaded the "features.txt" file which included the features corresponding to the column numbers. I attached a "v" in the numbers and converted it into a character variable so that subsetting would be easier. 

Then i uploaded the Test Files and binded them into one data frame. I did the same with the Train files. Before biding i subsetted the columns for mean and standard deviation to make it faster. I merged the test and train sets with rbind. 

For step 3 i extracted the activity labels from the set given. As the labels seemed drescriptive enough i used the same labels and merged it into the dataset. 

For part 4 i manually made two vector sets to change the column names into something more understandable. I used mainly full names or abbreviation for terms like std (standard deviation), acc(acceleration), etc.

For part 5 i first melted the data set and used the dcast function to extract mean of each variable for each activity and each subject. 
To make the dataset more understandable i extraced the coordinates (X, Y, Z, and MAG) from each variable and made a seperate column for the same. I included MAG in the coordinates column as MAG is the magnitude of the three-dimensional signals that was calculated using the Euclidean norm. This reduced the wideness of the dataset and made the rest of the variables much more understandable. 
As i could not find an easier way to clean up the data for extracting Coordinates i manually extracted them. 

The output is written in TidyData.txt
