library('tidyverse');
library('lubridate');


##How do ridership patterns vary by season?
allbike <- read_csv("BikeShare_Datasets/allquarters.csv", col_name=TRUE)

# Calculate duration by subtracting start date from end date, and select the new trip_minutes column in place of the busted duration column.
allbike <- allbike %>%
  mutate(trip_minutes=difftime(allbike$end_date, allbike$start_date, units = c("mins"))) %>%
  select(quarter, trip_minutes, start_date, end_date, start_station, start_station_number, end_station, end_station_number, bike_number, member_type)
View(allbike)


##Group by quarters

Qtype <- allbike %>%
  group_by(quarter) %>%
  summarise(count= n()) %>%
  arrange(desc(count))


##Filter out the Single Quarters of year 2010 and 2017 i.e. Q42010 and Q12017
seasons <-allbike %>% 
  select(quarter, trip_minutes, start_date, end_date, start_station, start_station_number, end_station, end_station_number, bike_number,member_type) %>%
  filter(quarter != "Q42010" & quarter !="Q12017")


##Separate quarter column into quarter_period and year. e.g. value Q42015 --> Q4 and 2015
Qgroups <- seasons %>%
  separate(quarter, into = c("quarter_period", "year"), sep = 2)


##Group quarter_period, quarter_period with maximum count is the favoured quarter thereby knowing the season.
PopularQ <- Qgroups %>%
  group_by(quarter_period) %>%
  summarise(count= n()) %>%
  arrange(desc(count))
View(PopularQ)


##What percentage of registered members and casual members -- who take rides under 30-minutes free


##Group by member_type for all duration
alltime <- allbike %>%
  arrange(desc(trip_minutes))
View(alltime)

allduration <- allbike %>%
  group_by(member_type) %>%
  summarise(count= n()) %>%
  arrange(desc(count))
View(allduration)


##Filter out rows which have trip_minutes as 30 min or else.
below30 <-allbike %>% 
  select(quarter, trip_minutes, start_date, end_date, start_station, start_station_number, end_station, end_station_number, bike_number,member_type) %>%
  filter(trip_minutes < 30)%>%
  arrange(desc(trip_minutes))

View (below30)
 ##Group by member_type for duration less than,equal to 30 min
mem_type <- below30 %>%
  group_by(member_type) %>%
  summarise(count= n()) %>%
  arrange(desc(count))
View(mem_type)



