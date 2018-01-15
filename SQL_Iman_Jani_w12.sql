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





-- 7c


select a.first_name, last_name , email from customer 


select * from country ;

select * from customer; 

