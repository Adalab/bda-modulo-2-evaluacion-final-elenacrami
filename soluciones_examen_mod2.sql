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
WHERE description LIKE '%dog%' OR description LIKE '%cat%'; -- Hago uso del comodín '%' que representa cero o más caracteres para establecer el criterio por el que quiero que encuentre los valores.

-- Solución con patrón REGEX:
SELECT title AS TituloPelicula, description AS Descripcion
FROM film
WHERE description REGEXP '(dog|cat)'; -- Hago uso de expresiones regulares REGEX con un patrón específico. 
-- La barra vertical funciona como un operador "o", y los paréntesis agrupan elementos para aplicar operadores a un conjunto completo.

/*15. Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor.
El resultado de esta consulta nos devuelve una tabla-resultado vacía, 
indicando que todos los actores qua aparecen en la tabla film_actor están vinculados a al menos una película.*/
SELECT actor.actor_id, CONCAT(first_name, " ",last_name) AS NombreActor
FROM actor
LEFT JOIN film_actor ON actor.actor_id = film_actor.actor_id -- Combino las filas de la tabla izquierda con las coincidencias de la derecha.
WHERE film_actor.actor_id IS NULL; -- Establezco la condición de que me la tabla-resultado sólo incluya los registros con valores nulos.

/*16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.*/
SELECT title AS TituloPeliculas0510
FROM film
WHERE release_year BETWEEN 2005 AND 2010; -- Hago uso de la cláusula 'BETWEEN' para seleccionar los registros con datos numéricos que se encuentren en ese rango específico.

/*17. Encuentra el título de todas las películas que son de la misma categoría que "Family".*/
SELECT film.title AS TituloPeliculasFamily
FROM film
INNER JOIN film_category ON film.film_id = film_category.film_id -- Combino filas con coincidencia en ambas tablas aun cuando los nombres de las columnas no sean identicos.
INNER JOIN category ON film_category.category_id = category.category_id -- Para ello necesitaré hacer uso de la palabra reservada 'ON'.
WHERE category.name = 'Family';

/*18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.*/
SELECT CONCAT(first_name," ",last_name) AS NombreActor
FROM actor
INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id
HAVING COUNT(film_actor.film_id) > 10; -- La cláusula HAVING, a diferencia de WHERE, permite contener funciones agregadas.

/*19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.*/
SELECT title AS TituloPelicula -- Asigno un alias al nombre de la columna con 'AS' para mejorar la legibilidad de las consultas.
FROM film
WHERE rating = 'R' AND length > 120; -- Indico las condiciones a través de la cuales quiero que se filtren los resultados de la subconsulta, especificando valores y columnas concretas.

/*20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos 
y muestra el nombre de la categoría junto con el promedio de duración.*/
SELECT category.name AS NombreCategoria, AVG(film.length) AS PromedioDuracion
FROM category
INNER JOIN film_category ON category.category_id = film_category.category_id
INNER JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name -- Agrupo los registros por la columna 'name' en la tabla 'category'.
HAVING AVG(film.length) > 120; -- Filtro los grupos de datos a través de la columna 'length' en la tabla 'film', donde la duración sea mayor de 120 minutos.

/*21. Encuentra los actores que han actuado en al menos 5 películas 
y muestra el nombre del actor junto con la cantidad de películas en las que han actuado.*/
SELECT CONCAT(first_name," ",last_name) AS NombreActor, COUNT(film_actor.film_id) AS TotalPeliculas -- Hago uso de la función agregada 'COUNT()' para contar el número de filas que contiene la columna 'film_id'.
FROM actor
INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id
HAVING COUNT(film_actor.film_id) >= 5;

/*22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. 
Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes.*/

SELECT DISTINCT title AS TituloPelicula5dias -- Hago uso de la cláusula DISTINCT para que el resultado no me devuelva los nombres de las películas repetidos.
FROM film
INNER JOIN inventory ON film.film_id = inventory.film_id -- Conecto la tabla film a través de su Primary Key con la tabla intermedia inventory para poder establecer la el puento de conexión con la tabla rental.
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id -- Conecto la tabla rental para poder acceder a los id de alquiler de las películas.
WHERE rental_id IN ( -- Es en rental_id donde enlazo mi subconsulta con mi consulta principal.
			SELECT rental_id
            FROM rental
            WHERE DATEDIFF(return_date, rental_date) > 5); -- Realizo la operación de sustracción entre la fecha en la que la película fue alquilada y la fecha en la que fue devuelta con el uso de la cláusula "DATEDIFF".
            
/*23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror".
Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" 
y luego exclúyelos de la lista de actores.*/
SELECT CONCAT(first_name," ",last_name) AS NombreActor -- Selecciono la información de las columnas que quiero mostrar, concatenando los valores de ambas con "CONCAT()" y aplicándoles un alias con "AS".
FROM actor
WHERE actor_id NOT IN ( -- Enlazo la subconsulta con la consulta principal.
		SELECT film_actor.actor_id
		FROM film_actor
		INNER JOIN film_category ON film_actor.film_id = film_category.film_id -- Establezco la primera unión con la tabla film_category y especifíco la condición que una ambas tablas.
		INNER JOIN category ON film_category.category_id = category.category_id
		WHERE category.name = 'Horror'); -- Indico la condición a través de la cual quiero que se filtren los resultados de la subconsulta, especificando un valor y columna concretos.

/*24. BONUS: 
Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film.*/
SELECT title AS TituloComedias
FROM film
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Comedy' AND length > 180; -- Indico las dos condiciones por las que quiero filtrar mis resultados, indicando valores concretos a las columnas de categoría y duración.

/*25. BONUS: 
Encuentra todos los actores que han actuado juntos en al menos una película. 
La consulta debe mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos.*/
WITH  ColaboracionActores AS (
	SELECT 
    CONCAT(a1.first_name, " ",a1.last_name) AS NombreActor1, -- Diferencio las concatenaciones de los nombres y apellidos con alias para poder distinguir ambos actores.
    CONCAT(a2.first_name, " ",a2.last_name) AS NombreActor2,  -- Ambas cláusulas CONCAT() devolverán el nombre completo de los dos actores que han trabajado juntos.
    COUNT(*) AS NumeroPeliculas -- Devolverá el número de películas en las que ambos actores han colaborado.
	FROM film_actor fa1
    INNER JOIN film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id -- Hago uso de la condición fa1.actor_id < fa2.actor_id para evitar contar las mismas parejas dos veces
    INNER JOIN actor a1 ON fa1.actor_id = a1.actor_id
    INNER JOIN actor a2 ON fa2.actor_id = a2.actor_id
    GROUP BY a1.first_name, a1.last_name, a2.first_name, a2.last_name
    HAVING COUNT(*) >= 1) -- Aseguro que solo se incluyan los actores que han trabajado juntos al menos una vez.

SELECT *
FROM ColaboracionActores; -- Llamamos a la CTE a realizar la consulta.
