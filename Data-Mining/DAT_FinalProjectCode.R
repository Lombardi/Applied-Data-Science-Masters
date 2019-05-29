library(rpart)
library(rpart.plot)
library(RColorBrewer)
library(rattle)
library(kernlab)
library(caret)
library(e1071)
library(klaR)
library(dplyr)
library(stringr)

# Clean the data #

filepath = 'C:/Users/AdamCharlesMiller/Google Drive/Grad School/Data Mining/Project/NYPD_Complaint_Data_Historic.csv'
nycrime_data <- read.csv(filepath)
nycrime_data <- nycrime_data[nycrime_data$BORO_NM == 'QUEENS',]
nycrime_data <- nycrime_data[nycrime_data$PREM_TYP_DESC == 'BAR/NIGHT CLUB',]
nycrime_data <- na.omit(nycrime_data)

write.csv(nycrime_data, 'Clean_NYPD_Data.csv')
nycrime_data <- read.csv('Clean_NYPD_Data.csv')

num <- c(3,4,9,12,13,16,17)

nycrime_data.clean <- subset(nycrime_data, select = c(num))
colnames(nycrime_data.clean) <- c('Date','Time','Desc','Success','LVO','Precinct','Occurence')
nycrime_data.clean$Precinct <- as.factor(nycrime_data.clean$Precinct)
nycrime_data.clean$Date <- as.Date(nycrime_data.clean$Date, "%m/%d/%Y")

nycrime_data.clean <- nycrime_data.clean %>%
mutate(month = format(Date, "%m"), year = format(Date, "%Y")) %>%
group_by(month,year)
nycrime_data.clean <- nycrime_data.clean[,-1]

z <- lapply(str_split(nycrime_data.clean$Time, ":"), '[',1)
nycrime_data.clean$Hour <- as.character(z)
nycrime_data.clean <- nycrime_data.clean[,-1]
cols <- c('month','year','Hour')
nycrime_data.clean[cols] <- lapply(nycrime_data.clean[cols], factor)

# Create training and testing datasets #

x <- nycrime_data.clean[,c(1:2,4:8)]
y <- unlist(nycrime_data.clean[,3])

index <- sample(1:nrow(nycrime_data.clean), size = round(nrow(nycrime_data.clean)*0.8), replace=FALSE)

train_x <- x[index,]
train_y <- y[index]
test_x <- x[-index,]
test_y <- y[-index]

# Create Decision Tree model #

nycrime.dtmodel <- rpart(LVO ~ ., data = nycrime_data.clean, 
                        method='class',
                       minsplit = 1,
                      minbucket =5)
fancyRpartPlot(nycrime.dtmodel, uniform = TRUE, main = 'Classification Tree for Queens Crime LVO')

# Main predictors seem to be Description as well as Precinct #

# Naive-Bayes model testing #

nycrime.nb <- train(x = train_x, y = train_y, method = 'nb', trControl=trainControl(method='cv', number=10))
nycrime.nb

nycrime.nb.predict <- predict(nycrime.nb$finalModel, test_x)

confusiontable.nb <- table(test_y,nycrime.nb.predict$class,dnn=c('Actual','Prediction'))
accuracy_initial <- sum(diag(confusiontable.nb)) / sum(confusiontable.nb)
accuracy_initial

# Inital NB model is at 93.1% accuracy #

x <- nycrime_data.clean[,c(1,4)]
train_x <- x[index,]
test_x <- x[-index,]

nycrime.nb.updated <- train(x = train_x, y = train_y, method = 'nb', trControl=trainControl(method='cv', number=10))
nycrime.nb.updated

nycrime.nb.updated.predict <- predict(nycrime.nb.updated$finalModel, test_x)

confusiontable.nb.updated <- table(test_y,nycrime.nb.updated.predict$class,dnn=c('Actual','Prediction'))
accuracy_updated <- sum(diag(confusiontable.nb.updated)) / sum(confusiontable.nb.updated)
accuracy_updated

# Updated model accuracy degraded slightly, is currently at 92.9% #

### Support Vector Machines ###

train_data <- nycrime_data.clean[index,]
test_data <- nycrime_data.clean[-index,]

nycrime.svm <- svm(LVO~., data=train_data)
nycrime.svm.predict <- predict(nycrime.svm, test_data)
mean(nycrime.svm.predict == test_data$LVO)

# Initial Accuracy is 94.4% #

nycrime.svm.dt <- svm(LVO~Desc+Precinct, data=train_data)
nycrime.svm.dt.predict <- predict(nycrime.svm.dt, test_data)
mean(nycrime.svm.dt.predict == test_data$LVO)

# Using DT Predictors, model accuracy is reduced to 93.1% #