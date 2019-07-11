##############
### Part 1 ###
##############

# In this workshop we will be working with the "apply" functions. They help us avoid loops, 
# which are more computationally intensive and sintactically complex. 

# The "apply family" is made up of these 7 functions: 
# apply()
# lapply()
# sapply()
# vapply()
# mapply() 
# rapply()
# tapply()

# You'll chose the right function depending on the structure of your data and your desired output.

library(dplyr) # We will use some dplyr functions in combination with the apply ones

#### apply() ####
# To apply a function to an array (matrix, data frame, data table...)
# The function has 3 arguments:
# X --> the object we want to apply the function to (has to be a matrix, df...)
# Margin --> 1 to apply the function to rows, 2 for columns, or c(1, 2) for both
# FUN --> the function we want to pass to the object

# Construct a 5x6 df
X <- matrix(rnorm(30), nrow=5, ncol=6)
X <- as.data.frame(X)

# Sum the values of each column with `apply()` using the function "sum". 
# Store the result in a variable called "colsum"
colsum <- apply(X,2,sum)
  colsum
class(colsum)

# What would be the equivalent of this with a for loop?
result_c<-c()
for (i in 1:ncol(X))
 
{result_c[[i]]<-(sum(X[,i]))}

result_c
class(result_c)


# Sum the values of each row with `apply()`
rowsum <- apply(X,1,sum)
rowsum

# Again: what would be the equivalent of this with a for loop?
result_r<-c()
for (i in 1:nrow(X))
  
{result_r[[i]]<-(sum(X[i,]))}

result_r
class(result_r)

# ADVANCED STUFF (Optional): Now, try to get to the same outcome without using
# any function at all inside of apply:
rownums<-nrow(X)
colnums<-ncol(X)

helpfun<-function (X) {
  result_r<-c()
for (i in 1:colnums)
{result_r[[i]]<-(sum(X[i]))
}
  return(result_r)}

#doesn't work
helpfun2<-function (X) {
  a<-data.frame(rownums,1)
  for (i in 1:rownums-1)
  {a[i,]==X[i+1,]+X[i,]}
  return (a)
}

#doesn't work
colsum3<-apply(X, 2, helpfun)
colsum3

#works
colsum4<-apply(X,2, function(X) X[1]+X[2]+X[3]+X[4]+X[5])
colsum4

#doesn't work
total<<-0
colsum5<-apply(X,2, function(X) {for (i in 1:5)
  total<<-total+X[i]  }
  )
  

#doesn't work
apply(X,2, function(X) {for (i in 1:5)
  total[i]<<-total[i]+X[i]; return (total) }
)


#doesn't work
 colsum6<- function(X) {for (i in 1:rownums)
   total<<-0
   {total<<-total+X[i,1]}
  return(total)
 }
 
#double "for" loop
#doesn't work
colsum11<-function (X) {
    for (j in 1:colnums)
    for (i in 1:rownums)
    {mysum[i,j]==mysum[[j]]+X[[i,]]}
  return(mysum)
  }

#double "for" loop
mysum<-c()
for (j in 1:colnums) {
  for (i in 1:rownums)
  {a<<-X[i,j]+X[i,j]}
}
a

#### lapply() ####
# Same as apply, but it accepts many different objects as inputs and it outputs a list. 
# Arguments:
# X --> the object you want to apply the function to (has to be a list)
# FUN --> the function we want to pass to the object

# Let's define 3 dataframes and list them:
A <- data.frame(v1 = c(1,2,3), v2 = c(4,5,6), v3 = c(7,8,9))
B <- data.frame(v1 = c(4,5,6,7), v2 = c(8,9,10,11), v3 = c(12,13,14,15))
C <- data.frame(v1 = c(8,9,10), v2 = c(8,9,10))
myList <- list(A, B, C)
myList

# Extract the 2nd column from every dataframe inside myList, using lapply and
# the dplyr function "select"
lapply(myList, select,2)

lapply(myList, '[',i= ,j=2)

# Extract the 1st row from every dataframe inside myList, using lapply and 
# the dplyr function "slice"
lapply(myList, slice, 1)

lapply(myList, '[',i= 1,j=)

# Extract one single element from every dataframe in the list. 
# You can use "[" as a function

lapply(myList, '[',i= 1,j=1)

#### sapply() ####
# Same as lapply, but returns the simplest output possible (vector instead of list...)
# (If we set the argument simplify to FALSE, the output is exactly the same as with lapply)
sapply(myList, '[',i= 1,j=)
sapply(myList, '[',i= 1,j=,simplify = FALSE) #same output as lapply!

#### using rep() ####
# rep() is a function from base R that takes an input "x" and replicates it n times.
# it is a useful function in many cases, so let's learn how to use it.

# Initialize `Z`: create a vector by selecting the first element of the first column of
# each dataframe in "myList"
Z <- sapply(myList, '[',i= 1,j=1)
  Z

# Replicate the values of `Z` 3 times, 1 time and 2 times
Zrep <- rep(Z,c(3,1,2))
Zrep2 <- rep(Z,8)
Zrep
Zrep2

#### mapply() ####
# Multivariate apply: it vectorizes arguments to functions that not usually
# accept vectors as arguments

# Create a 4x4 matrix called Q1 using the functions matrix() and rep() that 
# looks like this:

# 1 2 3 4
# 1 2 3 4
# 1 2 3 4
# 1 2 3 4

Q1<-matrix(rep(1:4,each=4),4,4)
Q1 <- matrix(rep(c(1,2,3,4),4),4,4,byrow=TRUE)
  print(Q1)

# Now create the same matrix using `mapply()`
Q2 <-mapply(matrix,c(1,2,3,4),4)
Q2 <-mapply(matrix,1:4,4)
  print(Q2)

# The results are the same, we have vectorized the action of the function rep()

# 

##############
### Part 2 ###
##############


df<-read.csv('A:/B/Ubiqum/module3/players_apply_workshop.csv')
df

df[,2]<-as.character(df[,2])
df[,3]<-as.character(df[,3])
df[,4]<-as.character(df[,4])
df[,7]<-as.character(df[,7])

# show class of data using a for loop

for (i in 1:ncol(df))
{print(class(df[,i]))}


# Now try to do the same but with apply(). Notice the limitation of apply function - all classes will be shown as character

apply(df,2,class)

# Mean of numeric columns with apply()

df[,1]<-as.numeric(df[,1])
df[,5]<-as.numeric(df[,5])
df[,6]<-as.numeric(df[,6])

sapply(df,mean)

# Introduce some NAs
df[1:10, 5] <- NA

#  Mean of numeric columns with apply(): how do we deal with NA's?

sapply(df,mean,na.rm=TRUE)

unique(df$Franchise)

# In combination with the apply functions, it's very useful to be able to create your own functions
# How would you segregate the dataframe based on one column -- for example, Franchise?
#Keep just the rows for the Bangalore Franchise using base R:

filtered_df<-filter(df,df$Franchise=='Bangalore')
filtered_df

#Now we can generalize this with a function: keep the rows for the Franchise "x"

#Define the function:
segregate_Franchise <- function(x) {
    filtered_df2<-filter(df,df$Franchise==x)
    return(filtered_df2)
    }

filtered_df2<-filter(df,df$Franchise=='Delhi')

#Test your function:
segregate_Franchise('Bangalore')

## Now let's make a loop using lapply and the function that we just defined (we can define it again inside the lapply):
OutputList<-lapply(unique(df$Franchise),segregate_Franchise)
  
  OutputList[1]

# We can use the function split() function do a similar task
OutputSplit<-split(df,df$Franchise)
OutputSplit$Delhi


#### ADVANCED STUFF ####

#Using the INDEX argument of T apply, we can create a new array where the dimensions are two columns that we specify.
#This is our goal (Franchise in the rows and Speciality in the columns):


tapply(df$Price,list(df$Franchise,df$Specialty),sum)

tapply(df$Price, INDEX =list(df$Specialty,df$Franchise, df$Country), sum)

#              AllRounder Batsman  Bowler WK/Batsman
#Bangalore         NA      NA      NA         NA
#Chennai           NA      NA 2375000    1825000
#Delhi         225000 2450000 1625000     525000
#Hyderabad     850000 3150000 1185000     700000
#Jaipur        475000 1350000  725000     150000
#Kolkata           NA 1825000 2300000     825000
#Mohali            NA  900000 3020000     700000
#Mumbai       1525000  950000 1350000         NA