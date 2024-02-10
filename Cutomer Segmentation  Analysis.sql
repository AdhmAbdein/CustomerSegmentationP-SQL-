USE [CustomerSegmentationP];

--Detect null value and replace it with value
SELECT *
FROM [dbo].[Customer Segmentation]
WHERE [first_name]IS NULL OR 
[last_name]IS NULL OR 
[title]IS NULL OR 
[gender]IS NULL OR 
[email]IS NULL OR 
[city]IS NULL OR
[country]IS NULL OR
[country_code]IS NULL OR 
[latitude]IS NULL OR
[longitude]IS NULL OR
[phone]IS NULL OR 
[street_address]IS NULL OR 
[street_name]IS NULL OR
[street_number]IS NULL OR 
[street_suffix] IS NULL OR
[time_zone]IS NULL OR 
[company_name] IS NULL OR 
[department]IS NULL OR 
[job_title]IS NULL OR 
[language]IS NULL OR 
[university]IS NULL OR 
[linkedin_skill]IS NULL OR 
[ip_address] IS NULL;

UPDATE [dbo].[Customer Segmentation]
SET [country_code] = COALESCE([country_code], 'NAM')
WHERE [country_code] IS NULL;

-----------------------------------------------------
--Find duplicated row and delete it
WITH cte AS (
    SELECT 
        [email],
        ROW_NUMBER() OVER (
            PARTITION BY [email]
            ORDER BY [email]) row_num
    FROM 
        [dbo].[Customer Segmentation]
) 
SELECT * FROM cte 
WHERE row_num > 1;

-----------------------------------------------------------
--What is the distribution of titles (Mrs, Mr, Rev, Dr, Honorable) among the customers?
SELECT [title] , COUNT(*) AS "Number_of_customers"
FROM [dbo].[Customer Segmentation]
GROUP BY [title]
ORDER BY Number_of_customers DESC;

--How many unique titles are present in the dataset?
SELECT COUNT(DISTINCT[title] ) AS "TITELS"
FROM [dbo].[Customer Segmentation];

--What is the gender distribution among the customers?
SELECT [gender] , COUNT(*) AS "Number_of_customers"
FROM [dbo].[Customer Segmentation]
GROUP BY [gender]
ORDER BY Number_of_customers DESC;

--Which country has the highest number of customers?
SELECT TOP 1 [country] , COUNT(*) AS "Number_of_customers"
FROM [dbo].[Customer Segmentation]
GROUP BY [country]
ORDER BY Number_of_customers DESC;

--Can you identify the distribution of latitude and longitude across different countries?
SELECT [country] , AVG([latitude]) AS "AVG_latitude" ,
       AVG([longitude]) AS "AVG_longitude"
FROM [dbo].[Customer Segmentation]
GROUP BY [country];

--What are the most common street names in the dataset?
SELECT TOP 5 [street_name] , COUNT(*) AS "Number_of_customers"
FROM [dbo].[Customer Segmentation]
GROUP BY [street_name]
ORDER BY Number_of_customers DESC;

--How many unique job titles are there among the customers?
SELECT COUNT(DISTINCT [job_title]) AS "unique_job_titles"
FROM [dbo].[Customer Segmentation];

--Which time zone has the highest number of customers?
SELECT TOP 1 [time_zone] , COUNT(*) AS "Number_of_customer"
FROM [dbo].[Customer Segmentation]
GROUP BY [time_zone]
ORDER BY Number_of_customer DESC;

--Are there any relations between job titles and languages spoken by customers?
SELECT [language] , [title] , COUNT(*) AS "Number_of_customer"
FROM [dbo].[Customer Segmentation]
GROUP BY [language] , [title]
ORDER BY [language];

--What is the distribution of customers across different universities?
SELECT  [university] , COUNT(*) AS "Number_of_customer"
FROM [dbo].[Customer Segmentation]
GROUP BY [university]
ORDER BY Number_of_customer DESC;

--Can you identify clusters of customers based on their LinkedIn skills?
SELECT [linkedin_skill] , COUNT(*) AS "Number_of_customer"
FROM [dbo].[Customer Segmentation]
GROUP BY [linkedin_skill];

--How many customers have multiple email addresses?
SELECT [email] , COUNT(*) AS "Number_of_customer"
FROM [dbo].[Customer Segmentation]
GROUP BY [email]
HAVING COUNT(*) >1 ;

--What is the most common street suffix ?
SELECT TOP 1 [street_suffix] ,COUNT(*) AS "Number_of_customer"
FROM [dbo].[Customer Segmentation]
GROUP BY [street_suffix]
ORDER BY Number_of_customer DESC;

--What are the top 5 most common company among customers?
SELECT TOP 5 [company_name] ,COUNT(*) AS "Number_of_customer"
FROM [dbo].[Customer Segmentation]
GROUP BY [company_name]
ORDER BY Number_of_customer DESC;

--Customers with multiple job titles within the same department:
SELECT [first_name] , [last_name] , [department],COUNT(*) 
FROM [dbo].[Customer Segmentation]
GROUP BY [first_name] , [last_name] , [department]
HAVING COUNT(*) > 1

--What is the distribution of customers' IP addresses based on their countries?
SELECT [country] , COUNT([ip_address]) AS "Number_of_ip"
FROM [dbo].[Customer Segmentation]
GROUP BY [country]
ORDER BY Number_of_ip DESC;

--What is the number of languages spoken by customers in each country?
SELECT [country] , COUNT([language]) AS "Number_of_lang"
FROM [dbo].[Customer Segmentation]
GROUP BY [country]
ORDER BY Number_of_lang DESC

--What is the most common department among customers with the title "Dr"?
SELECT TOP 1 [title] , [department] , COUNT(*) AS "Number_of_customers"
FROM [dbo].[Customer Segmentation] 
WHERE [title] = 'Dr'
GROUP BY [title] , [department] 
ORDER BY Number_of_customers DESC;

--Are there any distribution in customers' language preferences based on their titles?
SELECT [title] , [language] , COUNT([language]) AS "Number_of_customer"
FROM [dbo].[Customer Segmentation]
GROUP BY [title] , [language]
ORDER BY [title] , Number_of_customer DESC;

--Distribution of customers' time zones based on countries:
SELECT [country] , [time_zone] , COUNT(*) AS "Number_of_customer"
FROM [dbo].[Customer Segmentation]
GROUP BY [country] , [time_zone] 
ORDER BY [country] , Number_of_customer DESC ;

--Are there any patterns in the distribution of customers' email domains?
SELECT RIGHT( [email] ,
              LEN([email]) - CHARINDEX('@', [email])) 
			  AS "email_domain",
       COUNT(*)
FROM [dbo].[Customer Segmentation]
GROUP BY RIGHT( [email] ,
         LEN([email]) - CHARINDEX('@', [email]));

--What is the most common country with the title "Honorable"?
SELECT TOP 1 [country] , [title] , COUNT(*) AS "Number_number_ofcustomer_honorable"
FROM [dbo].[Customer Segmentation]
WHERE [title] ='Honorable'
GROUP BY [country] , [title] 
ORDER BY Number_number_ofcustomer_honorable DESC;
