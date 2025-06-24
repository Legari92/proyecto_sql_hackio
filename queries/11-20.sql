
-- 11.Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
select
	r.rental_date,
	p.amount as precio
from
	payment p
join
	rental r 
	on p.rental_id = r.rental_id
order by
 	r.rental_date
offset (
	select count(*) - 3 from rental
)
limit 1;

-- 12. Encuentra el título de las películas en la tabla “filmˮ que no sean ni ‘NC-17ʼ ni ‘Gʼ en cuanto a su clasificación
select
	title,
	rating
from
	film
where
	rating not in ('NC-17', 'G');

-- 13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla fila
-- y muestra la clasificación junto con el promedio de duración.
select
	rating,
	round(avg(length), 2) as duracion_media
from
	film
group by
	rating;

-- 14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
select
	title,
	length
from
	film
where
	length > 180;

-- 15. ¿Cuánto dinero ha generado en total la empresa?
select
	sum(amount) as ingresos_totales
from
	payment;

-- 16. Muestra los 10 clientes con mayor valor de id.
select
	customer_id,
	concat(first_name, ' ', last_name) as nombre_cliente
from
	customer
order by 
	customer_id desc
limit 10;

-- 17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igbyʼ.
select
	concat(a.first_name, ' ', a.last_name) as nombre_actor,
	f.title
from
	film f
join
	film_actor fa
	on f.film_id = fa.film_id
join
	actor a
	on	fa.actor_id = a.actor_id
where
	f.title ilike 'Egg Igby';

-- 18. Selecciona todos los nombres de las películas únicos.
select
	distinct title
from
	film;

-- 19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “filmˮ.
select
	title,
	length
from
	film f
join
	film_category fc
	on f.film_id = fc.film_id
join 
	category c
	on fc.category_id = c.category_id
where
	length > 180
	and
	c."name" ilike 'comedy';

-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos 
-- y muestra el nombre de la categoría junto con el promedio de duración.
select
	c.name,
	round(avg(length), 2) as promedio_duracion
from
	film f
join 
	film_category fc
	on f.film_id = fc.film_id
join 
	category c
	on fc.category_id = c.category_id
group by 
	c.name
having
	avg(length) > 110;
	