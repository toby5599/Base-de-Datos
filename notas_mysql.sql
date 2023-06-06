--1) 

CREATE DATABASE users;

--2)

CREATE TABLE usuarios (
	id int(11) AUTO_INCREMENT,
    name varchar(50) NOT NULL,
    lastname varchar(50) NOT NULL,
    fecha_nacimiento DATETIME NULL,
    PRIMARY KEY (id)
)

--si queremos elegir una base de datos que vamos a trabajar ya que no nos deja añadir elementos
USE users

--si queremos borrar una tabla o base de datos
DROP TABLE users; 
DROP DATABASE users;


--si queremos insertar datos
SELECT * FROM users  --para seleccionar todo los elementos de la tabla usuarios
INSERT INTO users (nombre,apellido,edad)--para insertar datos
VALUES ('Tobias','Benitez','23') --los valores que queremos agregar

--para añadir una columna a una tabla
ALTER TABLE usuarios ADD COLUMN edad int NULL;

--para modificar
ALTER TABLE usuarios MODIFY COLUMN varchar(30) NULL;

--si queremos insertar un dato
UPDATE usuarios
SET edad = 25
WHERE id = '1'

--eleminar una columna de una tabla
alter table individuos drop column rol

--creacion de una clave foranea

CREATE TABLE publicaciones (
    id int(11) NOT NULL AUTO_INCREMENT
    auto_id int(11) NOT NULL,
    titulo varchar(150) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (autor_id) REFERENCES usuarios(id) --usuarios es la tabla
)

-- si queremos añadir una columna como llave foranea que relacione otra tabla a traves de la id

alter table miembros
add column oficios int,
add foreign key (oficios) references roles (oficio_id)


--varios elementos
UPDATE turnos_medicos
SET horario = "10:30", motivo = "dolor de cabeza"
where id_turno = 2;

--para cambiarle el nombre temporalmente, sin cambiarlo realmente
SELECT LastName AS apellido FROM Employees

SELECT FirstName AS nombre, LastName AS apellido FROM Employees

--si queremos seleccionar la misma tabla dos veces y a la segunda la multiplicamos por dos y le cambiamos el nombre
SELECT Price,Price*2 AS precio_doble FROM Products

--si queremos order los precios de forma ascendente o descendente
ORDER BY Price ASC -- DESC

-- Muestra el número de filas de la tabla departments.
SELECT COUNT(*) FROM departments;

-- Selecciona los valores de los títulos de la tabla titles, pero no muestra
-- duplicados.
SELECT DISTINCT title FROM titles;

--JERARQUIA

--1) valores numericos
--2) valores de cadena - de caracteres se ordenan lexicograficamente
--3) valores nulos
--4) otros tipos de datos: fechas, valores booleanos y otros.


--EJERCICIO crear dos tablas donde se relacionen a traves de una llave foranea

create table miembros (
	id int(11) auto_increment,
    nombre varchar(50) not null,
    apellido varchar(50) not null,
    edad int(11) not null,
    oficio int(11),
    foreign key (oficio) references roles(oficio_id), -- esto se agrega luego de crear la segunda tabla
    primary key (id)
);

--como modificamos esa columna
alter table miembros ADD CONSTRAINT oficio FOREIGN KEY (oficio) REFERENCES roles(oficio_id);

create table roles (
	oficio_id int(11) auto_increment,
    trabajo varchar(50) not null,
    tiempo varchar(50) not null,
    primary key (oficio_id)
)




--si queremos que cambie el orden de manera aleatoria
SELECT * FROM people
ORDER BY RAND() --NO EXISTE NULLS LAST A PARTE ES RAND() NO RANDOM()

--podemos elegir varios

SELECT * FROM Products
ORDER BY ProductName, ProductID

--si hay valores que se repiten y queremos que nos muestre los valores unicos, es decir, los valores no duplicados
SELECT DISTINCT name FROM people  --elegimos primero la columna y luego la tabla

--CLAUSURAS (WHERE)
SELECT * FROM people
WHERE name = 'tobias'

--menor a...
SELECT * FROM people
WHERE age < 30

--si queremos eliminar un dato
DELETE FROM turnos_medicos
WHERE id_turno = 3



--Operadores logicos (AND, OR, NOT)

--AND
SELECT * FROM people
WHERE age >= 10 AND AGE <= 25


--OR
SELECT * FROM people
WHERE name = "tobias" OR name = "Anne"

--algo mas complicado - lo que esta dentro del parentesis se pueden cumplirse los dos, pero el AND siempre se va a reestringir 
WHERE (Price < 20 OR CategoryID = 6) AND SupplierID = 7

--NOT -aca simplificamos no utilizar tantos OR
SELECT * FROM people
WHERE NOT name = "tobias"

--aca simplificamos no utilizar tantos OR
SELECT * FROM Customers
WHERE NOT Country = "USA"

--de esta manera escogemos los cinco primeros, establecemos un limite
SELECT * FROM Customers
WHERE CustomerID >= 50 AND NOT Country = "Germany" LIMIT 5


--EJERCICIO 1
SELECT * FROM Products
WHERE NOT CategoryID = 6
AND NOT SupplierID = 1
AND Price <= 30
ORDER BY RAND()
LIMIT 3


--BETWEEN - nos da los numeros entre 20 y 40
SELECT * FROM Products WHERE Price BETWEEN 20 AND 30

--LIKE

-- % - una empieze con algo, termine con algo o que contenga algo

--nos verifica que este esa letra
SELECT * FROM Employees WHERE LastName LIKE "%r%"

--si lo ponemos asi la R esta al final
SELECT * FROM Employees WHERE LastName LIKE "%r"

--otra manera con el nombre "Fuller" debe tener la cantidad de guiones bajos como letras tiene

SELECT * FROM Employees WHERE LastName LIKE "%F____r"

SELECT * FROM Employees WHERE LastName LIKE "%_u____"

SELECT * FROM Employees WHERE LastName LIKE "%F__%"


--IS NULL o IS NOT NULL

--si queremos que nos devuelva solamente los nulos

SELECT * FROM Products 
WHERE ProductName IS NULL
ORDER BY ProductID DESC

--si no queremos que nos devueva los nulos

SELECT * FROM Products 
WHERE ProductName IS NOT NULL
ORDER BY ProductID DESC


--IN

--en vez de poner esto

SELECT * FROM Products 
WHERE SupplierID = 3
OR SupplierID = 4
OR SupplierID = 5
OR SupplierID = 6

--mas abreviado
SELECT * FROM Products 
WHERE SupplierID IN (3,4,5,6)

--otro ejemplo
SELECT * FROM Employees
WHERE LastName IN ("Fuller","King")



--FUNCIONES

--para saber la cantidad de empleados o de filas que hay firstname 
SELECT count(FirstName) FROM Employees

--SUM() - si queremos sumar todos los precios
SELECT SUM(Price) FROM Products

--AVG() - nos devuelve el promedio
SELECT AVG(Price) FROM Products

--ROUND() - es para redondear, el 2 es para decirle la cantidad de decimales y as para cambiarle el nombre a la columna
SELECT ROUND(AVG(Price),2) AS promedio FROM Products

--MIN() - para saber el precio minimo
SELECT MIN(Price) AS precio_minimo FROM Products


--GROUP BY -- separa los grupos segun si hay elementos iguales, los pone en un grupo distinto a los demas

--saca el promedio de cada grupo, los que tengan supplierID con el mismo numero los junta en un grupo y les saca el promedio
SELECT SupplierID, ROUND(AVG(Price)) AS promedio FROM Products GROUP BY SupplierID
ORDER BY promedio DESC

--MAL-si queremos que nos muestre el promedio mayores a 40 de esta manera da error
SELECT SupplierID, ROUND(AVG(Price)) AS promedio FROM Products
WHERE Promedio > 40
GROUP BY SupplierID

--BIEN-hay que utilizar HAVING porque filtra grupos no elementos
SELECT SupplierID, ROUND(AVG(Price)) AS promedio FROM Products
GROUP BY SupplierID
HAVING promedio > 40

--si queremos elegir dos filas de un inner join, para que funcione:

select p.ProductID, SUM(Quantity) from products p
inner join orderdetails o on p.ProductID = o.ProductID
where p.ProductID = 11 or p.ProductID = 12
group by p.ProductID


--EJERCICIO 2
SELECT ProductID, SUM(Quantity) AS total FROM OrderDetails
GROUP BY ProductID
ORDER BY total DESC
LIMIT 1


--ORDEN DE PROCEDIMINETO
SELECT... FROM...
WHERE...
GROUP BY...
HAVING...  -- si utilizamos group by no podemos usar where, hay que usar HAVING
ORDER BY...
LIMIT...

--¡IMPORTANTE! NO PODEMOS AGREGAR UNA FUNCION DE AGREGACION DENTRO DE OTRA FUNCION DE AGREGACION
MAX(SUM(PRECIO))  --ESTO NO SE PUEDE HACER PERO SI CON SUBCONSULTAS

--como solucionamos esto:

select max(sumatoria) as max_sumatoria from (select p.ProductID, sum(Quantity) as sumatoria from products p  --importante el max_sumatoria y subquery
inner join orderdetails o on p.ProductID = o.ProductID
group by p.ProductID) as subquery

--otra forma de cambiarle el nombre es:
FROM OrderDetails as OD




--SUBCONSULTAS (HACER CONSULTAS DE OTRAS TABLAS)

select EmployeeID,FirstName,sueldo from employees e
where sueldo < (select AVG(Recompensa) from recompensas r WHERE e.EmployeeID = r.EmpleadoID)

--lo mismo pero utilizando JOIN:

SELECT EmployeeID,FirstName,sueldo FROM employees e
JOIN recompensas r ON e.EmployeeID = r.EmpleadoID
WHERE sueldo < (SELECT AVG(Recompensa) FROM recompensas);

--aca sin el join solamente hace la comparacion del sueldo de la tabla A sea menor al promedio de la recompensa de la tabla B, pero si utilizamos el JOIN solo se va a tener en cuenta las mismas ID, es decir, si la tabla A tiene seis ID y la segunda 8 ID se van a mostrar solamente 6 ID(si son las mismas).

SELECT EmployeeID, FirstName, sueldo
FROM employees e
WHERE sueldo < (SELECT AVG(Recompensa) FROM recompensas);


--otra subconsulta: en este caso hay dos condiciones primero que los numeros de autor_id este en la id de la otra tabla y la segundo condicion que todas las id de la segunda tabla, el nombre empiece con L
select * from curso.publicaciones where autor_id IN (
    select id from curso.usuarios where nombre like 'L%'
)

--otra subconsulta: la subconsulta mas comun por que es la misma tabla nada mas que se le aplica dos funciones a la misma columna

select max(sumatoria) as sumatoria_max from (select ProductID,SUM(Price) as sumatoria from products
group by ProductID) as consulta_1


--JOINS - PARA COMBINAR LA INFORMACION DE DOS BASES DE DATOS O MAS, PERO QUE LA INFORAMCION SE DEVUELVA EN UNA SOLA TABLA

--INTERSECCION
--de esta manera esta fucionando(interseccion) la tabla employees con la tabla orders, con inners joins va a hacer una interseccion entre las dos tablas como si fueran dos conjuntos tabla a y tabla b
SELECT LastName, FirstName, OrderID FROM Employees e
INNER JOIN Orders o ON e.EmployeeID = o.EmployeeID --si utilizamos el on ahi es cuando hacemos la interseccion entre las dos tablas.
--interseccion entre Employees con Orders: En un INNER JOIN, las filas de la tabla resultante contendrán las columnas de ambas tablas involucradas en la operación, pero solo mostrará las filas que cumplen con la condición de igualdad establecida. Las filas que no tienen coincidencias en ambas tablas no se incluirán en el resultado.


--MOSTRAR TABLA A
--de esta manera nos devuelve todos los elementos de la tabla a, aunque no haya datos relacionados entre las dos tablas igualmente te va a mostrar todo los elementos de la tabla a
SELECT FirstName,Recompesa,Mes FROM Employees e
LEFT JOIN Recompensas r ON e.EmployeeID = r.EmpleadoID

--MOSTRAR TABLA B
--con la tabla derecha
SELECT FirstName,Recompesa,Mes FROM Employees e
RIGHT JOIN Recompensas r ON e.EmployeeID = r.EmpleadoID


--full join

SELECT FirstName,Recompesa,Mes FROM Employees e
LEFT JOIN Recompensas r ON e.EmployeeID = r.EmpleadoID

UNION

SELECT FirstName,Recompesa,Mes FROM Employees e
RIGHT JOIN Recompensas r ON e.EmployeeID = r.EmpleadoID

--UNION ALL - DEVULEVE LA SUMA DE LAS DOS TABLAS SI EN LA PRIMERA TABLA HAY 6 ELEMENTOS Y EN LA SEGUNDA 4 ELEMENTOS CON UNION ALL VA A DEVOLVER 10 ELEMENTOS MAS ALLA DE QUE HAYA UNA RELACION ENTRE LOS ELEMENTOS

--UNION - SI HAY ELEMENTOS REPETIDOS EN LAS DOS TABLAS LOS SACA DEJANDO UNO QUEDANDO ASI MAS CHICA A LA TABLA

--otra ejemplo de utilizacion de UNION, cuando queremos hacer dos consultas

SELECT FirstName FROM employees where FirstName like 'J%'
UNION
SELECT FirstName FROM employees where FirstName like 'A%'

--tambien se puedo hacer lo mismo asi:
SELECT FirstName FROM employees where FirstName like 'J%' or FirstName like 'A%'


-- si queremos que nos se repitan los datos ponemos:
SELECT FirstName,Recompesa,Mes FROM Employees e
LEFT JOIN Recompensas r ON e.EmployeeID = r.EmpleadoID

UNION DISTINCT

SELECT FirstName,Recompesa,Mes FROM Employees e
RIGHT JOIN Recompensas r ON e.EmployeeID = r.EmpleadoID


--esto esta mal:

select * from products p
inner join orderdetails o on p.ProductID = o.ProductID
where ProductID = 11

--



--DISTINTOS MODELOS PARA REPRESENTAR ENTIDADES(TABLAS)

-- bbdd modelo relacional
-- bbdd modelo relacional cardinalidad: esta la notacion de Chen y la notacion de Martin



--PARA CREAR INDICES

--te muestra todos los valores repetidos pero sirve para hacer consultas mas rapido
CREATE INDEX nombre ON Products (ProductName)

--te permite identificar a la fila, y que en este caso no haya valores duplicados a parte de hacer consultas mas rapido
CREATE UNIQUE INDEX name ON Employees (FirstName,LastName)  --firstname puede tener el mismo nombre pero lastname no puede ser igual y viceversa



--VISTAS

--si seleccionamos tres columnas de una tabla y siempre estamos trabajando con esas tres, podemos crear una vista o una variable que guarde esas tres columnas

CREATE VIEW productos_simplificados AS

SELECT ProductID,ProductName,Price FROM Products
WHERE ProductID > 20
ORDER BY ProductID DESC

--la llamamos como si fuera una tabla

SELECT * FROM productos_simplificados

--si queremos eliminar la vista

DROP VIEW IF EXISTS productos_simplificados  --verifica si existe para no tirar errores

DROP VIEW productos_simplificados  --elimina sin preguntar pero tira error si es que existe






--FUNCIONES

--Funciones de cadena:
-- CONCAT: Concatena dos o más cadenas.
-- SUBSTRING: Extrae una subcadena de una cadena.
-- LENGTH: Devuelve la longitud de una cadena.
-- UPPER: Convierte una cadena a mayúsculas.
-- LOWER: Convierte una cadena a minúsculas.
-- TRIM: Elimina espacios en blanco al principio y al final de una cadena.

-- Funciones numéricas:
-- SUM: Calcula la suma de los valores de una columna numérica.
-- AVG: Calcula el promedio de los valores de una columna numérica.
-- MAX: Devuelve el valor máximo de una columna numérica.
-- MIN: Devuelve el valor mínimo de una columna numérica.
-- ROUND: Redondea un número al número de decimales especificado.
-- CEILING: Redondea un número hacia arriba al entero más cercano.
-- FLOOR: Redondea un número hacia abajo al entero más cercano.
-- TRUNCATE: Trunca un número a un número específico de decimales

-- funciones matemáticas
-- ABS: Devuelve el valor absoluto de un número.
-- POWER: Eleva un número a una potencia específica.
-- SQRT: Devuelve la raíz cuadrada de un número.
-- MOD: Devuelve el residuo de la división de dos números.

-- Funciones de redondeo hacia cero:
-- TRUNC: Trunca un número a un número entero sin decimales.
-- SIGN: Devuelve el signo de un número (-1, 0 o 1).
-- ROUND: Redondea un número al entero más cercano o al número de decimales especificado.

-- Funciones de fecha y hora:
-- NOW: Devuelve la fecha y hora actual.
-- CURDATE: Devuelve la fecha actual.
-- CURTIME: Devuelve la hora actual.
-- DATE_FORMAT: Formatea una fecha según el formato especificado.
-- DATEDIFF: Calcula la diferencia en días entre dos fechas.

-- Funciones de control de flujo:
-- IF: Realiza una evaluación condicional y devuelve un resultado en función de la condición.
-- CASE: Realiza evaluaciones condicionales múltiples y devuelve un resultado en función de las condiciones cumplidas.


-- Funciones de agregación:
-- COUNT: Cuenta el número de filas o valores no nulos en una columna.
-- GROUP_CONCAT: Concatena valores en una sola cadena, agrupados por una columna.
-- HAVING: Filtra los resultados de una consulta después de aplicar la cláusula GROUP BY.

-- Funciones de manipulación de fechas y horas:
-- DATE_ADD: Agrega una cantidad de tiempo a una fecha.
-- DATE_SUB: Resta una cantidad de tiempo a una fecha.
-- DATE_FORMAT: Formatea una fecha en un formato específico.
-- EXTRACT: Extrae una parte específica de una fecha (año, mes, día, hora, etc.).

-- Funciones de manipulación de cadenas:
-- LEFT: Devuelve un número específico de caracteres desde el principio de una cadena.
-- RIGHT: Devuelve un número específico de caracteres desde el final de una cadena.
-- REPLACE: Reemplaza todas las ocurrencias de una subcadena en una cadena por otra subcadena.
-- SUBSTRING_INDEX: Devuelve una subcadena de una cadena hasta una ocurrencia específica de un delimitador.

-- Funciones de control de flujo avanzadas:
-- COALESCE: Devuelve el primer valor no nulo de una lista de expresiones.
-- IFNULL: Devuelve un valor si una expresión es nula; de lo contrario, devuelve la expresión en sí.
-- CASE: Permite realizar evaluaciones condicionales complejas con múltiples resultados posibles.