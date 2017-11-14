library('tidyverse');
library('lubridate');



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


##Question 3: Can we uncover the "secret lives" of individual bikes, by measuring how a single bike moves across the city every day for a single year? By answering this question, it can help to develop future activities for community members who use the Bikeshare program such as group membership discounts and coupons for restaurants near the most popular stations.

library('tidyverse');
library('lubridate');
library('stringr')


###create datasets for each year, 2011-2016; Exclude Q42010 and Q12017
y2011 <- allbike %>%
  filter(str_detect(quarter, '2011'))
View(y2011)


y2012 <- allbike %>%
  filter(str_detect(quarter, '2012'))
View(y2012)


y2013 <- allbike %>%
  filter(str_detect(quarter, '2013'))
View(y2013)


y2013 <- allbike %>%
  filter(str_detect(quarter, '2014'))
View(y2014)


y2015 <- allbike %>%
  filter(str_detect(quarter, '2015'))
View(y2015)


y2016 <- allbike %>%
  filter(str_detect(quarter, '2016'))
View(y2016)

###Find how many times each bike has been used.  y2013 can be replaced with any of the above year datasets or the allbike dataset
bike_usage <- y2013 %>%
  group_by(bike_number) %>%
  summarise(count= n()) %>%
  arrange(desc(count)) 
View(bike_usage)
rm(bike_usage)


##one bike's travel through the city; y2013 can be replaced with any of the above year datasets or the allbike dataset
###Choose a bike from the resulting bike_usage dataset above
one_bikes_travel <- y2013 %>%
  group_by(start_date) %>%
  filter(str_detect(bike_number, 'W21384')) %>%
  arrange(start_date) 
View(one_bikes_travel)
rm(one_bikes_travel)
