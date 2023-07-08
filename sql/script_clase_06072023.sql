
USE northwind;

/*1. Extraed información de los productos "Beverages"
En este caso nuestro jefe nos pide que le devolvamos toda la información necesaria para identificar un tipo de producto. En concreto, tienen especial interés por los productos con categoría "Beverages". Devuelve el ID del producto, el nombre del producto y su ID de categoría.
La query debería resultar en una tabla como esta:
ProductID / ProductName / CategoryID */


SELECT *
	FROM products
    WHERE category_id IN (SELECT category_id
								FROM categories
								WHERE category_name = 'beverages');


/* 2.Extraed la lista de países donde viven los clientes, pero no hay ningún proveedor ubicado en ese país
Suponemos que si se trata de ofrecer un mejor tiempo de entrega a los clientes, entonces podría dirigirse a estos países para buscar proveedores adicionales.
Los resultados de esta query son:
country / */

SELECT DISTINCT country
	FROM customers
	WHERE country NOT IN (SELECT DISTINCT country 
								FROM suppliers);

/* 3.Extraer los clientes que compraron mas de 20 articulos "Grandma's Boysenberry Spread"
Extraed el OrderId y el nombre del cliente que pidieron más de 20 artículos del producto "Grandma's Boysenberry Spread" (ProductID 6) en un solo pedido.
Resultado de nuestra query deberíamos tener una tabla como esta:
OrderID /CustomerID */

SELECT customer_id, order_id
	FROM orders    
    WHERE order_id IN (SELECT order_id
							FROM order_details
							WHERE product_id = 6 AND quantity > 20);


/* 4.Extraed los 10 productos más caros
Nos siguen pidiendo más queries correlacionadas. En este caso queremos saber cuáles son los 10 productos más caros.
Los resultados esperados de esta query son:
Ten_most_expensive_products / UnitPrice */

SELECT product_name, unit_price
	FROM ( SELECT *
			FROM products
			ORDER BY unit_price DESC)  AS MiniTabla 
	LIMIT 10;

/* 5. BONUS:
Qué producto es más popular
Extraed cuál es el producto que más ha sido comprado y la cantidad que se compró.
El resultado de esta query es:
ProductNamr / MAX(SUmQUantity)*/

SELECT *
FROM order_details;

SELECT product_id, SUM(quantity) AS CantidadTotal
	FROM order_details
    GROUP BY product_id
    HAVING SUM(quantity) >= ALL (SELECT SUM(quantity)
	FROM order_details)
    


