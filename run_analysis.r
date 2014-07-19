run_analysis <- function(){
  
  ## Load all the files required 
  X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
  X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
  y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
  y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
  labels <- read.table("UCI HAR Dataset/activity_labels.txt",colClasses="character")
  features <- read.table("UCI HAR Dataset/features.txt", colClasses="character")
  subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
  subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
  
  ## Label the activities: "y_train" and "y_test" 
  y_train <- as.matrix(y_train)
  y_test <- as.matrix(y_test)
  
  for(i in seq_along(y_train)){
      y_train[i,1] <- labels[y_train[i,1],2]
  }
  
  for(i in seq_along(y_test)){
    y_test[i,1] <- labels[y_test[i,1],2]
  }
  
  ## column bind "X_train", "y_train" and "subject_train"
  ## then label the column names.
  traindata <- data.frame(subject_train,y_train,X_train)
  colnames(traindata) <- c("Subject","Activity",features[,2])
  
  ## Column bind "X_test", "y_test" and "subject_test",
  ## then coerce its column names into that of "traindata"
  testdata <- data.frame(subject_test,y_test,X_test)
  colnames(testdata) <- colnames(traindata)
  
  ## Row bind the "train" and "test" sets
  data <- rbind(traindata, testdata)
  
  ## Extract the measurements on the mean and sd columns 
  ## along with subject/activity labels
  meanindex <- grep("mean",colnames(data))
  stdindex <- grep("std",colnames(data))
  cindex <- c(meanindex, stdindex)
  cindex <- sort(cindex)
  
  data <- data[,c(1,2,cindex)] 
  
  ## Sort and order
  data <- data[order(data$Subject,data$Activity),]
  
  ## Constructing the first part of the tidy data set: "submean"
  ## the average of each variable for each subject
  submean <- data.frame(1:30)
      colnames(submean) <- "Subject"    
  for(i in 3:ncol(data)){ ## Feature variables are arranged from the 3rd column onwards
      varmean <- as.data.frame(tapply(data[,i],data$Subject,mean))
          colnames(varmean) <- colnames(data)[i]
      submean <- data.frame(submean,varmean)
  }
  
  ## Constructing the second part of the tidy data set: "actmean"
  ## the average of each variable for each activity
  actmean <- data.frame(1:6)
      colnames(actmean) <- "Activity"    
  for(i in 3:ncol(data)){ 
    varmean <- as.data.frame(tapply(data[,i],data$Activity,mean))
    colnames(varmean) <- colnames(data)[i]
    actmean <- data.frame(actmean,varmean)
  }
  actmean[,1] <- labels[,2]
  
  ## Save the result as a tab-delimited file format
  write.table(submean,"tidydata-subject.txt",sep="\t",row.names=FALSE)
  write.table(actmean,"tidydata-activity.txt",sep="\t",row.names=FALSE)
  
  
  
}