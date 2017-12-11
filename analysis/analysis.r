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
  geom_bar(stat="identity" , fill = "#ff6666") +
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

## Question 5: Which stations are the most and least used start stations?
                     
## Answer 5: StartStationUsage.png is a map of the most used start stations and least used start stations. The visualization shows that the top 20 start stations are clustered within the Washington D.C. boundary. The majority of the bottom 20 start stations are located outside D.C., in Northern Virginia and Maryland suburbs. 


#Get the top 20 start stations, identifed by start station number and arrange in descending order.
# Show columns: start_station_no, start_lat, start_lon, count
  top20startstationsno <- allbike %>%
    group_by(start_station_no,start_lat,start_lon) %>%
    summarise(count= n()) %>%
    arrange(desc(count)) %>%
    head(20)
  View(top20startstationsno)

 # Show columns: start_station_no, start_lat, start_lon and write csv ; drop the count column from top20startstationsno.
  top20startstationsnolist <- top20startstationsno %>%
    select(start_station_no,start_lat,start_lon)
  View(top20startstationsnolist)
# Write a CSV of the data
  write_csv(top20startstationsnolist, "data/stations/top20startstationsnolist.csv")
 
  #Get the bottom 20 start stations, identifed by start station number and arrange in descending order.
  # Show columns: start_station_no, start_lat, start_lon, count ; drop the count column from bottom20startstationno.
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
# Write a CSV of the data
  write.csv(bottom20startstationnolist, "data/stations/bottom20startstationnolist.csv")

## Outside of RStudio...                     
# 1. In a web browser, go to https://www.google.com/maps/about/mymaps/.
# 2. Click Get Started
# 3. If you are not already logged into Google, the website will ask you to log in.
# 4. If you already have a Google account, go ahead and log in.
# 5. If you do not already have a Google account, create one and log in.
# 6. Click the button for 'Create a New Map'.
# 7. Click on the words, 'Untitled Map', to give the map a title.
# 8. In the pop-up window, enter 'Start Station Usage' in the 'map title' entry field.
#9. In the pop-up window, enter 'Markers for the top and bottom 20 start stations in terms of usage' in the 'Description' entry field.
# 10. Click 'Save' in the pop-up window.
# 11. Import top20startstationsnolist.csv by clicking on the 'Import' link under 'Untitled Layer' in the map legend.
# 12. In the 'choose a file to import' pop-up window, click 'Select a file from your computer'.
# 13. Navigate to top20startstationsnolist.csv in your file structure and select it, then click 'Select' in the pop-up window.
# 14. In the 'Choose columns to position your placemarks' pop-up window, check the checkbox next to start_lat and then select the radio button next to latitude.
# 15. In the 'Choose columns to position your placemarks' pop-up window, check the checkbox next to start_lon and then select the radio button next to longitude.
# 16. In the 'Choose columns to position your placemarks' pop-up window, click 'Continue'.
# 17. In the 'Choose a column to title your markers' pop-up window, select the radio button next to start_station_no. 
# 18. In the 'Choose a column to title your markers' pop-up window, click 'Finish'.
# 19. In the map legend, click 'Add Layer'.
# 20. Repeat steps 11-18 for bottom20startstationnolist.csv.
# 21. In the map legend click the words 'top20startstationsnolist.csv'.
# 22. In the pop-up window, change the layer name to 'Top 20 Start Stations'.
# 23. In the map legend click the words 'bottom20startstationnolist.csv'.
# 24. In the pop-up window, change the layer name to 'Bottom 20 Start Stations'.
# 25. To change the markers for the 'Bottom' stations layer, hover your mouse over 'All Items' under 'Bottom 20 Start Stations' until you see a paint bucket icon to the right of 'All Items'.
# 26. Click the paint bucket icon.
# 27. Choose the red color with RGB (230,81,0) by clicking on the color square.
# 28. Click anywhere on the map to close the legend pop-up box.
# 29. Get the sharable link to the map by clicking the Share link on the legend.                  

## Question 6: What hours of the day and days of the week are rides concentrated in? Is there any difference between registered and casual users?
  
## Answer 5: Rush hour in the morning and afternoon are by far the most popular times of day for travel.  This is especially true for registered users.  For casual users, weekend days are far more popular. 

# Create a column in for day of week, and hour of day after creating a version.

cal <- allbike  

cal$day_start <- wday(cal$start_date, label=TRUE)
cal$hour_start <-hour(cal$start_date)  

# Do an group by and count by day of week and hour of day, to get one value per hour per day. 
day_hour <- cal %>%
  na.omit() %>%
  group_by(day_start,hour_start) %>%
  summarise(count= n()) %>%
  arrange(day_start,hour_start)

# Take off scientific notation, so legend on graph looks right.
options(scipen=999)

# Generate a heatmap with one square per hour per day of week, shaded according to number of rides in that block.
ggplot(day_hour, aes(day_start, hour_start)) +
  geom_tile(aes(fill = count), color = "white") +
  scale_fill_gradient(low = "green", high = "red") +
  ylab("Hour of Day") +
  xlab("Day of Week") +
  theme(legend.title = element_text(size = 10),
        legend.text = element_text(size = 12),
        plot.title = element_text(size=16),
        axis.title=element_text(size=14,face="bold"),
        axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(fill = "Number of Rides", title="For all riders, rush hour is busiest time")

# We see several intersting things here.  Rush hour is by far the busiest time for Capital Bikeshare, with the morning rush hour -- especially the 8 a.m. block and the 5 p.m. and 6 p.m. blocks as the busiest.  On weekends, we see much more activity during the middle of the day. 

# Now let's look at how this differs for casual riders vs. registered users. 

# For registered users, do a group by and count by day of week and hour of day, to get one value per hour per day. 

registered_day_hour <- cal %>%
  filter(member_type == "Registered") %>%
  na.omit() %>%
  group_by(day_start,hour_start) %>%
  summarise(count= n()) %>%
  arrange(day_start,hour_start)

# For registered users, generate a heatmap with one square per hour per day of week, shaded according to number of rides in that block.

ggplot(registered_day_hour, aes(day_start, hour_start)) +
  geom_tile(aes(fill = count), color = "white") +
  scale_fill_gradient(low = "green", high = "red") +
  ylab("Hour of Day") +
  xlab("Day of Week") +
  theme(legend.title = element_text(size = 10),
        legend.text = element_text(size = 12),
        plot.title = element_text(size=16),
        axis.title=element_text(size=14,face="bold"),
        axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(fill = "Number of Rides", title="For registered users, rush hour dominates")

# For casual users, do a group by and count by day of week and hour of day, to get one value per hour per day. 

casual_day_hour <- cal %>%
  filter(member_type == "Casual") %>%
  na.omit() %>%
  group_by(day_start,hour_start) %>%
  summarise(count= n()) %>%
  arrange(day_start,hour_start)

# For casual users, generate a heatmap with one square per hour per day of week, shaded according to number of rides in that block.

ggplot(casual_day_hour, aes(day_start, hour_start)) +
  geom_tile(aes(fill = count), color = "white") +
  scale_fill_gradient(low = "green", high = "red") +
  ylab("Hour of Day") +
  xlab("Day of Week") +
  theme(legend.title = element_text(size = 10),
        legend.text = element_text(size = 12),
        plot.title = element_text(size=16),
        axis.title=element_text(size=14,face="bold"),
        axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(fill = "Number of Rides", title="Weekends dominate for casual users")

# An interesting comparison.  For registered users, much more activity during rush hour during the week.  For casual users, much more activity on weekends, with some bleed over to Mondays and Fridays, suggesting long weekends may have some impact. 

## Question 7: How do different types of users -- registered vs. casual -- differ in usage by season? This builds off of question 1. 
## Answer 7: The distribution of rides in each season is much more even for registered users than it is for casual users.  A much higher percentage of rides by casual users come in the summer and spring.  For registered users, rides are move evenly distributed between fall, summer and spring. 

##First, filter out the Single Quarters of year 2010 and 2017 i.e. Q42010 and Q12017, so we are only analyzing full years. 
seasons <-allbike %>% 
  select(quarter, member_type) %>%
  filter(quarter != "Q42010" & quarter !="Q12017")

##Then, separate quarter column into quarter_period and year. e.g. value Q42015 --> Q4 and 2015
Qgroups <- seasons %>%
  separate(quarter, into = c("quarter_period", "year"), sep = 2)

## Group by quarter_period and count the number of records in each quarter after filtering for only registered users, the calculate percentage. 
PopularQ_reg <- Qgroups %>%
  filter(member_type == "Registered") %>%
  group_by(quarter_period) %>%
  summarise(trips= n()) %>%
  mutate(percent= (trips/sum(trips))*100) %>%
  arrange(quarter_period)

## In preparation to plot, rename quarters with season names.  Note: the seasons don't map perfectly to quarters.  For example, in reality, Winter is Dec. 21 to Mar. 21.  The quarter runs Jan. 1 to Mar. 30. But we'll make that clear in subtitle. 

PopularQ_reg$quarter_period[PopularQ_reg$quarter_period =="Q1"] <- "Winter (Q1)"
PopularQ_reg$quarter_period[PopularQ_reg$quarter_period =="Q2"] <- "Spring (Q2)"
PopularQ_reg$quarter_period[PopularQ_reg$quarter_period =="Q3"] <- "Summer (Q3)"
PopularQ_reg$quarter_period[PopularQ_reg$quarter_period =="Q4"] <- "Fall (Q4)"

## Create a bar plot showing the count of trips by season. 

ggplot(data=PopularQ_reg ,aes(quarter_period, percent)) +
  geom_bar(stat="identity" , fill = "#FF6666") + 
  ggtitle("") +
  labs(y="Percentage of total trips", x ="Seasons",title="For registered users, more even distribution", subtitle="Source: Analysis of Capital Bikeshare ridership data") 

## Now see how casual users compare

## Group by quarter_period and count the number of records in each quarter after filtering for only casual users, the calculate percentage. 
PopularQ_casual <- Qgroups %>%
  filter(member_type == "Casual") %>%
  group_by(quarter_period) %>%
  summarise(trips= n()) %>%
  mutate(percent= (trips/sum(trips))*100) %>%
  arrange(quarter_period)

## In preparation to plot, rename quarters with season names.  Note: the seasons don't map perfectly to quarters.  For example, in reality, Winter is Dec. 21 to Mar. 21.  The quarter runs Jan. 1 to Mar. 30. But we'll make that clear in subtitle. 

PopularQ_casual$quarter_period[PopularQ_casual$quarter_period =="Q1"] <- "Winter (Q1)"
PopularQ_casual$quarter_period[PopularQ_casual$quarter_period =="Q2"] <- "Spring (Q2)"
PopularQ_casual$quarter_period[PopularQ_casual$quarter_period =="Q3"] <- "Summer (Q3)"
PopularQ_casual$quarter_period[PopularQ_casual$quarter_period =="Q4"] <- "Fall (Q4)"

## Create a bar plot showing the count of trips by season. 

ggplot(data=PopularQ_casual ,aes(quarter_period, percent)) +
  geom_bar(stat="identity" , fill = "#FF6666") + 
  ggtitle("") +
  labs(y="Percentage of total trips", x ="Seasons",title="For casual users, less even distribution", subtitle="Source: Analysis of Capital Bikeshare ridership data") 

# Question 8: How has the distribution of ridership by season changed over the years?

# Answer 8: Though there have been minor changes in distribution by season each year from 2011 to 2016, the distribution has largely stayed the same. 

year2011 <- subset(Qgroups, year == '2011', 
                   select=c(quarter_period, year))

year2012 <- subset(Qgroups, year == '2012', 
                   select=c(quarter_period, year))

year2013 <- subset(Qgroups, year == '2013', 
                   select=c(quarter_period, year))

year2014 <- subset(Qgroups, year == '2014', 
                   select=c(quarter_period, year))

year2015 <- subset(Qgroups, year == '2015', 
                   select=c(quarter_period, year))

year2016 <- subset(Qgroups, year == '2016', 
                   select=c(quarter_period, year))


### Group by quarter

Popular2011 <- year2011 %>%
  group_by(quarter_period) %>%
  summarise(trips= n()) %>%
  arrange(quarter_period)


Popular2012 <- year2012 %>%
  group_by(quarter_period) %>%
  summarise(trips= n()) %>%
  arrange(quarter_period)


Popular2013 <- year2013 %>%
  group_by(quarter_period) %>%
  summarise(trips= n()) %>%
  arrange(quarter_period)

Popular2014 <- year2014 %>%
  group_by(quarter_period) %>%
  summarise(trips= n()) %>%
  arrange(quarter_period)


Popular2015 <- year2015 %>%
  group_by(quarter_period) %>%
  summarise(trips= n()) %>%
  arrange(quarter_period)

Popular2016 <- year2016 %>%
  group_by(quarter_period) %>%
  summarise(trips= n()) %>%
  arrange(quarter_period)


### Plots for year individually from year 2011 to 2016

## 2011

### plot preparation. 

Popular2011$quarter_period[Popular2011$quarter_period =="Q1"] <- "Winter (Q1)"
Popular2011$quarter_period[Popular2011$quarter_period =="Q2"] <- "Spring (Q2)"
Popular2011$quarter_period[Popular2011$quarter_period =="Q3"] <- "Summer (Q3)"
Popular2011$quarter_period[Popular2011$quarter_period =="Q4"] <- "Fall (Q4)"

## Create a bar plot showing the count of trips by season. 

ggplot(data=Popular2011 ,aes(quarter_period, trips/1000000)) +
  geom_bar(stat="identity" , fill = "#FF6666") + 
  ggtitle("") +
  labs(y="Number of Rides (in Millions)", x ="Seasons",title="Bikeshare ridership during year 2011", subtitle="Source: Analysis of Capital Bikeshare ridership data") 

## 2012

### plot preparation. 

Popular2012$quarter_period[Popular2012$quarter_period =="Q1"] <- "Winter (Q1)"
Popular2012$quarter_period[Popular2012$quarter_period =="Q2"] <- "Spring (Q2)"
Popular2012$quarter_period[Popular2012$quarter_period =="Q3"] <- "Summer (Q3)"
Popular2012$quarter_period[Popular2012$quarter_period =="Q4"] <- "Fall (Q4)"

## Create a bar plot showing the count of trips by season. 

ggplot(data=Popular2012 ,aes(quarter_period, trips/1000000)) +
  geom_bar(stat="identity" , fill = "#FF6666") + 
  ggtitle("") +
  labs(y="Number of Rides (in Millions)", x ="Seasons",title="Bikeshare ridership during year 2012", subtitle="Source: Analysis of Capital Bikeshare ridership data") 


## 2013

### plot preparation. 

Popular2013$quarter_period[Popular2013$quarter_period =="Q1"] <- "Winter (Q1)"
Popular2013$quarter_period[Popular2013$quarter_period =="Q2"] <- "Spring (Q2)"
Popular2013$quarter_period[Popular2013$quarter_period =="Q3"] <- "Summer (Q3)"
Popular2013$quarter_period[Popular2013$quarter_period =="Q4"] <- "Fall (Q4)"

## Create a bar plot showing the count of trips by season. 

ggplot(data=Popular2013 ,aes(quarter_period, trips/1000000)) +
  geom_bar(stat="identity" , fill = "#FF6666") + 
  ggtitle("") +
  labs(y="Number of Rides (in Millions)", x ="Seasons",title="Bikeshare ridership during year 2013", subtitle="Source: Analysis of Capital Bikeshare ridership data") 


## 2014

### plot preparation. 

Popular2014$quarter_period[Popular2014$quarter_period =="Q1"] <- "Winter (Q1)"
Popular2014$quarter_period[Popular2014$quarter_period =="Q2"] <- "Spring (Q2)"
Popular2014$quarter_period[Popular2014$quarter_period =="Q3"] <- "Summer (Q3)"
Popular2014$quarter_period[Popular2014$quarter_period =="Q4"] <- "Fall (Q4)"

## Create a bar plot showing the count of trips by season. 

ggplot(data=Popular2014 ,aes(quarter_period, trips/1000000)) +
  geom_bar(stat="identity" , fill = "#FF6666") + 
  ggtitle("") +
  labs(y="Number of Rides (in Millions)", x ="Seasons",title="Bikeshare ridership during year 2014", subtitle="Source: Analysis of Capital Bikeshare ridership data") 


## 2015

### plot preparation. 

Popular2015$quarter_period[Popular2015$quarter_period =="Q1"] <- "Winter (Q1)"
Popular2015$quarter_period[Popular2015$quarter_period =="Q2"] <- "Spring (Q2)"
Popular2015$quarter_period[Popular2015$quarter_period =="Q3"] <- "Summer (Q3)"
Popular2015$quarter_period[Popular2015$quarter_period =="Q4"] <- "Fall (Q4)"

## Create a bar plot showing the count of trips by season. 

ggplot(data=Popular2015 ,aes(quarter_period, trips/1000000)) +
  geom_bar(stat="identity" , fill = "#FF6666") + 
  ggtitle("") +
  labs(y="Number of Rides (in Millions)", x ="Seasons",title="Bikeshare ridership during year 2015", subtitle="Source: Analysis of Capital Bikeshare ridership data") 


## 2016

### plot preparation. 

Popular2016$quarter_period[Popular2016$quarter_period =="Q1"] <- "Winter (Q1)"
Popular2016$quarter_period[Popular2016$quarter_period =="Q2"] <- "Spring (Q2)"
Popular2016$quarter_period[Popular2016$quarter_period =="Q3"] <- "Summer (Q3)"
Popular2016$quarter_period[Popular2016$quarter_period =="Q4"] <- "Fall (Q4)"

## Create a bar plot showing the count of trips by season. 

ggplot(data=Popular2016 ,aes(quarter_period, trips/1000000)) +
  geom_bar(stat="identity" , fill = "#FF6666") + 
  ggtitle("") +
  labs(y="Number of Rides (in Millions)", x ="Seasons",title="Bikeshare ridership during year 2016", subtitle="Source: Analysis of Capital Bikeshare ridership data") 

## Question 9: Gina
# Create data frame
station_typex <- allbike %>%
  group_by(start_station) %>%
  summarise(total= n(),
            registered = sum(member_type == "Registered"),
            casual = sum(member_type == "Casual")
            ) %>%
  mutate(percent_reg = (registered/total)*100) %>%
  mutate(percent_cas = (casual/total)*100) %>%
  mutate(log_total = (log(total))) %>%
  filter(total > 100000)

# First plot
ggplot(station_typex, aes(x=percent_reg, y=percent_cas, size=total)) +
  geom_point() 

# Second plot
ggplot(station_typex, aes(x=percent_reg, y=total)) +
  geom_point() 
