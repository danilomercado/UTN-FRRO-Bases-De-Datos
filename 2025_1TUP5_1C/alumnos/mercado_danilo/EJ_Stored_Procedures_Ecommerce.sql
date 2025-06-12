USE ecommerce_arg;

/* 1- Crear un procedimiento almacenado llamado sp_productos_por_categoria que reciba una categoría como parámetro y muestre todos los productos activos de esa categoría.*/
DELIMITER //
CREATE PROCEDURE sp_productos_por_categoria(
        IN p_categoria VARCHAR(100)
)
BEGIN 
	SELECT pr.nombre, pr.precio, pr.stock
    FROM productos AS pr
    WHERE pr.categoria = p_categoria
    ORDER BY pr.nombre;
END //

CALL sp_productos_por_categoria('Muebles');


/*2- Crear un procedimiento sp_ordenes_por_usuario que reciba el ID de un usuario y devuelva todas sus órdenes con su estado y total.*/

DELIMITER //
CREATE PROCEDURE sp_ordenes_por_usuario(
	IN p_id_usuario INT
)
BEGIN 
	SELECT o.id_orden, o.fecha_orden, o.estado, o.total
    FROM ordenes AS o
    WHERE o.id_usuario = p_id_usuario
    ORDER BY o.id_orden;
END //

CALL sp_ordenes_por_usuario(2)

/*3- Crear un procedimiento sp_stock_bajo que muestre todos los productos cuyo stock sea menor a 10 unidades.*/

DELIMITER //
CREATE PROCEDURE sp_stock_bajo(
	IN p_stock INT
)
BEGIN
	SELECT pr.nombre, pr.descripcion, pr.precio, pr.categoria, pr.activo
    FROM productos AS pr
    WHERE pr.stock < p_stock;
END //

CALL sp_stock_bajo(15);

/*4- Crear un procedimiento sp_pagos_confirmados_por_fecha que reciba una fecha como parámetro y liste todos los pagos confirmados de esa fecha.*/
DELIMITER // 
CREATE PROCEDURE sp_pagos_confirmados_por_fecha(
	IN p_fecha_pago DATE
)
BEGIN 
	SELECT pa.metodo_pago, pa.monto, pa.confirmado
    FROM pagos AS pa
    WHERE pa.fecha_pago = p_fecha_pago AND pa.confirmado = 1;
END //

CALL sp_pagos_confirmados_por_fecha('2024-05-10');


/*5- Crear un procedimiento sp_ventas_por_producto que reciba un ID de producto y devuelva la cantidad total vendida según detalle_orden.*/
DELIMITER //
CREATE PROCEDURE sp_ventas_por_producto(
	IN p_id_producto INT
)
BEGIN
	SELECT dt.id_producto, SUM(dt.cantidad) AS total_vendido
	FROM detalle_orden AS dt
    WHERE dt.id_producto = p_id_producto
    GROUP BY dt.id_producto;
END //

CALL sp_ventas_por_producto(3);

/*6- Crear un procedimiento sp_actualizar_stock que reciba un ID de producto y una cantidad, y reste esa cantidad del stock actual.*/
DELIMITER //
CREATE PROCEDURE sp_actualizar_stock(
    IN p_id_producto INT,
    IN p_cantidad INT
)
BEGIN
    UPDATE productos
    SET stock = stock - p_cantidad
    WHERE id_producto = p_id_producto;
END //

CALL sp_actualizar_stock(3, 5);

/* 7- Crear un procedimiento sp_orden_detallada que reciba el ID de una orden y devuelva los datos de la orden, los productos asociados (nombre, cantidad, precio) y el total acumulado.*/

/*8- Crear un procedimiento sp_clientes_recientes que devuelva todos los usuarios registrados en el último mes desde la fecha actual.*/

