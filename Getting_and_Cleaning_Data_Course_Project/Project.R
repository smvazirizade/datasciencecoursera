m(list = setdiff(ls(), lsf.str()))
wants <- c("dplyr","Hmisc","data.table","plyr")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])
for (pkg in wants) {library(pkg, character.only = TRUE)}
clc <- function() cat(rep("\n", 50))
clc()



##Step1 Merging the training and the test sets to create one data set:
#Reading Data
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt")
subjecttrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
#
xtest <- read.table("UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("UCI HAR Dataset/test/y_test.txt")
subjecttest <- read.table("UCI HAR Dataset/test/subject_test.txt")
#
features <- read.table("UCI HAR Dataset/features.txt")
#
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
# create x data set
xdata <- rbind(xtrain, xtest)
# create y data set
ydata <- rbind(ytrain, ytest)
# create subject data set
subjectdata <- rbind(subjecttrain, subjecttest)

##Step2 Extracting only the measurements on the mean and standard deviation for each measurement:
# wer are looking for mean() or std() in the second column of feature
Selectedfeatures <- grep("-(mean|std)\\(\\)", features[, 2])
# extract that columns
xdatameanorstd <- xdata[, Selectedfeatures]
# correct the column names
names(xdatameanorstd) <- features[Selectedfeatures, 2]


##Step3 Useing descriptive activity names to name the activities in the data set:
ydata[, 1] <- activities[ydata[, 1], 2]
# redefining ydata
names(ydata) <- "activity"

##Step4 Appropriately labeling the data set with descriptive variable names:
names(subjectdata) <- "subject"
alldata <- cbind(xdata, ydata, subjectdata)

##Step5 From the data set in step 4, creating a second, independent tidy data set with the average of each variable for each activity and each subject.
NewData <- alldata %>%   group_by(subject, activity) %>%  summarize(funs(mean))
write.table(NewData, "NewData.txt", row.name=FALSE)

