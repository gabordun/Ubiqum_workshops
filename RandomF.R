library(caret)
WholeYear<-read.csv('A:/B/Ubiqum/module2/classification/WholeYear.csv')
set.seed(123)
rownum<-nrow(WholeYear)
rownum
a<-0.2*rownum
#b<-a-floor(a)
#b
WholeYear<-WholeYear[sample(1:nrow(WholeYear),floor(a),replace=FALSE),]
inTraining<-createDataPartition(WholeYear$SolarRad,p=.75,list=FALSE)
training<-WholeYear[inTraining,]
testing<-WholeYear[-inTraining,]
fitControl<-trainControl(method="repeatedcv", number=10,repeats = 1)
rfFit1<-train(SolarRad~.,data=training, method="rf",trControl=fitControl,tuneLength=1)
rfFit1