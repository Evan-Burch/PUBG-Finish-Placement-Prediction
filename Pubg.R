library(readr)
library(e1071)
train_V2 <- read_csv("train_V2.csv")
pubg_test <- read_csv("test_V2.csv")

hist(train_V2$damageDealt)
hist(train_V2$kills)
hist(train_V2$matchDuration)
hist(train_V2$walkDistance)

summary(train_V2)
summary(pubg_test)

plot(train_V2$kills ~ train_V2$winPlacePerc)
plot(train_V2$killPlace ~ train_V2pubg$winPlacePerc)

train_V2 <- na.omit(train_V2)
train_V2 <- subset(train_V2,select = -c(killPoints, rankPoints, winPoints)) 

#SVR Model
model <- svm(winPlacePerc ~ kills, train_V2)

predictedY <- predict(model, train_V2)

#points(data$X, predictedY, col = "red", pch=4)


solo <- subset(train_V2 , train_V2$matchType == "solo", select = -c(killPoints, rankPoints, winPoints)) 

duo <- subset(train_V2 , train_V2$matchType == "duo", select = -c(killPoints, rankPoints, winPoints)) 

squad <- subset(train_V2 , train_V2$matchType == "squad", select = -c(killPoints, rankPoints, winPoints)) 

solo_fpp <- subset(train_V2 , train_V2$matchType == "solo-fpp", select = -c(killPoints, rankPoints, winPoints)) 

duo_fpp <- subset(train_V2 , train_V2$matchType == "duo-fpp", select = -c(killPoints, rankPoints, winPoints))


