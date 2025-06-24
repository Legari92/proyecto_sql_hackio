

-- 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?
-- Empate entre Kenneth, Penelope y Julia. Si usáramos limit 1, no veríamos el empate.
select
	first_name,
	count(first_name) as cantidad
from
	actor
group by
	first_name
order by
	cantidad desc;

-- 42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
select
	r.rental_id,
	concat(c.first_name, ' ', c.last_name) as nombre_cliente
from
	rental r
join 
	customer c on r.customer_id = c.customer_id;

-- 43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
select
	concat(c.first_name, ' ', c.last_name) as nombre_cliente,
	r.rental_id
from
	customer c
left join
	rental r on c.customer_id = r.customer_id;

-- 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación
select
	*
from
	film f
cross join 
	category c;

-- No aporta valor porque devuelve todas las combinaciones posibles entre películas y categorías, sin tener en cuenta las relaciones reales.

-- 45. Encuentra los actores que han participado en películas de la categoría 'Action'.
select
	distinct concat(a.first_name, ' ', a.last_name) as nombre_actor
from
	actor a
join 
	film_actor fa on a.actor_id = fa.actor_id
join
	film f on fa.film_id = f.film_id
join
	film_category fc on f.film_id = fc.film_id
join
	category c on fc.category_id = c.category_id
where
	c."name" ilike 'Action';

-- 46. Encuentra todos los actores que no han participado en películas.
/* hacemos select count(*) as total_nulls
 * from film_actor
 * where actor_id is null; Comprobamos que no haya nulls en film_actor.actor_id, después ejecutamos lo siguiente
*/
select
	concat(a.first_name, ' ', a.last_name) as nombre_actor
from
	actor a
left join 
	film_actor fa on a.actor_id = fa.actor_id
where 
	 fa.actor_id is null;

-- 47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
select
	concat(a.first_name, ' ', a.last_name) as nombre_actor,
	count(fa.film_id)
from
	actor a 
join
	film_actor fa on a.actor_id = fa.actor_id
group by 
	a.first_name,
	a.last_name;

-- 48. Crea una vista llamada “actor_num_peliculasˮ que muestre los nombres de los actores y el número de películas en las que han participado.
create view actor_num_peliculas as
select
	concat(a.first_name, ' ', a.last_name) as nombre_actor,
	count(fa.film_id)
from
	actor a
join 
	film_actor fa on a.actor_id = fa.actor_id 
group by 
	a.actor_id;

-- 49. Calcula el número total de alquileres realizados por cada cliente.
select
	concat(c.first_name, ' ', c.last_name) as nombre_cliente,
	count(r.rental_id)
from
	customer c
join 
	rental r on c.customer_id = r.customer_id
group by
	c.customer_id;
	
-- 50. Calcula la duración total de las películas en la categoría 'Action'.
select
	c.name as categoria,
	sum(length) as duracion_total
from
	film f
join
	film_category fc on f.film_id = fc.film_id
join 
	category c on fc.category_id = c.category_id
where 
	c.name ilike 'action'
group by 
	c.category_id;
