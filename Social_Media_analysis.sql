Create database  social_media_analysis;
use  social_media_analysis;
Select * from social_media;

#Total Users
Select count(userID) from social_media;

#Total LIkes
SELECT SUM(TotalLikes) AS TotalLikes
FROM Social_Media;


#Number of users by country
SELECT Country, COUNT(UserId) AS UserCount FROM Social_Media
 GROUP BY Country 
 ORDER BY UserCount DESC;



######Group users by age ranges and compute average usage and likes
SELECT 
  CASE 
    WHEN Age < 20 THEN 'Under 20'
    WHEN Age BETWEEN 20 AND 29 THEN '20-29'
    WHEN Age BETWEEN 30 AND 39 THEN '30-39'
    WHEN Age BETWEEN 40 AND 49 THEN '40-49'
    WHEN Age BETWEEN 50 AND 59 THEN '50-59'
    ELSE '60+' 
  END AS Agegroup,
AVG(UsageDuraiton) AS AvgUsage,AVG(TotalLikes) AS AvgLikes FROM Social_Media GROUP BY Agegroup;



#####Top Countries by Average Usage
Select Country,Avg(UsageDuraiton) from Social_Media 
group by Country 
order by avg(UsageDuraiton) desc;



######3 Do Users Who Spend More Time Get More Likes?
Select UsageDuraiton,Avg(TotalLikes) from Social_media
 group by UsageDuraiton 
 order by UsageDuraiton;


####Users with Above-Average Likes
SELECT * FROM Social_Media 
WHERE TotalLikes > (SELECT AVG(TotalLikes) FROM Social_Media);


###country-wise Total and Average Likes
SELECT Country, SUM(TotalLikes) AS TotalLikes, AVG(TotalLikes) AS AverageLikes From Social_Media 
GROUP BY Country 
ORDER BY TotalLikes DESC;



########Age Distribution by Country
Select Country,max(age) as olderuser,min(age) as youngster,avg(age) as averageuser from social_media
 group by country ;



#####Categorizing users by how long they use social media daily:
SELECT 
  CASE 
    WHEN UsageDuraiton <= 1 THEN 'Very Low'
    WHEN UsageDuraiton BETWEEN 2 AND 3 THEN 'Low'
    WHEN UsageDuraiton BETWEEN 4 AND 5 THEN 'Moderate'
    WHEN UsageDuraiton >= 6 THEN 'High'
  END AS UsageCategory,
  COUNT(UserId) AS UserCount
FROM Social_Media
GROUP BY UsageCategory
ORDER BY UserCount DESC;



#####Top 5 Most Active Countries (by Average Usage Duration)
SELECT Country, AVG(UsageDuraiton) AS AvgUsage
FROM Social_Media
GROUP BY Country
ORDER BY AvgUsage DESC
LIMIT 5;



######Find the Most Active Age Group
SELECT 
  CASE 
    WHEN Age < 20 THEN 'Under 20'
    WHEN Age BETWEEN 20 AND 29 THEN '20-29'
    WHEN Age BETWEEN 30 AND 39 THEN '30-39'
    WHEN Age BETWEEN 40 AND 49 THEN '40-49'
    WHEN Age BETWEEN 50 AND 59 THEN '50-59'
    ELSE '60+'
  END AS AgeGroup,
  AVG(UsageDuraiton) AS AvgUsage
FROM Social_Media
GROUP BY AgeGroup
ORDER BY AvgUsage DESC; 

##### Percentage of Users by Country
SELECT Country, 
       ROUND(COUNT(UserId) * 100.0 / (SELECT COUNT(*) FROM Social_Media), 2) AS PercentageOfUsers
FROM Social_Media
GROUP BY Country
ORDER BY PercentageOfUsers DESC;


####Average likes per age:
SELECT Age, AVG(TotalLikes) AS AvgLikes
FROM Social_Media
GROUP BY Age
ORDER BY Age;
####Find Users Who Are Underperforming
SELECT *
FROM Social_Media
WHERE UsageDuraiton > 3 
  AND TotalLikes < (SELECT AVG(TotalLikes) FROM Social_Media);


#Country with Highest Average Usage Duration
SELECT Country, 
       AVG(UsageDuraiton) AS AvgUsage
FROM Social_Media
GROUP BY Country
ORDER BY AvgUsage DESC
LIMIT 1;



#Find Youngest & Oldest User in the Dataset
SELECT MIN(Age) AS YoungestUser, MAX(Age) AS OldestUser
FROM Social_Media;


#Users Spending More Than 5 Hours Daily
SELECT UserId, Country, UsageDuraiton, TotalLikes
FROM Social_Media
WHERE UsageDuraiton > 5
ORDER BY UsageDuraiton DESC;

#Likes Per Hour Usage Ratio
SELECT UserId,
       TotalLikes,
       UsageDuraiton,
       (TotalLikes / UsageDuraiton) AS LikesPerHour
FROM Social_Media
ORDER BY LikesPerHour DESC
LIMIT 10;

#% of Total Likes by Country
SELECT Country,
       SUM(TotalLikes) AS CountryLikes,
       ROUND(100.0 * SUM(TotalLikes) / (SELECT SUM(TotalLikes) FROM Social_Media), 2) AS LikesPercentage
FROM Social_Media
GROUP BY Country
ORDER BY LikesPercentage DESC;

#Rolling average of usage per country (Window Function)
SELECT 
    Country,
    Age,
    UsageDuraiton,
    AVG(UsageDuraiton) OVER (PARTITION BY Country ORDER BY Age ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS RollingAvgUsage
FROM Social_Media;

#Rank users by likes within their country (RANK)
SELECT 
    UserId,
    Country,
    TotalLikes,
    RANK() OVER (PARTITION BY Country ORDER BY TotalLikes DESC) AS RankInCountry
FROM Social_Media;

# Correlated Subquery: Users with above-average usage in their country
SELECT *
FROM Social_Media sm
WHERE UsageDuraiton > (
    SELECT AVG(UsageDuraiton)
    FROM Social_Media
    WHERE Country = sm.Country
);

#. Percentile Rank of Users Based on Likes
SELECT 
    UserId,
    TotalLikes,
    PERCENT_RANK() OVER (ORDER BY TotalLikes) AS LikesPercentile
FROM Social_Media;

#Advanced Grouping: Usage segmentation by country & age group
SELECT 
    Country,
    CASE 
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 40 THEN '25-40'
        WHEN Age BETWEEN 41 AND 60 THEN '41-60'
        ELSE '60+'
    END AS AgeBracket,
    COUNT(*) AS UsersCount,
    AVG(UsageDuraiton) AS AvgUsage
FROM Social_Media
GROUP BY Country, AgeBracket
ORDER BY Country, AgeBracket;

# BONUS: Top 20% of Users Based on Usage
WITH RankedUsage AS (
    SELECT *,
           NTILE(5) OVER (ORDER BY UsageDuraiton DESC) AS UsageTier
    FROM Social_Media
)
SELECT * 
FROM RankedUsage
WHERE UsageTier = 1;



#Users Who Are the Only Ones from Their Country
SELECT *
FROM social_media a
WHERE (
    SELECT COUNT(*)
    FROM social_media b
    WHERE a.Country = b.Country
) = 1;


#Compare Each User to the Average Duraiton Across All
SELECT 
    *,
    usageduraiton - (SELECT AVG(usageduraiton) FROM social_media) AS DiffFromAvg
FROM social_media;

#Duraiton Ratio Compared to Country Average
SELECT 
    a.UserId,
    a.Country,
    a.usageduraiton,
    a.usageduraiton / b.AvgUsage AS UsageduraitonRatio
FROM social_media a
JOIN (
    SELECT Country, AVG(usageduraiton) AS AvgUsage
    FROM social_media
    GROUP BY Country
) b ON a.Country = b.Country;
