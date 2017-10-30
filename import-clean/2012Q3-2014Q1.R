
#install.packages('tidyverse')
#load the tidyverse
library('tidyverse')
#install.packages('lubridate')
#load lubridate
library(lubridate)

#Column Names/order
##duration, start_date, end_date, start_station_number, start_station, end_station_number, end_station, bike_number, member_type

#First transformation - Rename columns to replace spaces with underscores and replace capital letters with lowercase
Q42016 <- read_csv("Data/2016-Q4-Trips-History-Data.csv", col_names=TRUE)
Q42016 <- Q42016 %>%
  rename(duration = "Duration (ms)", start_date = "Start date", end_date = "End date", start_station_number = "Start station number", start_station = "Start station", end_station_number = "End station number", end_station = "End station", bike_number = "Bike number", member_type = "Member Type" ) %>%
  mutate(quarter = "Q4-2016")  %>%
  select(quarter, duration:member_type)%>%
  mutate(duration = round(duration/1000))

Q42016$start_date <- mdy_hm(Q42016$start_date)
Q42016$end_date <- mdy_hm(Q42016$end_date)
Q42016$duration <- seconds_to_period(Q42016$duration)
View(Q42016)
rm(Q42016)

###Q3-2012
####Read in the csv dataset
Q32012 <- read_csv("Data/2012-Q3-cabi-trip-history-data.csv", col_names=TRUE)
Q32012 <- Q32012 %>%
####Rename column names to remove capital letters and replace spaces with underscores
  rename(duration = "Duration", start_date = "Start date", end_date = "End date", start_station = "Start Station", end_station = "End Station", bike_number = "Bike#", member_type = "Subscriber Type" ) %>%
####Add a column with the column name 'quarter' and populate the values of the column with quarter number and year
    mutate(quarter = "Q3-2012")  %>%
####display the quarter column first
  select(quarter, duration:member_type)
####convert the start date string to datetime in ISO format
Q32012$start_date <- mdy_hm(Q32012$start_date)
####convert the end date string to datetime in ISO format
Q32012$end_date <- mdy_hm(Q32012$end_date)
####convert the duration string to hours, minutes, and seconds
Q32012$duration <- hms(Q32012$duration)
View(Q32012)
rm(Q32012)

###Q4-2012
Q42012 <- read_csv("Data/2012-Q4-cabi-trip-history-data.csv", col_names=TRUE)
Q42012 <- Q42012 %>%
  rename(duration = "Duration", start_date = "Start date", end_date = "End date", start_station = "Start Station", end_station = "End Station", bike_number = "Bike#", member_type = "Subscription Type" ) %>%
  mutate(quarter = "Q4-2012")  %>%
  select(quarter, duration:member_type)
Q42012$member_type[Q42012$member_type == "Subscriber"] <- "Registered"
Q42012$start_date <- mdy_hm(Q42012$start_date)
Q42012$end_date <- mdy_hm(Q42012$end_date)
Q42012$duration <- hms(Q42012$duration)
View(Q42012)
rm(Q42012)

###Q1-2013
Q12013 <- read_csv("Data/2013-Q1-cabi-trip-history-data.csv", col_names=TRUE)
Q12013 <- Q12013 %>%
  rename(duration = "Duration", start_date = "Start date", end_date = "End date", start_station = "Start Station", end_station = "End Station", bike_number = "Bike#", member_type = "Subscription Type" ) %>%
  mutate(quarter = "Q1-2013")  %>%
  select(quarter, duration:member_type)
Q12013$member_type[Q12013$member_type == "Subscriber"] <- "Registered"
Q12013$start_date <- mdy_hm(Q12013$start_date)
Q12013$end_date <- mdy_hm(Q12013$end_date)
Q12013$duration <- hms(Q12013$duration)
View(Q12013)
rm(Q12013)

###Q2-2013
Q22013 <- read_csv("Data/2013-Q2-cabi-trip-history-data.csv", col_names=TRUE)
Q22013 <- Q22013 %>%
  rename(duration = "Duration", start_date = "Start time", end_date = "End date", start_station = "Start Station", end_station = "End Station", bike_number = "Bike#", member_type = "Subscription Type" ) %>%
  mutate(quarter = "Q2-2013")  %>%
  select(quarter, duration:member_type)
Q22013$member_type[Q22013$member_type == "Subscriber"] <- "Registered"
Q22013$start_date <- mdy_hm(Q22013$start_date)
Q22013$end_date <- mdy_hm(Q22013$end_date)
Q22013$duration <- hms(Q22013$duration)
View(Q22013)
rm(Q22013)

###Q3-2013
Q32013 <- read_csv("Data/2013-Q3-cabi-trip-history-data.csv", col_names=TRUE)
Q32013 <- Q32013 %>%
  rename(duration = "Duration", start_date = "Start date", end_date = "End date", start_station = "Start Station", end_station = "End Station", bike_number = "Bike#", member_type = "Subscription Type" ) %>%
  mutate(quarter = "Q3-2013")  %>%
  select(quarter, duration:member_type)
Q32013$member_type[Q32013$member_type == "Subscriber"] <- "Registered"
Q32013$start_date <- mdy_hm(Q32013$start_date)
Q32013$end_date <- mdy_hm(Q32013$end_date)
Q32013$duration <- hms(Q32013$duration)
View(Q32013)
rm(Q32013)

###Q4-2013
Q42013 <- read_csv("Data/2013-Q4-cabi-trip-history-data.csv", col_names=TRUE)
Q42013 <- Q42013 %>%
  rename(duration = "Duration", start_date = "Start date", end_date = "End date", start_station = "Start Station", end_station = "End Station", bike_number = "Bike#", member_type = "Subscription Type" ) %>%
  mutate(quarter = "Q4-2013")  %>%
  select(quarter, duration, start_date, end_date, start_station, end_station, bike_number, member_type)
Q42013$member_type[Q42013$member_type == "Subscriber"] <- "Registered"
Q42013$start_date <- mdy_hm(Q42013$start_date)
Q42013$end_date <- mdy_hm(Q42013$end_date)
Q42013$duration <- hms(Q42013$duration)
View(Q42013)
rm(Q42013)

###Q1-2014
Q12014 <- read_csv("Data/2014-Q1-cabi-trip-history-data.csv", col_names=TRUE)
Q12014 <- Q12014 %>%
  rename(duration = "Duration", start_date = "Start date", end_date = "End date", start_station = "Start Station", end_station = "End Station", bike_number = "Bike#", member_type = "Member Type" ) %>%
  mutate(quarter = "Q1-2014")  %>%
  select(quarter, duration, start_date, end_date, start_station, end_station, bike_number, member_type)
Q12014$start_date <- mdy_hm(Q12014$start_date)
Q12014$end_date <- mdy_hm(Q12014$end_date)
Q12014$duration <- hms(Q12014$duration)
View(Q12014)
rm(Q12014)
