SELECT *
FROM video_game

-- Basic count of records

SELECT COUNT(*) AS total_records
FROM video_game AS vg 


-- Count records by release_year

SELECT vg.release_year, COUNT(*) AS total_records
FROM video_game AS vg
GROUP BY vg.release_year
ORDER BY vg.release_year DESC

-- Count records by release_year and platform

SELECT vg.release_year, vg.platform, COUNT(*) AS total_records
FROM video_game AS vg
GROUP BY vg.release_year, vg.platform
ORDER BY vg.release_year DESC, vg.platform

-- Average price per game for each platform

SELECT vg.platform, AVG(vg.price) AS average_price
FROM video_game AS vg
GROUP BY vg.platform

-- Total sales by genre for 2017 games
SELECT vg.genre, SUM(vg.sales) AS total_sales
FROM video_game AS vg 
WHERE vg.release_year = 2017
GROUP BY vg.genre

-- Show genres with average metacritic score over 85
SELECT vg.genre, AVG(vg.metacritic_score) AS average_score
FROM video_game AS vg 
GROUP BY vg.genre 
HAVING AVG(vg.metacritic_score) > 65