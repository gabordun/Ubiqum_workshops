# DPLYR Workshop

# In the following exercises, we will use these six functions from the dplyr package:
# 1. filter() -> pick observations
# 2. arrange() -> reorder rows
# 3. select() -> pick columns
# 4. mutate() -> add new variables as functions of others
# 5. summarise() -> collapse many values to a summary
# 6. group by() -> group observations

# Loading libraries ####
library(downloader) # to get the data
library(dplyr)

# Reading data ####
url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/msleep_ggplot2.csv"
filename <- "msleep_ggplot2.csv"
if (!file.exists(filename)) download(url,filename)
msleep <- read.csv("msleep_ggplot2.csv")

# Exercises ####

# 1. Select the "name" column and all columns starting with "sl"

head(msleep)
name_sl<-cbind(msleep$name, msleep$sleep_cycle, msleep$sleep_rem, msleep$sleep_total)
colnames(name_sl)[1:4]<c('name','sleep_cycle','sleep_rem','sleep_total')

select(msleep, name, starts_with("sl"))  #<- this is the good
msleep %>% select(name, starts_with("sl"))  #<- ctrl + shift + M

# 2. Let's take a look at the average sleep time of the animals according to their eating habits.
# Create a new datafame with two columns: "vore" and "mean_sleep"

mean_sleep_by_vore<-msleep %>% group_by(vore) %>% summarise(mean_sleep=mean(sleep_total))

# 3. Build again the same df, but this time we want to exclude animals that sleep less than 2 hours or more than 19

mean_sleep_by_vore_limited <-  msleep %>% group_by(vore) %>% 
  filter(2 <= sleep_total) %>% filter(sleep_total <= 19) %>% 
  summarise(mean_sleep = mean(sleep_total))

# 4. Same df as before, but don't want domesticated animals in our table
# Note: we do want animals that have NA in the conservation column

mean_sleep_by_vore_limited_notdomest <-
  msleep %>% group_by(vore) %>% filter(2 <= sleep_total) %>% 
  filter(sleep_total <= 19) %>% filter(conservation!="domesticated") %>% 
  summarise(mean_sleep = mean(sleep_total))

# 5. Now, exclude NAs from your df

msleep_noNA<-na.omit(msleep)

#msleep_Blanks <- sapply(msleep, as.character)
#msleep_Blanks[is.na(df)] <- " "

# 6. Add a column to your df with their brain-to-body mass ratio

msleep_extended<-msleep_noNA %>% mutate(brainwt/bodywt*100)
round(msleep_extended[12],digits=1)
colnames(msleep_extended)[12]<-"brain-to-body mass ratio"

# 7. Add a column to your dataframe with the count of animals for each row

#msleep_count<-msleep %>% mutate(rnorm(sample(83:1), mean = 50, sd= 10))
msleep_count<-msleep %>% group_by (vore) %>% summarize(n())
#colnames(msleep_count)[12]<-"count"

# 8. Order your df by the count column in descending order

msleep_count<-msleep_count %>% arrange(desc(count))

# 9. create a table

msleep_new<- na.omit(msleep)

msleep_new<-msleep_new %>% mutate(brainwt/bodywt*100)
round(msleep_new[12],digits=1)
colnames(msleep_new)[12]<-"btb"

msleep_new<-msleep_new %>% mutate(1)
colnames(msleep_new)[13]<-"count"

msleep_new<-msleep_new %>% #select(vore,sleep_total,btb,count) %>% 
  group_by(vore) %>%
  #filter(2 <= sleep_total) %>% 
  #filter(sleep_total <= 19) %>% filter(conservation!="domesticated") %>% 
  summarise(mean_sleep=mean(sleep_total),mean_btb = mean(btb),count=sum(count)) %>% 
  arrange(desc(count))
