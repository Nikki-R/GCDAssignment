setwd("C:/Users/Nikki/Documents/Data Science Specialization/Working Directory/Coursera")

#Loads in all data tables
test <- read.table("./Data/Assignment_3.4_Data/test/X_test.txt")
testact <- read.table("./Data/Assignment_3.4_Data/test/Y_test.txt")
testsubject <- read.table("./Data/Assignment_3.4_Data/test/subject_test.txt")
train <- read.table("./Data/Assignment_3.4_Data/train/X_train.txt")
trainact <- read.table("./Data/Assignment_3.4_Data/train/Y_train.txt")
trainsubject <- read.table("./Data/Assignment_3.4_Data/train/subject_train.txt")
actlab <- read.table("./Data/Assignment_3.4_Data/activity_labels.txt")
features <- read.table("./Data/Assignment_3.4_Data/features.txt")

library(dplyr)

#Adds activity type to test dataset by row
testcomplete <- mutate(test, act = testact$V1)
testcomplete <- testcomplete[,c(562,1:561)]
#head(testcomplete[2,1:5])

#Adds activity type to train dataset by row
traincomplete <- mutate(train, act = trainact$V1)
traincomplete <- traincomplete[,c(562,1:561)]
#head(traincomplete[2,1:5])

#Adds subject to test dataset by row
testcomplete <- mutate(testcomplete, subject = testsubject$V1)
testcomplete <- testcomplete[,c(563,1:562)]
#head(testcomplete[2,1:5])

#Adds subject by to train dataset by row
traincomplete <- mutate(traincomplete, subject = trainsubject$V1)
traincomplete <- traincomplete[,c(563,1:562)]
#head(traincomplete[2,1:5])

#Merges 2 datasets
merged <- rbind(traincomplete,testcomplete)
#head(merged[1,1:7])

#Adds activity description
mergedlab <- merge(merged, actlab, by.x="act", by.y="V1")
mergedlab <- mergedlab[,c(1,564,2:563)] #reorder
mergedlab <- rename(mergedlab, activity = V2.y, activityref=act)
#head(merged[1,1:7])

#Select correct columns

features <- mutate(features, colref=1:561)
interestvars <- features[grepl("std\\(\\)|mean\\(\\)",features$V2),] #66 rows
head(interestvars,20)
colindex <- (interestvars[,1])
varnames <- c("activityref", "activity", "subject",as.character(features[colindex,2]))
colindex2 <- c(1,2,3, colindex + 3)

#Just want to select the columns giving mean() or std()

mergedlab <- mergedlab[,colindex2]
#head(mergedlab)
names(mergedlab) <- varnames
#Checks
names(mergedlab)
head(mergedlab[,1:5])

#Create summarised table
mergedlab2 <- mergedlab
names(mergedlab2) <- gsub("-","", names(mergedlab))
names(mergedlab2) <- gsub("\\(","", names(mergedlab2))
names(mergedlab2) <- gsub("\\)","", names(mergedlab2))

inputtable <- mergedlab2[,c(2:69)] #Remove 'activityref' from table, for grouping
grouped <- group_by(inputtable, activity, subject)
tidy <- summarise_all(grouped, mean)
write.table(tidy, file="./Data/Assignment_3.4_Data/Output/tidy.txt",sep="\t")

#Create list of variables from table for codebook
variables2 <- names(tidy)
variabledesc <- c("Activity completed by subject", "Subject id", replicate(length(variables2)-2,"See details in codebook"))
variables2 <- data.frame("Variable" = variables2, "Description" = variabledesc)
write.table(variables2, file="./Data/Assignment_3.4_Data/Variables2.csv", sep=",")
