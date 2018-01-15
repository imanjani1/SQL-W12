-- 1

Use sakila;

-- 1a

select first_name , last_name from actor;

-- 1b

select upper(concat(first_name,' ' , last_name )) as 'Actor Name'  from actor;

-- 2

-- 2a

select actor_id, first_name , last_name 
from actor
where first_name = "Joe";

-- 2b

select * from actor
where last_name like "%GEN%";

-- 2c

select * from actor
where last_name like "%LI%"
order by last_name,first_name;

-- 2d
select country_id, country from country
where country in ('Afghanistan', 'Bangladesh', 'China');


--  3

-- 3a
ALTER table actor
Add column middle_name varchar(25) AFTER first_name;


-- 3b
ALTER table actor
modify column middle_name blob;

-- 3c

ALTER table actor
drop column middle_name;

--  4

-- 4a
select last_name , count(*) from actor
group by last_name order by 2 desc;

-- 4b
select last_name , count(*) from actor
group by last_name 
having count(*) >= 2
order by count(*) desc;


-- 4c

update actor
set first_name = "HARPO" ,last_name="GROUCHO"
where first_name = "GROUCHO" and last_name="WILLIAMS";


-- 4 d

-- check if the name changed 
select * from actor
where first_name like "%HARPO%";
-- now we changing 


-- 5 

-- 5a

CREATE SCHEMA address

/**************6***************/

-- 6 


-- 6 a
select a.first_name , a.last_name , b.address
from staff a
inner join address b
on a.address_id =b.address_id; 


-- 6b 
select  b.total , a.* from staff a
inner join 
(select staff_id , sum(amount) as total from payment 
where year(payment_date) = 2005
group by staff_id ) as b
on a.staff_id=b.staff_id



-- 6c

select a.film_id, a.title , b.number_of_acotrs
from film a
inner join 
(select film_id , count(actor_id) as number_of_acotrs  from film_actor
group by film_id) b
on a.film_id=b.film_id;




-- 6d



select count(*) from inventory
where film_id in (select film_id from film
where title="Hunchback Impossible");

-- 6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
-- List the customers alphabetically by last name:
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_amount
FROM customer c LEFT JOIN payment p
USING (customer_id)
GROUP BY customer_id
ORDER BY c.last_name ASC;

-- 7a 


select * from film where
language_id in 
			(select language_id from language 
			where name ="English")
and title like 'k%'
or title like 'q%'; 



-- 7b 
select * from actor
where actor_id in

				(select actor_id from film_actor
				where film_id in
						(select film_id from film
							where title ="Alone Trip"));








-- 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email 
-- addresses of all Canadian customers. Use joins to retrieve this information.
SELECT c.first_name, c.last_name, c.email
FROM customer c 
JOIN address a
ON c.address_id = a.address_id
JOIN city y
ON a.city_id = y.city_id
JOIN country r
ON y.country_id = r.country_id
WHERE country = 'Canada';

-- 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
-- Identify all movies categorized as family films.
SELECT title
FROM film
WHERE film_id IN
(
 SELECT film_id 
 FROM film_category
 WHERE category_id IN
 (
  SELECT category_id
  FROM category
  WHERE name = 'Family'
 )
);

-- 7e. Display the most frequently rented movies in descending order.
SELECT f.title, COUNT(r.rental_id) AS frequency_rented
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
GROUP BY f.title
ORDER BY frequency_rented DESC;

-- 7f. Write a query to display how much business, in dollars, each store brought in.
SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM store s
JOIN inventory i ON i.store_id = s.store_id
JOIN rental r ON r.inventory_id = i.inventory_id
JOIN payment p ON p.rental_id = r.rental_id
GROUP BY s.store_id;

-- 7g. Write a query to display for each store its store ID, city, and country.
SELECT s.store_id, y.city, r.country
FROM store s
JOIN address a ON a.address_id = s.address_id
JOIN city y ON y.city_id = a.city_id
JOIN country r ON r.country_id = y.country_id;

-- 7h. List the top five genres in gross revenue in descending order. 
-- (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
SELECT c.name
FROM category c
JOIN film_category f ON f.category_id = c.category_id
JOIN inventory i ON i.film_id = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
JOIN payment p ON p.rental_id = r.rental_id
GROUP BY c.name
ORDER BY SUM(p.amount) DESC
LIMIT 5;

-- 8a. In your new role as an executive, you would like to have an easy way of viewing the 
-- Top five genres by gross revenue. Use the solution from the problem above to create a view. 
-- If you haven't solved 7h, you can substitute another query to create a view.
CREATE VIEW top_five_genres AS
SELECT c.name, SUM(p.amount) AS gross_revenue
FROM category c
JOIN film_category f ON f.category_id = c.category_id
JOIN inventory i ON i.film_id = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
JOIN payment p ON p.rental_id = r.rental_id
GROUP BY c.name
ORDER BY gross_revenue DESC
LIMIT 5;

-- 8b. How would you display the view that you created in 8a?
SELECT *
FROM top_five_genres;

-- 8c. You find that you no longer need the view top_five_genres. Write a query to delete it.
DROP VIEW top_five_genres;
