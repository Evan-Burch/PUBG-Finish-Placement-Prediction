library(readr)
pubg <- read_csv("train_V2.csv")
pubg_test <- read_csv("test_V2.csv")

hist(pubg$damageDealt)
hist(pubg$kills)
hist(pubg$matchDuration)
hist(pubg$walkDistance)

summary(pubg)
summary(pubg_test)

plot(pubg$kills ~ pubg$winPlacePerc)
plot(pubg$killPlace ~ pubg$winPlacePerc)
 
cor(pubg)
solo <- subset(train_V2, select = -c(killPoints, rankPoints, winPoints))

