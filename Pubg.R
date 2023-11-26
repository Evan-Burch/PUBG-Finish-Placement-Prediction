library("readr")
library("e1071")
library("corrplot")
library("Metrics")

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

# Use an 80 20 split to create our own train/test sets
smp_size <- floor(0.80 * nrow(train_V2_clean))
set.seed(123)
train_ind <- sample(seq_len(nrow(train_V2_clean)), size = smp_size)
pubg_train <- train_V2_clean[train_ind, ]
pubg_test <- train_V2_clean[-train_ind, ]

pubg_train_reduced = pubg_train[1:10000,]
pubg_test_reduced = pubg_test[1:2000,]

# Exploring Dataset after cleaning
hist(pubg_train_reduced$damageDealt)
hist(pubg_train_reduced$kills)
hist(pubg_train_reduced$matchDuration)
hist(pubg_train_reduced$walkDistance)

summary(pubg_train_reduced)
summary(pubg_test_reduced)

# Create dataframes with the string variables removed. This will be used in some of the Methods
pubg_train_reduced_stringless <- subset(pubg_train_reduced, select = -c(Id, groupId, matchId, matchType))
pubg_test_reduced_stringless <- subset(pubg_test_reduced, select = -c(Id, groupId, matchId, matchType))

### Method 1 - Subset the train and test data using the 6 match types

# Train
solo_train <- subset(pubg_train_reduced_stringless , pubg_train_reduced$matchType == "solo") 
duo_train <- subset(pubg_train_reduced_stringless , pubg_train_reduced$matchType == "duo") 
squad_train <- subset(pubg_train_reduced_stringless , pubg_train_reduced$matchType == "squad") 
solo_fpp_train <- subset(pubg_train_reduced_stringless , pubg_train_reduced$matchType == "solo-fpp") 
duo_fpp_train <- subset(pubg_train_reduced_stringless , pubg_train_reduced$matchType == "duo-fpp")
squad_fpp_train <-  subset(pubg_train_reduced_stringless , pubg_train_reduced$matchType == "duo-fpp")

# Test
solo_test <- subset(pubg_test_reduced_stringless , pubg_test_reduced$matchType == "solo") 
duo_test <- subset(pubg_test_reduced_stringless , pubg_test_reduced$matchType == "duo") 
squad_test <- subset(pubg_test_reduced_stringless , pubg_test_reduced$matchType == "squad") 
solo_fpp_test <- subset(pubg_test_reduced_stringless , pubg_test_reduced$matchType == "solo-fpp") 
duo_fpp_test <- subset(pubg_test_reduced_stringless , pubg_test_reduced$matchType == "duo-fpp")
squad_fpp_test <-  subset(pubg_test_reduced_stringless , pubg_test_reduced$matchType == "duo-fpp")

### Method 2 - Correlation matrix
#set <- subset(train_V2_clean, select = -c(Id, groupId, matchId, matchType)) 
#corr <- cor(set, method="pearson")
#corrplot(corr, method='color')

### Method 3 - Linear/Logistic Regression

# Create a model using the train data where all matchTypes are present
model_lm <- lm(winPlacePerc ~ ., data = pubg_train_reduced)

# Use the model from above to predict the entire test data
mae(pubg_test_reduced$winPlacePerc, predict(model_lm))

# Use the model above to predict the test data one matchType subset at a time
mae(solo_test$winPlacePerc, predict(model_lm))
mae(duo_test$winPlacePerc, predict(model_lm))
mae(squad_test$winPlacePerc, predict(model_lm))
mae(solo_fpp_test$winPlacePerc, predict(model_lm))
mae(duo_fpp_test$winPlacePerc, predict(model_lm))
mae(squad_fpp_test$winPlacePerc, predict(model_lm))

# For each matchType subset, create a its own train model and use that to predict its test data
linear_solo <- lm(winPlacePerc ~ ., data = solo_train)
mae(solo_test$winPlacePerc, predict(linear_solo))

linear_duo <- lm(winPlacePerc ~ ., data = duo_train)
mae(duo_test$winPlacePerc, predict(linear_duo))

linear_squad <- lm(winPlacePerc ~ ., data = squad_train)
mae(squad_test$winPlacePerc, predict(linear_squad))


linear_solo_fpp <- lm(winPlacePerc ~ ., data = solo_fpp_train)
mae(solo_fpp_test$winPlacePerc, predict(linear_solo_fpp))

linear_duo_fpp <- lm(winPlacePerc ~ ., data = duo_fpp_train)
mae(duo_fpp_test$winPlacePerc, predict(linear_duo_fpp))

linear_squad_fpp <- lm(winPlacePerc ~ ., data = squad_fpp_train)
mae(squad_fpp_test$winPlacePerc, predict(linear_squad_fpp))

# Method 4 - Support Vector Regression(SVR)

svr_train <- subset(pubg_train_reduced, select = -c(Id, groupId, matchId, matchType)) 
svr_test <- subset(pubg_test_reduced, select = -c(Id, groupId, matchId, matchType, winPlacePerc))

model_svm <- svm(winPlacePerc ~ ., svr_train)
predictions <-  predict(model_svm,svr_test)

mae <- mean(abs(predictions - pubg_train_reduced$winPlacePerc))
print(paste("Mean Absolute Error (MAE):", mae))

OptModelsvm=tune(svm, winPlacePerc ~ ., data=svr_train,ranges=list(elsilon=seq(0,1,0.1), cost=1:100))



# Method 5 - Random Forest Regressor

set.seed(42)
model_rf <- randomForest(formula = winPlacePerc ~ ., data = pubg_train_reduced, mtry = 10, ntree = 500)
predictions <- predict(model_rf, newdata = pubg_test_reduced)
mae <- mean(abs(predictions - pubg_test_reduced$winPlacePerc))
print(paste("Mean Absolute Error (MAE):", mae))



