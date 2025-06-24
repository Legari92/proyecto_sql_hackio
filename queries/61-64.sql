
-- 61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
select
	c.name as categoria,
	count(r.rental_id) as total_alquileres
from
	category c
join 
	film_category fc on c.category_id = fc.category_id
join
	film f on fc.film_id = f.film_id
join
	inventory i on f.film_id = i.film_id
join
	rental r on i.inventory_id = r.inventory_id
group by
	c.name
order by
	total_alquileres desc;
   
-- 62. Encuentra el número de películas por categoría estrenadas en 2006.
select
	c.name as categoria,
	count(f.film_id) as peliculas_totales
from
	film f
join
	film_category fc on f.film_id = fc.film_id
join 
	category c on fc.category_id = c.category_id
where 
	f.release_year = '2006'
group by 
	c.name 
order by
	peliculas_totales desc;

-- 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
select
	*
from
	store st
cross join
	staff sf;

-- 64. Encuentra la cantidad total de películas alquiladas por cada cliente y  muestra el ID del cliente,
-- su nombre y apellido junto con la cantidad de películas alquiladas.
select
	c.customer_id,
	concat(c.first_name, ' ', c.last_name) as nombre_cliente,
	count(r.rental_id) as peliculas_alquiladas
from
	customer c
join 
	rental r on c.customer_id = r.customer_id
group by
	c.customer_id
order by 
	peliculas_alquiladas desc;