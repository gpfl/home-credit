#####
#04/10/18 - Gustavo
library(data.table)
library(tidyverse)
library(caret)

apptest <- fread("application_test.csv")
apptrain<- fread("application_train.csv")
View(apptrain)
summary(apptrain)
str(apptrain)

# Contagem de nulos por coluna
colSums(is.na(apptrain))

#####