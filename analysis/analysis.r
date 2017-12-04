#### This file is for analysis of bikeshare data.  
#### Running the cleaning script, import-clean/all-quarters.r will produce a dataframe called `allbike`. Use allbike to run these scripts on. 

#### If you've already run the cleaning script and have exported a csv, and don't want to run the script again, you can read it in directly here, with the following import field:   

allbike <- read_csv("data/allquarters/allquarters.csv")

#### Load required libraries. Note: loading tidverse also loads ggplot2.
library('tidyverse')
library('lubridate')
library('scales')
library('stringr')

##Question 1: How do ridership patterns vary by season? 

##Answer 1: Between 2011 and 2016, ridership was substantially higher in the Summer (4.99 million rides) and Spring (4.53 million rides) than in the Fall (3.51 million rides) and Winter (2.30 million rides). This makes sense. More tourists visit Washington in the summer.  And it's especially unpleasant to ride a bike in extreme cold. See the code below we used to answer this question, and a plot that highlights our conclusion. 
## Marketing problem: can we make this a less seasonal business? 

##First, filter out the Single Quarters of year 2010 and 2017 i.e. Q42010 and Q12017, so we are only analyzing full years. 
seasons <-allbike %>% 
  select(quarter) %>%
  filter(quarter != "Q42010" & quarter !="Q12017")

##Then, separate quarter column into quarter_period and year. e.g. value Q42015 --> Q4 and 2015
Qgroups <- seasons %>%
  separate(quarter, into = c("quarter_period", "year"), sep = 2)

## Group by quarter_period and count the number of records in each quarter.
PopularQ <- Qgroups %>%
  group_by(quarter_period) %>%
  summarise(trips= n()) %>%
  arrange(quarter_period)

## In preparation to plot, rename quarters with season names.  Note: the seasons don't map perfectly to quarters.  For example, in reality, Winter is Dec. 21 to Mar. 21.  The quarter runs Jan. 1 to Mar. 30. But we'll make that clear in subtitle. 

PopularQ$quarter_period[PopularQ$quarter_period =="Q1"] <- "Winter (Q1)"
PopularQ$quarter_period[PopularQ$quarter_period =="Q2"] <- "Spring (Q2)"
PopularQ$quarter_period[PopularQ$quarter_period =="Q3"] <- "Summer (Q3)"
PopularQ$quarter_period[PopularQ$quarter_period =="Q4"] <- "Fall (Q4)"

## Create a bar plot showing the count of trips by season. 

ggplot(data=PopularQ ,aes(quarter_period, trips/1000000)) +
  geom_bar(stat="identity" , fill = "#FF6666") + 
  ggtitle("") +
  labs(y="Number of Rides (in Millions)", x ="Seasons",title="Bikeshare ridership highest in Summer", subtitle="Source: Analysis of Capital Bikeshare ridership data") 

##Question 2: There are two main types of riders who use the Capital Bikeshare system: registered members who buy monthly or annual memberships and casual users who buy single-trip, single-day or week-long passes.  How does the ridership behavior of these two groups differ?  Specificially, what percentage of registered members take trips under 30 minutes, avoiding paying a penalty for taking a longer ride?  And how does that compare to the percentage for casual members?

##Answer 2: Registered users are more likely to take a sub-30 minute trip than casual users. We found that 92.8 percent of trips by registered users were for less than 30 minutes, compared to 59.8 percent of casual users.  See the code below we used to answer this question, and a plot that highlights our conclusion. 

# Group by member type and count the number of trips by type.
all_trips <- allbike %>%
  group_by(member_type) %>%
  summarise(total_trips= n()) 

# Create a subset of the data with only trips less than 30 minutes, group by member type and count sub-30 minute trips for each group. 

below_30 <-allbike %>% 
  filter(trip_minutes < 30) %>%
  group_by(member_type) %>%
  summarise(below_30_trips= n())

##Left join tables all_trips and below_30  and calculate percentage for under 30 min trips for different types of members
trip_percent <- all_trips %>% 
  left_join(below_30)%>%
  mutate(
    under30_percentage = (below_30_trips/total_trips)*100
  )
View(trip_percent)

##Plot the data
ggplot(data=trip_percent ,aes(member_type, under30_percentage)) +
  geom_bar(stat="identity" , fill = "#FF6666") +
  ggtitle("") +
  labs(y= "% of Trips Under 30 mins", x = "Membership type", title="Registered users take more short trips", subtitle="Source: Analysis of Capital Bikeshare ridership data")

##Question 3: How many of the most used bike stations are near a Metro station?
##Answer 3: Of the 20 most used starting stations, 40 percent (8 of 20) are within a half mile of a metro station, indicating that the positioning of bike stations near public transport is an important driver of ridership. 

## Group by start station and count, sort descending.  Then take the top 20 rows and write it out to a csv
top_20_start_stations <- allbike %>%
  group_by(start_station) %>%
  summarise(count= n()) %>%
  arrange(desc(count))
top_20_start_stations <- head(top_20_start_stations, n=20) 
write_csv(start_station,"data/proximity/proximity_raw.csv")

# In CSV, proximity_raw add a column indicating whether the station is within a half mile of a metro station, as determined by examining location on Google Map and measuring distance. Save it as proximity.csv. 

# Read in the newly edited csv with metro station proximity coding.
proximity <- read_csv("data/proximity/proximity.csv")

# Group by proximity to metro, count and calculate percentage.
proximity_grouping <- proximity %>%
  group_by(close_to_metro) %>%
  summarise(count= n()) %>%
  mutate(percent=(count/20)*100)

# Create a stacked bar chart 
ggplot(data=proximity_grouping,aes(1, percent, fill=close_to_metro)) +
  geom_bar(stat="identity") + 
  ggtitle("") +
  labs(y="Percentage of stations in top 20", x ="",title="40 percent of most used stations \n are close to metro", subtitle="Source: Analysis of Capital Bikeshare ridership data") +
  guides(fill=guide_legend(title="Within \nhalf mile \nof Metro Station")) +
  theme(axis.ticks.x=element_blank(), axis.text.x=element_blank()) +
  scale_y_continuous(labels=function(x) paste0(x,"%"))

## Question 4: Are there dedicated bike lanes in the city along the most popular routes taken by people riding Capital Bikeshare bikes?  

##Answer 4: To determine stations that people are riding between frequently, we selected all combinations of start station and end stations with more than 15,000 trips in our data, a total of 17. Using the Google Maps APIs routing tool, we looked at the most efficient bike route along each of those routes, and determined whether there were dedicated bike lanes along those routes. Of the 17, only four had bike lanes along the entire route. The other 13 had partial coverage.  

# Filter out rows where start station and end station are equal, create a new column with the combination of start station and end station, group by those combos and count, then get only those with more than 15K trips.
popular <- allbike %>%
  select(start_station, end_station, start_date, end_date, trip_minutes) %>%
  filter(start_station != end_station) %>%
  mutate(combos = str_c(start_station, "-", end_station)) %>%
  group_by(combos) %>%
  summarise(count= n()) %>%
  arrange(desc(count)) %>%
  filter(count > 15000)

## Write a CSV of the data, and open in Excel
write_csv(popular, "data/popular_paths.csv")

## Create a column called bike_lane_coverage. For each combo of stations, locate the start station on Google Maps, and the end station on Google Maps.  Obtain bike directions between the two points to obtain the preferred path. Visually analyze the degree to which dedicated bike lanes, indicated as solid green lines, are present on the path.  If there are bike lanes along the entire route, mark the cell in bike_lane_coverage as complete.  If there are bike lanes along part of the route, mark the cell as incomplete.  If there are no bike lanes, mark the cell as missing. Save this edited csv as popular_paths_checked.csv

## Future work: find a way to automate this process, using GGMap. We couldn't make this work.

## Read the data back in as popular_paths_checked 
popular_paths <- read_csv("data/popular_paths_checked.csv")

## Group routes by whether or not they've got complete or incomplete coverage along the routes
bike_paths <- popular_paths %>%
  na.omit %>%
  group_by(bike_lane_coverage) %>%
  summarise(coverage= n()) %>%
  arrange(coverage)

## Plot them out. 
ggplot(data=bike_paths ,aes(bike_lane_coverage, coverage)) +
  geom_bar(stat="identity" , fill = "#FF6666") + 
  ggtitle("") +
  labs(y="Number of routes\n (more than 15K trips)", x ="Bike Lane coverage along route",title="Most used bikeshare routes \nare missing bike lanes", subtitle="Source: Analysis of Capital Bikeshare ridership data")





Join
multiple strings into a single string.
str_c(letters, LETTERS) 

Steps:
  Concatenate start and end
group by that concatenated column and count
Sort
Select the top 10. 
Also calculate an average as a baseline. 

And then subset by times of day. most popular combos change at different times of day? SEAN  

## Question 5: Distribution of number of trips for individual bikes? GINA

## Question 5: Are the bikeshare stations located in areas that easily connect with the city’s public transportation system, and how heavily are those used? (Audience: Capital Bikeshare and Washington, D.C. transportation planners). ROBERTO

A.  Group by station and count. 
B.  Calculate the average number of originating trips at metro station stations and non metro station stations. 

