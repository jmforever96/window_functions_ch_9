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
SELECT *, 
		RANK() OVER(PARTITION BY year ORDER BY population DESC) AS rank_order
FROM population;

-- 3. 
-- Use the unemployment table:
-- Calculate the rolling 12-month average unemployment rate using the unemployment table.
-- Include the current month and the preceding 11 months.
-- Hint: Reference two columns in the ORDER BY argument (year and period).

SELECT *, 
		ROUND(AVG(value) OVER (PARTITION BY county ORDER BY year, period ROWS BETWEEN 11 PRECEDING AND CURRENT ROW), 2) AS rolling_avg_per_12
FROM unemployment;
