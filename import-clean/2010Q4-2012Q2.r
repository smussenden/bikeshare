# This is the process to clean up Capital Bikeshare ridership data.  Our end goal is to take all of the single quarter csvs 2010 through 2017 and combine them into one single csv we can use for analysis.  In the process, we'll need to do some of the following things: renamed column headers across columns; join with station name and location data stored in a different file (and account for fact that some older stations may have different names); convert milliseconds column into something more useful #we should use the lubridate package, part of tidyverse to work with those; Also, looks like some older stations had station number baked in with station name, so we're going to need to split that off. 

# Remove all previous objects
rm(list=ls(all=TRUE))

# Load the tidyverse, so we can work with dplyr, ggplot2, readr, and also the ggplot themes package ggthemes 

library('tidyverse')

# Load lubridate so we can convert funky dates. 

library('lubridate')

####BEGIN Q42010####

# Read in Q42010.
Q42010 <- read_csv("data/csv/2010-Q4-cabi-trip-history-data.csv", col_names= TRUE)

# Rename the columns to match formatting from other sections. 
Q42010 <- Q42010 %>%
  rename(duration="Duration", start_date="Start date", end_date="End date", start_station="Start station", end_station="End station", bike_number="Bike#", member_type='Member Type')

# Fix the problem with two observations in this data set, which contain double parentheses in start_station and end_station, which is throwing off the separate function that follows next. 
Q42010$end_station[Q42010$end_station == "19th & New Hampshire Ave NW (Dupont Circle south) (31234)"] <- "19th & New Hampshire Ave NW Dupont Circle south (31234)"
Q42010$start_station[Q42010$start_station == "19th & New Hampshire Ave NW (Dupont Circle south) (31234)"] <- "19th & New Hampshire Ave NW Dupont Circle south (31234)"

# Modify the file as follows...
Q42010 <- Q42010 %>%  
  # Add a column with the name of the file, to indicate quarter.
  mutate(quarter = "Q42010") %>%
  # Deal with problem of station name and station id being stuck in same column. Separate on first    parentheses. 
  separate(start_station, c("start_station", "start_station_number"), sep='\\(') %>%
  # This error is thrown, still need to debug: Too many values at 2 locations: 96358, 96359
  # Now remove the trailing parentheses at the end of the column.
  separate(start_station_number, c("start_station_number", "other"), sep='\\)') %>%
  # Repeat start_station transformation for end_station. 
  separate(end_station, c("end_station", "end_station_number"), sep='\\(') %>%
  # This error is thrown, still need to debug: Too many values at 2 locations: 96358, 96359
  # Now remove the trailing parentheses at the end of the column.
  separate(end_station_number, c("end_station_number", "other2"), sep='\\)') %>%
  # Select columns we need in order. 
  select(quarter, duration, start_date, end_date, start_station, start_station_number, end_station, end_station_number, bike_number, member_type)

# Convert the start date to a valid datetime format, using lubridate. 
Q42010$start_date <- mdy_hm(Q42010$start_date)
# Convert the end date to a valid datetime format, using lubridate. 
Q42010$end_date <- mdy_hm(Q42010$end_date)

####END Q42010####

####BEGIN Q12011####

# Read in Q12011.
Q12011 <- read_csv("data/csv/2011-Q1-cabi-trip-history-data.csv", col_names= TRUE)

# Rename the columns to match formatting from other sections. 
Q12011 <- Q12011 %>%
  rename(duration="Duration", start_date="Start date", end_date="End date", start_station="Start station", end_station="End station", bike_number="Bike#", member_type='Member Type')
View(Q12011)

Q12011 <- Q12011 %>%  
  # Add a column with the name of the file, to indicate quarter.
  mutate(quarter = "Q12011") %>%
  # Deal with problem of station name and station id being stuck in same column. Separate on first parentheses. 
  separate(start_station, c("start_station", "start_station_number"), sep='\\(') %>%
  # Now remove the trailing parentheses at the end of the column.
  separate(start_station_number, c("start_station_number", "other"), sep='\\)') %>%
  # Repeat start_station transformation for end_station. 
  separate(end_station, c("end_station", "end_station_number"), sep='\\(') %>%
  # Now remove the trailing parentheses at the end of the column.
  separate(end_station_number, c("end_station_number", "other2"), sep='\\)') %>%
  # Select columns we need in order. 
  select(quarter, duration, start_date, end_date, start_station, start_station_number, end_station, end_station_number, bike_number, member_type)

# Convert the start date to a valid datetime format, using lubridate. 
Q12011$start_date <- mdy_hm(Q12011$start_date)
# Convert the end date to a valid datetime format, using lubridate. 
Q12011$end_date <- mdy_hm(Q12011$end_date)


####END Q12011####

####BEGIN Q22011####

# Read in Q22011.
Q22011 <- read_csv("data/csv/2011-Q2-cabi-trip-history-data.csv", col_names= TRUE)

# Rename the columns to match formatting from other sections. 
Q22011 <- Q22011 %>%
  rename(duration="Duration", start_date="Start date", end_date="End date", start_station="Start station", end_station="End station", bike_number="Bike#", member_type='Member Type')
View(Q22011)

Q22011 <- Q22011 %>%  
  # Add a column with the name of the file, to indicate quarter.
  mutate(quarter = "Q22011") %>%
  # Deal with problem of station name and station id being stuck in same column. Separate on first parentheses. 
  separate(start_station, c("start_station", "start_station_number"), sep='\\(') %>%
  # Now remove the trailing parentheses at the end of the column.
  separate(start_station_number, c("start_station_number", "other"), sep='\\)') %>%
  # Repeat start_station transformation for end_station. 
  separate(end_station, c("end_station", "end_station_number"), sep='\\(') %>%
  # Now remove the trailing parentheses at the end of the column.
  separate(end_station_number, c("end_station_number", "other2"), sep='\\)') %>%
  # Select columns we need in order. 
  select(quarter, duration, start_date, end_date, start_station, start_station_number, end_station, end_station_number, bike_number, member_type)

# Convert the start date to a valid datetime format, using lubridate. 
Q22011$start_date <- mdy_hm(Q22011$start_date)
# Convert the end date to a valid datetime format, using lubridate. 
Q22011$end_date <- mdy_hm(Q22011$end_date)


####END Q22011####
####BEGIN Q32011####
# Read in Q32011.
Q32011 <- read_csv("data/csv/2011-Q3-cabi-trip-history-data.csv", col_names= TRUE)

# Rename the columns to match formatting from other sections. 
Q32011 <- Q32011 %>%
  rename(duration="Duration", start_date="Start date", end_date="End date", start_station="Start station", end_station="End station", bike_number="Bike#", member_type='Member Type')
View(Q32011)

Q32011 <- Q32011 %>%  
  # Add a column with the name of the file, to indicate quarter.
  mutate(quarter = "Q32011") %>%
  # Deal with problem of station name and station id being stuck in same column. Separate on first parentheses. 
  separate(start_station, c("start_station", "start_station_number"), sep='\\(') %>%
  # Now remove the trailing parentheses at the end of the column.
  separate(start_station_number, c("start_station_number", "other"), sep='\\)') %>%
  # Repeat start_station transformation for end_station. 
  separate(end_station, c("end_station", "end_station_number"), sep='\\(') %>%
  # Now remove the trailing parentheses at the end of the column.
  separate(end_station_number, c("end_station_number", "other2"), sep='\\)') %>%
  # Select columns we need in order. 
  select(quarter, duration, start_date, end_date, start_station, start_station_number, end_station, end_station_number, bike_number, member_type)

# Convert the start date to a valid datetime format, using lubridate. 
Q32011$start_date <- mdy_hm(Q32011$start_date)
# Convert the end date to a valid datetime format, using lubridate. 
Q32011$end_date <- mdy_hm(Q32011$end_date)

####END Q32011####
####BEGIN Q42011####

# Read in Q42011.
Q42011 <- read_csv("data/csv/2011-Q4-cabi-trip-history-data.csv", col_names= TRUE)

# Rename the columns to match formatting from other sections. 
Q42011 <- Q42011 %>%
  rename(duration="Duration", start_date="Start date", end_date="End date", start_station="Start station", end_station="End station", bike_number="Bike#", member_type='Member Type')
View(Q42011)

Q42011 <- Q42011 %>%  
  # Add a column with the name of the file, to indicate quarter.
  mutate(quarter = "Q42011") %>%
  # Deal with problem of station name and station id being stuck in same column. Separate on first parentheses. 
  separate(start_station, c("start_station", "start_station_number"), sep='\\(') %>%
  # Now remove the trailing parentheses at the end of the column.
  separate(start_station_number, c("start_station_number", "other"), sep='\\)') %>%
  # Repeat start_station transformation for end_station. 
  separate(end_station, c("end_station", "end_station_number"), sep='\\(') %>%
  # Now remove the trailing parentheses at the end of the column.
  separate(end_station_number, c("end_station_number", "other2"), sep='\\)') %>%
  # Select columns we need in order. 
  select(quarter, duration, start_date, end_date, start_station, start_station_number, end_station, end_station_number, bike_number, member_type)

# Convert the start date to a valid datetime format, using lubridate. 
Q42011$start_date <- mdy_hm(Q42011$start_date)
# Convert the end date to a valid datetime format, using lubridate. 
Q42011$end_date <- mdy_hm(Q42011$end_date)

####END Q42011####
####BEGIN Q12012####
# Read in Q12012.
Q12012 <- read_csv("data/csv/2012-Q1-cabi-trip-history-data.csv", col_names= TRUE)

# Rename the columns to match formatting from other sections. 
Q12012 <- Q12012 %>%
  rename(duration="Duration", start_date="Start date", end_date="End date", start_station="Start Station", end_station="End Station", bike_number="Bike#", member_type='Type')
View(Q12012)

Q12012 <- Q12012 %>%  
  # Add a column with the name of the file, to indicate quarter.
  mutate(quarter = "Q12012") %>%
  # Deal with lack of start_station_number column (and lack of station numbers), by creating a column filled with no values.
  mutate(start_station_number = "") %>%
  # Deal with lack of end_station_number column (and lack of station numbers), by creating a column filled with no values.
  mutate(end_station_number = "") %>%
  # Select columns we need in order. 
  select(quarter, duration, start_date, end_date, start_station, start_station_number, end_station, end_station_number, bike_number, member_type)

# Convert the start date to a valid datetime format, using lubridate. 
Q12012$start_date <- mdy_hm(Q12012$start_date)
# Convert the end date to a valid datetime format, using lubridate. 
Q12012$end_date <- mdy_hm(Q12012$end_date)

####END Q12012####
####BEGIN Q22012####

# Read in Q22012.
Q22012 <- read_csv("data/csv/2012-Q2-cabi-trip-history-data.csv", col_names= TRUE)

# Rename the columns to match formatting from other sections. 
Q22012 <- Q22012 %>%
  rename(duration="Duration", start_date="Start date", end_date="End date", start_station="Start Station", end_station="End Station", bike_number="Bike#", member_type='Bike Key')
View(Q22012)

Q22012 <- Q22012 %>%  
  # Add a column with the name of the file, to indicate quarter.
  mutate(quarter = "Q22012") %>%
  # Deal with lack of start_station_number column (and lack of station numbers), by creating a column filled with no values.
  mutate(start_station_number = "") %>%
  # Deal with lack of end_station_number column (and lack of station numbers), by creating a column filled with no values.
  mutate(end_station_number = "") %>%
  # Select columns we need in order. 
  select(quarter, duration, start_date, end_date, start_station, start_station_number, end_station, end_station_number, bike_number, member_type)

# Convert the start date to a valid datetime format, using lubridate. 
Q22012$start_date <- mdy_hm(Q22012$start_date)
# Convert the end date to a valid datetime format, using lubridate. 
Q22012$end_date <- mdy_hm(Q22012$end_date)


####END Q22012####

####Putting together the data ####

# Bind together the data sets into one giant data set.
Q42010_Q22012 <- bind_rows(Q42010,Q12011,Q22011,Q32011,Q42011,Q12012,Q22012)
# Convert the duration values to a valid period format with lubridate.  Have to do this after the bind, or the bind will not occur correctly. 
Q42010_Q22012$duration <- hms(Q42010_Q22012$duration)

# Exploring 
stations <- Q42010_Q22012 %>%
  unite(ss, start_station, start_station_number, remove=FALSE, sep="-")
View(stations)

stations <- stations %>% 
    group_by(ss) %>%
    summarise(count= n())
  View(stations)

  
  
    
  
  
  

# OTHER NOTES
Q42010$year <- year(Q42010$start_date)
Q42010$day_week <- wday(Q42010$start_date, label=TRUE)


##Sean
Q42010 <- read_csv("data/csv/2010-Q4-cabi-trip-history-data.csv", col_names= TRUE)
Q12011 <- read_csv("data/csv/2011-Q1-cabi-trip-history-data.csv", col_names= TRUE)
Q22011 <- read_csv("data/csv/2011-Q2-cabi-trip-history-data.csv", col_names= TRUE)
Q32011 <- read_csv("data/csv/2011-Q3-cabi-trip-history-data.csv", col_names= TRUE)
Q42011 <- read_csv("data/csv/2011-Q4-cabi-trip-history-data.csv", col_names= TRUE)
Q12012 <- read_csv("data/csv/2012-Q1-cabi-trip-history-data.csv", col_names= TRUE)
Q22012 <- read_csv("data/csv/2012-Q2-cabi-trip-history-data.csv", col_names= TRUE)

#Gina
Q32012 <- read_csv("data/csv/2012-Q3-cabi-trip-history-data.csv", col_names= TRUE)
Q42012 <- read_csv("data/csv/2012-Q4-cabi-trip-history-data.csv", col_names= TRUE)
Q12013 <- read_csv("data/csv/2013-Q1-cabi-trip-history-data.csv", col_names= TRUE)
Q22013 <- read_csv("data/csv/2013-Q2-cabi-trip-history-data.csv", col_names= TRUE)
Q32013 <- read_csv("data/csv/2013-Q3-cabi-trip-history-data.csv", col_names= TRUE)
Q42013 <- read_csv("data/csv/2013-Q4-cabi-trip-history-data.csv", col_names= TRUE)
Q12014 <- read_csv("data/csv/2014-Q1-cabi-trip-history-data.csv", col_names= TRUE)

#Alisha
Q22014 <- read_csv("data/csv/2014-Q2-cabi-trip-history-data.csv", col_names= TRUE)
Q32014 <- read_csv("data/csv/2014-Q3-cabi-trip-history-data.csv", col_names= TRUE)
Q42014 <- read_csv("data/csv/2014-Q4-cabi-trip-history-data.csv", col_names= TRUE)
Q12015 <- read_csv("data/csv/2015-Q1-Trips-History-Data.csv", col_names= TRUE) 
Q22015 <- read_csv("data/csv/2015-Q2-Trips-History-Data.csv", col_names= TRUE)
Q32015 <- read_csv("data/csv/2015-Q3-cabi-trip-history-data.csv", col_names= TRUE)
Q42015 <- read_csv("data/csv/2015-Q4-Trips-History-Data.csv", col_names= TRUE)

#Roberto
Q12016 <- read_csv("data/csv/2016-Q1-Trips-History-Data.csv", col_names= TRUE)
Q22016 <- read_csv("data/csv/2016-Q2-Trips-History-Data.csv", col_names= TRUE)
Q32016A <- read_csv("data/csv/2016-Q3-Trips-History-Data-1.csv", col_names= TRUE)
Q32016B <- read_csv("data/csv/2016-Q3-Trips-History-Data-2.csv", col_names= TRUE)
Q42016 <- read_csv("data/csv/2016-Q4-Trips-History-Data.csv", col_names= TRUE)
Q12017 <- read_csv("data/csv/2017-Q1-Trips-History-Data.csv", col_names= TRUE)



## Create a summary of each data set so that we can see issues with column headers

## Duration – 
From 2010 Q4 until 2014 Q4, duration was recorded in hours, minutes and seconds. 
Beginning 2015 Q1 duration was recorded in milliseconds

Station numbers - were not recorded until 2015 Q3
``
Columns/Order – 
2010 Q4 - Duration, Start date, End date, Start station, End station, Bike#, Member Type
2011 Q1 - Duration, Start date, End date, Start station, End station, Bike#, Member Type
2011 Q2 - Duration, Start date, End date, Start station, End station, Bike#, Member Type
2011 Q3 - Duration, Start date, End date, Start station, End station, Bike#, Member Type
2011 Q4 - Duration, Start date, End date, Start station, End station, Bike#, Member Type
2012 Q1 - Duration, Start date, End date, Start Station, End Station, Bike#, Type
2012 Q2 - Duration, Start date, End date, Start Station, End Station, Bike#, Bike Key
2012 Q3 - Duration, Start date, End date, Start Station, End Station, Bike#, Subscriber Type
2012 Q4 - Duration, Start date, End date, Start Station, End Station, Bike#, Subscription Type
2013 Q1 - Duration, Start date, End date, Start Station, End Station, Bike#, Subscription Type
2013 Q2 - Duration, Start time, End date, Start Station, End Station, Bike#, Subscription Type
2013 Q3 - Duration, Start date, End date, Start Station, End Station, Bike#, Subscription Type
2013 Q4 - Duration, Start date, Start Station, End date, End Station, Bike#, Subscription Type
2014 Q1 - Duration, Start date, Start Station, End date, End Station, Bike#, Member Type
2014 Q2 - Duration, Start date, Start Station, End date, End Station, Bike#, Subscriber Type
2014 Q3 - Duration, Start date, Start Station, End date, End Station, Bike#, Subscription Type
2014 Q4 – Duration, Start date, Start Station, End date, End Station, Bike#, Subscription Type
2015 Q1 - Total duration (ms), Start date, Start station, End date, End station, Bike number, Subscription Type
2015 Q2 - Duration (ms), Start date, Start station, End date, End station, Bike number, Subscription type
2015 Q3 - Duration (ms), Start date, End date, Start station number, Start station, End station number, End station, Bike #, Member type
2015 Q4 - Duration (ms), Start date, End date, Start station number, Start station, End station number, End station, Bike #, Member type
2016 Q1 Duration (ms), Start date, End date, Start station number, Start station, 	End station number, End station, Bike number, Member Type
2016 Q2 - Duration (ms), Start date, End date, Start station number, Start station, End station number, End station, Bike number, Account type
2016 Q3 - Duration (ms), Start date, End date, Start station number, Start station, End station number, End station, Bike number	, Member Type
2016 Q3-2 - Duration (ms), Start date, End date, Start station number, Start station, End station number, End station, Bike number, Member Type
2016 Q4 - Duration (ms), Start date, End date, Start station number, Start station, End station number, End station, Bike number, Member Type
2017 Q1 - Duration (ms), Start date, End date, Start station number, Start station, End station number, End station, Bike number, Member Type




Member/Subscription Type – 
2010 Q4 - Member: Casual, Registered
2011 Q1 - Member: Casual, Registered
2011 Q2 - Member: Casual, Registered
2011 Q3 - Member: Casual, Registered
2011 Q4 - Member: Casual, Registered
2012 Q1 - Type: Casual, Registered
2012 Q2 - Bike Key: Casual, Registered
2012 Q3 - Subscriber Type: Casual, Registered
2012 Q4 - Subscription Type: Casual, Subscriber
2013 Q1 - Subscription Type: Casual, Subscriber
2013 Q2 - Subscription Type: Casual, Subscriber
2013 Q3 - Subscription Type: Casual, Subscriber
2013 Q4 - Subscription Type: Casual, Subscriber
2014 Q1 - Member Type: Casual, Registered
2014 Q2 - Subscriber Type: Casual, Registered
2014 Q3 - Subscription Type: Casual, Registered
2014 Q4 - Subscription Type: Casual, Registered
2015 Q1 - Subscription Type: Casual, Registered
2015 Q2 - Subscription Type: Casual, Member
2015 Q3 - Member Type: Casual, Registered
2015 Q4 - Member Type: Casual, Registered
2016 Q1 - Member Type: Casual, Registered
2016 Q2 - Account Type: Casual, Registered
2016 Q3 - Member Type: Casual, Registered
2016 Q3-2 - Member Type: Casual, Registered
2016 Q4 - Member Type: Casual, Registered
2017 Q1 - Member Type: Casual, Registered
