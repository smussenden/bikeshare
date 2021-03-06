## Finding 4

#### _Question_: Are there dedicated bike lanes in the city along the most popular routes taken by people riding Capital Bikeshare bikes?  

![Popular routes](plots/common-trips.png?raw=true "Bike Paths")

![Popular routes](plots/easternmarket-lincolnpark.png?raw=true "Google Map with Bike Paths")

_Answer_: To determine stations that people are riding between frequently, we selected all combinations of start station and end stations with more than 15,000 trips in our data, a total of 17. Using the Google Maps APIs routing tool, we looked at the most efficient bike route along each of those routes, and determined whether there were dedicated bike lanes along those routes. Of the 17, only four had bike lanes along the entire route. The other 13 had partial coverage.  
