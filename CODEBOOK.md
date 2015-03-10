  This codebook is concerning the datas and variables used in this reposity for getting and cleaning data course project. 
  All the txt tiles are download for the course website and stroed in the folder UCI HAR Dataset in the local computer.
  -----------------
 Subject: the subjects who take the tests and trains, data from the file subject_test.txt and subject_train.txt. Values between 1 to 30.
 Label: the type of activity a object take, including types of sports and movements.
 ------------------
 hese signals were used to estimate the mean of the variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
BodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

-----------------
 The set of variables that were estimated from these signals are: 
mean(): Mean value
std(): Standard deviation

------------------
Ways to get the clean data:
---------
library(tidyr)
#first to read the files and stroe them into the computer

x_test<-read.table("UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("UCI HAR Dataset/test/y_test.txt")
s_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
names(s_test)<-"Subject"
names(y_test)<-"Label"
xdata<-cbind(x_test,y_test,s_test)
x_train<-read.table("UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("UCI HAR Dataset/train/y_train.txt")
s_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
names(y_train)<-"Label"
names(s_train)<-"Subject"
ydata<-cbind(x_train,y_train,s_train)
dataset<-bind_rows(xdata,ydata)

##merge the datasets into one

features<-read.table("UCI HAR Dataset/features.txt")

#load the features table

f1<-features$V2

#subset the column with the name of the method and tolower it

feature1<-grep("mean()",f1,fixed=TRUE)

#select data from the features whose name include exactly mean()

feature2<-grep("std()",f1,fixed=TRUE)

#select data from the features whose name include exactly std()

featuredata<-c(feature1,feature2)

#put the two features data together so the list is rows in features which use the method of mean and std

namedata<-f1[featuredata]
datasel<-dataset[,featuredata]

#subset the data we want from the dataset

names(datasel)<-namedata
datafin<-cbind(datasel,dataset[,562],dataset[,563])

#join the label column in the data set

names(datafin)[67]<-"Label"  
#name the label column
labels<-read.table("UCI HAR Dataset/activity_labels.txt")
datafinal<-merge(datafin,labels,by.x="Label",by.y="V1",all=TRUE,sort=FALSE)

#merge and match the two dataframes,replace the numeric activity labels into the labels with strings.

datafinal<-datafinal[,2:69] 

#delete the numeric label column 

names(datafinal)[68]<-"Label"

#Name the activity column a name

