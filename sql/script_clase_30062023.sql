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
 
 /*Primer join es una copia del anterior*/
SELECT count(orders.order_id) AS TotalPEdidos, customers.customer_id, customers.company_name
FROM customers 
INNER JOIN orders
ON customers.customer_id = orders.customer_id
WHERE customers.country = 'UK'
GROUP BY customers.company_name, customers.customer_id;

SELECT count(order_id) AS TotalPEdidos, customer_id
FROM orders
WHERE ship_country = 'UK'
group by shipped_date, customer_id;
 
 /*Segundo join es añadir la tabla orders year(shipped date)*/
  SELECT count(orders.order_id) AS TotalPEdidos, customers.customer_id, customers.company_name
 FROM customers 
 INNER JOIN orders
 ON customers.customer_id = orders.customer_id
 WHERE customers.country = 'UK'
 GROUP BY customers.company_name, customers.customer_id;
 
 /*3. Mejorad la query anterior:
 Lo siguiente que nos han pedido es la misma consulta anterior pero con la adición de la 
 cantidad de dinero que han pedido por esa cantidad de objetos, teniendo en cuenta los 
 descuentos, etc. Ojo que los descuentos en nuestra tabla nos salen en porcentajes, 15% 
 nos sale como 0.15.*/
 
 /*4. BONUS: Pedidos que han realizado cada compañía y su fecha:
Después de estas solicitudes desde UK y gracias a la utilidad de los resultados que se han
 obtenido, desde la central nos han pedido una consulta que indique el nombre de cada 
 compañia cliente junto con cada pedido que han realizado y su fecha.*/
 
 /*5. BONUS: Tipos de producto vendidos:
Ahora nos piden una lista con cada tipo de producto que se han vendido, sus categorías,
 nombre de la categoría y el nombre del producto, y el total de dinero por el que se ha 
 vendido cada tipo de producto (teniendo en cuenta los descuentos).
Pista Necesitaréis usar 3 joins.*/