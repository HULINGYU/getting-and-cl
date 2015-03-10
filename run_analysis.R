##merge two datasets into one
features<-read.table("p1/features.txt")#load the features table
f1<-features$V2#subset the column with the name of the method and tolower it
feature1<-grep("mean()",f1,fixed=TRUE)
#select data from the features whose name include exactly mean(),
feature2<-grep("std()",f1,fixed=TRUE)
#select data from the features whose name include exactly std(),
featuredata<-c(feature1,feature2)
#put the two features data together so the list is rows in features which use the method of mean and std
namedata<-f1[featuredata]
datasel<-dataset[,featuredata]
names(datasel)<-namedata
datafin<-cbind(datasel,dataset[,562],dataset[,563])#join the label column in the data set
names(datafin)[67]<-"Label"   #name the label column
labels<-read.table("p1/activity_labels.txt")
datafinal<-merge(datafin,labels,by.x="Label",by.y="V1",all=TRUE,sort=FALSE)
datafinal<-datafinal[,2:69] #delete the numeric label column 
names(datafinal)[68]<-"Label" #Name the activity column a name
