-- consulta1
SELECT CódigoOficina, Ciudad
FROM Oficinas;

-- consulta2
SELECT Ciudad, Teléfono
FROM Oficinas
WHERE País = 'España';
-- consulta3

SELECT Nombre, Apellido1, Apellido2, Email
FROM Empleados
WHERE CódigoJefe = 7;
-- consulta4

-- Utilizando la función YEAR de MySQL:
SELECT DISTINCT CódigoCliente
FROM Pagos
WHERE YEAR(FechaPago) = 2008;

-- Utilizando la función DATE_FORMAT de MySQL:
SELECT DISTINCT CódigoCliente
FROM Pagos
WHERE DATE_FORMAT(FechaPago, '%Y') = '2008';

-- consulta5
SELECT COUNT(*) as TotalEmpleados
FROM Empleados;

-- consulta6
SELECT País, COUNT(*) AS TotalClientes
FROM Clientes
GROUP BY País;

-- consulta7
SELECT AVG(TotalPago) AS PagoPromedio2009
FROM Pagos
WHERE YEAR(FechaPago) = 2009;

-- consulta8
SELECT Estado, COUNT(*) AS TotalPedidos
FROM Pedidos
GROUP BY Estado
ORDER BY TotalPedidos DESC;

-- consulta9
SELECT MAX(PrecioVenta) AS PrecioProductoMásCaro, MIN(PrecioVenta) AS PrecioProductoMásBarato
FROM Productos;

-- consulta10
SELECT NombreCliente
FROM Clientes
ORDER BY LimiteCredito DESC
LIMIT 1;

-- consulta11
SELECT Nombre
FROM Productos
ORDER BY PrecioVenta DESC
LIMIT 1;

-- consulta12
SELECT Productos.Nombre AS ProductoMásVendido
FROM Productos
JOIN (
    SELECT CódigoProducto, SUM(Cantidad) AS TotalUnidadesVendidas
    FROM DetallesPedidos
    GROUP BY CódigoProducto
    ORDER BY TotalUnidadesVendidas DESC
    LIMIT 1
) AS UnidadesVendidas
ON Productos.CódigoProducto = UnidadesVendidas.CódigoProducto;

-- consulta13
SELECT CódigoCliente, NombreCliente
FROM Clientes
WHERE LimiteCredito > (
    SELECT SUM(TotalPago)
    FROM Pagos
    WHERE Pagos.CódigoCliente = Clientes.CódigoCliente
);

-- consulta14
SELECT C.NombreCliente, COUNT(P.CódigoPedido) AS CantidadPedidos
FROM Clientes C
LEFT JOIN Pedidos P ON C.CódigoCliente = P.CódigoCliente
GROUP BY C.NombreCliente;

-- consulta15
SELECT E.Nombre, E.Apellido1, E.Apellido2, E.Puesto, O.Teléfono
FROM Empleados E
JOIN Oficinas O ON E.CódigoOficina = O.CódigoOficina
LEFT JOIN Clientes C ON E.CódigoEmpleado = C.CódigoEmpleado
WHERE C.CódigoCliente IS NULL OR C.Puesto <> 'Representante de Ventas';

-- consulta16
SELECT O.CódigoOficina, O.Ciudad, O.País
FROM Oficinas O
WHERE O.CódigoOficina NOT IN (
    SELECT DISTINCT E.CódigoOficina
    FROM Empleados E
    JOIN Clientes C ON E.CódigoEmpleado = C.CódigoEmpleado
    JOIN Pedidos P ON C.CódigoCliente = P.CódigoCliente
    JOIN DetallesPedidos DP ON P.CódigoPedido = DP.CódigoPedido
    JOIN Productos Pr ON DP.CódigoProducto = Pr.CódigoProducto
    WHERE Pr.Gama = 'Frutales'
    AND C.Puesto = 'Representante de Ventas'
);

-- consulta17
SELECT C.NombreCliente, COUNT(P.CódigoPedido) AS CantidadPedidos
FROM Clientes C
LEFT JOIN Pedidos P ON C.CódigoCliente = P.CódigoCliente
GROUP BY C.CódigoCliente, C.NombreCliente;

-- consulta18
SELECT C.NombreCliente, COALESCE(SUM(P.TotalPago), 0) AS TotalPagado
FROM Clientes C
LEFT JOIN Pagos P ON C.CódigoCliente = P.CódigoCliente
GROUP BY C.CódigoCliente, C.NombreCliente;