####### LIBRARIES #######
library(data.table)
library(tidyverse)
library(caret)


#######  IMPORTING CSV #####
apptest <- fread("application_test.csv")
apptrain<- fread("application_train.csv")

####### COLUMNS DESCRIPTION #######
description <- fread("HomeCredit_columns_description.csv")

####### DAYS_EMPLYED CORRECTION #######
apptrain[, DAYS_EMPLOYED := ifelse(DAYS_EMPLOYED==365243, NA, DAYS_EMPLOYED)]


####### NA IDENTIFICATION #######
apptrain[, lapply(.SD, function(x) sum(is.na(x)))]

View(description)

summary(apptrain)
str(apptrain)

# Contagem de nulos por coluna
colSums(is.na(apptrain))

#####