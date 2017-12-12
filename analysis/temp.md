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
