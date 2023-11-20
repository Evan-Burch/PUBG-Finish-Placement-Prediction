# PUBG-Finish-Placement-Prediction
Use data science models to predict the win placement of players in PUBG games. The data we use has 6.4 million entries for 29 different variables. See the kaggle competition here for the data and more information: https://www.kaggle.com/competitions/pubg-finish-placement-prediction/overview

``` 
> summary(pubg)
      Id              groupId            matchId             assists       
 Length:4446966     Length:4446966     Length:4446966     Min.   : 0.0000  
 Class :character   Class :character   Class :character   1st Qu.: 0.0000  
 Mode  :character   Mode  :character   Mode  :character   Median : 0.0000  
                                                          Mean   : 0.2338  
                                                          3rd Qu.: 0.0000  
                                                          Max.   :22.0000  
                                                                           
     boosts        damageDealt          DBNOs         headshotKills    
 Min.   : 0.000   Min.   :   0.00   Min.   : 0.0000   Min.   : 0.0000  
 1st Qu.: 0.000   1st Qu.:   0.00   1st Qu.: 0.0000   1st Qu.: 0.0000  
 Median : 0.000   Median :  84.24   Median : 0.0000   Median : 0.0000  
 Mean   : 1.107   Mean   : 130.72   Mean   : 0.6579   Mean   : 0.2268  
 3rd Qu.: 2.000   3rd Qu.: 186.00   3rd Qu.: 1.0000   3rd Qu.: 0.0000  
 Max.   :33.000   Max.   :6616.00   Max.   :53.0000   Max.   :64.0000  
                                                                       
     heals         killPlace       killPoints       kills          killStreaks    
 Min.   : 0.00   Min.   :  1.0   Min.   :   0   Min.   : 0.0000   Min.   : 0.000  
 1st Qu.: 0.00   1st Qu.: 24.0   1st Qu.:   0   1st Qu.: 0.0000   1st Qu.: 0.000  
 Median : 0.00   Median : 47.0   Median :   0   Median : 0.0000   Median : 0.000  
 Mean   : 1.37   Mean   : 47.6   Mean   : 505   Mean   : 0.9248   Mean   : 0.544  
 3rd Qu.: 2.00   3rd Qu.: 71.0   3rd Qu.:1172   3rd Qu.: 1.0000   3rd Qu.: 1.000  
 Max.   :80.00   Max.   :101.0   Max.   :2170   Max.   :72.0000   Max.   :20.000  
                                                                                  
  longestKill      matchDuration   matchType            maxPlace    
 Min.   :   0.00   Min.   :   9   Length:4446966     Min.   :  1.0  
 1st Qu.:   0.00   1st Qu.:1367   Class :character   1st Qu.: 28.0  
 Median :   0.00   Median :1438   Mode  :character   Median : 30.0  
 Mean   :  23.00   Mean   :1580                      Mean   : 44.5  
 3rd Qu.:  21.32   3rd Qu.:1851                      3rd Qu.: 49.0  
 Max.   :1094.00   Max.   :2237                      Max.   :100.0  
                                                                    
   numGroups        rankPoints      revives         rideDistance     
 Min.   :  1.00   Min.   :  -1   Min.   : 0.0000   Min.   :    0.00  
 1st Qu.: 27.00   1st Qu.:  -1   1st Qu.: 0.0000   1st Qu.:    0.00  
 Median : 30.00   Median :1443   Median : 0.0000   Median :    0.00  
 Mean   : 43.01   Mean   : 892   Mean   : 0.1647   Mean   :  606.12  
 3rd Qu.: 47.00   3rd Qu.:1500   3rd Qu.: 0.0000   3rd Qu.:    0.19  
 Max.   :100.00   Max.   :5910   Max.   :39.0000   Max.   :40710.00  
                                                                     
   roadKills          swimDistance        teamKills        vehicleDestroys   
 Min.   : 0.000000   Min.   :   0.000   Min.   : 0.00000   Min.   :0.000000  
 1st Qu.: 0.000000   1st Qu.:   0.000   1st Qu.: 0.00000   1st Qu.:0.000000  
 Median : 0.000000   Median :   0.000   Median : 0.00000   Median :0.000000  
 Mean   : 0.003496   Mean   :   4.509   Mean   : 0.02387   Mean   :0.007918  
 3rd Qu.: 0.000000   3rd Qu.:   0.000   3rd Qu.: 0.00000   3rd Qu.:0.000000  
 Max.   :18.000000   Max.   :3823.000   Max.   :12.00000   Max.   :5.000000  
                                                                             
  walkDistance     weaponsAcquired    winPoints       winPlacePerc   
 Min.   :    0.0   Min.   :  0.00   Min.   :   0.0   Min.   :0.0000  
 1st Qu.:  155.1   1st Qu.:  2.00   1st Qu.:   0.0   1st Qu.:0.2000  
 Median :  685.6   Median :  3.00   Median :   0.0   Median :0.4583  
 Mean   : 1154.2   Mean   :  3.66   Mean   : 606.5   Mean   :0.4728  
 3rd Qu.: 1976.0   3rd Qu.:  5.00   3rd Qu.:1495.0   3rd Qu.:0.7407  
 Max.   :25780.0   Max.   :236.00   Max.   :2013.0   Max.   :1.0000  
                                                     NA's   :1       
```
