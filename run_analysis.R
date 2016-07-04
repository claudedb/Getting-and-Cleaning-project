#Step 1: Merge Dataset

subject_test<-read.table('UCI HAR Dataset/test/subject_test.txt',header=F)
activity_test<-read.table('UCI HAR Dataset/test/y_test.txt',head=F)
x_test<-read.table('UCI HAR Dataset/test/x_test.txt',head=F)

subject_train<-read.table('UCI HAR Dataset/train/subject_train.txt',header=F)
activity_train<-read.table('UCI HAR Dataset/train/y_train.txt',head=F)
x_train<-read.table('UCI HAR Dataset/train/x_train.txt',head=F)

x_data<-rbind(x_test,x_train)
activity_data<-rbind(activity_test,activity_train)
subject_data<-rbind(subject_test,subject_train)

merged_data<-cbind(subject_data,activity_data,x_data)

#Step 2: Select only the data on the mean and standard variation

feature<-read.table('UCI HAR Dataset/features.txt',header=F)
feature[,2]<-as.character(feature[,2])
selected_feature<-grep('.*mean.*|.*std*.',feature[,2])

selected_x_data<-x_data[selected_feature]

meanstd_data=cbind(subject_data,activity_data,selected_x_data)

#Step 3:Use descriptive Activity names
activity_label<-read.table('UCI HAR Dataset/activity_labels.txt',header=F)
colnames(activity_label)<-c('ActivityID','Activity')
activity_names<-merge(activity_data,activity_label, by.x='V1',by.y='ActivityID')[,2]

step3_data<-cbind(subject_data,activity_names,selected_x_data)

#Step 4: Approprietly label the data set
selected_feature.names<-feature[selected_feature,2]
selected_feature.names=gsub('-mean','MEAN',selected_feature.names)
selected_feature.names=gsub('-std','STD',selected_feature.names)
selected_feature.names<-gsub('[()]','',selected_feature.names)

colnames(step3_data)<-c('Subject','Activity',selected_feature.names)

#Step 5: Independent tidy data

tidy_data<-ddply(step3_data,.(Subject,Activity), function(x) colMeans(x[,3:81]))

write.table(tidy_data, file='project_tidy_data.txt')
write.csv(tidy_data, file='CSV_project_tidy_data.csv')

