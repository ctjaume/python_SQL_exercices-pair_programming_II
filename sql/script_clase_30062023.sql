USE northwind;

/*1. Pedidos por empresa en UK:
Desde las oficinas en UK nos han pedido con urgencia que 
realicemos una consulta a la base de datos con la que podamos 
conocer cuántos pedidos ha realizado cada empresa cliente de UK.
 Nos piden el ID del cliente y el nombre de la empresa y el número de pedidos.*/
 
 SELECT count(orders.order_id) AS TotalPEdidos, customers.customer_id, customers.company_name
 FROM customers 
 INNER JOIN orders
 ON customers.customer_id = orders.customer_id
 WHERE customers.country = 'UK'
 GROUP BY customers.company_name, customers.customer_id;

 
/*2. Productos pedidos por empresa en UK por año:
Desde Reino Unido se quedaron muy contentas con nuestra rápida respuesta a su petición 
anteriory han decidido pedirnos una serie de consultas adicionales.
 La primera de ellas consiste en una query que nos sirva para conocer cuántos objetos 
 ha pedido cada empresa cliente de UK
 durante cada año. Nos piden concretamente conocer el nombre de la empresa, el año, y 
 la cantidad de objetos que han pedido. Para ello hará falta hacer 2 joins.*/
 

SELECT count(orders.order_id) AS TotalPedidos, customers.customer_id, customers.company_name, count(order_details.quantity) cantidadProductos
FROM customers 
INNER JOIN orders
ON customers.customer_id = orders.customer_id
INNER JOIN order_details
ON orders.order_id =  order_details.order_id
WHERE customers.country = 'UK'
GROUP BY customers.company_name, customers.customer_id;

 
 /*3. Mejorad la query anterior:
 Lo siguiente que nos han pedido es la misma consulta anterior pero con la adición de la 
 cantidad de dinero que han pedido por esa cantidad de objetos, teniendo en cuenta los 
 descuentos, etc. Ojo que los descuentos en nuestra tabla nos salen en porcentajes, 15% 
 nos sale como 0.15.*/
 
 SELECT count(orders.order_id) AS TotalPedidos, customers.customer_id, customers.company_name, sum(order_details.quantity) as cantidadProductos, sum(order_details.unit_price *  order_details.quantity* (1- order_details.discount)) as dineroTotal
FROM customers 
INNER JOIN orders
ON customers.customer_id = orders.customer_id
INNER JOIN order_details
ON orders.order_id =  order_details.order_id
WHERE customers.country = 'UK'
GROUP BY customers.company_name, customers.customer_id;
 
 /*4. BONUS: Pedidos que han realizado cada compañía y su fecha:
Después de estas solicitudes desde UK y gracias a la utilidad de los resultados que se han
 obtenido, desde la central nos han pedido una consulta que indique el nombre de cada 
 compañia cliente junto con cada pedido que han realizado y su fecha.*/
 SELECT customers.company_name, orders.order_id, orders.shipped_date
 FROM customers
 INNER JOIN orders
 ON customers.customer_id = orders.customer_id;
 
 /*5. BONUS: Tipos de producto vendidos:
Ahora nos piden una lista con cada tipo de producto que se han vendido, sus categorías,
 nombre de la categoría y el nombre del producto, y el total de dinero por el que se ha 
 vendido cada tipo de producto (teniendo en cuenta los descuentos).
Pista Necesitaréis usar 3 joins.*/

SELECT products.product_id AS IdProducto, products.product_name AS NombreProducto, 
categories.category_id AS IdCategoria, categories.category_name AS Categoria, 
SUM(order_details.unit_price * order_details.quantity * order_details.discount) AS TotalVentas
FROM products
NATURAL JOIN categories
NATURAL JOIN order_details
GROUP BY products.product_id
ORDER BY TotalVentas DESC
;
