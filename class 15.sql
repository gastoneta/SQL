use sakila;

#1 
CREATE
OR
REPLACE
    VIEW list_of_customers AS
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name),
    a.address,
    a.postal_code,
    a.phone,
    ci.city,
    co.country,
    CASE
        WHEN c.active = 1 THEN 'Active'
        ELSE 'Inactive'
    END 'Status'
FROM customer c
    INNER JOIN address a USING(address_id)
    INNER JOIN city ci USING(city_id)
    INNER JOIN country co USING(country_id);

SELECT * FROM list_of_customers;

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name),
    a.address,
    a.postal_code,
    a.phone,
    ci.city,
    co.country,
    CASE
        WHEN c.active = 1 THEN 'Active'
        ELSE 'Inactive'
    END 'Status'
FROM customer c
    INNER JOIN address a USING(address_id)
    INNER JOIN city ci USING(city_id)
    INNER JOIN country co USING(country_id);

#2
CREATE
OR
REPLACE VIEW film_details AS
SELECT
    f.film_id,
    f.title,
    f.description,
    ca.name AS 'Category',
    f.rental_rate AS 'Price',
    f.length,
    f.rating,
    GROUP_CONCAT(
        CONCAT(a.first_name, ' ', a.last_name)
    ) AS 'Actors'
FROM film f
    INNER JOIN film_category USING(film_id)
    INNER JOIN category ca USING(category_id)
    INNER JOIN film_actor USING(film_id)
    INNER JOIN actor a USING(actor_id)
GROUP BY film_id, ca.name;

SELECT * FROM film_details;

#3
CREATE
OR
REPLACE
    VIEW sales_by_film_category AS
SELECT
    ca.name,
    COUNT(r.rental_id) AS total_rental
FROM film
    INNER JOIN film_category USING(film_id)
    INNER JOIN category ca USING(category_id)
    INNER JOIN inventory USING(film_id)
    INNER JOIN rental r USING(inventory_id)
GROUP BY ca.name;

SELECT * FROM sales_by_film_category;

#4
CREATE
OR
REPLACE
    VIEW actor_information AS
SELECT
    a.actor_id,
    CONCAT(a.first_name, ' ', a.last_name) AS 'Actor',
    COUNT(film_id) AS 'Films Acted'
FROM actor a
    INNER JOIN film_actor USING(actor_id)
    INNER JOIN film USING(film_id)
GROUP BY a.actor_id
ORDER BY a.last_name;

SELECT * FROM actor_information;

#5
SELECT VIEW_DEFINITION
FROM INFORMATION_SCHEMA.VIEWS
WHERE TABLE_NAME = 'actor_info';

select
    `a`.`actor_id` AS `actor_id`,
    `a`.`first_name` AS `first_name`,
    `a`.`last_name` AS `last_name`,
    group_concat(
        distinct concat(
            `c`.`name`,
            ': ', (
                select
                    group_concat(
                        `f`.`title`
                        order by
                            `f`.`title` ASC separator ', '
                    )
                from ( (
                            `sakila`.`film` `f`
                            join `sakila`.`film_category` `fc` on( (`f`.`film_id` = `fc`.`film_id`)
                            )
                        )
                        join `sakila`.`film_actor` `fa` on( (`f`.`film_id` = `fa`.`film_id`)
                        )
                    )
                where ( (
                            `fc`.`category_id` = `c`.`category_id`
                        )
                        and (
                            `fa`.`actor_id` = `a`.`actor_id`
                        )
                    )
            )
        )
        order by
            `c`.`name` ASC separator '; '
    ) AS `film_info`
from ( ( (
                `sakila`.`actor` `a`
                left join `sakila`.`film_actor` `fa` on( (
                        `a`.`actor_id` = `fa`.`actor_id`
                    )
                )
            )
            left join `sakila`.`film_category` `fc` on( (
                    `fa`.`film_id` = `fc`.`film_id`
                )
            )
        )
        left join `sakila`.`category` `c` on( (
                `fc`.`category_id` = `c`.`category_id`
            )
        )
    )
group by
    `a`.`actor_id`,
    `a`.`first_name`,
    `a`.`last_name`;
