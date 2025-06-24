
-- 31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.
select 
 	f.title,
 	concat(a.first_name, ' ', a.last_name) as nombre_actor
from 
 	film f
left join
 	film_actor fa on f.film_id = fa.film_id
left join 
	actor a on fa.actor_id = a.actor_id;
	
 -- 32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.
select 
 	concat(a.first_name, ' ', a.last_name) as nombre_actor,
 	f.title
from 
 	actor a
left join
 	film_actor fa
 	 on a.actor_id = fa.actor_id 
left join 
	film f
	on fa.film_id = f.film_id;

-- 33. Obtener todas las películas que tenemos y todos los registros de alquiler.
select
	f.title,
	i.inventory_id,
	r.rental_id,
	r.rental_date,
	r.return_date,
	r.customer_id,
	r.staff_id
from
	film f
left join 
	inventory i
	on f.film_id = i.film_id
left join
	rental r
	on i.inventory_id = r.inventory_id;

-- 33B. En caso de que el ejercicio 33 se refiera a copias físicas.
select
	f.title,
	count(distinct i.inventory_id) as cantidad_copias,
	count(r.rental_id) as total_alquileres
from
	film f
left join 
	inventory i on f.film_id = i.film_id
left join
	rental r on i.inventory_id = r.inventory_id
group by
	f.title
order by
	total_alquileres desc;

-- 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.	
with info_pagos as(
	select 
		customer_id,
		sum(amount) as total_ventas
	from
		payment p
	group by
		customer_id
)
select 
	c.customer_id,
	concat(c.first_name, ' ', c.last_name) as nombre,
	ip.total_ventas
from	
	customer c
join 
	info_pagos ip on c.customer_id = ip.customer_id
order by 
	ip.total_ventas desc
limit 5;

-- 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.
select 
	a.first_name,
	a.last_name 
from 
	actor a
where a.first_name ilike 'Johnny';

-- 36. Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como Apellido.
-- Entre comillas para que sea case sensitive.
select 
	first_name as "Nombre",
	last_name as "Apellido"
from
	actor;

-- 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
select 
	min(actor_id) as actor_id_min,
	max(actor_id) as actor_id_max
from
	actor;

-- 38. Cuenta cuántos actores hay en la tabla “actorˮ.
select
	count(actor_id) as total_actores
from
	actor;

-- 39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.
select
	concat(last_name, ' ',first_name) as nombre_completo
from
	actor
order by
	last_name;

-- 40. Selecciona las primeras 5 películas de la tabla “filmˮ.
select
	film_id,
	title
from
	film
order by
	film_id
limit 5;