library("readr")
library("e1071")
library("corrplot")

train_V2 <- read_csv("train_V2.csv")
pubg_test <- read_csv("test_V2.csv")

hist(train_V2$damageDealt)
hist(train_V2$kills)
hist(train_V2$matchDuration)
hist(train_V2$walkDistance)

summary(train_V2)
summary(pubg_test)

#plot(train_V2$kills ~ train_V2$winPlacePerc)
#plot(train_V2$killPlace ~ train_V2$winPlacePerc)

train_V2_clean <- na.omit(train_V2)

# This is for correlation matrix
train_V2_clean <- subset(train_V2_clean,select = -c(killPoints, rankPoints, winPoints)) 

set <- subset(train_V2_clean, select = -c(Id, groupId, matchId, matchType)) 
corr <- cor(set, method="pearson")
corrplot(corr, method='color')

#SVR Model
#model <- svm(winPlacePerc ~ kills, train_V2)

#predictedY <- predict(model, train_V2)

#points(data$X, predictedY, col = "red", pch=4)


solo <- subset(train_V2_clean , train_V2$matchType == "solo") 

duo <- subset(train_V2_clean , train_V2$matchType == "duo") 

squad <- subset(train_V2_clean , train_V2$matchType == "squad") 

solo_fpp <- subset(train_V2_clean , train_V2$matchType == "solo-fpp") 

duo_fpp <- subset(train_V2_clean , train_V2$matchType == "duo-fpp")


