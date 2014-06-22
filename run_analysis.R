run_analysis<-function(){
  library(reshape2)
############################## -PART 1 & 2- ###################################
  #Features
  features<-read.table("UCI HAR Dataset/features.txt")
  ##mean
  nom<-grep("mean()", features[,2], fixed=TRUE)
  m<-paste("V", nom, sep="")
  ##standard deviation
  nos<-grep("std()", features[,2], fixed=TRUE)
  s<-paste("V", nos, sep="")


  ##Test Set
  x1<-read.table("UCI HAR Dataset/test/X_test.txt")
  datax1<-x1[,c(m, s)]
  names(datax1)<-features[c(nom, nos),2]
  y1<-read.table("UCI HAR Dataset/test/y_test.txt")
  names(y1)<-"Y"
  subject1<-read.table("UCI HAR Dataset/test/subject_test.txt")
  names(subject1)<-"Subject"
  test<-cbind(datax1, y1, subject1)

  ##Train Set
  x2<-read.table("UCI HAR Dataset/train/X_train.txt")
  datax2<-x2[,c(m, s)]
  names(datax2)<-features[c(nom, nos),2]
  y2<-read.table("UCI HAR Dataset/train/y_train.txt")
  names(y2)<-"Y"
  subject2<-read.table("UCI HAR Dataset/train/subject_train.txt")
  names(subject2)<-"Subject"
  train<-cbind(datax2, y2, subject2)

  ##Merging Train and Test Datasets
  ##With extracted mean() and std()
  data<-rbind(test, train)

############################## -PART 3- ###################################

  ##Activity Labels
  activity<-read.table("UCI HAR Dataset/activity_labels.txt")
  names(activity)<-c("Y", "Activity")

  m<-merge(data, activity, by="Y")
  dataset<-m[, c(68:69, 2:67)]

############################## -PART 4- ###################################

  a<-names(dataset)[3:68]
  for(i in 64:66){
  	a<- sub("BodyBody", "Body", a, fixed=TRUE)
  }
  x<-c("tB", "fB", "tG", "fG", "Body", "Gravity", "Acc", "Gyro", "Jerk", "Mag", "-mean()", "-std()", "-X", "-Y", "-Z")
  y<-c("time_B", "frequency_B", "time_G", "frequency_G", "body_", "gravity_", "acc_", "gyro_", "jerk_", "mag_", "mean", "std", "_Xaxis", "_Yaxis", "_Zaxis")
  for(i in 1:length(x)){
  	a<- sub(x[i], y[i], a, fixed=TRUE)
  }
  names(dataset)<-c("Subject", "Activity", a)

############################## -PART 5- ###################################
  melted<-melt(dataset, id.vars=c("Subject", "Activity"))
  x<-dcast(melted, Subject+Activity~variable, mean)

  ## I know this part of the code is length and doesnt make much sense.
  ## but it creates a tidy set according to what i wanted and i could
  ## not find a better method. 
  ## P.s. I am new to R
  ##{
    col<-c("Subject", "Activity", "time_body_acc_mean_Xaxis","time_body_acc_mean_Yaxis","time_body_acc_mean_Zaxis","time_body_acc_mag_mean")
    tbam<-x[, col]
    tbam<-melt(tbam, id.vars=c("Subject", "Activity"))
    names(tbam)<-c("Subject", "Activity", "Coordinates", "time_body_acc_mean")
    levels(tbam$Coordinates)[3]<-"Z"
    levels(tbam$Coordinates)[2]<-"Y"
    levels(tbam$Coordinates)[1]<-"X"
    levels(tbam$Coordinates)[4]<-"MAG"
    
    col<-c("Subject", "Activity", "time_gravity_acc_mean_Xaxis","time_gravity_acc_mean_Yaxis","time_gravity_acc_mean_Zaxis","time_gravity_acc_mag_mean")
    tgam<-x[, col]
    tgam<-melt(tgam, id.vars=c("Subject", "Activity"))
    names(tgam)<-c("Subject", "Activity", "Coordinates", "time_gravity_acc_mean")
    levels(tgam$Coordinates)[3]<-"Z"
    levels(tgam$Coordinates)[2]<-"Y"
    levels(tgam$Coordinates)[1]<-"X"
    levels(tgam$Coordinates)[4]<-"MAG"
    
    col<-c("Subject", "Activity", "time_body_acc_jerk_mean_Xaxis","time_body_acc_jerk_mean_Yaxis","time_body_acc_jerk_mean_Zaxis","time_body_acc_jerk_mag_mean")
    tbajm<-x[, col]
    tbajm<-melt(tbajm, id.vars=c("Subject", "Activity"))
    names(tbajm)<-c("Subject", "Activity", "Coordinates", "time_body_acc_jerk_mean")
    levels(tbajm$Coordinates)[3]<-"Z"
    levels(tbajm$Coordinates)[2]<-"Y"
    levels(tbajm$Coordinates)[1]<-"X"
    levels(tbajm$Coordinates)[4]<-"MAG"
    
    col<-c("Subject", "Activity", "time_body_gyro_mean_Xaxis","time_body_gyro_mean_Yaxis","time_body_gyro_mean_Zaxis","time_body_gyro_mag_mean")
    tbgm<-x[, col]
    tbgm<-melt(tbgm, id.vars=c("Subject", "Activity"))
    names(tbgm)<-c("Subject", "Activity", "Coordinates", "time_body_gyro_mean")
    levels(tbgm$Coordinates)[3]<-"Z"
    levels(tbgm$Coordinates)[2]<-"Y"
    levels(tbgm$Coordinates)[1]<-"X"
    levels(tbgm$Coordinates)[4]<-"MAG"
    
    col<-c("Subject", "Activity", "time_body_gyro_jerk_mean_Xaxis","time_body_gyro_jerk_mean_Yaxis","time_body_gyro_jerk_mean_Zaxis","time_body_gyro_jerk_mag_mean")
    tbgjm<-x[, col]
    tbgjm<-melt(tbgjm, id.vars=c("Subject", "Activity"))
    names(tbgjm)<-c("Subject", "Activity", "Coordinates", "time_body_gyro_jerk_mean")
    levels(tbgjm$Coordinates)[3]<-"Z"
    levels(tbgjm$Coordinates)[2]<-"Y"
    levels(tbgjm$Coordinates)[1]<-"X"
    levels(tbgjm$Coordinates)[4]<-"MAG"
    
    abc<-merge(merge(merge(merge(tbam, tgam, by=c("Subject","Activity", "Coordinates")), tbajm, by=c("Subject","Activity", "Coordinates")), tbgm, by=c("Subject","Activity", "Coordinates")), tbgjm, by=c("Subject","Activity", "Coordinates"))
    
    ###########################################
    
    col<-c("Subject", "Activity", "frequency_body_acc_mean_Xaxis","frequency_body_acc_mean_Yaxis","frequency_body_acc_mean_Zaxis","frequency_body_acc_mag_mean")
    tbam<-x[, col]
    tbam<-melt(tbam, id.vars=c("Subject", "Activity"))
    names(tbam)<-c("Subject", "Activity", "Coordinates", "frequency_body_acc_mean")
    levels(tbam$Coordinates)[3]<-"Z"
    levels(tbam$Coordinates)[2]<-"Y"
    levels(tbam$Coordinates)[1]<-"X"
    levels(tbam$Coordinates)[4]<-"MAG"
    
    col<-c("Subject", "Activity", "frequency_body_acc_jerk_mean_Xaxis","frequency_body_acc_jerk_mean_Yaxis","frequency_body_acc_jerk_mean_Zaxis","frequency_body_acc_jerk_mag_mean")
    tbajm<-x[, col]
    tbajm<-melt(tbajm, id.vars=c("Subject", "Activity"))
    names(tbajm)<-c("Subject", "Activity", "Coordinates", "frequency_body_acc_jerk_mean")
    levels(tbajm$Coordinates)[3]<-"Z"
    levels(tbajm$Coordinates)[2]<-"Y"
    levels(tbajm$Coordinates)[1]<-"X"
    levels(tbajm$Coordinates)[4]<-"MAG"
    
    col<-c("Subject", "Activity", "frequency_body_gyro_mean_Xaxis","frequency_body_gyro_mean_Yaxis","frequency_body_gyro_mean_Zaxis","frequency_body_gyro_mag_mean")
    tbgm<-x[, col]
    tbgm<-melt(tbgm, id.vars=c("Subject", "Activity"))
    names(tbgm)<-c("Subject", "Activity", "Coordinates", "frequency_body_gyro_mean")
    levels(tbgm$Coordinates)[3]<-"Z"
    levels(tbgm$Coordinates)[2]<-"Y"
    levels(tbgm$Coordinates)[1]<-"X"
    levels(tbgm$Coordinates)[4]<-"MAG"
    
    xyz<-merge(merge(tbam, tbgm, by=c("Subject","Activity", "Coordinates")), tbajm, by=c("Subject","Activity", "Coordinates"))
    
    fin<-merge(abc, xyz, by=c("Subject","Activity", "Coordinates"))
    
    ###############################################
    
    col<-c("Subject", "Activity", "time_body_acc_std_Xaxis","time_body_acc_std_Yaxis","time_body_acc_std_Zaxis","time_body_acc_mag_std")
    tbam<-x[, col]
    tbam<-melt(tbam, id.vars=c("Subject", "Activity"))
    names(tbam)<-c("Subject", "Activity", "Coordinates", "time_body_acc_std")
    levels(tbam$Coordinates)[3]<-"Z"
    levels(tbam$Coordinates)[2]<-"Y"
    levels(tbam$Coordinates)[1]<-"X"
    levels(tbam$Coordinates)[4]<-"MAG"
    
    col<-c("Subject", "Activity", "time_gravity_acc_std_Xaxis","time_gravity_acc_std_Yaxis","time_gravity_acc_std_Zaxis","time_gravity_acc_mag_std")
    tgam<-x[, col]
    tgam<-melt(tgam, id.vars=c("Subject", "Activity"))
    names(tgam)<-c("Subject", "Activity", "Coordinates", "time_gravity_acc_std")
    levels(tgam$Coordinates)[3]<-"Z"
    levels(tgam$Coordinates)[2]<-"Y"
    levels(tgam$Coordinates)[1]<-"X"
    levels(tgam$Coordinates)[4]<-"MAG"
    
    col<-c("Subject", "Activity", "time_body_acc_jerk_std_Xaxis","time_body_acc_jerk_std_Yaxis","time_body_acc_jerk_std_Zaxis","time_body_acc_jerk_mag_std")
    tbajm<-x[, col]
    tbajm<-melt(tbajm, id.vars=c("Subject", "Activity"))
    names(tbajm)<-c("Subject", "Activity", "Coordinates", "time_body_acc_jerk_std")
    levels(tbajm$Coordinates)[3]<-"Z"
    levels(tbajm$Coordinates)[2]<-"Y"
    levels(tbajm$Coordinates)[1]<-"X"
    levels(tbajm$Coordinates)[4]<-"MAG"
    
    col<-c("Subject", "Activity", "time_body_gyro_std_Xaxis","time_body_gyro_std_Yaxis","time_body_gyro_std_Zaxis","time_body_gyro_mag_std")
    tbgm<-x[, col]
    tbgm<-melt(tbgm, id.vars=c("Subject", "Activity"))
    names(tbgm)<-c("Subject", "Activity", "Coordinates", "time_body_gyro_std")
    levels(tbgm$Coordinates)[3]<-"Z"
    levels(tbgm$Coordinates)[2]<-"Y"
    levels(tbgm$Coordinates)[1]<-"X"
    levels(tbgm$Coordinates)[4]<-"MAG"
    
    col<-c("Subject", "Activity", "time_body_gyro_jerk_std_Xaxis","time_body_gyro_jerk_std_Yaxis","time_body_gyro_jerk_std_Zaxis","time_body_gyro_jerk_mag_std")
    tbgjm<-x[, col]
    tbgjm<-melt(tbgjm, id.vars=c("Subject", "Activity"))
    names(tbgjm)<-c("Subject", "Activity", "Coordinates", "time_body_gyro_jerk_std")
    levels(tbgjm$Coordinates)[3]<-"Z"
    levels(tbgjm$Coordinates)[2]<-"Y"
    levels(tbgjm$Coordinates)[1]<-"X"
    levels(tbgjm$Coordinates)[4]<-"MAG"
    
    abc<-merge(merge(merge(merge(tbam, tgam, by=c("Subject","Activity", "Coordinates")), tbajm, by=c("Subject","Activity", "Coordinates")), tbgm, by=c("Subject","Activity", "Coordinates")), tbgjm, by=c("Subject","Activity", "Coordinates"))
    
    ###########################################
    
    col<-c("Subject", "Activity", "frequency_body_acc_std_Xaxis","frequency_body_acc_std_Yaxis","frequency_body_acc_std_Zaxis","frequency_body_acc_mag_std")
    tbam<-x[, col]
    tbam<-melt(tbam, id.vars=c("Subject", "Activity"))
    names(tbam)<-c("Subject", "Activity", "Coordinates", "frequency_body_acc_std")
    levels(tbam$Coordinates)[3]<-"Z"
    levels(tbam$Coordinates)[2]<-"Y"
    levels(tbam$Coordinates)[1]<-"X"
    levels(tbam$Coordinates)[4]<-"MAG"
    
    col<-c("Subject", "Activity", "frequency_body_acc_jerk_std_Xaxis","frequency_body_acc_jerk_std_Yaxis","frequency_body_acc_jerk_std_Zaxis","frequency_body_acc_jerk_mag_std")
    tbajm<-x[, col]
    tbajm<-melt(tbajm, id.vars=c("Subject", "Activity"))
    names(tbajm)<-c("Subject", "Activity", "Coordinates", "frequency_body_acc_jerk_std")
    levels(tbajm$Coordinates)[3]<-"Z"
    levels(tbajm$Coordinates)[2]<-"Y"
    levels(tbajm$Coordinates)[1]<-"X"
    levels(tbajm$Coordinates)[4]<-"MAG"
    
    col<-c("Subject", "Activity", "frequency_body_gyro_std_Xaxis","frequency_body_gyro_std_Yaxis","frequency_body_gyro_std_Zaxis","frequency_body_gyro_mag_std")
    tbgm<-x[, col]
    tbgm<-melt(tbgm, id.vars=c("Subject", "Activity"))
    names(tbgm)<-c("Subject", "Activity", "Coordinates", "frequency_body_gyro_std")
    levels(tbgm$Coordinates)[3]<-"Z"
    levels(tbgm$Coordinates)[2]<-"Y"
    levels(tbgm$Coordinates)[1]<-"X"
    levels(tbgm$Coordinates)[4]<-"MAG"
    
    col<-c("Subject", "Activity", "frequency_body_gyro_jerk_mag_mean")
    tf<-x[, col]
    tf<-melt(tf, id.vars=c("Subject", "Activity"))
    names(tf)<-c("Subject", "Activity", "Coordinates", "frequency_body_gyro_jerk_mean")
    levels(tf$Coordinates)<-"MAG"
    
    col<-c("Subject", "Activity", "frequency_body_gyro_jerk_mag_std")
    tg<-x[, col]
    tg<-melt(tg, id.vars=c("Subject", "Activity"))
    names(tg)<-c("Subject", "Activity", "Coordinates", "frequency_body_gyro_jerk_std")
    levels(tg$Coordinates)<-"MAG"
    
    tfg<-merge(tf, tg, by=c("Subject", "Activity", "Coordinates"))
    
    
    xyz<-merge(merge(tbam, tbgm, by=c("Subject","Activity", "Coordinates")), tbajm, by=c("Subject","Activity", "Coordinates"))
    
    sin<-merge(merge(abc, xyz, by=c("Subject","Activity", "Coordinates")), tfg, all=TRUE)
    
    fsin<-merge(fin, sin, by=c("Subject","Activity", "Coordinates"))
    
    
  ##}

  write.table(fsin, file = "TidyData.txt", row.names = FALSE)

}