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



###Q3-2012
####Read in the csv dataset
Q32012 <- read_csv("data/csv/2012-Q3-cabi-trip-history-data.csv", col_names=TRUE)
Q32012 <- Q32012 %>%
  ####Rename column names to remove capital letters and replace spaces with underscores
  rename(duration = "Duration", start_date = "Start date", end_date = "End date", start_station = "Start Station", end_station = "End Station", bike_number = "Bike#", member_type = "Subscriber Type" ) %>%
  ####Add a column with the column name 'quarter' and populate the values of the column with quarter number and year
  mutate(quarter = "Q32012")  %>%
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






