use netflix_db;
-- Netflix Project 
drop table if exists netflix;
create table netflix
(
show_id varchar(7),
types varchar(50),
title varchar(150),
director varchar(255),
casts varchar(800),
country varchar(150),
date_added varchar(50),
release_year int,
rating varchar(10),
duration varchar(10),
listed_in varchar(250),
description varchar(250)
);

select * from netflix;

SELECT
	COUNT(*) AS TOTAL_CONTENT
FROM
	NETFLIX;

select distinct types from netflix;

-- 15 Business Problems & Solutions
/*
1. Count the number of Movies vs TV Shows */

select * from netflix;

select types, count(*) as total_content
from netflix
group by types;
/*
2. Find the most common rating for movies and TV shows */

select
TYPES,
RATING
FROM
	(
		SELECT
			TYPES,
			RATING,
			COUNT(*),
			RANK() OVER (
				PARTITION BY
					TYPES
				ORDER BY
					COUNT(*) DESC
			) AS RANKING
		FROM
			NETFLIX
		GROUP BY
			1,
			2
	) AS T1;
-- order by 1,3;
/*
3. List all movies released in a specific year (e.g., 2020) */

SELECT
	*
FROM
	NETFLIX;

SELECT
	TITLE,
	RELEASE_YEAR 
FROM
	NETFLIX
where 
	release_year = 2020;

/*
4. Find the top 5 countries with the most content on Netflix */

SELECT
	*
FROM
	NETFLIX;

SELECT
	COUNTRY,
	COUNT(SHOW_ID) AS TOTAL_CONTENT
FROM
	NETFLIX
GROUP BY
	COUNTRY
ORDER BY
	TOTAL_CONTENT DESC
LIMIT
	5;
5. Identify the longest movie

SELECT
	title,
	MAX(DURATION) AS MAX_LENGTH
FROM
	NETFLIX
where types = 'Movie'
group by title;

6. Find content added in the last 5 years

SELECT
	*
FROM
	NETFLIX
WHERE
	TO_DATE(DATE_ADDED, 'Month DD', 'YYYY') >= CURRENT_DATE -INTERNAL '5 years'

select current_date - interval '5 years';

7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

SELECT
	TITLE,
	TYPES,
	DIRECTOR
FROM
	NETFLIX
WHERE
	DIRECTOR ilike 'Rajiv Chilaka';


8. List all TV shows with more than 5 seasons

SELECT
	*,
	split_part(duration,' ',1) as seasons
FROM
	NETFLIX
WHERE
	TYPES = 'TV show' 
;

9. Count the number of content items in each genre


SELECT
	*
FROM
	NETFLIX;

SELECT
	LISTED_IN,
	COUNT(SHOW_ID) AS NUM_OF_CONTENT
FROM
	NETFLIX
GROUP BY
	LISTED_IN;

10.Find each year and the average numbers of content release in India on netflix. 
return top 5 year with highest avg content release!

SELECT
	*
FROM
	NETFLIX;

SELECT
	RELEASE_YEAR,
	COUNT(*) AS NUM_OF_CONTENT_RELEASE
FROM
	NETFLIX
GROUP BY
	RELEASE_YEAR;
	
11. List all movies that are documentaries

SELECT
	*
FROM
	NETFLIX;

SELECT
	TITLE,
	LISTED_IN
FROM
	NETFLIX
WHERE
	LISTED_IN ILIKE 'documentaries';
12. Find all content without a director


SELECT
	TITLE,
	DIRECTOR
FROM
	NETFLIX
WHERE
	DIRECTOR IS NULL;

13. Find how many movies actor 'Salman Khan' appeared in last 10 years!

SELECT
	*
FROM
	NETFLIX;

SELECT
	*
FROM
	NETFLIX
WHERE
	CASTS ILIKE '%Salman Khan%'
	AND RELEASE_YEAR > EXTRACT(
		YEAR
		FROM
			CURRENT_DATE
	) -10;

14. Find the top 10 actors who have appeared in the highest number of movies produced in India.

SELECT
	*
FROM
	NETFLIX;

SELECT
	--SHOW_ID,
	--CASTS,
	UNNEST(STRING_TO_ARRAY(CASTS, ',')) AS ACTORS,
	COUNT(*) AS TOTAL_CONTENT
FROM
	NETFLIX
GROUP BY
	1
ORDER BY
	TOTAL_CONTENT DESC
LIMIT
	10;

15. Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
the description field. Label content containing these keywords as 'Bad' and all other 
content as 'Good'. Count how many items fall into each category.

select * from netflix;

WITH
	NEW_TABLE AS (
		SELECT
			*,
			CASE
				WHEN DESCRIPTION ILIKE '%kill%'
				OR DESCRIPTION ILIKE '%violence%' THEN 'Bad_content'
				ELSE 'Good_content'
			END CATEGORY
		FROM
			NETFLIX
	)
SELECT
	CATEGORY,
	COUNT(*) AS TOTAL_CONTENT
FROM
	NEW_TABLE
GROUP BY
	1;


	


