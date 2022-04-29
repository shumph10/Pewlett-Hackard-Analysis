-- Use aggregate functions as you run queries to answer the following questions. You will have to search the internet for some of them. Try to use aliases for more informative column headings.


-- What is the average cost to rent a film in the Sakila stores?
SELECT ROUND(AVG(rental_rate), 3) AS avg_rental_cost
FROM film;

-- What is the average rental cost of films by rating? On average, what is the cheapest rating of films to rent? What is the most expensive?
SELECT rating,
	ROUND(AVG(rental_rate), 3) AS avg_rental_cost
FROM film
GROUP BY rating;

-- How much would it cost to replace all films in the database?
SELECT ROUND(SUM(rental_rate), 3) AS rental_replacement_cost
FROM film;

-- How much would it cost to replace all films in each ratings category?
SELECT rating,
	ROUND(SUM(rental_rate), 3) AS rental_replacement_by_rating
FROM film
GROUP BY rating;

-- How long is the longest movie in the database? How long is the shortest movie?
SELECT ROUND(MIN(length), 3) AS shortest_movie, ROUND(MAX(length), 3) AS longest_movie
FROM film;

SELECT ROUND(MAX(length), 3) AS longest_movie
FROM film;