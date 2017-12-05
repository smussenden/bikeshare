# Bikeshare Analysis Project
##### Data Preparation & Documentation
##### Team MusGonRubVis
##### Oct. 29, 2017
##### INFM600
##### Word Count: 895

#### DATA SOURCE INFORMATION

**Data Citation**
Capital Bikeshare (2017). Trip History Data [Data files, documentation]. Retrieved from [https://s3.amazonaws.com/capitalbikeshare-data/index.html](https://s3.amazonaws.com/capitalbikeshare-data/index.html). Date accessed Sept. 19, 2017.  

**Description**
Capital Bikeshare, a bike rental service in the Washington, D.C. metro area, maintains more than 400 stations where customers can pick up and return rented bicycles. The company records -- and publishes -- an abundance of real-time and historical data about bike availability, station location and individual customer trip history. The trip history data we selected for analysis was published in quarterly datasets (Q4 2010 to Q1 2017), with one row per customer trip. The columns provide information on trip duration, start date and time, end date and time, start station location, end station location, bike number and membership type.

#### LICENSING

Capital Bikeshare, operated by Motivate International Inc. on behalf of regional governments it calls "the member organizations," makes the system data available for public use under a "non-exclusive, royalty-free, limited, perpetual license to access, reproduce, analyze, copy, modify, distribute in your product or service and use the Data for any lawful purpose," subject to conditions detailed in the [data license agreement](https://www.capitalbikeshare.com/data-license-agreement).  

Among other stipulations, the license prohibits us from doing any of the following:
* "Use the Data in any unlawful manner or for any unlawful purpose;
* Host, stream, publish, distribute, sublicense, or sell the Data as a stand-alone dataset; provided, however, you may include the Data as source material, as applicable, in analyses, reports, or studies published or distributed for non-commercial purposes;
* Access the Data by means other than the interface Motivate provides or authorizes for that purpose;
* Circumvent any access restrictions relating to the Data;
* Use data mining or other extraction methods in connection with Motivate's website or the Data;
* Attempt to correlate the Data with names, addresses, or other information of customers or Members of Motivate; and
* State or imply that you are affiliated, approved, endorsed, or sponsored by Motivate.
* Use or authorize others to use, without the written permission of the applicable owners, the trademarks or trade names of Motivate International Inc., the Member Jurisdictions or any sponsor of the Capital Bikeshare service. These marks include, but are not limited to Capital Bikeshare, and the Capital Bikeshare logo."

#### METADATA

We will use a detailed metadata description provided by Capital Bikeshare to interpret the values given for each individual trip in the data set:
* Duration – Total trip time. Given in hours, minutes and seconds in some quarters, in milliseconds in other quarters.
* Start Date – Trip start date and time. Given as year, month, day, hour and minute.
* End Date – Trip end date and time. Given as year, month, day, hour and minute.
* Start Station and Start Station Number – Location and unique identification number for the bike station where the trip started.
* End Station and End Station Number – Location and unique identification number for the bike station where the trip ended.
* Bike Number – Identification number of the bike used for the trip.
* Member Type – Indicates whether a user was a "registered" member (with an annual membership, a 30-day membership or a "day key" membership) or a "casual" rider (paying for a single trip, or using a 24-hour, three day or five day pass).

#### DATA QUALITY ISSUES

We encountered the following data quality issues:

* For the Member Type column, there was a discrepancy between the column name used in different quarters. Some data sets used alternative names for the Member Type column, including Account Type, Subscription Type, and Subscriber Type.
* The Start Station Number and End Station Number columns first appeared in 2015. In previous years, the unique identification numbers were bundled together with the Start Station and End Station columns.
* When we imported the datasets into R Studio, the values for the Duration, Start Date, and End Date columns were imported as strings and had to be converted to a valid datetime format.

#### DATA REMEDIATION

The data was stored in CSV files, one for each quarter, beginning with Q4 2010 and ending with Q12017. We used RStudio to remediate the data.

We examined the column names used in each file to check for consistency, discovering three different column names associated with membership type: Subscriber Type, Subscription Type and Member Type. To standardize the data, we renamed the column in each file as member_type, because the Capital Bikeshare metadata used Member Type.

We examined unique values for each column in each file.  In the column membership type column, we noticed that several files used the term Subscriber to refer to Registered users, a term used in the remaining files. We decided to replace Subscriber with Registered in order to standardize the column values and prevent errors in future analysis.

Because we planned to combine the data into a single data file, a column named “quarter” was added to each file. This will allow us to analyze trends by quarter.

By default, RStudio imported the Duration, Start Date and End Date columns as strings. We converted them into valid datetime and time series formats to make analysis possible.

#### DATA CLEANING PROCESS

For a step-by-step look at our data cleaning steps, please see the following files R script files:
* [2010Q4-2012Q2.r](../import-clean/2010Q4-2012Q2.r)
* [2012Q3-2014Q1.r](../import-clean/2012Q3-2014Q1.R)
* [2014Q2-2015Q4.r](../import-clean/2014Q2-2015Q4.R)
* [2016Q1-2017Q1.r](../import-clean/2016Q1-2017Q1.R)
