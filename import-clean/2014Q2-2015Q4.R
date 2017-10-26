print('Alisha')
install.packages("lubridate")
library('tidyverse')
library('lubridate')


##Reading in File Q22014
Q22014 <- read_csv("BikeShare_Datasets/2014-Q2-cabi-trip-history-data.csv", col_names = TRUE)
View(Q22014)
Q22014 <- Q22014 %>%
  rename(duration = "Duration", start_date = "Start date", start_station = "Start Station", end_date = "End date", end_station = "End Station", bike_number = "Bike#", member_type = "Subscriber Type")%>%
  mutate(quarter = "Q2-2014")%>%
  select(quarter, duration:member_type)

##Converting date from string to date type
Q22014$start_date <- mdy_hm(Q22014$start_date)
Q22014$end_date <- mdy_hm(Q22014$end_date)

#Converting time to date time type
Q22014$duration <- hms(Q22014$duration)

View(Q22014)
rm(Q22014)  


##Reading in File Q32014
Q32014 <- read_csv("BikeShare_Datasets/2014-Q3-cabi-trip-history-data.csv", col_names = TRUE)
View(Q32014)
Q32014 <- Q32014 %>%
  rename(duration = "Duration", start_date = "Start date", start_station = "Start Station", end_date = "End date", end_station = "End Station", bike_number = "Bike#", member_type = "Subscription Type")%>%
  mutate(quarter = "Q3-2014")%>%
  select(quarter, duration:member_type)

##Converting date from string to date type
Q32014$start_date <- mdy_hm(Q32014$start_date)
Q32014$end_date <- mdy_hm(Q32014$end_date)

#Converting time to date time type
Q32014$duration <- hms(Q32014$duration)

View(Q32014)
rm(Q32014)

##Reading in File Q42014
Q42014 <- read_csv("BikeShare_Datasets/2014-Q4-cabi-trip-history-data.csv", col_names = TRUE)
View(Q42014)
Q42014 <- Q42014 %>%
  rename(duration = "Duration", start_date = "Start date", start_station = "Start Station", end_date = "End date", end_station = "End Station", bike_number = "Bike#", member_type = "Subscription Type") %>%
  mutate(quarter = "Q4-2014")%>%
  select(quarter, duration:member_type)

##Converting date from string to date type (ISSUE)
Q42014$start_date <- ymd_hms(Q42014$start_date)
Q42014$end_date <- ymd_hms(Q42014$end_date)

#Converting time to date time type
Q42014$duration <- hms(Q42014$duration)

View(Q42014)
rm(Q42014)

##Reading in File Q12015
Q12015 <- read_csv("BikeShare_Datasets/2015-Q1-Trips-History-Data.csv", col_names = TRUE)
View(Q12015)
Q12015 <- Q12015 %>%
  rename(duration = "Total duration (ms)", start_date = "Start date", start_station = "Start station", end_date = "End date", end_station = "End station", bike_number = "Bike number", member_type = "Subscription Type")%>%
  mutate(quarter = "Q1-2015")%>%
  select(quarter, duration:member_type)%>%
  mutate(duration = round(duration/1000))

Q12015$duration <- seconds_to_period(Q12015$duration)

##Converting date from string to date type
Q12015$start_date <- mdy_hm(Q12015$start_date)
Q12015$end_date <- mdy_hm(Q12015$end_date)

View(Q12015)
rm(Q12015)


##Reading in File Q22015
Q22015 <- read_csv("BikeShare_Datasets/2015-Q2-Trips-History-Data.csv", col_names = TRUE)
View(Q22015)
Q22015 <- Q22015 %>%
  rename(duration = "Duration (ms)", start_date = "Start date", start_station = "Start station", end_date = "End date", end_station = "End station", bike_number = "Bike number", member_type = "Subscription type")%>%
  mutate(quarter = "Q2-2015")%>%
  select(quarter, duration:member_type)%>%
  mutate(duration = round(duration/1000))

Q22015$duration <- seconds_to_period(Q22015$duration)

##Rename Member to Registered in member_type
Q22015$member_type[Q22015$member_type =="Member"] <- "Registered"

##Converting date from string to date type
Q22015$start_date <- mdy_hm(Q22015$start_date)
Q22015$end_date <- mdy_hm(Q22015$end_date)

View(Q22015)
rm(Q22015)

##Reading in File Q32015
Q32015 <- read_csv("BikeShare_Datasets/2015-Q3-cabi-trip-history-data.csv", col_names = TRUE)
View(Q32015)
Q32015 <- Q32015 %>%
  rename(duration = "Duration (ms)", start_date = "Start date", end_date = "End date", start_station_number = "Start station number",start_station = "Start station", end_station_number = "End station number", end_station = "End station", bike_number = "Bike #", member_type = "Member type")%>%
  mutate(quarter = "Q3-2015")%>%
  select(quarter, duration:member_type)%>%
  mutate(duration = round(duration/1000))

Q32015$duration <- seconds_to_period(Q32015$duration)

##Converting date from string to date type
Q32015$start_date <- mdy_hm(Q32015$start_date)
Q32015$end_date <- mdy_hm(Q32015$end_date)

View(Q32015)
rm(Q32015)

##Reading in File Q42015
Q42015 <- read_csv("BikeShare_Datasets/2015-Q4-Trips-History-Data.csv", col_names = TRUE)
View(Q42015)
Q42015 <- Q42015 %>%
  rename(duration = "Duration (ms)", start_date = "Start date", end_date = "End date", start_station_number = "Start station number",start_station = "Start station", end_station_number = "End station number", end_station = "End station", bike_number = "Bike #", member_type = "Member type")%>%
  mutate(quarter = "Q4-2015")%>%
  select(quarter, duration:member_type)%>%
  mutate(duration = round(duration/1000))

Q42015$duration <- seconds_to_period(Q42015$duration)


##Converting date from string to date type
Q42015$start_date <- mdy_hm(Q42015$start_date)
Q42015$end_date <- mdy_hm(Q42015$end_date)

View(Q42015)
rm(Q42015)





  
