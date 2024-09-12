USE sakila;

/*1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.*/
SELECT DISTINCT title AS NombrePelicula
FROM film;

/*2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".*/
SELECT title  AS NombrePelicula
FROM film
WHERE rating = 'PG-13';

/*3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.*/
SELECT title AS TituloPelicula, description AS Descripcion
FROM film
WHERE description LIKE '%amazing%';

/*4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.*/
SELECT title AS TituloPelicula
FROM film
WHERE length > 120;

/*5. Recupera los nombres de todos los actores.*/
-- Solución con 'nombre' entendido como nombre + apellido:
SELECT CONCAT(first_name, " ", last_name) AS NombreActor
FROM actor;

/*6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.*/
SELECT CONCAT(first_name, " ", last_name) AS NombreActor
FROM actor
WHERE last_name IN ('Gibson');

/*7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.*/
SELECT CONCAT(first_name, " ", last_name) AS NombreActor
FROM actor
WHERE actor_id BETWEEN 10 AND 20;

/*8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.*/
SELECT title  AS TituloPelicula
FROM film
WHERE rating != 'PG-13' AND rating != 'R';

/*9. Encuentra la cantidad total de películas en cada clasificación de la tabla film 
y muestra la clasificación junto con el recuento.*/
SELECT COUNT(film_id) AS Recuento, rating AS Clasificacion
FROM film
GROUP BY rating;

/*10. Encuentra la cantidad total de películas alquiladas por cada cliente 
y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.*/
SELECT customer.customer_id AS IDCliente, 
       CONCAT(first_name, " ",last_name) AS NombreCliente, 
       COUNT(rental.rental_id) AS PeliculasAlquiladas
FROM customer
INNER JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id;

/*11. Encuentra la cantidad total de películas alquiladas por categoría 
y muestra el nombre de la categoría junto con el recuento de alquileres.*/
SELECT category.name AS NombreCategoria, COUNT(rental.rental_id) AS RecuentoAlquileres
FROM category
INNER JOIN film_category ON category.category_id = film_category.category_id
INNER JOIN inventory ON film_category.film_id = inventory.film_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY category.name;

/*12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film 
y muestra la clasificación junto con el promedio de duración.*/
SELECT AVG(length) AS PromedioDuracion, rating AS Clasificacion
FROM film
GROUP BY rating;

/*13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".*/
SELECT DISTINCT CONCAT(actor.first_name," ",actor.last_name) AS NombreActor
FROM actor
INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
INNER JOIN film ON film_actor.film_id = film.film_id
WHERE film.title = 'Indian Love';

/*14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.*/
-- Solución con comodines de LIKE (solución a corregir):
SELECT title AS TituloPelicula, description AS Descripcion
FROM film
WHERE description LIKE '%dog%' OR description LIKE '%cat%';

-- Solución con patrón REGEX:
SELECT title AS TituloPelicula, description AS Descripcion
FROM film
WHERE description REGEXP '(dog|cat)';

/*15. Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor.
El resultado de esta consulta nos devuelve una tabla-resultado vacía, 
indicando que todos los actores qua aparecen en la tabla film_actor están vinculados a al menos una película.*/
SELECT actor.actor_id, CONCAT(first_name, " ",last_name) AS NombreActor
FROM actor
LEFT JOIN film_actor ON actor.actor_id = film_actor.actor_id
WHERE film_actor.actor_id IS NULL;

/*16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.*/
SELECT title AS TituloPeliculas0510
FROM film
WHERE release_year BETWEEN 2005 AND 2010;

/*17. Encuentra el título de todas las películas que son de la misma categoría que "Family".*/
SELECT film.title AS TituloPeliculasFamily
FROM film
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Family';

/*18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.*/
SELECT CONCAT(first_name," ",last_name) AS NombreActor
FROM actor
INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id
HAVING COUNT(film_actor.film_id) > 10;

/*19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.*/
SELECT title AS TituloPelicula
FROM film
WHERE rating = 'R' AND length > 120;

/*20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos 
y muestra el nombre de la categoría junto con el promedio de duración.*/
SELECT category.name AS NombreCategoria, AVG(film.length) AS PromedioDuracion
FROM category
INNER JOIN film_category ON category.category_id = film_category.category_id
INNER JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name
HAVING AVG(film.length) > 120;

/*21. Encuentra los actores que han actuado en al menos 5 películas 
y muestra el nombre del actor junto con la cantidad de películas en las que han actuado.*/
SELECT CONCAT(first_name," ",last_name) AS NombreActor, COUNT(film_actor.film_id) AS TotalPeliculas
FROM actor
INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id
HAVING COUNT(film_actor.film_id) >= 5;

/*22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. 
Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes.*/

-- SIN TERMINAR
SELECT title AS TituloPelicula5dias, DATEDIFF(return_date, rental_date) AS DiasAlquilados
FROM film
WHERE film_id IN (
			SELECT inventory.film_id
			FROM inventory
			INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
            );
-- rental_id?

/*23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror".
Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" 
y luego exclúyelos de la lista de actores.*/
SELECT CONCAT(first_name," ",last_name) AS NombreActor
FROM actor
WHERE actor_id NOT IN (
		SELECT film_actor.actor_id
		FROM film_actor
		INNER JOIN film_category ON film_actor.film_id = film_category.film_id
		INNER JOIN category ON film_category.category_id = category.category_id
		WHERE category.name = 'Horror');

/*24. BONUS: 
Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film.*/
SELECT title AS TituloComedias
FROM film
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Comedy' AND length > 180;

/*25. BONUS: 
Encuentra todos los actores que han actuado juntos en al menos una película. 
La consulta debe mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos.*/
-- SIN TERMINAR
WITH  ActoresJuntos
AS (
	SELECT CONCAT(first_name, " ",last_name) AS NombreActores, XXX AS NombrePeliculas
	FROM
    INNER JOIN
    WHERE 
);

