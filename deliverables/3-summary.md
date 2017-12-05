## INFM 600 Final Project Summary

#### Introduction
As consultants brought in by Capital Bikeshare to make data-driven business improvement recommendations, we analyzed six years of ridership data provided by the company. 

We focused our analysis on: 

* How Capital Bikeshare could improve their ridership during all seasons of the year. 
* How casual riders differ in their use of Capital Bikeshare compared to registered users.  
* How the city’s network of bike lanes compares to the most popular user routes.
* How the city’s public transportation system is related to ridership. 
* How usage of Capital Bikeshare differs in Washington and the surrounding suburbs.

#### Data source and processing:

Capital Bikeshare provided quarterly ridership data from Q42010 to Q12017.  We reviewed metadata provided by the company to better understand the data.   Each observation represented one trip taken during that period.  It included information on trip start and end stations, start and end time, duration and membership type. 
 
We spent most of the time cleaning and standardizing the data.  In merging datasets into one file, we renamed fields and standardized variable names.  We also merged the data with a separate file containing station geocoordinates. 

We used R studio to clean and analyze the data, using packages like Tidyverse, lubridate, and ggplot. We also used the Google Maps API (and associated tools) to analyze and visualize our findings.

#### Findings

We asked several questions during our analysis.  For example:

#### _How do ridership patterns vary by season?_ 

![Ridership patters by seasons](5-findings/plots/season_trips_plot.png?raw=true "Seasonal Ridership")

#### Interpretation

Between 2011 and 2016, ridership was substantially higher in the Summer (4.99 million rides) and Spring (4.53 million rides) than in the Fall (3.51 million rides) and Winter (2.30 million rides).  More tourists visit Washington in the summer.  And it's unpleasant to ride in extreme cold. Clearly, the weather significantly affects the ridership patterns.

#### Argument for decision based on our finding

We think Capital Bikeshare can increase ridership in Fall and Spring by executing the following ideas:
Ad campaigns aimed at promoting the benefits of riding, mentioning seasonal events like the Cherry Blossom Festival. 
Reduced membership fees for people signing up during Fall and Spring seasons. 
Targeted marketing efforts at commuters, who have more incentive to ride in all seasons. 

#### Additional findings and recommendations

We also found:

Casual users take more trips exceeding 30 minutes then registered users, taking bikes out of circulation for loyal customers. 
Bikeshare has an important symbiosis with Metro, as almost half of the top 20 most used Bikeshare stations are within a half mile of a Metro station. 
Along the routes taken by Capital Bikeshare users between the most common combinations of start and end stations, almost all have incomplete bike lane coverage. 
Bikeshare stations in Washington, D.C., are significantly more popular than stations in the suburbs. 
