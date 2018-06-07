.#Introduction
The man script, run_analysis.R. includes 5 steps:  

##Step1 Merging the training and the test sets to create one data set  

##Step2 Extracting only the measurements on the mean and standard deviation for each measurement  

##Step3 Useing descriptive activity names to name the activities in the data set  

##Step4 Appropriately labeling the data set with descriptive variable names  

##Step5 From the data set in step 4, creating a second, independent tidy data set with the average of each variable for each activity and each subject.


.#Variables
Inputed data  
xtrain, ytrain, subjecttrain  
xtest, ytest, subjecttest  
features, activities  

created data set  
xdata, ydata, subjectdata

selected the names inlcuding mean() or std()  
Selectedfeatures
extracted that columns  
xdatameanorstd

data created in step 4  
alldata

the output data of step 5  
NewData <- alldata %>%   group_by(subject, activity) %>%  summarize(funs(mean))

