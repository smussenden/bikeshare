library('tidyverse');
library('lubridate');
library('ggthemes');
library('ggmap');
library('dplyr')


##Analysis scripts are to be ran against the 'allbike' master dataset resulting from all-quarters.r cleaning script

##Question 1: How do ridership patterns vary by season? We would like to answer this question by observing the different changes that occurred in pattern of trips taken during the different quarter of the year for the past five years. In doing so we will be able to determine if there has been a growth of popularity in for this bikeshare program and if it has not improved then we can look into other factors as to why they have not improved (e.g. bike station location, public transportation near the stations).

####Group by quarters, Q1-Q4
Qtype <- allbike %>%
  group_by(quarter) %>%
  summarise(count= n()) %>%
  arrange(desc(count))

####Filter out the Single Quarters of year 2010 and 2017 i.e. Q42010 and Q12017
seasons <-allbike %>% 
  select(quarter, trip_minutes, start_date, end_date, start_station, start_station_number, end_station, end_station_number, bike_number,member_type) %>%
  filter(quarter != "Q42010" & quarter !="Q12017")

####Separate quarter column into quarter_period and year. e.g. value Q42015 --> Q4 and 2015
Qgroups <- seasons %>%
  separate(quarter, into = c("quarter_period", "year"), sep = 2)

####Group quarter_period, quarter_period with maximum count is the favoured quarter thereby knowing the season.
PopularQ <- Qgroups %>%
  group_by(quarter_period) %>%
  summarise(count= n()) %>%
  arrange(desc(count))
View(PopularQ)


##Question 2: What percentage of registered members and casual members -- who take rides under 30-minutes free. This question will help determine whether or not individuals who are registered users tend to use the bikes for longer period of time or do they use them for a similar time period as casual users. Furthermore, this could potentially help us identify patterns why casual users may choose to use the Bikeshare service on a casual basis rather than register to it.

####Group by member_type for all duration
alltime <- allbike %>%
  arrange(desc(trip_minutes))
View(alltime)

allduration <- allbike %>%
  group_by(member_type) %>%
  summarise(count= n()) %>%
  arrange(desc(count))
View(allduration)

####Filter out rows which have trip_minutes as 30 min or less.
below30 <-allbike %>% 
  select(quarter, trip_minutes, start_date, end_date, start_station, start_station_number, end_station, end_station_number, bike_number,member_type) %>%
  filter(trip_minutes < 30)%>%
  arrange(desc(trip_minutes))
View (below30)

####Group by member_type for duration less than or equal to 30 min
mem_type <- below30 %>%
  group_by(member_type) %>%
  summarise(count= n()) %>%
  arrange(desc(count))
View(mem_type)


##Question 3: Which stations are the most and least used start stations? 

#Get the top 20 start stations, identifed by start station number and arrange in descending order.
# Show columns: start_station_no, start_lat, start_lon, count
  top20startstationsno2 <- allbike %>%
    group_by(start_station_no,start_lat,start_lon) %>%
    summarise(count= n()) %>%
    arrange(desc(count)) %>%
    head(20)
  View(top20startstationsno2)

 # Show columns: start_station_no, start_lat, start_lon and write csv  
  top20startstationsnolist <- top20startstationsno2 %>%
    select(start_station_no,start_lat,start_lon)
  View(top20startstationsnolist)
  write.csv(top20startstationsnolist, "data/stations/top20startstationsnolist.csv")
 
  #Get the bottom 20 start stations, identifed by start station number and arrange in descending order.
  # Show columns: start_station_no, start_lat, start_lon, count
    bottom20startstationno <- allbike %>%
    group_by(start_station_no,start_lat,start_lon) %>%
    summarise(count= n()) %>%
    arrange(desc(count)) %>%
    tail(20)
  View(bottom20startstationno)

 # Show columns: start_station_no, start_lat, start_lon and write csv  
  bottom20startstationnolist <- bottom20startstationno %>%
    select(start_station_no,start_lat,start_lon)
  View(bottom20startstationnolist)
  write.csv(bottom20startstationnolist, "data/stations/bottom20startstationnolist.csv")
  
 
