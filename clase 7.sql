use sakila;

SELECT *
from film;


-- 1 Encuentra las pel�culas de menor duraci�n, muestra el t�tulo y la calificaci�n.
-- 2 Escriba una consulta que devuelva el titulo de la pel�cula cuya duraci�n es la m�s baja. Si hay m�s de una pel�cula con la duraci�n m�s baja, la consulta devuelve un conjunto de resultados vac�o.
-- 3 Genere un informe con la lista de clientes que muestre los pagos m�s bajos realizados por cada uno de ellos. Muestre la informaci�n del cliente, la direcci�n y el monto m�s bajo, proporcione ambas soluciones usando TODO y/o ANY y MIN.
-- 4 Genere un informe que muestre la informaci�n del cliente con el pago m�s alto y el pago m�s bajo en la misma fila.
 
-- 1
SELECT *
	from (select title, rating, length
		from film f) a
		order by length ASC;
			
SELECT film_id , `length` 
from film f 
order by `length` ASC;



SELECT title,rating 
  FROM film f 
 WHERE EXISTS (SELECT * 
                 FROM film f2   
                WHERE f.`length` <= f2.`length`  
                  AND f.film_id  <> f2.film_id
                 ORDER by`length` ASC);

	

         
-- 2 

SELECT title
from film f 
WHERE f.film_id = ANY(select film_id -- recordemos que aca hace como una especie de comparacion de film_id
						from film f2
						WHERE f2.`length` < f.`length`  -- y aca decimos que buscamos el f2.length que es menor que el f.length
						and f2.film_id <> f.film_id); 

-- (solucion de reta)					
SELECT title
FROM film f
WHERE 1=(SELECT COUNT(*)
			FROM film f2 
			WHERE `length`=(SELECT MIN(`length`) -- en esta linea esta comparando si el length de la primer subquery es igual al MIN(length) de la segunda subquery si es asi se cuenta en la primer subquery en el COUNT(*)
							FROM film f3));
		
						
						
						
						
-- 3						
						
SELECT customer_id,
		first_name,
		last_name,
		a.address,
		(SELECT MIN(p.amount)
			from payment p
			WHERE p.customer_id = c.customer_id) as min_amount
FROM customer c
join address a
on c.address_id = a.address_id
order by min_amount DESC;
			



SELECT  c.customer_id,
		c.first_name,
		c.last_name,
		a.address
from customer c                                         -- NO FUNCIONA
join address a 
on c.address_id  = a.address_id 
WHERE c.customer_id = ANY (SELECT p.customer_id
							from payment p
							where p.amount = MIN(p.amount));

						

						
						
-- 4
							 
SELECT ALL  c.customer_id,c.first_name,c.last_name,
	(SELECT CONCAT((SELECT MIN(amount)
		FROM payment p
		WHERE c.customer_id = p.customer_id), " / ",
	(SELECT MAX(amount)
		FROM payment p
		WHERE c.customer_id = p.customer_id)
	))AS lowest_highest_paymemt
FROM customer c;

							

SELECT c.customer_id, c.first_name, c.last_name, (SELECT CONCAT((SELECT MIN(p.amount)
																	FROM payment p 
																	WHERE c.customer_id = p.customer_id), " / ", 
																(SELECT MAX(p2.amount)
																	FROM payment p2
																	WHERE c.customer_id = p2.customer_id)
)) AS lowest_highest_amount
from customer c;


-- Tenga en cuenta que la GROUP_CONCAT()funci�n concatena valores de cadena en diferentes filas, mientras que la funci�n CONCAT_WS()o CONCAT()concatena dos o m�s valores de cadena en diferentes columnas.




 
						
					