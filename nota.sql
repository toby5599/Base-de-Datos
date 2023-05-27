CREATE TABLE "users" (
	"nombre"	TEXT,
	"apellido"	TEXT,
	"edad"	INTEGER
);
--MYSQL

CREATE TABLE usuarios (
	id int(11) AUTO_INCREMENT,
    name varchar(50) NOT NULL,
    lastname varchar(50) NOT NULL,
    fecha_nacimiento DATETIME NULL,
    PRIMARY KEY (id)
)

--MYSQL
--si queremos elegir una base de datos que vamos a trabajar ya que no nos deja añadir elementos
USE users

--MYSQL
CREATE DATABASE users;

--MYSQL
--SI QUEREMOS DESECHAR UNA TABLA
DROP TABLE users;

SELECT * FROM users  --para seleccionar todo los elementos de la tabla usuarios

INSERT INTO users --para insertar datos

VALUES ('Tobias','Benitez','23') --los valores que queremos agregar

--MYSQL
--para añadir una columna a una tabla
ALTER TABLE usuarios ADD COLUMN edad int NULL;
--para modificar
ALTER TABLE usuarios MODIFY COLUMN varchar(30) NULL;


--si queremos agregar varios valores, utilizamos la coma

INSERT INTO usuarios (nombre,apellido,edad)
VALUES	('pedro','jorge',32),
		('juan','penelope',25),
		('atila','benitez',25)

--MYSQL
INSERT INTO usuarios (name,lastname,fecha_nacimiento)
VALUES ('Tobias','Benitez','1999-02-06'),
		('pedro' ,'martinez','2022-04-04');


--si queremos eliminar todos los usuarios

DELETE FROM usuarios

--si queremos añadir mas de una intruccion

INSERT INTO usuarios (nombre,apellido,edad)
VALUES ('tobias','benitez',23);

SELECT * FROM usuarios

--SQL
--si queremos insertar un dato
UPDATE usuarios
SET edad = 25
WHERE id = '1'

PK (PRIMARY KEY) -- CAMPO QUE SIRVE PARA INDETIFICAR REGISTROS
FK (FOREIGN KEY) -- CAMPO QUE HACE REFERENCIA A UNA PRIMARY KEY DE OTRA TABLA


--para cambiarle el nombre temporalmente, sin cambiarlo realmente
SELECT LastName AS apellido FROM Employees

SELECT FirstName AS nombre, LastName AS apellido FROM Employees

--si queremos seleccionar la misma tabla dos veces y a la segunda la multiplicamos por dos y le cambiamos el nombre
SELECT Price,Price*2 AS precio_doble FROM Products

--si queremos order los precios de forma ascennte o descente

ORDER BY Price ASC -- DESC


--JERARQUÍA

-- 1) LETRAS
-- 2) CARACTERES ESPECIALES
-- 3) NUMEROS
-- 4) NULL

--si queremos que los nulls se muestren al final

SELECT * FROM Products

ORDER BY ProductName ASC NULLS LAST

--EN MYSQL NO EXISTE NULLS LAST

--si queremos que cambie el orden de manera aleatoria, pero no respeta NULLS LAST

SELECT * FROM Products

ORDER BY RANDOM() NULLS LAST

--MYSQL
SELECT * FROM people
ORDER BY RAND() --NO EXISTE NULLS LAST A PARTE ES RAND() NO RANDOM()

--podemos elegir varios

SELECT * FROM Products

ORDER BY ProductName, ProductID

--si hay valores que se repiten y queremos que nos muestre los valores unicos, es decir, los valores no duplicados

SELECT DISTINCT ProductName FROM Products

--si queremos que sea aleatorio

SELECT DISTINCT ProductName

FROM Products ORDER BY RANDOM()



--CLAUSURAS (WHERE)

SELECT ProductName FROM Products
WHERE ProductID = 14

--otra forma

SELECT * FROM Products
WHERE ProductName = "Tofu"

--que menores a 

SELECT * FROM Products
WHERE Price < 40

--si queremos eliminar un dato

DELETE FROM turnos_medicos
WHERE id_turno = 3

--si queremos modificar un dato

UPDATE turnos_medicos SET horario = "10:30"
WHERE id_turno = 2

--varios elementos

UPDATE turnos_medicos
SET horario = "10:30", motivo = "dolor de cabeza"
where id_turno = 2;

SELECT * FROM turnos_medicos


--Operadores logicos (AND, OR, NOT)

SELECT * FROM Products

WHERE ProductID >= 10 AND ProductID <= 20

--OR - si estan los dos nombres de lo muestra si esta uno te muestra el otro

SELECT * FROM Employees
WHERE FirstName = "Nancy" OR FirstName = "Anne"

--algo mas complicado - lo que esta dentro del parentesis se pueden cumplirse los dos, pero el AND siempre se va a reestringir 

WHERE (Price < 20 OR CategoryID = 6) AND SupplierID = 7

--NOT -aca simplificamos no utilizar tantos OR

SELECT * FROM Customers
WHERE NOT Country = "USA"

--de esta manera escogemos los cinco primeros, establecemos un limite

SELECT * FROM Customers
WHERE CustomerID >= 50 AND NOT Country = "Germany" LIMIT 5


--EJERCICIO

SELECT * FROM Products
WHERE NOT CategoryID = 6
AND NOT SupplierID = 1
AND Price <= 30
ORDER BY RANDOM()
LIMIT 3

--BETWEEN - nos da los numeros entre 20 y 40

SELECT * FROM Products WHERE Price BETWEEN 20 AND 40

--otro ejemplo

SELECT * FROM Employees WHERE EmployeeID BETWEEN 3 AND 6

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


--GROUP BY -- separa los grupos segun si hay elementos iguales los pone en un grupo distinto a los demas

--saca el promedio de cada grupo, los que tengan supplierID con el mismo numero los junta en un grupo y les saca el promedio
SELECT SupplierID, ROUND(AVG(Price)) AS promedio FROM Products GROUP BY SupplierID
ORDER BY promedio DESC

--si queremos que nos muestre el promedio mayores a 40 de esta manera da error
SELECT SupplierID, ROUND(AVG(Price)) AS promedio FROM Products
WHERE Promedio > 40
GROUP BY SupplierID

--hay que utilizar HAVING porque filtra grupos no elementos
SELECT SupplierID, ROUND(AVG(Price)) AS promedio FROM Products
GROUP BY SupplierID
HAVING promedio > 40


--RESUMEN

--EJERCICIO

SELECT ProductID, SUM(Quantity) AS total FROM OrderDetails
GROUP BY ProductID
ORDER BY total DESC
LIMIT 1


--ORDEN DE PROCEDIMINETO

SELECT... FROM...
WHERE...
GROUP BY...
HAVING...
ORDER BY...
LIMIT...

--¡IMPORTANTE! NO PODEMOS AGREGAR UNA FUNCION DE AGREGACION DENTRO DE OTRA FUNCION DE AGREGACION

MAX(SUM(PRECIO))  --ESTO NO SE PUEDE HACER PERO SI CON SUBCONSULTAS


--SUBCONSULTAS - son consultas dentro de otras consultas, nota no alteran la base de datos solo la consultan, entonces update no la podemos usar para hacer modificiones

--primero se ejecuta la subconsulta y luego la consulta mas grande

SELECT ProductID, Quantity, (SELECT ProductName FROM Products) FROM OrderDetails

--esto no lo podemos hacer porque el select selecciona columnas, no tablas, para eso hay que hacer dos subconsultas
SELECT ProductID, Quantity, (SELECT ProductName,CategoryID FROM Products) FROM OrderDetails

--como hacemos dos subconsultas

SELECT ProductID, Quantity, (SELECT ProductName FROM Products), (SELECT ProductID FROM Products) FROM OrderDetails


--como hacemos una consulta donde cada nombre pertenece a la id

SELECT ProductID, 
		Quantity, 
		(SELECT ProductName FROM Products WHERE OrderDetails.ProductID = ProductID) AS Nombre --ProductName esta en la otra tabla y la seleccionamos luego hay que llamar a la tabla que esta fuera orderDetails.productsId(tabla de afuera) de la otra tabla de afuera y eso es igual a productId de la tabla de la subconsulta llamada products
		FROM OrderDetails



--otra forma de cambiarle el nombre es:
FROM [OrderDetails] OD

--la otra forma es:
FROM OrderDetails as OD

--EJERCICIO - como vemos trabajar con subconsultas es muy pesado, entonces para eso se utilizan joint

SELECT ProductID, SUM(Quantity) AS total_vendido,
	(SELECT ProductName FROM Products WHERE ProductID = OD.ProductID) AS Nombre,
	(SELECT Price FROM Products WHERE ProductID = OD.ProductID) AS Precio,
	ROUND(SUM(Quantity) * (SELECT Price FROM Products WHERE ProductID = OD.ProductID)) AS Total_recaudado
FROM [OrderDetails] OD
GROUP BY ProductID
ORDER BY total_recaudado DESC

--y con ese ejercicio podemos seleccionar las columnas que quremos mostrar de subconsulta

SELECT Nombre,Total_vendido FROM (SELECT ProductID, SUM(Quantity) AS total_vendido,
	(SELECT ProductName FROM Products WHERE ProductID = OD.ProductID) AS Nombre,
	ROUND(SUM(Quantity) * (SELECT Price FROM Products WHERE ProductID = OD.ProductID)) AS Total_recaudado
FROM [OrderDetails] OD
WHERE (SELECT Price FROM Products WHERE ProductID = OD.ProductID) > 40
GROUP BY ProductID
ORDER BY total_recaudado DESC)
WHERE total_vendido > 150



--JOINTS - PARA COMBINAR LA INFORMACION DE DOS BASES DE DATOS O MAS, PERO QUE LA INFORAMCION SE DEVUELVA EN UNA SOLA TABLA

--de esta manera esta fucionando la tabla employees con la tabla orders, con inners joins va a hacer una interseccion entre las dos tablas como si fueran dos conjuntos tabla a y tabla b
SELECT LastName, FirstName, OrderID FROM Employees e
INNER JOIN Orders o ON e.EmployeeID = o.EmployeeID


--si queremos crear una tabla con codigo

CREATE TABLE "Recompensas" (
"RecompensaID" INTEGER,
"EmpleadoID" INTEGER,
"Recompesa" INTEGER,
"Mes" TEXT,
PRIMARY KEY("RecompensaID" AUTOINCREMENT)
)

--si queremos añadir datos a la tabla

INSERT INTO Recompensas (EmpleadoID,Recompesa,Mes) VALUES

(3,200,"enero"),
(2,180,"febrero"),
(5,250,"marzo"),
(1,280,"abril"),
(8,160,"mayo"),
(null,null,"junio")


--aca podemos unir dos tablas, las dos tablas se uner gracias a que tienen la misma ID 
SELECT FirstName,Recompesa,Mes FROM Employees e
INNER JOIN Recompensas r ON e.EmployeeID = r.EmpleadoID  --si utilizamos el on hay es cuando hacemos la interseccion entre las dos tablas


--de esta manera nos devuelve todos los elementos de la tabla a, aunque no haya datos relacionados entre las dos tablas igualmente te va a mostrar todo los elementos de la tabla a
SELECT FirstName,Recompesa,Mes FROM Employees e
LEFT JOIN Recompensas r ON e.EmployeeID = r.EmpleadoID


--si queremos mostrar la tabla b con los datos que hace interseccion con la tabla a hacemos:
SELECT FirstName,Recompesa,Mes FROM Recompensas r  --intercambiamos employees por recomensas y listo
LEFT JOIN Employees e ON e.EmployeeID = r.EmpleadoID


--full join

--SIMULANDO UN FULL JOIN UNIENDO UN LEFT JOIN CON UNA SIMULACION DE RIGHT JOIN

SELECT FirstName,Recompesa,Mes FROM Employees e
LEFT JOIN Recompensas r ON e.EmployeeID = r.EmpleadoID

UNION

SELECT FirstName,Recompesa,Mes FROM Recompensas r
LEFT JOIN Employees e ON e.EmployeeID = r.EmpleadoID

--UNION ALL - DEVULEVE LA SUMA DE LAS DOS TABLAS SI EN LA PRIMERA TABLA HAY 6 ELEMENTOS Y EN LA SEGUNDA 4 ELEMENTOS CON UNION ALL VA A DEVOLVER 10 ELEMENTOS MAS ALLA DE QUE HAYA UNA RELACION ENTRE LOS ELEMENTOS

--UNION - SI HAY ELEMENTOS REPETIDOS EN LAS DOS TABLAS LOS SACA DEJANDO UNO QUEDANDO ASI MAS CHICA A LA TABLA




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


--TRANSACCIONES (funciona como git)

BEGIN; --si ponemos estamos esto lo estamos poniendo en el espacio de trabajo

UPDATE Products SET ProductName = "tobias"  --aca estamos cambiando todos los nombres

--pero si luego ponemos 

ROLLBACK --vamos al paso anterior, y no hacemos ningun cambio


COMMIT --una vez que estamos seguros de los cambios, con commit asentamos los cambios, como si fuera git




--PROCEDIMIENTOS ALMACENADOS

--FUNCIONES DEFINIDAS POR EL USUARIO

