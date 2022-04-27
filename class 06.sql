-- Enumerar todos los actores que comparten el apellido. Mostrarlos en orden

select * from actor a1 where exists (select last_name from actor a2 where a1.last_name = a2.last_name)
order by last_name ;


-- Encuentra actores que no trabajan en ninguna pelicula
SELECT *
from actor a
WHERE EXISTS (SELECT * from film f join film_actor fa on f.film_id = fa.film_id where actor_id = NULL);
		
	
select first_name  
from actor a1 
where not exists (select actor_id from film_actor fa where a1.actor_id = fa.actor_id);

-- Encuentro clientes que alquilaron solo una pelicula

SELECT * 
from customer c 
where name  (SELECT customer_id from rental r where r.customer_id = c.customer_id)

-- Encuentro clientes que alquilaron mas de una pelicula
select *
from customer c
where(select count(*)from rental r where r.customer_id = c.customer_id) > 1

-- Lista de los actores que actuaron en 'TRAICIÓN TRAICIONADA' o en 'ATRAPA AMISTAD'
select a.first_name, a.last_name, f2.title
from actor a, film f2 
where exists (select * from film_actor fa 
where f2.film_id = fa.film_id and f2.title = 'BETRAYED REAR' 
or f2.title = 'CATCH AMISTAD');


-- Lista los actores que actuaron en 'TRAICIÓN TRAICIONADA' pero no en 'ATRAPA AMISTAD'
select a.first_name, a.last_name, f2.title
from actor a, film f2 
where exists (select * from film_actor fa 
where f2.film_id = fa.film_id and f2.title = 'BETRAYED REAR' 
);

-- Lista de los actores que actuaron tanto en 'TRAICIONADO POR LA PARTE POSTERIOR' como en 'ATRAPA AMISTAD'
select a.first_name, a.last_name, f2.title
from actor a, film f2 
where exists (select * from film_actor fa 
where f2.film_id = fa.film_id and f2.title = 'BETRAYED REAR' 
and f2.title = 'CATCH AMISTAD');

-- Lista todos los actores que no trabajaron en 'TRAICIONADO POR LA PARTE POSTERIOR' o 'ATRAPA AMISTAD'
select a.first_name, a.last_name, f2.title
from actor a, film f2 
where not exists (select * from film_actor fa 
where f2.film_id = fa.film_id and f2.title = 'BETRAYED REAR' 
or f2.title = 'CATCH AMISTAD');