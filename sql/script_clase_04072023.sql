/*Para ver como funciona esta creación de columnas temporales prueba el siguiente código:
SELECT  'Hola!'  AS tipo_nombre
FROM customers;*/
USE northwind;

/* EJERCICIO 1
Extraer toda la información sobre las compañias que tengamos en la BBDD
Nuestros jefes nos han pedido que creemos una query que nos devuelva todos
 los clientes y proveedores que tenemos en la BBDD. Mostrad la ciudad a la que
 pertenecen, el nombre de la empresa y el nombre del contacto, además de
 la relación (Proveedor o Cliente). Pero importante! No debe haber duplicados
 en nuestra respuesta. La columna Relationship no existe y debe ser creada 
 como columna temporal. Para ello añade el valor que le quieras dar al campo
 y utilizada como alias Relationship.
Nota: Deberás crear esta columna temporal en cada instrucción SELECT.*/
SELECT first_name as nombre, title as posicion, city as ciudad, 'empleados' as relacion
FROM employees
UNION
SELECT contact_name as nombre, contact_title as posicion, city as ciudad, 'clientes' as relacion
FROM customers;

/* Ejercicio 2 
Extraer todos los pedidos gestinados por "Nancy Davolio"
En este caso, nuestro jefe quiere saber cuantos pedidos ha 
gestionado "Nancy Davolio", una de nuestras empleadas. 
Nos pide todos los detalles tramitados por ella.*/
/*SELECT employee_number AS NumeroEmpleado, first_name AS NombreEmpleado, last_name AS ApellidoEmpleado
FROM employees
WHERE employee_number IN (SELECT sales_rep_employee_number FROM customers);*/
SELECT *
FROM orders
WHERE employee_id = 1;

SELECT * 
FROM orders
WHERE employee_id IN (SELECT employee_id 
				FROM employees 
                WHERE first_name = 'Nancy' AND last_name= 'Davolio');


/*EJERCICIO 3
Extraed todas las empresas que no han comprado en el año 1997
En este caso, nuestro jefe quiere saber qué empresas no han comprado en el año 1997.
💡 Pista 💡 Para extraer el año de una fecha, podemos usar el estamento year*/
SELECT *
FROM customers
WHERE customer_id NOT IN(
    SELECT customer_id
    FROM orders
    WHERE year(order_date) = 1997);
/*EJERCICIO 4
Extraed toda la información de los pedidos donde tengamos "Konbu".
Estamos muy interesados en saber como ha sido la evolución de la venta de 
Konbu a lo largo del tiempo. Nuestro jefe nos pide que nos muestre todos 
los pedidos que contengan "Konbu".
💡 Pista 💡 En esta query tendremos que combinar conocimientos adquiridos 
en las lecciones anteriores como por ejemplo el INNER JOIN.*/
SELECT * 
FROM orders
WHERE order_id IN (SELECT order_id
	FROM order_details
	INNER JOIN products
	ON order_details.product_id = products.product_id
    WHERE products.product_name = 'Konbu');