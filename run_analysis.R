##Course project script run_analysis.R

##Load all data into R objects
features<-read.table("./UCI HAR Dataset/features.txt")
activity<-read.table("./UCI HAR Dataset/activity_labels.txt")
xtrain<-read.table("./UCI HAR Dataset/train/x_train.txt")
ytrain<-read.table("./UCI HAR Dataset/train/y_train.txt")
subjecttrain<-read.table("./UCI HAR Dataset/train/subject_train.txt")
xtest<-read.table("./UCI HAR Dataset/test/x_test.txt")
ytest<-read.table("./UCI HAR Dataset/test/y_test.txt")
subjecttest<-read.table("./UCI HAR Dataset/test/subject_test.txt")

##Merge the data using cbind and rbind. Keep subject id in the first
##column and activity id in the second column followed by 561 vector
##data in the next 561 columns
alldata<-rbind(cbind(subjecttrain,ytrain,xtrain),cbind(subjecttest,ytest,xtest))
colnames(alldata)[1]<-"subject"
colnames(alldata)[2]<-"activity"

##Sort by first two columns
alldata<-alldata[order(alldata[1],alldata[2]),]

##Replace activity id in second column with activity labels from
##activity.txt
alldata$activity<-gsub("1","walking",alldata$activity)
alldata$activity<-gsub("2","walking upstairs",alldata$activity)
alldata$activity<-gsub("3","walking downstairs",alldata$activity)
alldata$activity<-gsub("4","sitting",alldata$activity)
alldata$activity<-gsub("5","standing",alldata$activity)
alldata$activity<-gsub("6","laying",alldata$activity)

##Rename columns 3-563 of the data frame to correspond with 561
##entries in features.txt
colnames(alldata)[3:563]<-as.character(features[,2])

##Extract subset of data frame by column names which include the
##string 'mean' and 'std' using grep. Since this step eliminates
##columns 1 and 2, create a new data frame and cbind the first two
##columns of older data frame on to new data frame.
alldatas<-alldata[,c(colnames(alldata)[grep("mean",colnames(alldata))],colnames(alldata)[grep("std",colnames(alldata))])]
alldatas<-cbind(alldata[1],alldata[2],alldatas)

##Create new data frame with means
alldatas$activity<-as.factor(alldatas$activity)
final<-NULL
int<-NULL
for (i in 1:30){

	for (j in 1:6){

	x<-alldatas[alldatas$subject==i & as.numeric(alldatas$activity)==j, ]
	y<-as.data.frame(lapply(x[3:81],mean))
	int<-cbind("subject"=i, "activity"=levels(alldatas$activity)[j], y)
	final<-rbind(final,int)
	}
}

##Rename columns according to tidy data requirements
names(final)<-gsub("Acc","LinearAcceleration",names(final))
names(final)<-gsub(".mean","Mean",names(final))
names(final)<-gsub("...X","Xdirection",names(final))
names(final)<-gsub("...Y","Ydirection",names(final))
names(final)<-gsub("...Z","Zdirection",names(final))
names(final)<-gsub("Gyro","AngularVelocity",names(final))
names(final)<-gsub("Mag","Magnitude",names(final))
names(final)<-gsub(".std","StandardDeviation",names(final))
names(final)<-gsub("Freq","Frequency",names(final))
names(final)<-gsub("^f","FrequencyDomain",names(final))
names(final)<-gsub("^t","TimeDomain",names(final))
names(final)<-gsub("\\..$","",names(final))
names(final)<-gsub("BodyBody","Body",names(final))
names(final)[3:81]<-gsub("^","Meanof",names(final)[3:81])
