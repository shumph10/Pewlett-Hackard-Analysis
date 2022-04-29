-- Select count of actors first names in descending order
SELECT first_name, COUNT(first_name) as first_name_count
FROM actor
GROUP BY (first_name)
ORDER BY first_name_count DESC

-- Select the average duration of movies by rating
SELECT rating, ROUND(AVG("length"), 3) as "Average Duration"
FROM film
GROUP BY rating;
-- Select top ten replace costs for the length of the movie
SELECT ROUND(AVG(replacement_cost), 2)  as "Replacement Cost by Length", "length", COUNT (*) as movie_count
FROM film
GROUP BY "length"
ORDER BY "Replacement Cost by Length" DESC
LIMIT 10;

-- Select the count of countries
SELECT country_id, COUNT(*)t
FROM city
GROUP BY country_id;

-- if you do the first way bc its a relational database you will get only the country id #s 
-- need to join with country file bc it has the country id to join on and the country name
-- that way you can replace the country id # with the country name

SELECT country.country, COUNT(country.country) as city_count
FROM city
	JOIN country on city.country_id = country.country_id
GROUP BY country.country
ORDER BY city_count DESC;


-- how to get distinct values 
SELECT DISTINCT customer_id, inventory_id, rental_date
FROM rental
ORDER BY rental_date DESC;

SELECT DISTINCT customer_id, inventory_id
FROM rental;
-- shows person a ordered x 
-- could also use to figure out if a certain movie is in stock at a certain store

SELECT DISTINCT ON (customer_id) customer_id,rental_date
FROM rental
ORDER BY customer_id;
-- shows distict results for just one variable
-- if there are more than one rental for a certain customer, it returns the first one that it encounters

--can get it to return the last one encountered with DESC
SELECT DISTINCT ON (customer_id) customer_id,rental_date
FROM rental
ORDER BY customer_id, rental_date DESC;


-- get the latest rental for each customers first and last name and email address
SELECT DISTINCT ON (first_name, last_name, email) 
	first_name, last_name, email, ren.rental_date
FROM rental as ren
	JOIN customer as cust on cust.customer_id = ren.customer_id
ORDER BY first_name, last_name, email DESC;

--OR
Select first_name, last_name, email, MAX(ren.rental_date) as last_rental
FROM rental as ren
	JOIN customer as cust on cust.customer_id = ren.customer_id
GROUP BY first_name, last_name, email
ORDER BY first_name, last_name, email;

-- returns the same thing
-- if youre dealing with a lot of complicated things -- esp if there are null values 
	--want to do the distinct on instead of max bc it can be finicky
	
--retrieve the lastest rental date for each title
	-- rental stuff is in rental 
	-- inventory is a look up table - has the inventory id in the inventory table has a film id attached
	-- then get the title of the movie from the film id in the film table
	-- connect the rental table to the film table through the inventory table
SELECT f.title, MAX(rental_date) as last_rental
FROM rental r 
	join inventory i 
		on r.inventory_id = i.inventory_id
	join film f
		on i.film_id = f.film_id
group by f.title
order by last_rental DESC;

























