
-- 51.  Crea una tabla temporal llamada “cliente_rentas_temporalˮ para almacenar el total de alquileres por cliente.
create temporary table cliente_rentas_temporal as
	select
		concat(c.first_name, ' ', c.last_name) as nombre_cliente,
		count(r.rental_id) as total_alquileres
	from
		customer c
	join
		rental r on c.customer_id = r.customer_id
	group by
		c.customer_id
		
-- 52. Crea una tabla temporal llamada “peliculas_alquiladasˮ que almacene las películas que han sido alquiladas al menos 10 veces.
create temporary table peliculas_alquiladas as
	select
		f.title as titullo,
		count(r.rental_id) as total_alquileres
	from
		film f
	join
		inventory i on f.film_id = i.film_id
	join 
		rental r on i.inventory_id = r.inventory_id
	group by 
		f.film_id, f.title
	having 
		count(r.rental_id) > 10
		
-- 53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sandersʼ y
-- que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.
select
	f.title
from
	customer c
join
	rental r on c.customer_id = r.customer_id
join 
	inventory i on r.inventory_id = i.inventory_id
join
	film f on i.film_id = f.film_id
where
	c.first_name ilike 'Tammy'
	and c.last_name ilike 'Sanders'
	and r.return_date is null
order by
	f.title;

-- 54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fiʼ. 
-- Ordena los resultados alfabéticamente por apellido.
select distinct
	a.first_name as nombre_actor,
	a.last_name as apellido_actor
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
	c.name ilike 'Sci-fi'
order by 
	a.last_name;

-- 55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus
-- Cheaperʼ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.
with alquiler_spartacus as(
	select
		min(r.rental_date) as fecha_primer_alquiler
	from
		film f 
	join 
		inventory i on f.film_id = i.film_id
	join 
		rental r on i.inventory_id = r.inventory_id
	where
		f.title ilike 'Spartacus Cheaper'
)
select distinct
	a.first_name as nombre_actor,
	a.last_name as apellido_actor
from
	actor a
join
	film_actor fa on a.actor_id = fa.actor_id
join 
	film f on fa.film_id = f.film_id
join 
	inventory i on f.film_id = i.film_id
join 
	rental r on i.inventory_id = r.inventory_id
where
	r.rental_date > (select fecha_primer_alquiler from alquiler_spartacus)
order by
	a.last_name;

-- 56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Musicʼ.
select
    a.first_name as nombre_actor,
    a.last_name as apellido_actor
from
    actor a
where
    a.actor_id not in (
        select
            fa.actor_id
        from
             film_actor fa
        join 
        	film f on fa.film_id = f.film_id
        join 
        	film_category fc on f.film_id = fc.film_id
        join 
        	category c on fc.category_id = c.category_id
        where
            c.name ilike 'Music'
)
order by
    a.last_name;

-- 57.  Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
select distinct
	f.title
from
	film f
join
	inventory i on f.film_id = i.film_id
join 
	rental r on i.inventory_id = r.inventory_id
where
	r.return_date - r.rental_date > interval '8 days';

-- 58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animationʼ.
select
	f.title
from
	film f
join
	film_category fc on f.film_id = fc.film_id
join
	category c on fc.category_id = c.category_id 
where
	c.name ilike 'Animation';

-- 59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Feverʼ. 
-- Ordena los resultados alfabéticamente por título de película.
select
	f.title
from
	film f
where 
	length = (
	select
		length
	from
		film
	where
		title ilike 'Dancing Fever'
)
order by
	f.title;

-- 60.  Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.
-- Si hubiésemos hecho count(r.rental_id) se podría dar el caso de que el cliente hubiese alquilado varias veces la misma película.
select
	concat(c.first_name, ' ', c.last_name) as nombre_cliente
from
	customer c
join 
	rental r on c.customer_id = r.customer_id
join 
	inventory i on r.inventory_id = i.inventory_id
group by
	c.customer_id
having
	count(distinct i.film_id) >= 7
order by
	c.last_name;