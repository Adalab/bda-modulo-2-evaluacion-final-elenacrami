
# Evaluación Final Módulo 2

Este proyecto contiene el código creado en respuesta a los 25 ejercicios planteados en la *Evaluación Final Módulo 1* en un archivo sql titulado *soluciones_examen_mod2.sql* y se ha desarrollado con el uso del sistema de gestión de base de datos llamado MySQL.

![](https://github.com/elenacrami/mi_primer_repo/blob/main/Mysql_logo.png)

## Propósito:

El propósito de la creación del código es la comprobación de la adquisición de conocimientos básicos de MySQL en la creación, modificación e inserción de datos en una base de datos, a través de un uso correcto y fluido de los siguientes conceptos:

• Queries básicas: **SELECT, DISTINCT, FROM, LIMIT, OFFSET...**

• Queries avanzadas: **GROUP BY, HAVING, CASE...**

• Operadores de comparación: **IS NULL, NOT NULL**.

• Funciones agregadas: **COUNT(), SUM(), AVG(), MAX(), MIN()**.

• Operadores especiales de filtro: **UNION, UNION ALL, IN/NOT IN, LIKE/NOT LIKE, REGEXP**.

• Unión de tablas - Joins: **CROSS JOIN, INNER JOIN, NATURAL JOIN, RIGHT JOIN, LEFT JOIN, SELF JOIN**.

• Subconsultas y subconsultas correlacionadas

• CTE's: **WITH ... AS ...**

## Funcionalidad:
El código interactuará con la base de datos Sakila para:

**1. Obtener insights sobre el catálogo de películas** 

**2.Analizar el comportamiento de los clientes** 

**3.Optimizar el inventario**

**4.Mejorar las recomendaciones**

**5.Evaluar el impacto de nuevas películas**

**6.Optimizar la gestión del inventario**

**7.Segmentar la clientela**

**8.Tomar decisiones estratégicas**

El conjunto de consultas realizadas en este proyecto permite explorar la base de datos Sakila de diversas maneras, desde obtener información básica sobre películas y actores hasta realizar análisis más complejos sobre patrones de alquiler y características de las películas.

## Instalacion:
**1.Descarga el instalador:** Visita la página oficial de MySQL (https://dev.mysql.com/) y descarga el instalador correspondiente a tu sistema operativo (Windows, macOS, Linux).\

**2.Ejecuta el instalador:** Sigue las instrucciones del asistente de instalación, seleccionando las opciones que se adapten a tus necesidades.\

**3.Configura MySQL:** Una vez instalado, configura el servidor MySQL estableciendo una contraseña segura para el usuario root y otros parámetros necesarios.

Para obtener los resultados exactos, necesitarás ejecutar estas consultas en una base de datos SQL que contenga la estructura de Sakila. Las tablas y columnas específicas pueden variar ligeramente según la implementación, pero los conceptos generales y la lógica de las consultas se mantendrán.
## Conceptos básicos:

`MySQL`: sistema de gestión de bases de datos.

`BBDD (Bases de Datos)`: sistema organizado y estructurado que almacena grandes volumenes de información de manera eficiente, permitiendo la recuperación, actualización y gestión de datos de manera sistemática. Su estructura se compone de:


- `Tablas/entidades`: estructuras que almacenan datos en una bbdd.

- `Atributos/columnas`: campos individuales que describen los datos almacenados en la tabla

- `Registros/filas`: entradas individuales de datos almacenados en una tabla.

`Primary Key (PK)`: atributo/conjunto de atributos en una tabla que tienen identificación única y relación con otras tablas.

`Foreign Key (FK)`: atributo/conjunto de atributos en una tabla que establece una relación referencial con la clave primaria (PK) de otra tabla, garantizando que los datos estén relacionados correctamente.


## Orden de la sintáxis:

**1. SELECT** (una columna, varis columnas, * - todo)

**2. FROM** (tabla)

**3. JOIN** (para unir tablas)

**4. ON** (para especificar la condición que se utiliza para unir las tablas en una operación join)

**5. WHERE** (para establecer la condición por la que filtrar registros)

**6. GROUP BY** (para agrupar filas que tengan valores en común en columnas específicas)

**7. HAVING** (para filtrar grupos de datos que fueron agregados por GROUP BY)

**8. ORDER BY** (ASC / DESC)

**9. LIMIT** (para limitar el número de filas devueltas por la consulta)

## Ejemplos de sintáxis:

SELECT DISTINCT title AS NombrePelicula \
FROM film;


SELECT CONCAT(first_name, " ", last_name) AS NombreActor \
FROM actor \
WHERE actor_id BETWEEN 10 AND 20;


SELECT DISTINCT CONCAT(actor.first_name," ",actor.last_name) AS NombreActor \
FROM actor \
INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id \
INNER JOIN film ON film_actor.film_id = film.film_id \
WHERE film.title = 'Indian Love';

## Contacto:

[LinkedIn Profile](https://www.linkedin.com/in/elenacravenmiñarro)

<elena.crami@gmail.com>