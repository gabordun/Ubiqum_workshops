###########################################################################
#                                                                         #
#           Computing RMSE for a small matrix prediction                  #
#           Author: Shekhar Biswas, Gabor Dunai                           #
#           Version: 1.0                                                  #
#           Date: 16.05.2019                                              #
#                                                                         #
###########################################################################


#--------------Substitute every question mark with your own code following the instructions---------------#

#Load (or download) the necessary libraries
library(readxl)
library(Metrics)
library(ggplot2)

#Load the dataset
crickets <- read_excel("A:/B/Ubiqum/module2/task3/crickets.xlsx")

#Check the relationship between the variables####
View(crickets)
#By plotting them
ggplot(crickets,aes(chirps, temp))+geom_line()
  #By checking the correlation between them
  Corr<-cor(crickets)
Corr

plot(temp ~ chirps, data = crickets)
mC <- lm(temp ~ chirps, data = crickets)
abline(mC)

# For ggplot use geom_abline(), however this library does
# have probelms.
# The belo code should do your job
ggplot(crickets, aes(temp, chirps)) + geom_point() +
  geom_smooth(method = "lm", se = FALSE)

#Build a simple linear model using the lm() functionand check the R2####
linearMod <- lm(temp ~ chirps, data = crickets)
summary(linearMod) #R Squared: 

#Store the predictions in a new column called tempPred using predict.lm()
crickets$tempPred <- predict.lm(linearMod)

#Plot the actual values and the regression line to disuaize the distances####
  plot.new()
  abline(25.2323,3.2911,h=crickets$temp,v=crickets$chirps)

#R2 Formula####
#R2 = 1-SSE/SST
#SSE - sum of all the squared distances between the actual values and the predictions
#SST - sum of all the squared distances between the actual values and the mean

#Calculate SST - the Sum of Squares Total####
#which is the sum of all the squared distances between the actual values and the mean

#What is the mean for temperature?

#First we'll create a new column called distanceFromMean with the distance between 
#each actual value and the mean
crickets$distanceFromMean <- c(crickets$temp-mean(crickets$temp))
  
  #Let's sum all the values in this column, what is the result? 
  mySum <-  sum(crickets$distanceFromMean)
  #Print the scientific notation we get as a normal number
  format(mySum, scientific = FALSE) #What is the result?

#And now create a new column called ST (Squares Total)
#with the squared values for distanceFromMean
crickets$ST <- c(crickets$distanceFromMean)^2
  
  #Save the sum
  SST <- sum(crickets$ST)
  
  
  #Calculate SSE - the Sum of Squared Errors####
#which is the sum of all the squared distances between the actual values and the predictions

#First let's create a new column with the residuals (the distances between actual and predicted values)
crickets$residuals <- c(crickets$tempPred-crickets$temp)
  
  #And now create a new column called SE (for Squared Errors) with the squared residuals
  crickets$SE <- c(crickets$residuals)^2
  
  #Save the sum
  SSE <- sum(crickets$SE)
  
  #Calculate R2 according to the formula R2 = 1-SSE/SST####

R2 <- 1-SSE/SST
  R2

#Calculate RMSE####

#Get the RMSE for the linear model we ran
Metrics::rmse(crickets$temp, crickets$tempPred)

#Calculate the Root of the Mean of the Squared Error 
#remember that we already have a column with the Squared Error

tempRMSE <- sqrt(mean(c(crickets$SE)))
  tempRMSE
