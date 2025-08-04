-- 1. 
-- Use a window function to add columns showing:
-- The maximum population (max_pop) for each county.
-- The minimum population (min_pop) for each county.
SELECT DISTINCT county, 
		year, 
		population, 
		MAX(population) OVER(PARTITION BY county) AS max_pop, 
		MIN(population) OVER(PARTITION BY county) AS min_pop
FROM population
ORDER BY county, year;

-- 2. 
-- Rank counties from largest to smallest population for each year.
SELECT DISTINCT county, 
		year, 
		population, 
		RANK() OVER(PARTITION BY year ORDER BY population DESC) AS rank_order
FROM population
ORDER BY population DESC;

-- 3. 
-- Use the unemployment table:
-- Calculate the rolling 12-month average unemployment rate using the unemployment table.
-- Include the current month and the preceding 11 months.
-- Hint: Reference two columns in the ORDER BY argument (county and period).

SELECT DISTINCT county, 
		period_name AS month, 
		AVG(value) OVER (PARTITION BY county ORDER BY period ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS rolling_avg_per_12
FROM unemployment
ORDER BY rolling_avg_per_12 DESC;
