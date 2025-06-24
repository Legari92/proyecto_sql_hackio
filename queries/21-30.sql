

-- 21. ¿Cuál es la media de duración del alquiler de las películas?

select
  round(avg(date(return_date) - date(rental_date)), 2) as media_duracion_dias
from
  rental;

-- 22. Crea una columna con el nombre y apellidos de todos los actores y actrices.
select
	concat(first_name, ' ', last_name) as nombre_completo
from
	actor;

-- 23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
select 
	date(rental_date) as fecha_alquiler,
	count(*) as total_alquileres
from
	rental
group by
	fecha_alquiler
order by
	total_alquileres desc;

-- 24. Encuentra las películas con una duración superior al promedio.
with promedio as(
	select
		avg(length) as media
	from
		film
)
select 
	title,
	f.length,
	p.media
from
	film f,
	promedio p
where
	f.length > p.media;

-- 25. Averigua el número de alquileres registrados por mes.
select
	to_char(rental_date, 'YYYY-MM') as mes,
	count(*)
from
	rental
group by
	to_char(rental_date, 'YYYY-MM');

-- 26. Encuentra el promedio, la desviación estándar y varianza del total pagado.
with promedio as(
	select
		round(avg(amount), 2) as valor_promedio,
		round(stddev(amount), 2) as desviacion_estandar,
		round(var_samp(amount), 2) as varianza,
		round(min(amount), 2) as minimo,
		round(max(amount), 2) as maximo
	from 
		payment
)
select 
	valor_promedio,
	desviacion_estandar,
	varianza,
	minimo,
	maximo
from
	promedio;

-- 27. ¿Qué películas se alquilan por encima del precio medio?
with precio as(
	select 
		round(avg(rental_rate), 2) as precio_medio
	from 
		film f
)		
select
	title,
	rental_rate as precio_alquiler
from 
	film f,
	precio p
where
	rental_rate > precio_medio;

-- 28. Muestra el id de los actores que hayan participado en más de 40 películas.
with peliculas_por_actor as(
	select 
		actor_id,
		count(*) as peliculas_totales
	from
		film_actor fa
	group by
	fa.actor_id
)		
select 
	ppa.actor_id,
	concat(a.first_name, ' ', a.last_name) as nombre,
	peliculas_totales
from
	peliculas_por_actor ppa
join 
	actor a
	on ppa.actor_id = a.actor_id
where
	ppa.peliculas_totales > 40;

-- 29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.
select
	f.title,
	count(i.inventory_id) as cantidad_disponible
from 
	film f
left join 
	inventory i
	on f.film_id = i.film_id
group by 
	title;

-- 30. Obtener los actores y el número de películas en las que ha actuado.
	select 
		a.actor_id,
		concat(a.first_name, ' ', a.last_name) as nombre,
		count(title) as apariciones
	from
		film f
	join 
		film_actor fa on f.film_id = fa.film_id
	join
		actor a on fa.actor_id = a.actor_id
	group by 
		a.actor_id, a.first_name, a.last_name;



	
	
