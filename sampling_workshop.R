# -------------------------------- #
# Creating samples in R            #
# Author: Gabor Dunai              #
# Version 1.0 - 07.2019            #
# -------------------------------- #

a<-data.frame(1:1000)
a
set.seed(123)
b<-sample_n(a,0.2*nrow(a),replace=FALSE)
b

c<-replicate(50,sample_n(a,0.2*nrow(a),replace=FALSE))
c

d<-unlist(c)
d

e<-unique(d)
e

hist(d)
hist(e)

library(ggplot2)

f<-data.frame(table(d))
max(f[,2])
min(f[,2])

ggplot(as.data.frame(d), aes(d)) +
  geom_histogram(bins = 1000)

graphics.off()
