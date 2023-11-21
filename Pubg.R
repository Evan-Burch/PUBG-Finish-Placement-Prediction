library("readr")
library("e1071")
library("corrplot")

# Read in the data
train_V2 <- read_csv("train_V2.csv")
pubg_test <- read_csv("test_V2.csv")

# Histograms to analyze and explore the dataset
hist(train_V2$damageDealt)
hist(train_V2$kills)
hist(train_V2$matchDuration)
hist(train_V2$walkDistance)

summary(train_V2)
summary(pubg_test)

# Clean NAs, unused attributes, and outliers from the data
train_V2_clean <- na.omit(train_V2)
train_V2_clean <- subset(train_V2_clean, select =-c(killPoints, rankPoints, winPoints))
train_V2_clean <- subset(train_V2_clean, train_V2_clean$matchDuration != 9)
train_V2_clean <- subset(train_V2_clean, train_V2_clean$kills < 50)

smp_size <- floor(0.80 * nrow(train_V2_clean))
set.seed(123)
train_ind <- sample(seq_len(nrow(train_V2_clean)), size = smp_size)
pubg_train <- train_V2_clean[train_ind, ]
pubg_test <- train_V2_clean[-train_ind, ]

summary(train_V2_clean)

# Method 1 - Subset the data using the 6 match types
solo <- subset(train_V2 , train_V2$matchType == "solo") 

duo <- subset(train_V2 , train_V2$matchType == "duo") 

squad <- subset(train_V2 , train_V2$matchType == "squad") 

solo_fpp <- subset(train_V2 , train_V2$matchType == "solo-fpp") 

duo_fpp <- subset(train_V2 , train_V2$matchType == "duo-fpp")

squad_fpp <-  subset(train_V2 , train_V2$matchType == "duo-fpp")

# Method 2 - Correlation matrix
set <- subset(train_V2_clean, select = -c(Id, groupId, matchId, matchType)) 
corr <- cor(set, method="pearson")
corrplot(corr, method='color')

# Method 3 - Linear/Logistic Regression
#plot(train_V2$kills ~ train_V2$winPlacePerc)
#plot(train_V2$killPlace ~ train_V2$winPlacePerc)

# Method 4 - Support Vector Regression(SVR)
#model <- svm(winPlacePerc ~ kills, train_V2)
#predictedY <- predict(model, train_V2)
#points(data$X, predictedY, col = "red", pch=4)

# Method 5 - Decision Tree Regressor


