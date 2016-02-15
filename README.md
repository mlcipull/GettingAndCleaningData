# GettingAndCleaningData
Course 3 in the data science specialization from Coursera

This repository contains my work for the course project in the Getting and Cleaning Data Project.

the run_analysis.R code is what was used to create a "tidy" dataset according to course guidelines.
This script does the following:
1. Reads data from the UCI HAR dataset (this is data about activity performed by subjects wearing a tracker).
2. Merges the datasets
3. Only keeps information on the mean and standard deviations of the measurements.
4. Gives the data relevant names for all variables
5. Aggregates data to give the average of each variable of each variable for each activity and each subject.
6. Creates a file with this new "tidy" dataset. 
