library(stringr)

###find non-standard bike numbers
bike_number_anomalies <- allbike %>%
  filter(str_detect(bike_number, '0x')) %>%
  select(quarter,bike_number) 
View(bike_number_anomalies)
rm(bike_number_anomalies)


###How many times has each bike been used?
bike_usage <- allbike %>%
  group_by(bike_number) %>%
  summarise(count= n()) %>%
  arrange(count)
View(bike_usage)

###How many times has each bike been used per quarter?
bike_usage_qtr <- allbike %>%
  group_by(bike_number,quarter) %>%
  summarise(count= n()) %>%
  arrange(desc(count)) 
View(bike_usage_qtr)
rm(bike_usage_qtr)

###one bike's usage
bike_W21050 <- allbike %>%
  filter(str_detect(bike_number, 'W21050'))
# select(quarter,bike_number) 
View(bike_W21050)
rm(bike_W21050)

###one bike's usage per qtr
bike_W21050_qtr <- allbike %>%
  group_by(quarter) %>%
  filter(str_detect(bike_number, 'W21050')) %>%
  summarise(count= n()) %>%
  arrange(quarter,desc(count)) 
View(bike_W21050_qtr)
rm(bike_W21050_qtr)

bike_W21384_qtr <- allbike %>%
  group_by(quarter) %>%
  filter(str_detect(bike_number, 'W21384')) %>%
  summarise(count= n()) %>%
  arrange(quarter,desc(count)) 
View(bike_W21384_qtr)
rm(bike_W21384_qtr)

##one bike's travel through the city
bike_W21384_travel <- y2013 %>%
  group_by(start_date) %>%
  filter(str_detect(bike_number, 'W21384'))
arrange(start_date) 
View(bike_W21384_travel)
rm(bike_W21384_travel)



###create df for one year
y2011 <- allbike %>%
  filter(str_detect(quarter, '2011'))
View(y2011)
rm(y2011)

y2012 <- allbike %>%
  filter(str_detect(quarter, '2012'))
View(y2012)
rm(y2012)

y2013 <- allbike %>%
  filter(str_detect(quarter, '2013'))
View(y2013)
rm(y2013)


y2013 <- allbike %>%
  filter(str_detect(quarter, '2014'))
View(y2014)
rm(y2014)

y2015 <- allbike %>%
  filter(str_detect(quarter, '2015'))
View(y2015)
rm(y2015)

y2016 <- allbike %>%
  filter(str_detect(quarter, '2016'))
View(y2016)
rm(y2011)


start_station <- allbike %>%
  group_by(start_station) %>%
  summarise(count= n()) %>%
  arrange(count)
View(start_station)

