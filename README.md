# Social_Media_Analysis
📊 Social Media Usage Analysis using SQL
📁 Project Overview
This project is a data analysis case study on social media usage behavior across different countries, age groups, and engagement levels. The analysis was performed using SQL on a dataset containing users’ demographic information and their social media metrics like TotalLikes, Followers, Comments, and usageduraiton (time spent).

🔍 Objectives
Analyze usage patterns across countries and age groups

Identify heavy and light social media users

Rank users based on their social media engagement

Detect behavioral trends using advanced SQL analytics (window functions, percentiles, z-scores)

Provide insights for potential marketing or platform strategy decisions

📂 Dataset Summary

Column Name	Description
UserId	Unique ID for each user
Age	Age of the user
Gender	Gender of the user
Country	Country of the user
Followers	Number of followers
TotalLikes	Total likes received
TotalComments	Total comments received
social_media	Platform used (e.g., Instagram, TikTok)
usageduraiton	Time spent daily on social media (hrs)
Note: Column names like social_media and usageduraiton were standardized to match the dataset.

🧠 Key SQL Techniques Used
Window Functions: RANK(), PERCENT_RANK(), NTILE(), AVG() OVER

Aggregation: AVG(), SUM(), STDDEV()

Conditional Logic: CASE WHEN for categorizing age groups and engagement levels

Subqueries & Joins: For comparative analysis

Outlier Detection: Z-score, standard deviation filtering

Segmentation: By country, age brackets, and engagement

📈 Analysis Highlights
💡 Identified top-performing users by country based on likes

📌 Flagged “Heavy Users” who spend significantly more time than average

🎯 Created age group segments and compared average time spent

📊 Built a percentile-based ranking for understanding user engagement tiers

🔍 Compared each user’s usageduraiton to their country average

🧪 Detected usage outliers using standard deviation

