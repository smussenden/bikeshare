# This is the process to clean up Capital Bikeshare ridership data.  Our end goal is to take all of the single quarter csvs 2010 through 2017 and combine them into one single csv we can use for analysis.  In the process, we'll need to do some of the following things: renamed column headers across columns; join with station name and location data stored in a different file (and account for fact that some older stations may have different names); convert milliseconds column into something more useful #we should use the lubridate package, part of tidyverse to work with those; Also, looks like some older stations had station number baked in with station name, so we're going to need to split that off.

# Remove all previous objects
rm(list=ls(all=TRUE))

# Load the tidyverse, so we can work with dplyr, ggplot2, readr, and also the ggplot themes package ggthemes

library('tidyverse')

# Load lubridate so we can convert funky dates.

library('lubridate')

# Load stringr so we can tweak strings
library('stringr')


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
####BEGIN Q32012####

# Read in Q32012
Q32012 <- read_csv("data/csv/2012-Q3-cabi-trip-history-data.csv", col_names=TRUE)

# Rename the columns to match formatting from other sections.
Q32012 <- Q32012 %>%
  rename(duration = "Duration", start_date = "Start date", end_date = "End date", start_station = "Start Station", end_station = "End Station", bike_number = "Bike#", member_type = "Subscriber Type" )

# Modify the file as follows...
Q32012 <- Q32012 %>%
  # Add a column with the name of the file, to indicate quarter.
  mutate(quarter = "Q32012") %>%
  # Deal with lack of start_station_number column (and lack of station numbers), by creating a column filled with no values.
  mutate(start_station_number = "") %>%
  # Deal with lack of end_station_number column (and lack of station numbers), by creating a column filled with no values.
  mutate(end_station_number = "") %>%
  # Select columns we need in order.
  select(quarter, duration, start_date, end_date, start_station, start_station_number, end_station, end_station_number, bike_number, member_type)
# Convert the start date to a valid datetime format, using lubridate.
Q32012$start_date <- mdy_hm(Q32012$start_date)
# Convert the end date to a valid datetime format, using lubridate.
Q32012$end_date <- mdy_hm(Q32012$end_date)

####END Q32012####

####BEGIN Q42012####

# Read in Q42012
Q42012 <- read_csv("data/csv/2012-Q4-cabi-trip-history-data.csv", col_names=TRUE)

# Rename the columns to match formatting from other sections.
Q42012 <- Q42012 %>%
  rename(duration = "Duration", start_date = "Start date", end_date = "End date", start_station = "Start Station", end_station = "End Station", bike_number = "Bike#", member_type = "Subscription Type")

# Modify the file as follows...
Q42012 <- Q42012 %>%
  # Add a column with the name of the file, to indicate quarter.
  mutate(quarter = "Q42012")  %>%
  # Deal with lack of start_station_number column (and lack of station numbers), by creating a column filled with no values.
  mutate(start_station_number = "") %>%
  # Deal with lack of end_station_number column (and lack of station numbers), by creating a column filled with no values.
  mutate(end_station_number = "") %>%
  # Select columns we need in order.
  select(quarter, duration, start_date, end_date, start_station, start_station_number, end_station, end_station_number, bike_number, member_type)
# Convert the member type column value to match the value in other sections.
Q42012$member_type[Q42012$member_type == "Subscriber"] <- "Registered"
# Convert the start date to a valid datetime format, using lubridate.
Q42012$start_date <- mdy_hm(Q42012$start_date)
# Convert the end date to a valid datetime format, using lubridate.
Q42012$end_date <- mdy_hm(Q42012$end_date)

####END Q42012####

###BEGIN Q12013####

#Read in Q12013
Q12013 <- read_csv("data/csv/2013-Q1-cabi-trip-history-data.csv", col_names=TRUE)

# Rename the columns to match formatting from other sections.
Q12013 <- Q12013 %>%
  rename(duration = "Duration", start_date = "Start date", end_date = "End date", start_station = "Start Station", end_station = "End Station", bike_number = "Bike#", member_type = "Subscription Type" )

# Modify the file as follows...
Q12013 <- Q12013 %>%
  # Add a column with the name of the file, to indicate quarter.
  mutate(quarter = "Q12013")  %>%
  # Deal with lack of start_station_number column (and lack of station numbers), by creating a column filled with no values.
  mutate(start_station_number = "") %>%
  # Deal with lack of end_station_number column (and lack of station numbers), by creating a column filled with no values.
  mutate(end_station_number = "") %>%
  # Select columns we need in order.
  select(quarter, duration, start_date, end_date, start_station, start_station_number, end_station, end_station_number, bike_number, member_type)
# Convert the member type column value to match the value in other sections.
Q12013$member_type[Q12013$member_type == "Subscriber"] <- "Registered"
# Convert the start date to a valid datetime format, using lubridate.
Q12013$start_date <- mdy_hm(Q12013$start_date)
# Convert the end date to a valid datetime format, using lubridate.
Q12013$end_date <- mdy_hm(Q12013$end_date)

####END Q12013####

####BEGIN Q22013####

#Read in Q22013
Q22013 <- read_csv("data/csv/2013-Q2-cabi-trip-history-data.csv", col_names=TRUE)

# Rename the columns to match formatting from other sections.
Q22013 <- Q22013 %>%
  rename(duration = "Duration", start_date = "Start time", end_date = "End date", start_station = "Start Station", end_station = "End Station", bike_number = "Bike#", member_type = "Subscription Type" )

# Modify the file as follows...
Q22013 <- Q22013 %>%
  # Add a column with the name of the file, to indicate quarter.
  mutate(quarter = "Q22013")  %>%
  # Deal with lack of start_station_number column (and lack of station numbers), by creating a column filled with no values.
  mutate(start_station_number = "") %>%
  # Deal with lack of end_station_number column (and lack of station numbers), by creating a column filled with no values.
  mutate(end_station_number = "") %>%
  # Select columns we need in order.
  select(quarter, duration, start_date, end_date, start_station, start_station_number, end_station, end_station_number, bike_number, member_type)
# Convert the member type column value to match the value in other sections.
Q22013$member_type[Q22013$member_type == "Subscriber"] <- "Registered"
# Convert the start date to a valid datetime format, using lubridate.
Q22013$start_date <- mdy_hm(Q22013$start_date)
# Convert the end date to a valid datetime format, using lubridate.
Q22013$end_date <- mdy_hm(Q22013$end_date)

####END Q22013####

####BEGIN Q32013####

#Read in Q32013
Q32013 <- read_csv("data/csv/2013-Q3-cabi-trip-history-data.csv", col_names=TRUE)

# Rename the columns to match formatting from other sections.
Q32013 <- Q32013 %>%
  rename(duration = "Duration", start_date = "Start date", end_date = "End date", start_station = "Start Station", end_station = "End Station", bike_number = "Bike#", member_type = "Subscription Type" )

# Modify the file as follows...
Q32013 <- Q32013 %>%
  # Add a column with the name of the file, to indicate quarter.
  mutate(quarter = "Q32013")  %>%
  # Deal with lack of start_station_number column (and lack of station numbers), by creating a column filled with no values.
  mutate(start_station_number = "") %>%
  # Deal with lack of end_station_number column (and lack of station numbers), by creating a column filled with no values.
  mutate(end_station_number = "") %>%
  # Select columns we need in order.
  select(quarter, duration, start_date, end_date, start_station, start_station_number, end_station, end_station_number, bike_number, member_type)
# Convert the member type column value to match the value in other sections.
Q32013$member_type[Q32013$member_type == "Subscriber"] <- "Registered"
# Convert the start date to a valid datetime format, using lubridate.
Q32013$start_date <- mdy_hm(Q32013$start_date)
# Convert the end date to a valid datetime format, using lubridate.
Q32013$end_date <- mdy_hm(Q32013$end_date)

####END Q32013####

####BEGIN Q42013####

#Read in Q42013
Q42013 <- read_csv("data/csv/2013-Q4-cabi-trip-history-data.csv", col_names=TRUE)

# Rename the columns to match formatting from other sections.
Q42013 <- Q42013 %>%
  rename(duration = "Duration", start_date = "Start date", end_date = "End date", start_station = "Start Station", end_station = "End Station", bike_number = "Bike#", member_type = "Subscription Type" )

# Modify the file as follows...
Q42013 <- Q42013 %>%
  # Add a column with the name of the file, to indicate quarter.
  mutate(quarter = "Q42013")  %>%
  # Deal with lack of start_station_number column (and lack of station numbers), by creating a column filled with no values.
  mutate(start_station_number = "") %>%
  # Deal with lack of end_station_number column (and lack of station numbers), by creating a column filled with no values.
  mutate(end_station_number = "") %>%
  # Select columns we need in order.
  select(quarter, duration, start_date, end_date, start_station, start_station_number, end_station, end_station_number, bike_number, member_type)
# Convert the member type column value to match the value in other sections.
Q42013$member_type[Q42013$member_type == "Subscriber"] <- "Registered"
# Convert the start date to a valid datetime format, using lubridate.
Q42013$start_date <- mdy_hm(Q42013$start_date)
# Convert the end date to a valid datetime format, using lubridate.
Q42013$end_date <- mdy_hm(Q42013$end_date)

####END Q42013####

####BEGIN Q12014####

#Read in Q12014
Q12014 <- read_csv("data/csv/2014-Q1-cabi-trip-history-data.csv", col_names=TRUE)

# Rename the columns to match formatting from other sections.
Q12014 <- Q12014 %>%
  rename(duration = "Duration", start_date = "Start date", end_date = "End date", start_station = "Start Station", end_station = "End Station", bike_number = "Bike#", member_type = "Member Type" )

# Modify the file as follows...
Q12014 <- Q12014 %>%
  # Add a column with the name of the file, to indicate quarter.
  mutate(quarter = "Q12014")  %>%
  # Deal with lack of start_station_number column (and lack of station numbers), by creating a column filled with no values.
  mutate(start_station_number = "") %>%
  # Deal with lack of end_station_number column (and lack of station numbers), by creating a column filled with no values.
  mutate(end_station_number = "") %>%
  # Select columns we need in order.
  select(quarter, duration, start_date, end_date, start_station, start_station_number, end_station, end_station_number, bike_number, member_type)
# Convert the start date to a valid datetime format, using lubridate.
Q12014$start_date <- mdy_hm(Q12014$start_date)
# Convert the end date to a valid datetime format, using lubridate.
Q12014$end_date <- mdy_hm(Q12014$end_date)

####END Q12014####

####BEGIN Q22014####

#Read in Q22014
Q22014 <- read_csv("data/csv/2014-Q2-cabi-trip-history-data.csv", col_names=TRUE)

# Rename the columns to match formatting from other sections.
Q22014 <- Q22014 %>%
  rename(duration = "Duration", start_date = "Start date", end_date = "End date", start_station = "Start Station", end_station = "End Station", bike_number = "Bike#", member_type = "Subscriber Type" )

# Modify the file as follows...
Q22014 <- Q22014 %>%
  # Add a column with the name of the file, to indicate quarter.
  mutate(quarter = "Q22014")  %>%
  # Deal with lack of start_station_number column (and lack of station numbers), by creating a column filled with no values.
  mutate(start_station_number = "") %>%
  # Deal with lack of end_station_number column (and lack of station numbers), by creating a column filled with no values.
  mutate(end_station_number = "") %>%
  # Select columns we need in order.
  select(quarter, duration, start_date, end_date, start_station, start_station_number, end_station, end_station_number, bike_number, member_type)
# Convert the start date to a valid datetime format, using lubridate.
Q22014$start_date <- mdy_hm(Q22014$start_date)
# Convert the end date to a valid datetime format, using lubridate.
Q22014$end_date <- mdy_hm(Q22014$end_date)

####END Q22014####

####BEGIN Q32014####

#Read in Q32014
Q32014 <- read_csv("data/csv/2014-Q3-cabi-trip-history-data.csv", col_names=TRUE)

# Rename the columns to match formatting from other sections.
Q32014 <- Q32014 %>%
  rename(duration = "Duration", start_date = "Start date", end_date = "End date", start_station = "Start Station", end_station = "End Station", bike_number = "Bike#", member_type = "Subscription Type" )

# Modify the file as follows...
Q32014 <- Q32014 %>%
  # Add a column with the name of the file, to indicate quarter.
  mutate(quarter = "Q32014")  %>%
  # Deal with lack of start_station_number column (and lack of station numbers), by creating a column filled with no values.
  mutate(start_station_number = "") %>%
  # Deal with lack of end_station_number column (and lack of station numbers), by creating a column filled with no values.
  mutate(end_station_number = "") %>%
  # Select columns we need in order.
  select(quarter, duration, start_date, end_date, start_station, start_station_number, end_station, end_station_number, bike_number, member_type)
# Convert the start date to a valid datetime format, using lubridate.
Q32014$start_date <- mdy_hm(Q32014$start_date)
# Convert the end date to a valid datetime format, using lubridate.
Q32014$end_date <- mdy_hm(Q32014$end_date)

####END Q32014####

####BEGIN Q42014####

#Read in Q42014
Q42014 <- read_csv("data/csv/2014-Q4-cabi-trip-history-data.csv", col_names=TRUE)

# Rename the columns to match formatting from other sections.
Q42014 <- Q42014 %>%
  rename(duration = "Duration", start_date = "Start date", end_date = "End date", start_station = "Start Station", end_station = "End Station", bike_number = "Bike#", member_type = "Subscription Type" )

# Modify the file as follows...
Q42014 <- Q42014 %>%
  # Add a column with the name of the file, to indicate quarter.
  mutate(quarter = "Q42014")  %>%
  # Deal with lack of start_station_number column (and lack of station numbers), by creating a column filled with no values.
  mutate(start_station_number = "") %>%
  # Deal with lack of end_station_number column (and lack of station numbers), by creating a column filled with no values.
  mutate(end_station_number = "") %>%
  # Select columns we need in order.
  select(quarter, duration, start_date, end_date, start_station, start_station_number, end_station, end_station_number, bike_number, member_type)
# Convert the start date to a valid datetime format, using lubridate.
Q42014$start_date <- mdy_hm(Q42014$start_date)
# Convert the end date to a valid datetime format, using lubridate.
Q42014$end_date <- mdy_hm(Q42014$end_date)

####END Q42014####

####BEGIN Q12015####

#Read in Q12015
Q12015 <- read_csv("data/csv/2015-Q1-Trips-History-Data.csv", col_names=TRUE)

# Rename the columns to match formatting from other sections.
Q12015 <- Q12015 %>%
  rename(duration = "Total duration (ms)", start_date = "Start date", start_station = "Start station", end_date = "End date", end_station = "End station", bike_number = "Bike number", member_type = "Subscription Type")

# Modify the file as follows...
Q12015 <- Q12015 %>%
  # Add a column with the name of the file, to indicate quarter.
  mutate(quarter = "Q12015")  %>%
  # Deal with lack of start_station_number column (and lack of station numbers), by creating a column filled with no values.
  mutate(start_station_number = "") %>%
  # Deal with lack of end_station_number column (and lack of station numbers), by creating a column filled with no values.
  mutate(end_station_number = "") %>%
  # Convert milliseconds in duration column to seconds
  mutate(duration = round(duration/1000)) %>%
  # Select columns we need in order.
  select(quarter, duration, start_date, end_date, start_station, start_station_number, end_station, end_station_number, bike_number, member_type)
# Convert the seconds to duration format
Q12015$duration <- seconds_to_period(Q12015$duration)
# Convert the duration column back to character, so that it binds correctly
Q12015 <- Q12015 %>%
  mutate_if(is.period, as.character)
# Convert the start date to a valid datetime format, using lubridate.
Q12015$start_date <- mdy_hm(Q12015$start_date)
# Convert the end date to a valid datetime format, using lubridate.
Q12015$end_date <- mdy_hm(Q12015$end_date)

####END Q12015####

####BEGIN Q22015####

#Read in Q22015
Q22015 <- read_csv("data/csv/2015-Q2-Trips-History-Data.csv", col_names=TRUE)

# Rename the columns to match formatting from other sections.
Q22015 <- Q22015 %>%
  rename(duration = "Duration (ms)", start_date = "Start date", start_station = "Start station", end_date = "End date", end_station = "End station", bike_number = "Bike number", member_type = "Subscription type")

# Modify the file as follows...
Q22015 <- Q22015 %>%
  # Add a column with the name of the file, to indicate quarter.
  mutate(quarter = "Q22015")  %>%
  # Deal with lack of start_station_number column (and lack of station numbers), by creating a column filled with no values.
  mutate(start_station_number = "") %>%
  # Deal with lack of end_station_number column (and lack of station numbers), by creating a column filled with no values.
  mutate(end_station_number = "") %>%
  # Convert milliseconds in duration column to seconds
  mutate(duration = round(duration/1000)) %>%
  # Select columns we need in order.
  select(quarter, duration, start_date, end_date, start_station, start_station_number, end_station, end_station_number, bike_number, member_type)
# Convert the member type column value to match the value in other sections.
Q22015$member_type[Q22015$member_type == "Member"] <- "Registered"
# Convert the seconds to duration format
Q22015$duration <- seconds_to_period(Q22015$duration)
# Convert the duration column back to character, so that it binds correctly
Q22015 <- Q22015 %>%
  mutate_if(is.period, as.character)
# Convert the start date to a valid datetime format, using lubridate.
Q22015$start_date <- mdy_hm(Q22015$start_date)
# Convert the end date to a valid datetime format, using lubridate.
Q22015$end_date <- mdy_hm(Q22015$end_date)

####END Q22015####


####BEGIN Q32015####

#Read in Q32015
Q32015 <- read_csv("data/csv/2015-Q3-cabi-trip-history-data.csv", col_names=TRUE)

# Rename the columns to match formatting from other sections.
Q32015 <- Q32015 %>%
  rename(duration = "Duration (ms)", start_date = "Start date", start_station = "Start station", end_date = "End date", end_station = "End station", bike_number = "Bike #", member_type = "Member type")

# Modify the file as follows...
Q32015 <- Q32015 %>%
  # Add a column with the name of the file, to indicate quarter.
  mutate(quarter = "Q32015")  %>%
  # Deal with lack of start_station_number column (and lack of station numbers), by creating a column filled with no values.
  mutate(start_station_number = "") %>%
  # Deal with lack of end_station_number column (and lack of station numbers), by creating a column filled with no values.
  mutate(end_station_number = "") %>%
  # Convert milliseconds in duration column to seconds
  mutate(duration = round(duration/1000)) %>%
  # Select columns we need in order.
  select(quarter, duration, start_date, end_date, start_station, start_station_number, end_station, end_station_number, bike_number, member_type)
# Convert the member type column value to match the value in other sections.
Q32015$member_type[Q32015$member_type == "Member"] <- "Registered"
# Convert the seconds to duration format
Q32015$duration <- seconds_to_period(Q32015$duration)
# Convert the duration column back to character, so that it binds correctly
Q32015 <- Q32015 %>%
  mutate_if(is.period, as.character)
# Convert the start date to a valid datetime format, using lubridate.
Q32015$start_date <- mdy_hm(Q32015$start_date)
# Convert the end date to a valid datetime format, using lubridate.
Q32015$end_date <- mdy_hm(Q32015$end_date)

####END Q32015####

####BEGIN Q42015####

#Read in Q42015
Q42015 <- read_csv("data/csv/2015-Q4-Trips-History-Data.csv", col_names=TRUE)

# Rename the columns to match formatting from other sections.
Q42015 <- Q42015 %>%
  rename(duration = "Duration (ms)", start_date = "Start date", start_station = "Start station", start_station_number = "Start station number", end_date = "End date", end_station = "End station", end_station_number = "End station number", bike_number = "Bike #", member_type = "Member type")

# Modify the file as follows...
Q42015 <- Q42015 %>%
  # Add a column with the name of the file, to indicate quarter.
  mutate(quarter = "Q42015")  %>%
  # Convert milliseconds in duration column to seconds
  mutate(duration = round(duration/1000)) %>%
  # Select columns we need in order.
  select(quarter, duration, start_date, end_date, start_station, start_station_number, end_station, end_station_number, bike_number, member_type)
# Convert the seconds to duration format
Q42015$duration <- seconds_to_period(Q42015$duration)
# Convert the duration column back to character, so that it binds correctly. And convert start station number and end station number to character so they bind correctly.
Q42015 <- Q42015 %>%
  mutate_if(is.period, as.character) %>%
  mutate_at(vars(start_station_number), as.character) %>%
  mutate_at(vars(end_station_number), as.character)
# Convert the start date to a valid datetime format, using lubridate.
Q42015$start_date <- mdy_hm(Q42015$start_date)
# Convert the end date to a valid datetime format, using lubridate.
Q42015$end_date <- mdy_hm(Q42015$end_date)

####END Q42015####

####BEGIN Q12016####

#Read in Q12016
Q12016 <- read_csv("data/csv/2016-Q1-Trips-History-Data.csv", col_names=TRUE)

# Rename the columns to match formatting from other sections.
Q12016 <- Q12016 %>%
  rename(duration = "Duration (ms)", start_date = "Start date", start_station = "Start station", start_station_number = "Start station number", end_date = "End date", end_station = "End station", end_station_number = "End station number", bike_number = "Bike number", member_type = "Member Type")

# Modify the file as follows...
Q12016 <- Q12016 %>%
  # Add a column with the name of the file, to indicate quarter.
  mutate(quarter = "Q12016")  %>%
  # Convert milliseconds in duration column to seconds
  mutate(duration = round(duration/1000)) %>%
  # Select columns we need in order.
  select(quarter, duration, start_date, end_date, start_station, start_station_number, end_station, end_station_number, bike_number, member_type)
# Convert the seconds to duration format
Q12016$duration <- seconds_to_period(Q12016$duration)
# Convert the duration column back to character, so that it binds correctly. And convert start station number and end station number to character so they bind correctly.
Q12016 <- Q12016 %>%
  mutate_if(is.period, as.character) %>%
  mutate_at(vars(start_station_number), as.character) %>%
  mutate_at(vars(end_station_number), as.character)
# Convert the start date to a valid datetime format, using lubridate.
Q12016$start_date <- mdy_hm(Q12016$start_date)
# Convert the end date to a valid datetime format, using lubridate.
Q12016$end_date <- mdy_hm(Q12016$end_date)

####END Q12016####

####BEGIN Q22016####

#Read in Q22016
Q22016 <- read_csv("data/csv/2016-Q2-Trips-History-Data.csv", col_names=TRUE)

# Rename the columns to match formatting from other sections.
Q22016 <- Q22016 %>%
  rename(duration = "Duration (ms)", start_date = "Start date", start_station = "Start station", start_station_number = "Start station number", end_date = "End date", end_station = "End station", end_station_number = "End station number", bike_number = "Bike number", member_type = "Account type")

# Modify the file as follows...
Q22016 <- Q22016 %>%
  # Add a column with the name of the file, to indicate quarter.
  mutate(quarter = "Q22016")  %>%
  # Convert milliseconds in duration column to seconds
  mutate(duration = round(duration/1000)) %>%
  # Select columns we need in order.
  select(quarter, duration, start_date, end_date, start_station, start_station_number, end_station, end_station_number, bike_number, member_type)
# Convert the seconds to duration format
Q22016$duration <- seconds_to_period(Q22016$duration)
# Convert the duration column back to character, so that it binds correctly. And convert start station number and end station number to character so they bind correctly.
Q22016 <- Q22016 %>%
  mutate_if(is.period, as.character) %>%
  mutate_at(vars(start_station_number), as.character) %>%
  mutate_at(vars(end_station_number), as.character)
# Convert the start date to a valid datetime format, using lubridate.
Q22016$start_date <- mdy_hm(Q22016$start_date)
# Convert the end date to a valid datetime format, using lubridate.
Q22016$end_date <- mdy_hm(Q22016$end_date)

####END Q22016####

####BEGIN Q3A2016####

#Read in Q3A2016
Q3A2016 <- read_csv("data/csv/2016-Q3-Trips-History-Data-1.csv", col_names=TRUE)

# Rename the columns to match formatting from other sections.
Q3A2016 <- Q3A2016 %>%
  rename(duration = "Duration (ms)", start_date = "Start date", start_station = "Start station", start_station_number = "Start station number", end_date = "End date", end_station = "End station", end_station_number = "End station number", bike_number = "Bike number", member_type = "Member Type")

# Modify the file as follows...
Q3A2016 <- Q3A2016 %>%
  # Add a column with the name of the file, to indicate quarter.
  mutate(quarter = "Q32016")  %>%
  # Convert milliseconds in duration column to seconds
  mutate(duration = round(duration/1000)) %>%
  # Select columns we need in order.
  select(quarter, duration, start_date, end_date, start_station, start_station_number, end_station, end_station_number, bike_number, member_type)
# Convert the seconds to duration format
Q3A2016$duration <- seconds_to_period(Q3A2016$duration)
# Convert the duration column back to character, so that it binds correctly. And convert start station number and end station number to character so they bind correctly.
Q3A2016 <- Q3A2016 %>%
  mutate_if(is.period, as.character) %>%
  mutate_at(vars(start_station_number), as.character) %>%
  mutate_at(vars(end_station_number), as.character)
# Convert the start date to a valid datetime format, using lubridate.
Q3A2016$start_date <- mdy_hm(Q3A2016$start_date)
# Convert the end date to a valid datetime format, using lubridate.
Q3A2016$end_date <- mdy_hm(Q3A2016$end_date)

####END Q3A2016####

####BEGIN Q3B2016####

#Read in Q3B2016
Q3B2016 <- read_csv("data/csv/2016-Q3-Trips-History-Data-2.csv", col_names=TRUE)

# Rename the columns to match formatting from other sections.
Q3B2016 <- Q3B2016 %>%
  rename(duration = "Duration (ms)", start_date = "Start date", start_station = "Start station", start_station_number = "Start station number", end_date = "End date", end_station = "End station", end_station_number = "End station number", bike_number = "Bike number", member_type = "Member Type")

# Modify the file as follows...
Q3B2016 <- Q3B2016 %>%
  # Add a column with the name of the file, to indicate quarter.
  mutate(quarter = "Q32016")  %>%
  # Convert milliseconds in duration column to seconds
  mutate(duration = round(duration/1000)) %>%
  # Select columns we need in order.
  select(quarter, duration, start_date, end_date, start_station, start_station_number, end_station, end_station_number, bike_number, member_type)
# Convert the seconds to duration format
Q3B2016$duration <- seconds_to_period(Q3B2016$duration)
# Convert the duration column back to character, so that it binds correctly. And convert start station number and end station number to character so they bind correctly.
Q3B2016 <- Q3B2016 %>%
  mutate_if(is.period, as.character) %>%
  mutate_at(vars(start_station_number), as.character) %>%
  mutate_at(vars(end_station_number), as.character)
# Convert the start date to a valid datetime format, using lubridate.
Q3B2016$start_date <- mdy_hm(Q3B2016$start_date)
# Convert the end date to a valid datetime format, using lubridate.
Q3B2016$end_date <- mdy_hm(Q3B2016$end_date)

####END Q3B2016####

####BEGIN Q42016####

#Read in Q42016
Q42016 <- read_csv("data/csv/2016-Q4-Trips-History-Data.csv", col_names=TRUE)

# Rename the columns to match formatting from other sections.
Q42016 <- Q42016 %>%
  rename(duration = "Duration (ms)", start_date = "Start date", start_station = "Start station", start_station_number = "Start station number", end_date = "End date", end_station = "End station", end_station_number = "End station number", bike_number = "Bike number", member_type = "Member Type")

# Modify the file as follows...
Q42016 <- Q42016 %>%
  # Add a column with the name of the file, to indicate quarter.
  mutate(quarter = "Q42016")  %>%
  # Convert milliseconds in duration column to seconds
  mutate(duration = round(duration/1000)) %>%
  # Select columns we need in order.
  select(quarter, duration, start_date, end_date, start_station, start_station_number, end_station, end_station_number, bike_number, member_type)
# Convert the seconds to duration format
Q42016$duration <- seconds_to_period(Q42016$duration)
# Convert the duration column back to character, so that it binds correctly. And convert start station number and end station number to character so they bind correctly.
Q42016 <- Q42016 %>%
  mutate_if(is.period, as.character) %>%
  mutate_at(vars(start_station_number), as.character) %>%
  mutate_at(vars(end_station_number), as.character)
# Convert the start date to a valid datetime format, using lubridate.
Q42016$start_date <- mdy_hm(Q42016$start_date)
# Convert the end date to a valid datetime format, using lubridate.
Q42016$end_date <- mdy_hm(Q42016$end_date)

####END Q42016####

####BEGIN Q12017####

#Read in Q12017
Q12017 <- read_csv("data/csv/2017-Q1-Trips-History-Data.csv", col_names=TRUE)

# Rename the columns to match formatting from other sections.
Q12017 <- Q12017 %>%
  rename(duration = "Duration", start_date = "Start date", start_station = "Start station", start_station_number = "Start station number", end_date = "End date", end_station = "End station", end_station_number = "End station number", bike_number = "Bike number", member_type = "Member Type")

# Modify the file as follows...
Q12017 <- Q12017 %>%
  # Add a column with the name of the file, to indicate quarter.
  mutate(quarter = "Q12017")  %>%
  # Convert milliseconds in duration column to seconds
  mutate(duration = round(duration/1000)) %>%
  # Select columns we need in order.
  select(quarter, duration, start_date, end_date, start_station, start_station_number, end_station, end_station_number, bike_number, member_type)
# Convert the seconds to duration format
Q12017$duration <- seconds_to_period(Q12017$duration)
# Convert the duration column back to character, so that it binds correctly. And convert start station number and end station number to character so they bind correctly.
Q12017 <- Q12017 %>%
  mutate_if(is.period, as.character) %>%
  mutate_at(vars(start_station_number), as.character) %>%
  mutate_at(vars(end_station_number), as.character)
# Convert the start date to a valid datetime format, using lubridate.
Q12017$start_date <- mdy_hm(Q12017$start_date)
# Convert the end date to a valid datetime format, using lubridate.
Q12017$end_date <- mdy_hm(Q12017$end_date)

####END Q12017####

# Bind together the data sets into one giant data set.
allbike <- bind_rows(Q42010,Q12011,Q22011,Q32011,Q42011,Q12012,Q22012,Q32012,Q42012,Q12013,Q22013,Q32013,Q42013,Q12014,Q22014,Q32014,Q42014,Q12015,Q22015,Q32015,Q42015,Q12016,Q22016,Q3A2016,Q3B2016,Q42016,Q12017)


# Remove all but the allbike master dataset to free up memory
rm(list=(ls()[ls()!="allbike"]))



################ Here is where we still need to correct daylight savings time. 

# Calculate duration by subtracting start date from end date, and select the new trip_minutes column in place of the busted duration column. Also trim white space off the end of station names that are blocking grouping.
allbike <- allbike %>%
  mutate(trip_minutes=difftime(allbike$end_date, allbike$start_date, units = c("mins"))) %>%
  select(quarter, trip_minutes, start_date, end_date, start_station, start_station_number, end_station, end_station_number, bike_number, member_type) %>%
  mutate(start_station= str_trim(start_station)) %>%
  mutate(end_station= str_trim(end_station))


# Convert bike station start_station names so they join properly
allbike$start_station[allbike$start_station == "11th & K St NW"] <- "10th & K St NW"
allbike$start_station[allbike$start_station == "12th & Hayes St"] <- "Pentagon City Metro / 12th & S Hayes St"
allbike$start_station[allbike$start_station == "12th & Hayes St /  Pentagon City Metro"] <- "Pentagon City Metro / 12th & S Hayes St"
allbike$start_station[allbike$start_station == "13th & U St NW"] <- "12th & U St NW"
allbike$start_station[allbike$start_station == "15th & Hayes St"] <- "Pentagon City Metro / 12th & S Hayes St"
allbike$start_station[allbike$start_station == "16th & U St NW"] <- "New Hampshire Ave & T St NW"
allbike$start_station[allbike$start_station == "17th & K St NW [formerly 17th & L St NW]"] <- "17th & K St NW"
allbike$start_station[allbike$start_station == "17th & Rhode Island Ave NW"] <- "Rhode Island & Connecticut Ave NW"
allbike$start_station[allbike$start_station == "18th & Bell St"] <- "Crystal City Metro / 18th & Bell St"
allbike$start_station[allbike$start_station == "18th & Hayes St"] <- "Aurora Hills Community Ctr/18th & Hayes St"
allbike$start_station[allbike$start_station == "18th & Wyoming Ave NW"] <- "18th St & Wyoming Ave NW"
allbike$start_station[allbike$start_station == "19th & New Hampshire Ave NW Dupont Circle south"] <- "20th & O St NW / Dupont South"
allbike$start_station[allbike$start_station == "1st & N ST SE"] <- "1st & N St  SE"
allbike$start_station[allbike$start_station == "20th & Bell St"] <- "Crystal City Metro / 18th & Bell St"
allbike$start_station[allbike$start_station == "22nd & Eads St"] <- "Eads & 22nd St S"
allbike$start_station[allbike$start_station == "23rd & Eads"] <- "Eads & 22nd St S"
allbike$start_station[allbike$start_station == "23rd & Eads St"] <- "Eads & 22nd St S"
allbike$start_station[allbike$start_station == "26th & Crystal Dr"] <- "26th & S Clark St"
allbike$start_station[allbike$start_station == "33rd & Water St NW"] <- "34th & Water St NW"
allbike$start_station[allbike$start_station == "34th St & Minnesota Ave SE"] <- "Randle Circle & Minnesota Ave SE"
allbike$start_station[allbike$start_station == "4th & Adams St NE"] <- "4th & W St NE"
allbike$start_station[allbike$start_station == "4th & Kennedy St NW"] <- "5th & Kennedy St NW"
allbike$start_station[allbike$start_station == "4th St & Massachusetts Ave NW"] <- "3rd & H St NW"
allbike$start_station[allbike$start_station == "4th St & Rhode Island Ave NE"] <- "4th & W St NE"
allbike$start_station[allbike$start_station == "5th St & K St NW"] <- "5th & K St NW"
allbike$start_station[allbike$start_station == "6th & Water St SW / SW Waterfront"] <- "Maine Ave & 7th St SW"
allbike$start_station[allbike$start_station == "7th & F St NW / National Portrait Gallery"] <- "7th & F St NW/Portrait Gallery"
allbike$start_station[allbike$start_station == "7th & Water St SW / SW Waterfront"] <- "Maine Ave & 7th St SW"
allbike$start_station[allbike$start_station == "8th & F St NW"] <- "7th & F St NW/Portrait Gallery"
allbike$start_station[allbike$start_station == "8th & F St NW / National Portrait Gallery"] <- "7th & F St NW/Portrait Gallery"
allbike$start_station[allbike$start_station == "Bethesda Ave & Arlington Blvd"] <- "Bethesda Ave & Arlington Rd"
allbike$start_station[allbike$start_station == "Central Library"] <- "Central Library / N Quincy St & 10th St N"
allbike$start_station[allbike$start_station == "Connecticut Ave & Nebraska Ave NW"] <- "Connecticut & Nebraska Ave NW"
allbike$start_station[allbike$start_station == "Court House Metro / Wilson Blvd & N Uhle St"] <- "Wilson Blvd & N Uhle St"
allbike$start_station[allbike$start_station == "Fairfax Dr & Glebe Rd"] <- "Glebe Rd & 11th St N"
allbike$start_station[allbike$start_station == "Fallsgove Dr & W Montgomery Ave"] <- "Fallsgrove Dr & W Montgomery Ave"
allbike$start_station[allbike$start_station == "Garland Ave & Walden Rd"] <- "Dennis & Amherst Ave"
allbike$start_station[allbike$start_station == "Idaho Ave & Newark St NW [on 2nd District patio]"] <- "Wisconsin Ave & Newark St NW"
allbike$start_station[allbike$start_station == "King St Metro"] <- "King St Metro North / Cameron St"
allbike$start_station[allbike$start_station == "Lee Hwy & N Nelson St"] <- "Lee Hwy & N Monroe St"
allbike$start_station[allbike$start_station == "McPherson Square - 14th & H St NW"] <- "14th St & New York Ave NW"
allbike$start_station[allbike$start_station == "McPherson Square / 14th & H St NW"] <- "14th St & New York Ave NW"
allbike$start_station[allbike$start_station == "MLK Library/9th & G St NW"] <- "10th & G St NW"
allbike$start_station[allbike$start_station == "N Adams St & Lee Hwy"] <- "Lee Hwy & N Adams St"
allbike$start_station[allbike$start_station == "N Fillmore St & Clarendon Blvd"] <- "Clarendon Blvd & N Fillmore St"
allbike$start_station[allbike$start_station == "N Highland St & Wilson Blvd"] <- "Clarendon Metro / Wilson Blvd & N Highland St"
allbike$start_station[allbike$start_station == "N Nelson St & Lee Hwy"] <- "Lee Hwy & N Monroe St"
allbike$start_station[allbike$start_station == "N Quincy St & Wilson Blvd"] <- "Wilson Blvd & N Quincy St"
allbike$start_station[allbike$start_station == "New Hampshire Ave & T St NW [formerly 16th & U St NW]"] <- "New Hampshire Ave & T St NW"
allbike$start_station[allbike$start_station == "Pentagon City Metro / 12th & Hayes St"] <- "Pentagon City Metro / 12th & S Hayes St"
allbike$start_station[allbike$start_station == "Randle Circle & Minnesota Ave NE"] <- "Randle Circle & Minnesota Ave SE"
allbike$start_station[allbike$start_station == "S Abingdon St & 36th St S"] <- "S Stafford & 34th St S"
allbike$start_station[allbike$start_station == "Smithsonian / Jefferson Dr & 12th St SW"] <- "Smithsonian-National Mall / Jefferson Dr & 12th St SW"
allbike$start_station[allbike$start_station == "Solutions & Greensboro Dr"] <- "Greensboro & International Dr"
allbike$start_station[allbike$start_station == "Thomas Jefferson Cmty Ctr / 2nd St S & Ivy"] <- "TJ Cmty Ctr / 2nd St & S Old Glebe Rd"
allbike$start_station[allbike$start_station == "Virginia Square"] <- "Virginia Square Metro / N Monroe St & 9th St N"
allbike$start_station[allbike$start_station == "Wilson Blvd & N Oakland St"] <- "Virginia Square Metro / N Monroe St & 9th St N"
allbike$start_station[allbike$start_station == "Wisconsin Ave & Macomb St NW"] <- "Wisconsin Ave & Newark St NW"	

# Convert bike station end_station names so they join properly
allbike$end_station[allbike$end_station == "11th & K St NW"] <- "10th & K St NW"
allbike$end_station[allbike$end_station == "12th & Hayes St"] <- "Pentagon City Metro / 12th & S Hayes St"
allbike$end_station[allbike$end_station == "12th & Hayes St /  Pentagon City Metro"] <- "Pentagon City Metro / 12th & S Hayes St"
allbike$end_station[allbike$end_station == "13th & U St NW"] <- "12th & U St NW"
allbike$end_station[allbike$end_station == "15th & Hayes St"] <- "Pentagon City Metro / 12th & S Hayes St"
allbike$end_station[allbike$end_station == "16th & U St NW"] <- "New Hampshire Ave & T St NW"
allbike$end_station[allbike$end_station == "17th & K St NW [formerly 17th & L St NW]"] <- "17th & K St NW"
allbike$end_station[allbike$end_station == "17th & Rhode Island Ave NW"] <- "Rhode Island & Connecticut Ave NW"
allbike$end_station[allbike$end_station == "18th & Bell St"] <- "Crystal City Metro / 18th & Bell St"
allbike$end_station[allbike$end_station == "18th & Hayes St"] <- "Aurora Hills Community Ctr/18th & Hayes St"
allbike$end_station[allbike$end_station == "18th & Wyoming Ave NW"] <- "18th St & Wyoming Ave NW"
allbike$end_station[allbike$end_station == "19th & New Hampshire Ave NW Dupont Circle south"] <- "20th & O St NW / Dupont South"
allbike$end_station[allbike$end_station == "1st & N ST SE"] <- "1st & N St  SE"
allbike$end_station[allbike$end_station == "20th & Bell St"] <- "Crystal City Metro / 18th & Bell St"
allbike$end_station[allbike$end_station == "22nd & Eads St"] <- "Eads & 22nd St S"
allbike$end_station[allbike$end_station == "23rd & Eads"] <- "Eads & 22nd St S"
allbike$end_station[allbike$end_station == "23rd & Eads St"] <- "Eads & 22nd St S"
allbike$end_station[allbike$end_station == "26th & Crystal Dr"] <- "26th & S Clark St"
allbike$end_station[allbike$end_station == "33rd & Water St NW"] <- "34th & Water St NW"
allbike$end_station[allbike$end_station == "34th St & Minnesota Ave SE"] <- "Randle Circle & Minnesota Ave SE"
allbike$end_station[allbike$end_station == "4th & Adams St NE"] <- "4th & W St NE"
allbike$end_station[allbike$end_station == "4th & Kennedy St NW"] <- "5th & Kennedy St NW"
allbike$end_station[allbike$end_station == "4th St & Massachusetts Ave NW"] <- "3rd & H St NW"
allbike$end_station[allbike$end_station == "4th St & Rhode Island Ave NE"] <- "4th & W St NE"
allbike$end_station[allbike$end_station == "5th St & K St NW"] <- "5th & K St NW"
allbike$end_station[allbike$end_station == "6th & Water St SW / SW Waterfront"] <- "Maine Ave & 7th St SW"
allbike$end_station[allbike$end_station == "7th & F St NW / National Portrait Gallery"] <- "7th & F St NW/Portrait Gallery"
allbike$end_station[allbike$end_station == "7th & Water St SW / SW Waterfront"] <- "Maine Ave & 7th St SW"
allbike$end_station[allbike$end_station == "8th & F St NW"] <- "7th & F St NW/Portrait Gallery"
allbike$end_station[allbike$end_station == "8th & F St NW / National Portrait Gallery"] <- "7th & F St NW/Portrait Gallery"
allbike$end_station[allbike$end_station == "Bethesda Ave & Arlington Blvd"] <- "Bethesda Ave & Arlington Rd"
allbike$end_station[allbike$end_station == "Central Library"] <- "Central Library / N Quincy St & 10th St N"
allbike$end_station[allbike$end_station == "Connecticut Ave & Nebraska Ave NW"] <- "Connecticut & Nebraska Ave NW"
allbike$end_station[allbike$end_station == "Court House Metro / Wilson Blvd & N Uhle St"] <- "Wilson Blvd & N Uhle St"
allbike$end_station[allbike$end_station == "Fairfax Dr & Glebe Rd"] <- "Glebe Rd & 11th St N"
allbike$end_station[allbike$end_station == "Fallsgove Dr & W Montgomery Ave"] <- "Fallsgrove Dr & W Montgomery Ave"
allbike$end_station[allbike$end_station == "Garland Ave & Walden Rd"] <- "Dennis & Amherst Ave"
allbike$end_station[allbike$end_station == "Idaho Ave & Newark St NW [on 2nd District patio]"] <- "Wisconsin Ave & Newark St NW"
allbike$end_station[allbike$end_station == "King St Metro"] <- "King St Metro North / Cameron St"
allbike$end_station[allbike$end_station == "Lee Hwy & N Nelson St"] <- "Lee Hwy & N Monroe St"
allbike$end_station[allbike$end_station == "McPherson Square - 14th & H St NW"] <- "14th St & New York Ave NW"
allbike$end_station[allbike$end_station == "McPherson Square / 14th & H St NW"] <- "14th St & New York Ave NW"
allbike$end_station[allbike$end_station == "MLK Library/9th & G St NW"] <- "10th & G St NW"
allbike$end_station[allbike$end_station == "N Adams St & Lee Hwy"] <- "Lee Hwy & N Adams St"
allbike$end_station[allbike$end_station == "N Fillmore St & Clarendon Blvd"] <- "Clarendon Blvd & N Fillmore St"
allbike$end_station[allbike$end_station == "N Highland St & Wilson Blvd"] <- "Clarendon Metro / Wilson Blvd & N Highland St"
allbike$end_station[allbike$end_station == "N Nelson St & Lee Hwy"] <- "Lee Hwy & N Monroe St"
allbike$end_station[allbike$end_station == "N Quincy St & Wilson Blvd"] <- "Wilson Blvd & N Quincy St"
allbike$end_station[allbike$end_station == "New Hampshire Ave & T St NW [formerly 16th & U St NW]"] <- "New Hampshire Ave & T St NW"
allbike$end_station[allbike$end_station == "Pentagon City Metro / 12th & Hayes St"] <- "Pentagon City Metro / 12th & S Hayes St"
allbike$end_station[allbike$end_station == "Randle Circle & Minnesota Ave NE"] <- "Randle Circle & Minnesota Ave SE"
allbike$end_station[allbike$end_station == "S Abingdon St & 36th St S"] <- "S Stafford & 34th St S"
allbike$end_station[allbike$end_station == "Smithsonian / Jefferson Dr & 12th St SW"] <- "Smithsonian-National Mall / Jefferson Dr & 12th St SW"
allbike$end_station[allbike$end_station == "Solutions & Greensboro Dr"] <- "Greensboro & International Dr"
allbike$end_station[allbike$end_station == "Thomas Jefferson Cmty Ctr / 2nd St S & Ivy"] <- "TJ Cmty Ctr / 2nd St & S Old Glebe Rd"
allbike$end_station[allbike$end_station == "Virginia Square"] <- "Virginia Square Metro / N Monroe St & 9th St N"
allbike$end_station[allbike$end_station == "Wilson Blvd & N Oakland St"] <- "Virginia Square Metro / N Monroe St & 9th St N"
allbike$end_station[allbike$end_station == "Wisconsin Ave & Macomb St NW"] <- "Wisconsin Ave & Newark St NW"

# Remove handful of values that don't have a station (NAs), and values at three stations that cannot be located (looks like pop-up stations)
allbike <- allbike %>%
  filter(start_station != "Alta Bicycle Share Demonstration Station") %>%
  filter(start_station != "Alta Tech Office") %>%
  filter(start_station != "Birthday Station") %>%
  filter(!is.na(start_station)) %>%
  filter(end_station != "Alta Bicycle Share Demonstration Station") %>%
  filter(end_station != "Alta Tech Office") %>%
  filter(end_station != "Birthday Station") %>%
  filter(!is.na(end_station))

# Read in the csv of stations from Capital Bikeshare site https://gbfs.capitalbikeshare.com/gbfs/en/station_information.json
stationlist <- read_csv("data/stations/stations.csv",
                        col_types = cols(
                          station_id = col_character(),
                          short_name = col_character())
)

# Join the stationlist to start station values 
allbike <- left_join(allbike,stationlist, by=c("start_station" = "name"))

# Rename and select columns 
allbike <- allbike %>%
  select(quarter:start_station,short_name,lat,lon,end_station,bike_number,member_type) %>%
  rename(start_station_no="short_name",start_lat="lat",start_lon="lon")

# Join the stationlist to end station values 
allbike <- left_join(allbike,stationlist, by=c("end_station" = "name"))

# Rename and select columns 
allbike <- allbike %>%
  select(quarter:end_station,short_name,lat,lon,bike_number,member_type) %>%
  rename(end_station_no="short_name",end_lat="lat",end_lon="lon")



# Still need to write out the CSV
write_csv(allbike, "data/allquarters/allquarters.csv")

# If I don't want to run whole script above, just read in this code on new boot of R to load allbike
allbike <- read_csv("data/allquarters/allquarters.csv")


### CODE BELOW IS HOW I FIGURED OUT PROBLEMS WITH STATION MATCHING

### Station searching
stationsearch <- allbike %>%
  filter(start_station == "10th & K St NW")
View(stationsearch)


View(stationlist)

# Create a list of all the start stations in our allbike file.

startstations <- allbike %>%
  group_by(start_station) %>%
  summarise(count= n()) %>%
  mutate(length= str_length(start_station)) %>%
  arrange(count)
View(startstations)

# Create a list of end stations in our allbike file

endstations <- allbike %>%
  group_by(end_station) %>%
  summarise(count= n()) %>%
  mutate(length= str_length(end_station)) %>%
  arrange(count)
View(endstations)

# Bind these two files together to get a master list of all stations in our file

startstationbind <- startstations %>%
  rename(station = "start_station")
endstationbind <- endstations %>%
  rename(station = "end_station")
ourstations <- bind_rows(startstationbind,endstationbind)
ourstations <- ourstations %>%
  select(station) %>%
  distinct(station)

# Write this file out to a CSV
write_csv(ourstations, "data/stations/OurStations.csv")


# Figure out which startstations and endstations in our allbike dataset are not in their station list by using an anti_join

notinstartstations <- anti_join(startstations,stationlist, by=c( "start_station" = "name"))
notinendstations <- anti_join(endstations,stationlist, by=c( "end_station" = "name"))


# In notinstartstations and notinendstations, rename start_station and end_station as station. Then Bind together notinstartstations and notinendstations to get one big list of values in both files, then group by to remove duplicates

notinstartstations <- notinstartstations %>%
  rename(station = "start_station")

notinendstations <- notinendstations %>%
  rename(station = "end_station")

# Bind them together, then select only distinct values to remove duplicates
NotInEndStart <- bind_rows(notinstartstations,notinendstations)
NotInEndStart <- NotInEndStart %>%
  select(station) %>%
  distinct(station)

# Write this out to a CSV 
write_csv(NotInEndStart, "data/stations/OurStationsNotInTheirData.csv")

# Figure out which of our stations are not in their data
stnotinstation <- anti_join(stationlist,startstations, by=c("name" = "start_station"))
endnotinstation <- anti_join(stationlist,endstations, by=c("name" = "end_station"))

# Bind them together to get one big list of values in both files, then group by to remove duplicates.  This groupby ins't working in R for some reason
NotInTheirData <- bind_rows(stnotinstation,endnotinstation)
NotInTheirData <- NotInTheirData %>%
  select(name) %>%
  distinct(name)

# Write this out to a CSV 
write_csv(NotInTheirData, "data/stations/TheirStationsNotInOurData.csv")

# Create a copy of allbike called xallbike, which I can remove if I need to. This is my working verison. 

xallbike <- allbike


stations <- allbikex %>%
  group_by(start_station,start_station_number) %>%
  summarise(count= n()) %>%
  mutate(length= str_length(start_station)) %>%
  arrange(count)
View(stations)

str_trim(startfix, side = c("both"))
View(allbike)
# Group the stations
#stations <- allbike %>%
#  group_by(start_station) %>%
#  summarise(count= n()) %>%
#  arrange(desc(count)
#View(stations)
#duration <- allbike %>%
#  group_by(duration) %>%
#  summarise(count= n()) %>%
#  arrange(count)
#View(duration)

# Write out the stations to examine
write_csv(stations, "data/allquarters/stations.csv") 

abna <- allbike%>%
  filter(is.na(start_station))
View(abna)
abna2 <- allbike%>%
  filter(is.na(end_station))
View(abna)