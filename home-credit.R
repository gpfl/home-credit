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

####### DATA TRANSFORMATIONS #######

# Box-Cox test
preProcValues <- preProcess(apptrain, method = "BoxCox")
preProcValues

# Box-Cox Transformations 
BoxCoxValues <- apply(apptrain_num, 2, function(x) BoxCoxTrans(x, na.rm = TRUE))
x = list()

for (i in 1:ncol(apptrain_num)){
     lambda <- BoxCoxValues[[i]][[1]]
     x[[i]] <- lambda
}
# Organizing transformed lambda into a data.table
lambda = do.call(rbind, x)
lambda_df <- data.table("Column" = colnames(apptrain_num), "Lambda" = lambda)
# Lambda DF
na.omit(lambda_df)

# Subsetting columns transformed by Box-Cox
apptrain2[, na.omit(lambda_df)$Column, with=F]
# Tava tentando plotar essas variáveis em histogramas, como no kernel...