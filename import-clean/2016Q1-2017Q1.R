##Q12016

Q12016 <- read_csv("bike_share_data/2016-Q1-Trips-History-Data.csv" , col_names =TRUE)

Q12016 <- Q12016 %>%
  rename(duration="Duration (ms)", start_date="Start date", end_date="End date", start_station_number="Start station number", start_station="Start station", end_station_number="End station number", end_station="End station", bike_number='Bike number', member_type='Member Type') %>%
  mutate(quarter = "Q1-2016") %>%
  select(quarter, duration:member_type) %>%
  mutate(duration = round(duration/1000))

Q12016$duration <- seconds_to_period(Q12016$duration)

Q12016$start_date <- mdy_hm(Q12016$start_date)
Q12016$end_date <- mdy_hm(Q12016$end_date)


##Q22016

Q22016 <- read_csv("bike_share_data/2016-Q2-Trips-History-Data.csv" , col_names =TRUE)

Q22016 <- Q22016 %>%
  rename(duration="Duration (ms)", start_date="Start date", end_date="End date", start_station_number="Start station number", start_station="Start station", end_station_number="End station number", end_station="End station", bike_number='Bike number', member_type='Account type') %>%
  mutate(quarter = "Q2-2016") %>%
  select(quarter, duration:member_type) %>%
  mutate(duration = round(duration/1000))

Q22016$duration <- seconds_to_period(Q22016$duration)

Q22016$start_date <- mdy_hm(Q22016$start_date)
Q22016$end_date <- mdy_hm(Q22016$end_date)


##### Q3A2016

Q3A2016 <- read_csv("bike_share_data/2016-Q3-Trips-History-Data-1.csv" , col_names =TRUE)

Q3A2016 <- Q3A2016 %>%
  rename(duration="Duration (ms)", start_date="Start date", end_date="End date", start_station_number="Start station number", start_station="Start station", end_station_number="End station number", end_station="End station", bike_number='Bike number', member_type='Member Type') %>%
  mutate(quarter = "Q3A-2016") %>%
  select(quarter, duration:member_type) %>%
  mutate(duration = round(duration/1000))

Q3A2016$duration <- seconds_to_period(Q3A2016$duration)

Q3A2016$start_date <- mdy_hm(Q3A2016$start_date)
Q3A2016$end_date <- mdy_hm(Q3A2016$end_date)


## Q3B2016

Q3B2016 <- read_csv("bike_share_data/2016-Q3-Trips-History-Data-2.csv" , col_names =TRUE)

Q3B2016 <- Q3B2016 %>%
  rename(duration="Duration (ms)", start_date="Start date", end_date="End date", start_station_number="Start station number", start_station="Start station", end_station_number="End station number", end_station="End station", bike_number='Bike number', member_type='Member Type') %>%
  mutate(quarter = "Q3B-2016") %>%
  select(quarter, duration:member_type) %>%
  mutate(duration = round(duration/1000))

Q3B2016$duration <- seconds_to_period(Q3B2016$duration)

Q3B2016$start_date <- mdy_hm(Q3B2016$start_date)
Q3B2016$end_date <- mdy_hm(Q3B2016$end_date)



##Q42016

Q42016 <- read_csv("bike_share_data/2016-Q4-Trips-History-Data.csv" , col_names =TRUE)

Q42016 <- Q42016 %>%
  rename(duration="Duration (ms)", start_date="Start date", end_date="End date", start_station_number="Start station number", start_station="Start station", end_station_number="End station number", end_station="End station", bike_number='Bike number', member_type='Member Type') %>%
  mutate(quarter = "Q4-2016") %>%
  select(quarter, duration:member_type) %>%
  mutate(duration = round(duration/1000))

Q42016$duration <- seconds_to_period(Q42016$duration)

Q42016$start_date <- mdy_hm(Q42016$start_date)
Q42016$end_date <- mdy_hm(Q42016$end_date)

##Q12017

Q12017 <- read_csv("bike_share_data/2017-Q1-Trips-History-Data.csv" , col_names =TRUE)

Q12017 <- Q12017 %>%
  rename(duration="Duration", start_date="Start date", end_date="End date", start_station_number="Start station number", start_station="Start station", end_station_number="End station number", end_station="End station", bike_number='Bike number', member_type='Member Type') %>%
  mutate(quarter = "Q1-2017") %>%
  select(quarter, duration:member_type) %>%
  mutate(duration = round(duration/1000))

Q12017$duration <- seconds_to_period(Q12017$duration)

Q12017$start_date <- mdy_hm(Q12017$start_date)
Q12017$end_date <- mdy_hm(Q12017$end_date)


