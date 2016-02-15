## Getting and Cleaning Data
#   Project
#You will be required to submit: 
#  1) a tidy data set as described below, 
#  2) a link to a Github repository with your script for performing the analysis, 
#  and 3) a code book that describes the variables, the data, and any transformations or work
# that you performed to clean up the data called CodeBook.md. You should also include a README.md 
# in the repo with your scripts. 
#This repo explains how all of the scripts work and how they are connected.
#Remove any previous output.
rm(list=ls())

 

#you must add "stringsAsFactors=FALSE" if you want the activity names instead of #s.
activityLabels<-read.table("activity_labels.txt",stringsAsFactors = FALSE) #Links the class labels with their activity name. (ex. walking)
colnames(activityLabels)=c("ActivityID","Activity")
features<-read.table("features.txt") #List of all features
colnames(features)=c("column","feature")

trainingSet<-read.table("./train/X_train.txt")  # X
trainingLabels<-read.table("./train/y_train.txt") #Y
subjectTrain<-read.table("./train/subject_train.txt") #Subject

testSet<-read.table("./test/X_test.txt") #X
testLabels<-read.table("./test/y_test.txt") #Y
subjectTest<-read.table("./test/subject_test.txt") #Subject

# Combine train and test datasets
subject <- rbind(subjectTrain, subjectTest)  #Subject
y <- rbind(trainingLabels, testLabels) #Y
x <- rbind(trainingSet, testSet) #X

colnames(subject) = c("subjectID")
colnames(y)= c("ActivityID")
ntimes=length(y[,1])  #10299

activityName=vector(mode="character",ntimes)
##Add Activity Names
for (n in 1:6) {
  activityName[y==n] <- activityLabels$Activity[n]
}

#Varibale 2 of the features include the info on mean/std/etc. types. Lowercase contains
# "mean()" "std()" 
#Determine which columns have the pattern mean OR std.
mean.std.Cols<-grep("mean|std",features$feature)
mean.std.features <- grep("mean|std",features$feature,value=TRUE) #value = True gives the names instead of index.

AllData.mean.std<-x[,mean.std.Cols]
colnames(AllData.mean.std)=mean.std.features

#Put together the rest of the information
Final.Data <- cbind(subject,activityName,AllData.mean.std)
ncol <- length(Final.Data[1,])

#From the data set in step 4, creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject. Average the data by subject and column
ActivityAverages = aggregate(Final.Data, by=list(subject=Final.Data$subjectID,activity=Final.Data$activityName), FUN=mean)

#This aggregate method gives me 2 extra columns that are unncessary for the output. Remove them.
TidyAverages<-ActivityAverages[,-3]
TidyAverages<-TidyAverages[,-3]

write.table(TidyAverages,file="tidy_average_data.txt",sep=",")
