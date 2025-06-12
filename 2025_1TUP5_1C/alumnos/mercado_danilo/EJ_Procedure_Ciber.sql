USE ciber_rosarino;

/*1- Crear un procedimiento sp_productos_bajo_stock que reciba un valor límite y muestre todos los productos con stock menor a ese valor.*/

DELIMITER //
CREATE PROCEDURE sp_productos_bajo_stock(
	IN p_stock int
)
BEGIN
	SELECT *
    FROM productos
    WHERE stock < p_stock;
END //

CALL sp_productos_bajo_stock(81);

/*2- Crear un procedimiento sp_total_gastado_por_cliente que reciba un ID de cliente y devuelva la suma total gastada entre usos de computadoras y productos comprados.*/
DELIMITER //
CREATE PROCEDURE sp_total_gastado_por_cliente(
	IN p_id_cliente INT
)
BEGIN 
	SELECT SUM(u.costo+v.total)
    FROM clientes as c
    INNER JOIN usos as u on c.id_cliente = u.id_cliente
    INNER JOIN ventas as v on c.id_cliente = v.id_cliente
    WHERE c.id_cliente = p_id_cliente;
END //

CALL sp_total_gastado_por_cliente(2);

/*3- Crear un procedimiento sp_uso_por_fecha que reciba una fecha y devuelva todas las sesiones de uso registradas ese día, incluyendo cliente, computadora y costo. */
DELIMITER //
CREATE PROCEDURE sp_uso_por_fecha(
	IN p_fecha DATE
)
BEGIN
	SELECT c.nombre, c.apellido, cc.numero_pc, u.id_uso, u.costo
    FROM usos AS u
    INNER JOIN clientes AS c ON u.id_cliente = c.id_cliente
    INNER JOIN computadoras AS cc ON u.id_pc = cc.id_pc
    WHERE u.fecha = p_fecha;
END //

CALL sp_uso_por_fecha('2023-06-10');

/*4- Crear un procedimiento sp_clientes_frecuentes que reciba un número N y devuelva los clientes con más de N sesiones de uso.*/
DELIMITER //
CREATE PROCEDURE sp_clientes_frecuentas(
	IN p_min_sesiones INT
)
BEGIN
	SELECT c.id_cliente, c.nombre, c.apellido, COUNT(u.id_uso) AS total_sesiones
    FROM clientes AS c
	INNER JOIN usos AS u ON c.id_cliente = u.id_cliente
    GROUP BY c.id_cliente, c.nombre, c.apellido
    HAVING total_sesiones > p_min_sesiones;
END //

CALL sp_clientes_frecuentas(1);

/*5- Crear un procedimiento sp_disponibilidad_pc que reciba una marca y devuelva las computadoras disponibles de esa marca.*/
DELIMITER //
CREATE PROCEDURE sp_disponibilidad_pc(
	IN p_marca VARCHAR(100)
)
BEGIN 
	SELECT c.numero_pc, c.marca, c.ram_gb, c.estado
    FROM computadoras AS c
    WHERE c.marca = p_marca AND c.estado = "Disponible";
END //

CALL sp_disponibilidad_pc("Dell");

/*7- Crear un procedimiento sp_registrar_venta que reciba ID de cliente, ID de producto y cantidad, actualice el stock y registre la venta solo si hay stock suficiente.*/