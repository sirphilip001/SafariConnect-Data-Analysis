# SafariConnect Data Analysis Project

## Project Overview

*SafariConnect* is a transportation business analytics project focused on analyzing booking, passenger, route, driver, revenue, and operational data.

The goal of the project was to clean and transform a messy transportation dataset using *SQL* and *PostgreSQL*, then use *Power BI* to create an interactive dashboard that helps management understand business performance and make data-driven decisions.

The analysis focuses on six main business areas:

•	Route performance

•	Driver performance

•	Revenue trends

•	Passenger insights

•	Booking cancellations

•	Operational patterns

\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

### Business Questions

The analysis was designed to answer the following questions:

### 1\. Route Analysis

•	Which routes generate the most revenue?

•	Which routes are the most popular?

•	Which routes are most efficient per seat sold?

### 2\. Driver Performance

•	Which drivers generate the most revenue?

•	Does driver rating relate to passenger satisfaction?

•	Which drivers may require further performance review?

### 3\. Revenue Trends

•	How does revenue change month by month?

•	Which months perform best and worst?

•	Is revenue generally increasing or declining?

### 4\. Passenger Insights

•	Where do passengers come from?

•	Which seat classes are preferred?

•	What does passenger satisfaction look like?

### 5\. Cancellations

•	What is the cancellation rate by route?

•	How much revenue is lost through cancellations?

•	Which routes have the highest cancellation rates?

### 6\. Operational Patterns

•	What are the busiest days?

•	What are the busiest departure times?

•	When should additional vehicles or drivers be allocated?

\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

## Dataset

The project uses a transportation booking dataset containing information about passengers, routes, vehicles, drivers, bookings, payments, and customer ratings.

## Data Privacy

The original dataset is not included in this repository because it contains personally identifiable information (PII), including passenger names and phone numbers.

The repository therefore focuses on demonstrating the analytical workflow through:

•	SQL data cleaning and transformation

•	PostgreSQL database analysis

•	Power BI dashboard development

•	Data visualizations

•	Business insights

•	Recommendations

The SQL cleaning script used for the project is available in:
`
sql/SafariConnect\_cleaning.sql
`
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_


The dataset contains transportation booking information including:

| Column|	Description|
|-----------|------------|
|booking\_id	| Unique booking reference|
|passenger\_name |	Passenger name|
|passenger\_phone	|Passenger phone number|
|passenger\_gender|	Passenger gender|
|passenger\_city	|Passenger home city|
|route\_code|	Route identifier|
|route\_from|	Departure city|
|route\_to|	Destination city|
|vehicle\_plate|	Vehicle registration|
|vehicle\_type|	Type of vehicle|
|driver\_name|	Driver name|
|driver\_rating|	Driver platform rating|
|departure\_date	|Date of travel|
|departure\_time|	Scheduled departure time|
|seat\_class|	Seat class booked|
|seats\_booked	|Number of seats booked|
|fare\_per\_seat|	Fare per seat in KES|
|total\_fare|	Total booking amount|
|payment\_method	|Passenger payment method|
|booking\_status|	Booking outcome|
|trip\_rating	|Passenger satisfaction rating|

\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

## Data Cleaning with SQL

The original dataset contained several data quality issues that needed to be resolved before analysis.

The cleaning process was performed using PostgreSQL and SQL in DBeaver.

## Data quality issues identified

•	Inconsistent uppercase and lowercase passenger names

•	Extra whitespace in names

•	Inconsistent phone number formats

•	Missing phone numbers

•	Multiple date formats

•	Inconsistent city capitalization

•	Inconsistent gender values

•	Inconsistent payment method casing

•	Inconsistent booking status casing

•	Currency values stored as text

•	Inconsistent seat class values and abbreviations

•	Uppercase driver names

•	Invalid trip ratings

•	Negative seat quantities

•	Duplicate booking IDs

## Cleaning actions

The SQL cleaning process standardized the dataset by:

•	Formatting names consistently

•	Removing unnecessary whitespace

•	Standardizing phone number formats

•	Handling missing values

•	Converting dates into consistent formats

•	Standardizing city names

•	Standardizing gender categories

•	Standardizing payment methods

•	Standardizing booking statuses

•	Converting monetary fields from text to numeric values

•	Standardizing seat class categories

•	Validating trip ratings

•	Removing invalid negative seat quantities

•	Identifying and handling duplicate booking IDs

The complete SQL cleaning script is available in:
`
sql/SafariConnect\_cleaning.sql
`
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

## Tools \& Technologies

•	PostgreSQL — Database and data processing

•	DBeaver — SQL development and database management

•	SQL — Data cleaning and transformation

•	Power BI — Data visualization and dashboard development

•	Git \& GitHub — Project version control and portfolio documentation

\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

## Data Analysis \& Dashboard

After cleaning the data in PostgreSQL, the database was connected to Power BI.

The Power BI dashboard was used to analyze:

•	Revenue performance

•	Route performance

•	Driver performance

•	Passenger demographics

•	Booking status

•	Cancellation rates

•	Departure patterns

•	Vehicle performance

•	Customer satisfaction 

\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_
# Dashboard Preview

## Recommendations \& Insights


### Key Insights

### Revenue Trends

•	October recorded the highest revenue at KES 23,680, with 28 bookings and 24 completed bookings.

•	August recorded the lowest revenue at KES 13,400, with 18 bookings and 15 completed bookings.

•	April and August recorded relatively lower revenue, potentially indicating periods of lower customer demand.

### Operational Patterns

•	The busiest departure period was between 7:00 AM and 9:00 AM.

•	This morning peak generated the highest realized revenue, averaging approximately KES 20,000.

•	Monday to Thursday were the busiest days and generated the highest revenue.

### Route Performance

•	RT001 (Nairobi–Mombasa) generated the highest revenue at KES 51,600.

•	The route generated approximately KES 1,258.54 per seat.

•	RT001 had a 13.33% cancellation rate, representing approximately KES 10,800 in cancelled revenue.

### Payment Methods

•	Cash bookings had the highest cancellation rate at 12%.

•	Card payments generated the lowest revenue at KES 42,009.

### Passenger \& City Insights

•	Nairobi was the core customer market, with 113 completed bookings generating KES 112,000.

•	Nakuru generated the lowest revenue at KES 6,300.

•	Nyeri and Machakos recorded the lowest passenger volumes, with 12 passengers each.

### Driver Performance

•	Isaac Korir generated the highest driver revenue at KES 33,000.

•	Peter Ngugi generated the lowest at KES 23,900.

•	Driver performance should not be evaluated using revenue alone. Revenue, trip volume, and customer satisfaction should be considered together.

•	Isaac Korir's case demonstrates why revenue alone may not fully represent customer experience.

### Vehicle Performance

•	Matatus generated KES 87,930, representing 38.44% of total revenue.

•	Buses generated KES 85,460, representing 37.36%.

•	Minibuses generated KES 55,330, representing 24.19%.

\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

## Business Recommendations

 Based on the analysis, several actions could improve SafariConnect's operations.

#### 1. Increase capacity during peak periods

Additional vehicles and drivers should be considered between 7:00 AM and 9:00 AM, particularly from Monday to Thursday when demand is highest.

#### 2. Monitor route cancellations

A cancellation monitoring system could flag routes whose cancellation rates exceed an agreed threshold.

This would allow management to identify problem routes early and monitor lost revenue.

#### 3. Review cancellation policies

Because cash bookings showed the highest cancellation rate, SafariConnect could investigate the causes and consider measures such as:

•	A non-refundable portion of the booking

•	A cancellation fee

•	Allowing customers to reschedule instead of cancelling

A potential 20% cancellation fee could be evaluated as one possible policy.

#### 4. Optimize vehicle allocation

Vehicles currently operating on lower-demand routes could potentially be reassigned to busier routes and periods.

Particular attention should be given to Monday–Thursday, when demand is highest.

#### 5. Improve driver performance measurement

Driver performance should combine:

•	Revenue

•	Number of trips

•	Customer satisfaction

•	Driver rating

This provides a more complete view of driver performance than revenue alone.

#### 6. Strengthen the Nairobi market

Nairobi is the strongest customer market and could receive additional marketing investment to strengthen customer acquisition and retention.

\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_
```
Project Structure

SafariConnect-Data-Analysis/

│

├── README.md

│

├── sql/

│   └── SafariConnect\_cleaning.sql

│

├── powerbi/

│   └── SafariConnect\_Dashboard.pbix

│

└── screenshots/

   ├── dashboard\_overview.png

   └── recommendations\_insights.png

```





\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

## Project Workflow

Raw Dataset

&#x20;    ↓

Data Quality Assessment

&#x20;    ↓

SQL Data Cleaning

&#x20;    ↓

PostgreSQL Database

&#x20;    ↓

Power BI Connection

&#x20;    ↓

Data Analysis

&#x20;    ↓

Interactive Dashboard

&#x20;    ↓

Business Insights

&#x20;    ↓

Recommendations

\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

### Conclusion

This project demonstrates an end-to-end data analytics workflow, starting with a messy dataset and ending with a business intelligence dashboard.

The project combines SQL data cleaning, PostgreSQL, data analysis, Power BI visualization, and business interpretation to turn raw transportation data into actionable insights for management.





