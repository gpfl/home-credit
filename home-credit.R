####### LIBRARIES #######
library(data.table)
library(tidyverse)
library(caret)
library(corrplot)


#######  IMPORTING CSV #####
apptest <- fread("application_test.csv")
apptrain<- fread("application_train.csv")

####### COLUMNS DESCRIPTION #######
description <- fread("HomeCredit_columns_description.csv")

####### DAYS_EMPLYED CORRECTION #######
apptrain[, DAYS_EMPLOYED := ifelse(DAYS_EMPLOYED==365243, NA, DAYS_EMPLOYED)]

####### NA IDENTIFICATION #######
apptrain[, lapply(.SD, function(x) sum(is.na(x)))]

####### NO NA #######

apptrain2 <- na.omit(apptrain)
nums <- unlist(lapply(apptrain2, is.numeric))  

apptrain_num <- apptrain2[, nums, with=F]

cols_del <- findCorrelation(apptrain_num, cutoff = 0.8)

apptrain_num[, -cols_del, with=F]

correlation <- cor(apptrain_num)
corrplot.mixed(correlation, tl.cex=1)

View(description)

summary(apptrain)
str(apptrain)

# Contagem de nulos por coluna
colSums(is.na(apptrain))

#####