# For Project File change branch to master.

# MSC Final Year Project
ANALYSIS OF USED CARS IN INDIA & FIND THE PERCENTAGE LOSS FOR SELLER AND PERCENTAGE PROFIT FOR PURCHASER.
ANALYSIS OF USED CARS 

India, the competition between used cars and new cars has reached its peak. All these used cars are generally termed as “Certified Used Cars”, as they are provided warranty and certified quality from the car dealers. Different car manufacturers have entered the pre-owned car business with different objectives, and they have different marketing strategies and priorities in entering into the pre-owned car business.

The objective of this study is to find the company wise and model wise total loss for seller (in percent) after selling the car and profit for the customer who brought the car (in percent). The objective is to analyze the current data available to the business and generate insights for future. 

The entire analysis was conducted with the help of dataset, weka tool and R studio. Dataset file in CSV format. The analysis is done with the data of 10 years (2010-1019) comprising of 5238  Cars consisting of total 22 brands like BMW,AUDI, MARUTI SUZUKI, HONDA  etc. and total 188 models. 

In this we analyze the data company wise and model wise and calculate the total percent of loss for seller and profit percent for purchaser. In this we compare the company and models basis on km driven, mileage, engine, power, fuel types and base on price. And analysis also based on location and year wise. 


# BACKGROUND AND LITERATURES REVIEW :-

Even as new car sales have slowed down in the recent past, the used cars market has continued to grow over the past year and is larger than the new car market now. 

The growth rate of new car sales has slowed owing to a variety of reasons, including cyclical slowdown in auto sale in election years and an overall consumption slowdown in the economy. New car sales grew 2.70% in 2018-19, the slowest growth rate for the industry in four years. In April, passenger vehicle sales saw a sharp decline compared with the same month last year, and domestic sales saw a contraction of 17.07%.

According to the report, 45% of the buyers want a car that is four to five years old. However, 46% of the sellers want to sell their vehicle when it is six to eight years old.

Data analytics can help the used cars system in many ways. Predictive analytics is the process of analyzing the data using automated statistical processes and summarizing results into useful information. The information acquired from the predictive analysis can be very useful to the customers who buy used cars.


# PROJECT INTRODUCTION AND SCOPE :-

Used Car's Business is a blooming sector in India, especially with Multiple Car companies having their own Used car showrooms. And its only gonna increase, given the current trend of Indian people moving towards cars!, especially Middle class families, which prefer an Used car instead of a new one.

So there is a strong need to analyze used car data, With the R tool for visualization it is easy to understand and interpret the results of dataset produced by applying various techniques on it. R performs wide variety of functions, such as data manipulation, statistical modeling in graphics.

With the help of predictive modeling technique like Linear Regression, it is easy and significantly efficient to understand the future car prices. Clustering helps to relate observations in the same group to be similar and observations in different groups to be dissimilar. 

With Aggregation methods, it is easy to understand the average of company and model wise mileage, engine, km driven, power and cars selling and purchase prices.   Using the same we can also understand the year wise average used car sales . Using the method, it is easy to interpret the total cars sales locations in india.

Also using analytical techniques, to get company wise and model wise percentage profit for purchaser and percentage loss for seller. This will also tells the average selling price company wise and model wise.


# SYSTEM DESIGN AND FLOW :-
	Dataset: The dataset used csv format.
	Dataset origin:- kaggle.com
	R Studio and R Language :-
	In this system the Software used is RStudio:-
	As R Studio  is a free and open-source integrated development 	environment (IDE) for R, a programming language for statistical 	computing and graphics
	In this System the Technology used is R :-
	R is an open-source language and environment for statistical 	computing and data visualization, supporting data manipulation 	and transformations, as well as sophisticated graphical displays.
	Packages Used:-
	ggplot2:-
ggplot2 is a plotting system for R, based on the grammar of graphics, which tries to take the good parts of base and lattice graphics and none of the bad parts. 

	Plotly:-
Plotly provides online graphing, analytics, and statistics tools for individuals and collaboration.

	Dplyr :-
Dplyr is the next iteration of plyr, focused on tools for working with data frames (hence the d in the name). 

	Shiny :-
Shiny is a new package from R Studio that makes it incredibly easy to build interactive web applications with R.

	Shiny dashboard :-
Create dashboards with Shiny. This package provides a theme on top of Shiny, making it easy to create attractive dashboards.

	RColorBrewer :- 
Provides color schemes for maps (and other graphics) designed by Cynthia Brewer as described at http://colorbrewer2.org.

	Wordcloud :-
Plot a cloud of words shared across documents.

	Tm :-
A framework for text mining applications within R.

	Gapminder :-
The main object in this package is the gapminder data frame or “tibble”. There are other goodies, such as the data in tab delimited form, a larger unfiltered dataset, premade color schemes for the countries and continents, and ISO 3166-1 country codes.

	Factoextra :-
factoextra is an R package making easy to extract and  visualize the output of exploratory multivariate data analyses.

# CONCLUSIONS :-

	Linear Regression :-
1.	Power vs Engine :-
Power and engine linearly dependent on each other.
The accuracy is 75%, Here gives the engine_cc value and it will
predict the value for power.
Engine=998 and predicted value is 65.07 for power (actual = 67.04). 
2.	Company price vs engine & power :-
Company price, engine & power linearly dependent on each other.
The accuracy is 77%, here gives the power & engine_cc value and it will predict the value for Company price.
Power_Bhp=67.04,Engine_Cc=998 and predicted value is 3.36L for Company price (actual=4L).
3.	Selling price vs Company price & km driven 
Selling price ,Company price & km driven linearly dependent on each other.
The accuracy is 85%, here gives the Company price & km driven value and it will predict the value for Selling price. Company_Price_L=4.2 , Kilometers_Driven = 50000 and predicted value is 2.94L for Selling price (actual=2.75 L).

	K-Means clustering :-
1.	I create K-Means clustering for company wise using 3 columns
(Mileage, Engine & Power) with fixed number of cluster size 4 .
2.	The accuracy for clustering varies company wise. 
3.	Accuracy in between (65 to 99), it’s depends on company.
 

	With the growing family incomes and ever-growing middle class society, India is becoming one of the most potential markets meant for used cars.  
	Maruti Suzuki has the highest number of sales for used cars and it occupied almost 21% of market follow by Hyundai(19%) and the least number of sales of Datsun(0.2%) and Force(0.05%) respectively.
	Diesel and petrol cars are mostly used, whereas CNG & LPG cars are rarely used.
	Mileage range between 12-23kmpl, avg. minimum mileage gives by land rover(12) and  maximum mileage gives by Maruti Suzuki(23).
	Two types of transmission used in cars, Mostly used manual transmission where company like BMW and AUDI are used Automatic. 
	Avg. Engine range between 950-2600CC.
	Based on average price, companies like Audi, Bmw, Chevrolet, Fiat, Mitsubishi, Nissan, Skoda & Volkswagen gives average 45% loss for seller and 45 % profit for purchaser. 
	Companies like Maruti Suzuki, Honda, Hyundai, Ford, Renault, Datsun, Force gives average 25-35% loss for seller and profit for purchaser.
	The general consensus among the industry is that the Used cars segment may become almost double of the new car market in another five years as is the case in india. 


