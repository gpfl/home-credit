####### LIBRARIES #######
library(data.table)
library(tidyverse)
library(caret)


#######  IMPORTING CSV #####
apptest <- fread("application_test.csv")
apptrain<- fread("application_train.csv")

####### COLUMNS DESCRIPTION

description <- fread("HomeCredit_columns_description.csv")

View(description)

summary(apptrain)
str(apptrain)

# Contagem de nulos por coluna
colSums(is.na(apptrain))

#####