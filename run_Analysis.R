#code assumes relevant txt files are in the working directory
TestX <- read.table('X_test.txt')
TestY <- read.table('y_test.txt')
TestID <- read.table('subject_test.txt')
TrainX <- read.table('X_train.txt')
TrainY <- read.table('y_train.txt')
TrainID <- read.table('subject_train.txt')
ColNames <- read.table('features.txt')

colnames(TestX) <- ColNames[,2]
colnames(TrainX) <- ColNames[,2]
relcols <- grep("mean\\(\\)|std\\(\\)", ColNames$V2)
TestXextr <- TestX[,relcols]
TrainXextr <- TrainX[,relcols]

colnames(TestID) <- 'Subject'
colnames(TrainID) <- 'Subject'

TestYdescr <- factor(TestY[,1], levels = c(1,2,3,4,5,6), 
       labels = c("WALKING", "WALKING_UPSTAIRS", 
                  "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))
TrainYdescr <- factor(TrainY[,1], levels = c(1,2,3,4,5,6), 
       labels = c("WALKING", "WALKING_UPSTAIRS", 
                  "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))

Test <- cbind(TestID, TestYdescr, TestXextr)
Train <- cbind(TrainID, TrainYdescr, TrainXextr) 
colnames(Test)[2] <- 'Activity'
colnames(Train)[2] <- 'Activity'

uci.har <- rbind(Test, Train)

tidy.uci.har <- aggregate(uci.har[,3:68], by = list(uci.har$ID, uci.har$Activity), mean)
colnames(tidy.uci.har)[1:2] <- c('Subject', 'Activity')

write.table(tidy.uci.har, file = "TidyUciHar.txt")
