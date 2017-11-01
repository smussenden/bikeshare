
#install.packages('tidyverse')
#load the tidyverse
library('tidyverse')
#install.packages('lubridate')
#load lubridate
library(lubridate)

####BEGIN Q32012####

# Read in Q32012
Q32012 <- read_csv("Data/2012-Q3-cabi-trip-history-data.csv", col_names=TRUE)

# Rename the columns to match formatting from other sections.
Q32012 <- Q32012 %>%
  rename(duration = "Duration", start_date = "Start date", end_date = "End date", start_station = "Start Station", end_station = "End Station", bike_number = "Bike#", member_type = "Subscriber Type" ) %>%

# Modify the file as follows...
Q32012 <- Q32012 %>%
  # Add a column with the name of the file, to indicate quarter.  
  mutate(quarter = "Q3-2012")  %>%
  # Select columns we need in order.
  select(quarter, duration:member_type)
  # Convert the start date to a valid datetime format, using lubridate.
  Q32012$start_date <- mdy_hm(Q32012$start_date)
  # Convert the end date to a valid datetime format, using lubridate.
  Q32012$end_date <- mdy_hm(Q32012$end_date)

####END Q32012####

####BEGIN Q42012####

# Read in Q42012
Q42012 <- read_csv("Data/2012-Q4-cabi-trip-history-data.csv", col_names=TRUE)

# Rename the columns to match formatting from other sections.
Q42012 <- Q42012 %>%
  rename(duration = "Duration", start_date = "Start date", end_date = "End date", start_station = "Start Station", end_station = "End Station", bike_number = "Bike#", member_type = "Subscription Type" ) %>%
  
# Modify the file as follows...  
Q42012 <- Q42012 %>%
  # Add a column with the name of the file, to indicate quarter.  
  mutate(quarter = "Q4-2012")  %>%
  # Select columns we need in order.
  select(quarter, duration:member_type)
  # Convert the member type column value to match the value in other sections.
  Q42012$member_type[Q42012$member_type == "Subscriber"] <- "Registered"
  # Convert the start date to a valid datetime format, using lubridate.
  Q42012$start_date <- mdy_hm(Q42012$start_date)
  # Convert the end date to a valid datetime format, using lubridate.
  Q42012$end_date <- mdy_hm(Q42012$end_date)

####END Q42012####  

###BEGIN Q12013####
  
#Read in Q12013  
Q12013 <- read_csv("Data/2013-Q1-cabi-trip-history-data.csv", col_names=TRUE)
  
# Rename the columns to match formatting from other sections.  
Q12013 <- Q12013 %>%
  rename(duration = "Duration", start_date = "Start date", end_date = "End date", start_station = "Start Station", end_station = "End Station", bike_number = "Bike#", member_type = "Subscription Type" ) %>%
  
# Modify the file as follows...    
  # Add a column with the name of the file, to indicate quarter.    
  mutate(quarter = "Q1-2013")  %>%
  # Select columns we need in order.  
  select(quarter, duration:member_type)
  # Convert the member type column value to match the value in other sections.
  Q12013$member_type[Q12013$member_type == "Subscriber"] <- "Registered"
  # Convert the start date to a valid datetime format, using lubridate.
  Q12013$start_date <- mdy_hm(Q12013$start_date)
  # Convert the end date to a valid datetime format, using lubridate.
  Q12013$end_date <- mdy_hm(Q12013$end_date)

####END Q12013####
  
####BEGIN Q22013####
  
#Read in Q22013    
Q22013 <- read_csv("Data/2013-Q2-cabi-trip-history-data.csv", col_names=TRUE)
  
# Rename the columns to match formatting from other sections.  
Q22013 <- Q22013 %>%
  rename(duration = "Duration", start_date = "Start time", end_date = "End date", start_station = "Start Station", end_station = "End Station", bike_number = "Bike#", member_type = "Subscription Type" ) %>%
  
# Modify the file as follows...  
Q22013 <- Q22013 %>%
  # Add a column with the name of the file, to indicate quarter.    
  mutate(quarter = "Q2-2013")  %>%
  # Select columns we need in order.  
  select(quarter, duration:member_type)
  # Convert the member type column value to match the value in other sections.
  Q22013$member_type[Q22013$member_type == "Subscriber"] <- "Registered"
  # Convert the start date to a valid datetime format, using lubridate.
  Q22013$start_date <- mdy_hm(Q22013$start_date)
  # Convert the end date to a valid datetime format, using lubridate.
  Q22013$end_date <- mdy_hm(Q22013$end_date)

####END Q22013####  

####BEGIN Q32013####
  
#Read in Q32013
Q32013 <- read_csv("Data/2013-Q3-cabi-trip-history-data.csv", col_names=TRUE)
  
# Rename the columns to match formatting from other sections.  
Q32013 <- Q32013 %>%
  rename(duration = "Duration", start_date = "Start date", end_date = "End date", start_station = "Start Station", end_station = "End Station", bike_number = "Bike#", member_type = "Subscription Type" ) %>%
  
# Modify the file as follows...   
Q32013 <- Q32013 %>%
  # Add a column with the name of the file, to indicate quarter.    
  mutate(quarter = "Q3-2013")  %>%
  # Select columns we need in order.  
  select(quarter, duration:member_type)
  # Convert the member type column value to match the value in other sections.
  Q32013$member_type[Q32013$member_type == "Subscriber"] <- "Registered"
  # Convert the start date to a valid datetime format, using lubridate.
  Q32013$start_date <- mdy_hm(Q32013$start_date)
  # Convert the end date to a valid datetime format, using lubridate.
  Q32013$end_date <- mdy_hm(Q32013$end_date)

####END Q32013####

####BEGIN Q42013####

#Read in Q42013
Q42013 <- read_csv("Data/2013-Q4-cabi-trip-history-data.csv", col_names=TRUE)
  
# Rename the columns to match formatting from other sections.  
Q42013 <- Q42013 %>%
  rename(duration = "Duration", start_date = "Start date", end_date = "End date", start_station = "Start Station", end_station = "End Station", bike_number = "Bike#", member_type = "Subscription Type" ) %>%
  
# Modify the file as follows...   
Q42013 <- Q42013 %>%
  # Add a column with the name of the file, to indicate quarter.    
  mutate(quarter = "Q4-2013")  %>%
  # Select columns we need in order.  
  select(quarter, duration, start_date, end_date, start_station, end_station, bike_number, member_type)
  # Convert the member type column value to match the value in other sections.
  Q42013$member_type[Q42013$member_type == "Subscriber"] <- "Registered"
  # Convert the start date to a valid datetime format, using lubridate.
  Q42013$start_date <- mdy_hm(Q42013$start_date)
  # Convert the end date to a valid datetime format, using lubridate.
  Q42013$end_date <- mdy_hm(Q42013$end_date)

####END Q42013####

####BEGIN Q12014####
  
#Read in Q12014
Q12014 <- read_csv("Data/2014-Q1-cabi-trip-history-data.csv", col_names=TRUE)
  
# Rename the columns to match formatting from other sections.  
Q12014 <- Q12014 %>%
  rename(duration = "Duration", start_date = "Start date", end_date = "End date", start_station = "Start Station", end_station = "End Station", bike_number = "Bike#", member_type = "Member Type" ) %>%
  
# Modify the file as follows...   
Q42013 <- Q42013 %>%
  # Add a column with the name of the file, to indicate quarter.    
  mutate(quarter = "Q1-2014")  %>%
  # Select columns we need in order.  
  select(quarter, duration, start_date, end_date, start_station, end_station, bike_number, member_type)
  # Convert the start date to a valid datetime format, using lubridate.
  Q12014$start_date <- mdy_hm(Q12014$start_date)
  # Convert the end date to a valid datetime format, using lubridate.
  Q12014$end_date <- mdy_hm(Q12014$end_date)

####END Q12014####


# Bind together the data sets into one giant data set.
Q32012_Q12014 <- bind_rows(Q32012,Q42012,Q12013,Q22013,Q32013,Q42013,Q12014)
# Convert the duration values to a valid period format with lubridate.  Have to do this after the bind, or the bind will not occur correctly.
Q32012_Q12014$duration <- hms(Q32012_Q12014$duration)

# Exploring
stations <- Q32012_Q12014 %>%
  unite(ss, start_station, start_station_number, remove=FALSE, sep="-")
View(stations)

stations <- stations %>%
  group_by(ss) %>%
  summarise(count= n())
View(stations)

