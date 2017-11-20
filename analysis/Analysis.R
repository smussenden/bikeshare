#### This file is for analysis of bikeshare data.  Running the cleaning script, all-quarters.r will produce a dataframe called `allbike`. Use allbike to run these scripts against. 

#### If you've already run the cleaning script and have exported a csv, and don't want to run the script again, you can read it in directly here.  


#### Load required libraries. Note: loading tidverse also loads ggplot2.
library('tidyverse')
library('lubridate')
library('scales')
library('stringr')

##Question 1: How do ridership patterns vary by season? 

##Answer 1: Between 2011 and 2016, ridership was substantially higher in the Summer (4.99 million rides) and Spring (4.53 million rides) than in the Fall (3.51 million rides) and Winter (2.30 million rides). This makes sense. More tourists visit Washington in the summer.  And it's especially unpleasant to ride a bike in extreme cold. See the code below we used to answer this question, and a plot that highlights our conclusion. 

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
  labs(y="Number of Rides (in Millions)", x ="Seasons",title="Bikeshare ridership highest in Summer", subtitle="Source: Analysis of Capital Bikeshare ridership data") + 
  scale_y_continuous(labels = comma)

##Question 2: There are two main types of riders who use the Capital Bikeshare system: registered members who buy monthly or annual memberships and casual users who buy single-trip, single-day or week-long passes.  How does the ridership behavior of these two groups differ?  Specificially, what percentage of registered members take trips under 30 minutes, avoiding paying a penalty for taking a longer ride?  And how does that compare to the percentage for casual members?

##Answer 2: Registered users are more likely to take a sub-30 minute trip than casual users. We found that 92.8 percent of trips by registered users were for less than 30 minutes, compared to 59.8 percent of casual users.  See the code below we used to answer this question, and a plot that highlights our conclusion. 

# Group by member type and count the number of trips by type.
all_trips <- allbike %>%
  group_by(member_type) %>%
  summarise(total_trips= n()) 
View(mem_type)

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

##Question 3: Can we uncover the "secret lives" of individual bikes, by measuring how a single bike moves across the city every day for a single year? By answering this question, it can help to develop future activities for community members who use the Bikeshare program such as group membership discounts and coupons for restaurants near the most popular stations.

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

