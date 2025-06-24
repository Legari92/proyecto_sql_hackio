
-- 2. Muestra los nombres de todas las películas con una clasificación por edades de ‘Rʼ.
select
    title, "rating"
from
    film
where
	rating = 'R'
;

-- 3. Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 y 40.
select
	concat(first_name, ' ', last_name) as actor_name,
	a.actor_id
from
	actor a
where
	a.actor_id between 30 and 40
;

-- 4.Obtén las películas cuyo idioma coincide con el idioma original.
-- Todos los valores en original_language_id son NULL.
select 
  title,
  language_id,
  original_language_id
from 
	film
where  
	language_id = original_language_id; 
;

-- 5. Ordena las películas por duración de forma ascendente.
-- (asc es el orden por defecto así que no lo ponemos)
select
	title,
	length
from
	film
order by 
	length ;

-- 6. Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su apellido.
-- Usamos ilike para hacer la búsqueda sin que importen las minúsculas o mayúsculas.
select
	concat(first_name,' ', last_name) as actor_name
from
	actor
where
	last_name ilike 'allen';

-- 7. Encuentra la cantidad total de películas en cada clasificación de la tabla “filmˮ  y muestra la clasificación junto con el recuento
select
	 rating,
     count(*) as total_peliculas
from
	film
group by
	rating;

-- 8. Encuentra el título de todas las películas que son ‘PG-13ʼ o tienen un duración mayor a 3 horas en la tabla film.
select
	title,
	rating,
	length
from
	film
where
	rating = 'PG-13'
or
	length > 180; 

-- 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.
-- Incluimos mínimo, máximo y promedio para dar contexto a la varianza muestral.
select
	min(replacement_cost) as minimo,
	max(replacement_cost) as maximo,
	avg(replacement_cost) as promedio,
	var_samp(replacement_cost) as varianza_muestral
from
	film;

-- 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.
select
	max(length) as duracion_maxima,
	min(length) as duracion_minima
from
	film;
