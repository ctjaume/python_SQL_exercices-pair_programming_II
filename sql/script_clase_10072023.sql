USE northwind;

/*1.Extraer en una CTE todos los nombres de las compañias y los id de los clientes.
Para empezar nos han mandado hacer una CTE muy sencilla el id del cliente y el nombre de la compañia de la tabla Customers.
Los resultados de esta query serán:
CustomerID / CompanyName*/

WITH consulta_cliente (CustomerID, CompanyName)  
	AS (SELECT customer_id, company_name 
			FROM customers)
            SELECT CustomerID, CompanyName
				FROM consulta_cliente;


/*2.Selecciona solo los de que vengan de "Germany"
Ampliemos un poco la query anterior. En este caso, queremos un resultado similar al anterior, pero solo queremos los que pertezcan a "Germany".
Los resultados de esta query serán:
-CustomerID / CompanyName*/

WITH consulta_cliente (CustomerID, CompanyName)  
	AS (SELECT customer_id, company_name 
			FROM customers
			WHERE country = 'Germany')
	SELECT CustomerID, CompanyName
				FROM consulta_cliente;

/*3.Extraed el id de las facturas y su fecha de cada cliente.
En este caso queremos extraer todas las facturas que se han emitido a un cliente, su fecha la compañia a la que pertenece.
📌 NOTA En este caso tendremos columnas con elementos repetidos(CustomerID, y Company Name).
Los resultados de esta query serán:
CustomerID / CompanyName / OrderID / OrderDate*/

WITH consulta_factura (CustomerID, CompanyName, OrderID, OrderDate)  
	AS (SELECT customer_id, company_name, order_id, order_date  
			FROM customers
            NATURAL JOIN orders
			ORDER BY customer_id)
	SELECT CustomerID, CompanyName, OrderID, OrderDate
				FROM consulta_factura;


/*4. Contad el número de facturas por cliente
Mejoremos la query anterior. En este caso queremos saber el número de facturas emitidas por cada cliente.
Los resultados de esta query serán:
CustomerID / CompanyName / NumeroFactura*/

WITH consulta_factura  
	AS (SELECT customers.customer_id, customers.company_name, orders.order_id 
			FROM customers
            INNER JOIN orders
            ON customers.customer_id = orders.customer_id            
			)
	SELECT customer_id, company_name, COUNT(order_id)
				FROM consulta_factura
                GROUP BY customer_id;


/*5.Cuál es la cantidad media pedida de todos los productos ProductID.
Necesitaréis extraer la suma de las cantidades por cada producto y calcular la media.
Los resultados de esta query serán:
Producto / Media */

WITH consulta_media
	AS (SELECT product_id, SUM(quantity)
			FROM order_details
            GROUP BY product_id)
	SELECT product_id, AVG(`SUM(quantity)`) 
		FROM consulta_media
        GROUP BY product_id;




