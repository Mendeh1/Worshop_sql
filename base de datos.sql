-- Creacion de base de DATOS
CREATE DATABASE Jardineria;

-- Definición de la tabla Empleados
CREATE TABLE Empleados (
    CódigoEmpleado INT PRIMARY KEY,
    Nombre VARCHAR(255),
    Apellido1 VARCHAR(255),
    Apellido2 VARCHAR(255),
    Extensión VARCHAR(10),
    Email VARCHAR(255),
    CódigoOficina INT,
    CódigoJefe INT,
    Puesto VARCHAR(100),
    FOREIGN KEY (CódigoOficina) REFERENCES Oficinas(CódigoOficina),
    FOREIGN KEY (CódigoJefe) REFERENCES Empleados(CódigoEmpleado)
    );
-- Definición de la tabla Jefe
CREATE TABLE Jefe (
	CodigoJefe INT,
    Nombre VARCHAR(200)
	);

-- Definición de la tabla Clientes
CREATE TABLE Clientes (
    CódigoCliente INT PRIMARY KEY,
    NombreCliente VARCHAR(255),
    NombreContacto VARCHAR(255),
    ApellidoContacto VARCHAR(255),
    Teléfono VARCHAR(15),
    Fax VARCHAR(15),
    Direccion1 VARCHAR(255),
    Direccion2 VARCHAR(255),
    Ciudad VARCHAR(100),
    Región VARCHAR(100),
    País VARCHAR(100),
    CódigoPostal VARCHAR(10),
    CódigoEmpleado INT,
    LimiteCredito DECIMAL(10, 2),
    FOREIGN KEY (CódigoEmpleado) REFERENCES Empleados(CódigoEmpleado)
);

-- Definición de la tabla Pedidos
CREATE TABLE Pedidos (
    CódigoPedido INT PRIMARY KEY,
    FechaPedido DATE,
    FechaEsperada DATE,
    FechaEntrega DATE,
    Estado VARCHAR(50),
    Comentarios TEXT,
    CódigoCliente INT,
    FOREIGN KEY (CódigoCliente) REFERENCES Clientes(CódigoCliente)
);

-- Definición de la tabla Pagos
CREATE TABLE Pagos (
    CódigoPago INT PRIMARY KEY,
    CódigoCliente INT,
    FormaPago VARCHAR(50),
    IdTransacción VARCHAR(255),
    FechaPago DATE,
    TotalPago DECIMAL(10, 2),
    FOREIGN KEY (CódigoCliente) REFERENCES Clientes(CódigoCliente)
);

-- Definición de la tabla Oficinas
CREATE TABLE Oficinas (
    CódigoOficina INT PRIMARY KEY,
    Ciudad VARCHAR(100),
    País VARCHAR(100),
    Región VARCHAR(100),
    CódigoPostal VARCHAR(10),
    Teléfono VARCHAR(15),
    Direccion VARCHAR(255)
);

-- Definición de la tabla Productos
CREATE TABLE Productos (
    CódigoProducto INT PRIMARY KEY,
    Nombre VARCHAR(255),
    Gama VARCHAR(100),
    Dimensiones VARCHAR(50),
    Proveedor VARCHAR(255),
    Descripción TEXT,
    CantidadEnStock INT,
    PrecioVenta DECIMAL(10, 2),
    PrecioProveedor DECIMAL(10, 2),
    CodigoGama INT,
    FOREIGN KEY (CodigoGama) REFERENCES GamasProductos(CodigoGama)
);

-- Definición de la tabla GamasProductos
CREATE TABLE GamasProductos (
    CodigoGama INT PRIMARY KEY,
    Gama VARCHAR(100),
    Descripción TEXT,
    Imagen VARCHAR(255) -- Puedes almacenar la ruta de la imagen o un identificador
);

-- Definición de la tabla DetallesPedidos
CREATE TABLE DetallesPedidos (
    CódigoPedido INT,
    CódigoProducto INT,
    Cantidad INT,
    PrecioPorUnidad DECIMAL(10, 2),
    PRIMARY KEY (CódigoPedido, CódigoProducto),
    FOREIGN KEY (CódigoPedido) REFERENCES Pedidos(CódigoPedido),
    FOREIGN KEY (CódigoProducto) REFERENCES Productos(CódigoProducto)
);
