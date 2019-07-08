# -------------------------------- #
# Creating functions in R          #
# Author: Ubiqum                   #
# Solutions: Gabor Dunai           #
# Version 1 - 25.02.2019/07.2019   #
# -------------------------------- #

# Write a function called "add_2" that takes an argument "number" and outputs that number plus 2
add_2 <- function(add_2) {
  add2<-add_2+2
    return(add2)
}

# Check that your function outputs these results:
add_2(3) #5
add_2(-2) #0


# Write a function called "add_something" that takes two arguments: "number" and "addition", and adds them up
add_something <- function(something,addition){
                number<-something+addition
                  return(number)
}
  
  # Check that your function outputs these results:
  add_something(2, 7) #9
add_something(2, pi) # 5.141593


# Write again the same "add_something" function, but now make 2 the default for addition
add_something2 <- function(something2,addition2=2){
  number2<-something2+addition2
  return(number2)
}
  
  # Check that your function outputs these results:
  add_something(2) #4
add_something(2,3) #5


# Rewrite again the "add_something" function, but now add another argument, "square", with default to FALSE.
# If square is set to TRUE, the output of the addition should be squared

add_something3 <- function(something3,addition3=2,square=FALSE){
  if (square==FALSE) 
  {number3<-(something3+addition3)}
  else
  {number3<-(something3+addition3)^2}
  return(number3)
}

  # Check that your function outputs these results:
  add_something3(2) #4
add_something3(2,3) #5
add_something3(2,3, square = TRUE) #25




# Inside of your function you can use functions from other packages :)
# Write a function called "preProc" that takes a dataframe and 
# normalizes the numeric variables (you can use "scale" from base R)
# dummifies the factor variables (you can use "dummy.data.frame" from the package "dummies")


# Test your function with this dataframe
myData <- data.frame(
  color = factor(c("red", "blue", "red", "green", "red", "blue", "green", "blue", "red", "red")),
  number1 = 1:10,
  zone = factor(c("south", "north", "north", "north", "east", "east", "south", "south", "north", "east")),
  number2 = rnorm(10, mean = 5, sd = 2)
)

preProc <- function(input) {
  help_list <<- list()
  for (i in 1:ncol(input)) {
    if (is.numeric(input[, i]) == TRUE) {help_list[[i]] <<- scale(input[, i])}
    
    if (is.factor(input[, i]) == TRUE) {help_list[[i]] <<- dummy(input[, i])}
  }
  return(do.call(cbind, help_list))
}


myPreProcData <- preProc(myData)
head(myPreProcData, 3)
#     number1    number2 colorblue colorgreen colorred zoneeast zonenorth zonesouth
#1 -1.4863011 -0.2437322         0          0        1        0         0         1
#2 -1.1560120 -1.8396433         1          0        0        0         1         0
#3 -0.8257228 -0.1004189         0          0        1        0         1         0


# Now, write the "preProc" function, but add 2 boolean arguments, "scale" and "dummify", so that they can be set to TRUE or FALSE 
# and the function behaves accordingly (i.e., if "Dummy = FALSE", the function just scales the numeric variables)

preProc2 <- function(input, scale = TRUE, dummy = TRUE) {
  help_list <<- list()
  if (scale == TRUE & dummy == TRUE) {
    for (i in 1:ncol(input)) {
      if (is.numeric(input[, i]) == TRUE) {help_list[[i]] <<- scale(input[, i])}
      
      if (is.factor(input[, i]) == TRUE) {help_list[[i]] <<- dummy(input[, i])}
    }
    return(do.call(cbind, help_list))
  }
  
  else {
    if (scale == TRUE & dummy == FALSE) {
      for (i in 1:ncol(input)) {
        if (is.numeric(input[, i]) == TRUE) {help_list[[i]] <<- scale(input[, i])}
        
        if (is.numeric(input[, i]) == FALSE) {help_list[[i]] <<- input[, i]}
      }
      return(do.call(cbind, help_list))
    }
    else {
      if (scale == FALSE & dummy == TRUE) {
        for (i in 1:ncol(input)) {
          if (is.factor(input[, i]) == TRUE) {help_list[[i]] <<- dummy(input[, i])}
          
          if (is.factor(input[, i]) == FALSE) {help_list[[i]] <<- input[, i]}
        }
        return(do.call(cbind, help_list))
      }
      else {
        if (scale == FALSE & dummy == FALSE) {
          for (i in 1:ncol(input)) {
            help_list[[i]] <<- input[, i]
            }
          }
          return(do.call(cbind, help_list))
        }
        return(do.call(cbind, help_list))
      }
    }
  }


#Guillem

preProc3 <- function(data, scale = TRUE, dummy = TRUE){
  if(scale == TRUE){
    data_norm <- scale(select_if(data, is.numeric))   # normalizing numeric columns
  } else{
    data_norm <- select_if(data, is.numeric)
  }
  if(dummy == TRUE){
    data_dummies <- dummy.data.frame(select_if(data, is.factor))   # dummifiying categorical columns
  } else{
    data_dummies <- select_if(data, is.factor)
  }
  data <- cbind(data_norm, data_dummies)
}

myPreProcData <- preProc2(myData)
myPreProcData

# Check your function here
myPreProcData <- preProc2(myData, scale = FALSE)
myPreProcData
#  number1  number2 colorblue colorgreen colorred zoneeast zonenorth zonesouth
#1       1 4.254203         0          0        1        0         0         1
#2       2 6.322516         1          0        0        0         1         0
#3       3 4.945294         0          0        1        0         1         0

myPreProcData <- preProc2(myData, dummy = FALSE)
myPreProcData
#     number1     number2 color  zone
#1 -1.4863011 -0.07041993   red south
#2 -1.1560120  1.57185810  blue north
#3 -0.8257228  0.47831899   red north

myPreProcData <- preProc2(myData, scale=FALSE, dummy = FALSE)
myPreProcData
