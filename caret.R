###########################Imports######################
library(caret)
library(mlbench)

##########################Model##########################
data(Sonar)
set.seed(123)
inTrain<-createDataPartition(y=Sonar$Class, p=.75, list=FALSE)
str(inTrain)
training<-Sonar[inTrain,]
testing<-Sonar[-inTrain,]
nrow(training)
nrow(testing)

ctrl<-trainControl(method="repeatedcv",repeats=3,classProbs=TRUE,
                   summaryFunction = twoClassSummary)
plsFit<-train(Class~.,data=training,method="pls",tuneLength=15,trControl=ctrl,metric="ROC",
              preProc=c("center","scale"))


plsFit
plot(plsFit)
plsClasses<-predict(plsFit, newdata=testing)
str(plsClasses)
plsProbs<-predict(plsFit, newdata=testing, type="prob")
str(plsProbs)
confusionMatrix(data=plsClasses, testing$Class)
rdaGrid<-data.frame(gamma=(0:4)/4,lambda=3/4)
set.seed(123)
rdaFit<-train(Class~.,data=training,method="rda",tuning=rdaGrid,trControl=ctrl,metric="ROC")
rdaFit
rdaClasses<-predict(rdaFit,newdata=testing)
confusionMatrix(rdaClasses, testing$Class)
resamps<-resamples(list(pls=plsFit,rda=rdaFit))
summary(resamps)
xyplot(resamps, what="BlandAltman")
diffs<-diff(resamps)
summary(diffs)