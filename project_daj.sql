--1.How many rows are in the data_analyst_jobs table?SELECT COUNT(*)
SELECT COUNT(*)
FROM data_analyst_jobs;

--2.Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row? ExxonMobil

SELECT company
FROM data_analyst_jobs
LIMIT 10;

--3.How many postings are in Tennessee? 21 How many are there in either Tennessee or Kentucky? 27

SELECT COUNT (*) AS tn_jobs
FROM data_analyst_jobs
WHERE location = 'TN';

SELECT COUNT (*) AS tn_or_ky_jobs
FROM data_analyst_jobs
WHERE location = 'TN' OR location = 'KY';

--4.How many postings in Tennessee have a star rating above 4? 3

SELECT COUNT (*) AS high_tn_ratings
FROM data_analyst_jobs
WHERE location = 'TN' AND star_rating > 4;

--5.How many postings in the dataset have a review count between 500 and 1000? 151

SELECT COUNT (*) AS high_num_of_reviews
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;

--6.Show the average star rating for companies in each state. The output should show the state as `state` and the average rating for the state as `avg_rating`. Which state shows the highest average rating? NE

SELECT location AS state, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE star_rating IS NOT NULL
GROUP BY location
ORDER BY avg_rating DESC;

--7.Select unique job titles from the data_analyst_jobs table. How many are there? 881

SELECT DISTINCT title
FROM data_analyst_jobs;

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs;

--8.How many unique job titles are there for California companies? 230

SELECT COUNT (DISTINCT title)
FROM data_analyst_jobs
WHERE location = 'CA';

--9.Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations? 40 (41 with null)

SELECT DISTINCT company, AVG(star_rating)AS avg_star_rating, review_count
FROM data_analyst_jobs
WHERE review_count > 5000
GROUP BY review_count, company;



SELECT COUNT(DISTINCT company)
FROM data_analyst_jobs
WHERE company IS NOT NULL AND review_count > 5000;

--10.Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? American Express What is that rating? 4.199

SELECT DISTINCT company, AVG(star_rating)AS avg_star_rating, review_count
FROM data_analyst_jobs
WHERE review_count > 5000
GROUP BY review_count, company
ORDER BY avg_star_rating DESC;

--11.Find all the job titles that contain the word ‘Analyst’. How many different job titles are there? 774

SELECT DISTINCT title
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%';

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%';

--12.How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common? Data

SELECT DISTINCT title
FROM data_analyst_jobs
WHERE title NOT ILIKE '%Analyst%' AND title NOT ILIKE '%Analytics%';

--BONUS You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks. 
 -- Disregard any postings where the domain is NULL. 
 -- Order your results so that the domain with the greatest number of `hard to fill` jobs is at the top. 
  -- Which three industries are in the top 4 on this list? Consulting and Business Services 5, Consumer Goods and Services 2, and Computers and Electronics 1. How many jobs have been listed for more than 3 weeks for each of the top 4?
  
SELECT domain, days_since_posting/7 AS weeks_since_posting, COUNT(title) AS number_of_jobs 
FROM data_analyst_jobs
WHERE skill = 'SQL' AND days_since_posting >21 AND domain IS NOT NULL
GROUP BY domain, days_since_posting
ORDER BY number_of_jobs DESC;

SELECT COUNT(domain)
FROM data_analyst_jobs
WHERE domain = 'Consulting and Business Services' AND days_since_posting > 21 AND skill = 'SQL';

SELECT COUNT(domain)
FROM data_analyst_jobs
WHERE domain = 'Computers and Electronics' AND days_since_posting > 21 AND skill = 'SQL';

SELECT COUNT(domain)
FROM data_analyst_jobs
WHERE domain = 'Consumer Goods and Services' AND days_since_posting > 21 AND skill = 'SQL';