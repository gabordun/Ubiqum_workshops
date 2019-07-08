library(ggplot2)
CompR<-read.csv('A:/B/Ubiqum/module2/classification/CompleteResponses.csv')
CompR$brand<-as.factor(CompR$brand)
myHist<-ggplot(CompR,aes(x=salary,fill=brand))+geom_histogram(binwidth = 1500)
myHist+geom_vline(aes(xintercept=mean(salary)))
summary(CompR)
barplot<-ggplot(CompR,aes(x=brand,fill=brand))+geom_bar()              
ggplot(CompR,aes(x=brand,fill=brand))+geom_bar()
barplot+scale_fill_manual(values=c("green","grey"))
bar2<-barplot+scale_fill_brewer(palette=)
bar2+ggtitle("Which type of computer is more beloved?")+ylab("freq")+xlab("type")

# scatterplot of bla bla bla
scatter <- ggplot(CompR, aes(x = age, y = credit, col = brand)) + 
  geom_point()


scatter+scale_fill_manual(values=c("green","pink"))
library(plotly)
ggplotly(scatter)
ggplotly(barplot)

set.seed(112)
data=matrix(Prediction)
data=matrix(sample(1:30,15) , nrow=3)
colnames(data)=c("A","B","C","D","E")
rownames(data)=c("var1","var2","var3")

barplot(data, col=colors()[c(23,89,12)] , border="white", font.axis=2,
        beside=T, legend=rownames(data), xlab="group", font.lab=2)