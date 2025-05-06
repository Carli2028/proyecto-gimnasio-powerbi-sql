CREATE DATABASE Genesis;
GO

USE Genesis;

CREATE TABLE Sucursales (
    SucursalID INT PRIMARY KEY IDENTITY(1,1),
    NombreSucursal VARCHAR(100),
    Direccion VARCHAR(150),
    Telefono VARCHAR(20)
);

INSERT INTO Sucursales (NombreSucursal, Direccion, Telefono) VALUES
('Sede Park', 'Calle Falsa 123, Zona Norte', '3814000001'),
('Av Patria', 'Av. Patria 456, Centro', '3814000002'),
('24 de Septiembre', '24 de Septiembre 789, Sur', '3814000003');


UPDATE Sucursales
SET NombreSucursal = 'Sede Park'
WHERE NombreSucursal = 'Viamonte 345';


UPDATE Sucursales
SET Direccion = 'Viamonte 345'
WHERE NombreSucursal = 'Sede Park';


CREATE TABLE Socios (
    SocioID INT PRIMARY KEY IDENTITY(1,1),
    SucursalID INT FOREIGN KEY REFERENCES Sucursales(SucursalID),
    Nombre VARCHAR(100),
    Apellido VARCHAR(100),
    DNI VARCHAR(10),
    FechaNacimiento DATE,
    Sexo CHAR(1),
    Email VARCHAR(100),
    Telefono VARCHAR(20),
    FechaInscripcion DATE,
    PlanID INT
);

DECLARE @Mes INT;
DECLARE @CantidadSocios INT;
DECLARE @SucursalID INT;

-- Generar 12 meses de inscripciones (de enero a diciembre)
SET @Mes = 1;

WHILE @Mes <= 12
BEGIN
    -- Determinar la cantidad de socios a generar por mes (entre 100 y 150)
    SET @CantidadSocios = FLOOR(RAND() * (150 - 100 + 1)) + 100;

    -- Generar socios para cada mes
    DECLARE @i INT = 1;
    WHILE @i <= @CantidadSocios
    BEGIN
        -- Asignar sucursal aleatoria (1, 2 o 3)
        SET @SucursalID = FLOOR(RAND() * 3) + 1;

        -- Generar un nombre y apellido aleatorio (puedes ajustar esta lista si lo deseas)
        DECLARE @Nombre VARCHAR(100);
        DECLARE @Apellido VARCHAR(100);
        DECLARE @Sexo CHAR(1);
        DECLARE @FechaNacimiento DATE;
        DECLARE @DNI VARCHAR(10);
        DECLARE @FechaInscripcion DATE;
        
        -- Nombre y Apellido aleatorio (lista muy básica para ejemplificar)
        SET @Nombre = (CASE 
                        WHEN @SucursalID = 1 THEN 'Juan' 
                        WHEN @SucursalID = 2 THEN 'Ana' 
                        ELSE 'Pedro' 
                     END);
                     
        SET @Apellido = (CASE 
                           WHEN @SucursalID = 1 THEN 'Gomez' 
                           WHEN @SucursalID = 2 THEN 'Lopez' 
                           ELSE 'Perez' 
                        END);
        
        -- Sexo aleatorio (M o F)
        SET @Sexo = (CASE WHEN RAND() < 0.5 THEN 'M' ELSE 'F' END);

        -- Fecha de nacimiento aleatoria (entre 18 y 60 años)
        SET @FechaNacimiento = DATEADD(YEAR, -(FLOOR(RAND() * (60 - 18 + 1)) + 18), GETDATE());

        -- DNI aleatorio (generamos un número de 10 dígitos)
        SET @DNI = CONCAT(FLOOR(RAND() * 1000000000), FLOOR(RAND() * 10));

        -- Fecha de inscripción aleatoria (en el mes correspondiente)
        SET @FechaInscripcion = DATEADD(MONTH, @Mes - 1, '2024-01-01');
        
        -- Insertar el socio en la tabla (ajustar la tabla si hace falta)
        INSERT INTO Socios (SucursalID, Nombre, Apellido, DNI, FechaNacimiento, Sexo, FechaInscripcion)
        VALUES (@SucursalID, @Nombre, @Apellido, @DNI, @FechaNacimiento, @Sexo, @FechaInscripcion);
        
        -- Incrementar el contador de socios
        SET @i = @i + 1;
    END
    
    -- Avanzar al siguiente mes
    SET @Mes = @Mes + 1;
END


-- Declarar variables principales
DECLARE @Mes INT;
DECLARE @CantidadSocios INT;
DECLARE @SucursalID INT;
DECLARE @PlanID INT;

-- Definir los 3 tipos de planes
DECLARE @Planes TABLE (PlanID INT, PlanNombre VARCHAR(50));
INSERT INTO @Planes (PlanID, PlanNombre) VALUES
(1, 'Fullpass'),
(2, 'Economy'),
(3, 'Musculacion');


CREATE TABLE ProductosVendidos (
    VentaID INT IDENTITY(1,1) PRIMARY KEY, -- Identificador único de la venta
    SucursalID INT, -- Relaciona la venta con la sucursal
    FechaVenta DATETIME, -- Fecha de la venta
    ProductoID INT, -- Identificador único del producto
    ProductoNombre VARCHAR(100), -- Nombre del producto
    CantidadVendida INT, -- Cantidad vendida
    PrecioUnitario DECIMAL(10, 2), -- Precio unitario
    TotalVenta DECIMAL(10, 2), -- Total de la venta (Cantidad * Precio)
    FOREIGN KEY (SucursalID) REFERENCES Sucursales(SucursalID)
);

-- Declarar variables
DECLARE @Mes INT;
DECLARE @CantidadVentas INT;
DECLARE @SucursalID INT;
DECLARE @ProductoID INT;
DECLARE @CantidadVendida INT;
DECLARE @PrecioUnitario DECIMAL(10,2);
DECLARE @ProductoNombre VARCHAR(100);
DECLARE @FechaVenta DATETIME;
DECLARE @TotalVenta DECIMAL(10,2);

-- Definir los productos disponibles en el gimnasio (suplementos y planes)
DECLARE @Productos TABLE (ProductoID INT, ProductoNombre VARCHAR(100), PrecioUnitario DECIMAL(10,2));
INSERT INTO @Productos (ProductoID, ProductoNombre, PrecioUnitario) VALUES
(1, 'Suplemento Proteína', FLOOR(RAND() * (50000 - 30000 + 1)) + 30000),
(2, 'Suplemento Creatina', FLOOR(RAND() * (50000 - 30000 + 1)) + 30000),
(3, 'Membresía Fullpass', 35000),
(4, 'Membresía Economy', 25000),
(5, 'Membresía Musculación', 25000);

-- Inicializamos el mes para el ciclo de ventas
SET @Mes = 1;

-- Bucle para los 12 meses (enero - diciembre)
WHILE @Mes <= 12
BEGIN
    -- Determinar la cantidad de ventas a generar por mes (entre 50 y 100)
    SET @CantidadVentas = FLOOR(RAND() * (100 - 50 + 1)) + 50;

    -- Generar ventas para cada mes
    DECLARE @i INT = 1;
    WHILE @i <= @CantidadVentas
    BEGIN
        -- Asignar sucursal aleatoria (1, 2 o 3)
        SET @SucursalID = FLOOR(RAND() * 3) + 1;

        -- Seleccionar un producto aleatorio
        SET @ProductoID = FLOOR(RAND() * 5) + 1; -- 5 productos en total (3 tipos de suplementos + 3 planes)
        SELECT @ProductoNombre = ProductoNombre, @PrecioUnitario = PrecioUnitario FROM @Productos WHERE ProductoID = @ProductoID;

        -- Cantidad vendida aleatoria (entre 1 y 10)
        SET @CantidadVendida = FLOOR(RAND() * 10) + 1;

        -- Fecha de venta aleatoria (entre el mes actual)
        SET @FechaVenta = DATEADD(MONTH, @Mes - 1, '2024-01-01');
        SET @FechaVenta = DATEADD(DAY, FLOOR(RAND() * (31)), @FechaVenta);

        -- Total de la venta (cantidad * precio unitario)
        SET @TotalVenta = @CantidadVendida * @PrecioUnitario;

        -- Insertar la venta en la tabla
        INSERT INTO ProductosVendidos (SucursalID, FechaVenta, ProductoID, ProductoNombre, CantidadVendida, PrecioUnitario, TotalVenta)
        VALUES (@SucursalID, @FechaVenta, @ProductoID, @ProductoNombre, @CantidadVendida, @PrecioUnitario, @TotalVenta);
        
        -- Incrementar el contador de ventas
        SET @i = @i + 1;
    END

    -- Avanzar al siguiente mes
    SET @Mes = @Mes + 1;
END


-- Declaramos los productos de bebidas
DECLARE @Bebidas TABLE (
    ProductoID INT,
    ProductoNombre VARCHAR(100),
    PrecioUnitario DECIMAL(10,2)
);

-- Insertamos bebidas con precios fijos
INSERT INTO @Bebidas (ProductoID, ProductoNombre, PrecioUnitario)
VALUES
(6, 'Agua Mineral 500ml', 2000),
(7, 'Monster Energy Drink', 4000),
(8, 'Gatorade 500ml', 3500);

-- Variables para iteración
DECLARE @Mes INT = 1;
DECLARE @i INT;
DECLARE @CantidadVentas INT;
DECLARE @SucursalID INT;
DECLARE @ProductoID INT;
DECLARE @ProductoNombre VARCHAR(100);
DECLARE @PrecioUnitario DECIMAL(10,2);
DECLARE @CantidadVendida INT;
DECLARE @FechaVenta DATE;
DECLARE @TotalVenta DECIMAL(10,2);

-- Bucle para cada mes del 2024
WHILE @Mes <= 12
BEGIN
    SET @CantidadVentas = FLOOR(RAND() * 31) + 20; -- 20 a 50 ventas por mes
    SET @i = 1;

    WHILE @i <= @CantidadVentas
    BEGIN
        -- Sucursal aleatoria
        SET @SucursalID = FLOOR(RAND() * 3) + 1; -- 1 a 3

        -- Producto aleatorio de bebidas
        SELECT TOP 1 
            @ProductoID = ProductoID,
            @ProductoNombre = ProductoNombre,
            @PrecioUnitario = PrecioUnitario
        FROM @Bebidas
        ORDER BY NEWID(); -- random

        -- Fecha de venta aleatoria en el mes
        SET @FechaVenta = DATEADD(DAY, FLOOR(RAND() * 28), DATEFROMPARTS(2024, @Mes, 1));

        -- Cantidad aleatoria (1 a 5)
        SET @CantidadVendida = FLOOR(RAND() * 5) + 1;

        -- Calcular total
        SET @TotalVenta = @CantidadVendida * @PrecioUnitario;

        -- Insertar en la tabla final
        INSERT INTO ProductosVendidos (SucursalID, FechaVenta, ProductoID, ProductoNombre, CantidadVendida, PrecioUnitario, TotalVenta)
        VALUES (@SucursalID, @FechaVenta, @ProductoID, @ProductoNombre, @CantidadVendida, @PrecioUnitario, @TotalVenta);

        SET @i += 1;
    END

    SET @Mes += 1;
END


CREATE TABLE Asistencia (
    AsistenciaID INT PRIMARY KEY IDENTITY(1,1),
    SocioID INT FOREIGN KEY REFERENCES Socios(SocioID),
    SucursalID INT FOREIGN KEY REFERENCES Sucursales(SucursalID),
    Fecha DATE
);

DECLARE @Mes INT = 1;
DECLARE @DiaSemana INT;
DECLARE @Frecuencia INT;
DECLARE @FechaAsistencia DATE;
DECLARE @SocioID INT;
DECLARE @SucursalID INT;

-- Bucle para los 12 meses del año
WHILE @Mes <= 12
BEGIN
    -- Generar la cantidad de días de asistencia para cada socio en el mes
    DECLARE @i INT = 1;
    DECLARE @CantidadSocios INT = (SELECT COUNT(*) FROM Socios WHERE MONTH(FechaInscripcion) <= @Mes);
    
    WHILE @i <= @CantidadSocios
    BEGIN
        -- Obtener un SocioID aleatorio
        SET @SocioID = (SELECT SocioID FROM Socios ORDER BY NEWID() OFFSET @i-1 ROWS FETCH NEXT 1 ROWS ONLY);
        
        -- Asignar una sucursal aleatoria
        SET @SucursalID = (SELECT SucursalID FROM Socios WHERE SocioID = @SocioID);
        
        -- Determinar la frecuencia de asistencia del socio (de 2 a 5 días por semana)
        SET @Frecuencia = FLOOR(RAND() * 4) + 2;

        -- Generar días aleatorios de asistencia en el mes, excluyendo domingos
        DECLARE @j INT = 1;
        WHILE @j <= @Frecuencia
        BEGIN
            -- Generar un día de la semana aleatorio (1-6: Lunes a Sábado)
            SET @DiaSemana = FLOOR(RAND() * 6) + 1;

            -- Asignar la fecha correspondiente
            SET @FechaAsistencia = DATEADD(WEEK, @Mes - 1, '2024-01-01');
            SET @FechaAsistencia = DATEADD(DAY, (@DiaSemana - 1) - DATEPART(WEEKDAY, @FechaAsistencia) + 7 * (FLOOR(RAND() * 4)), @FechaAsistencia);

            -- Insertar en la tabla de asistencia
            INSERT INTO Asistencia (SocioID, SucursalID, Fecha) 
            VALUES (@SocioID, @SucursalID, @FechaAsistencia);

            -- Incrementar contador de días de asistencia
            SET @j = @j + 1;
        END

        -- Incrementar contador de socios
        SET @i = @i + 1;
    END
    
    -- Avanzar al siguiente mes
    SET @Mes = @Mes + 1;
END


CREATE TABLE Staff (
    StaffID INT PRIMARY KEY IDENTITY(1,1),  -- Identificador único del staff
    SucursalID INT FOREIGN KEY REFERENCES Sucursales(SucursalID),  -- Relaciona con la sucursal
    Nombre VARCHAR(100),  -- Nombre del empleado
    Apellido VARCHAR(100),  -- Apellido del empleado
    Rol VARCHAR(50),  -- Rol del empleado (Entrenador, Recepcionista, etc.)
    FechaIngreso DATE,  -- Fecha de ingreso al gimnasio
    Email VARCHAR(100),  -- Correo electrónico
    Telefono VARCHAR(20)  -- Número de teléfono
);

DECLARE @SucursalID INT;
DECLARE @Rol VARCHAR(50);
DECLARE @Nombre VARCHAR(100);
DECLARE @Apellido VARCHAR(100);
DECLARE @FechaIngreso DATE;
DECLARE @Email VARCHAR(100);
DECLARE @Telefono VARCHAR(20);

-- Población de la tabla Staff
SET @SucursalID = 1;

-- Generar entre 5 y 10 empleados por sucursal
DECLARE @i INT = 1;
WHILE @i <= 10
BEGIN
    -- Asignar un rol aleatorio
    SET @Rol = (CASE 
                    WHEN FLOOR(RAND() * 2) = 0 THEN 'Entrenador'
                    ELSE 'Recepcionista'
                END);

    -- Nombre y Apellido aleatorio (lista de ejemplo)
    SET @Nombre = (CASE 
                    WHEN @SucursalID = 1 THEN 'Juan'
                    WHEN @SucursalID = 2 THEN 'Ana'
                    ELSE 'Pedro'
                END);

    SET @Apellido = (CASE 
                    WHEN @SucursalID = 1 THEN 'Gomez'
                    WHEN @SucursalID = 2 THEN 'Lopez'
                    ELSE 'Perez'
                END);

    -- Fecha de ingreso aleatoria (entre 1 y 5 años atrás)
    SET @FechaIngreso = DATEADD(YEAR, -(FLOOR(RAND() * 5) + 1), GETDATE());

    -- Generar un correo electrónico básico
    SET @Email = CONCAT(LOWER(@Nombre), '.', LOWER(@Apellido), '@gimnasio.com');

    -- Generar un teléfono aleatorio (con código de área)
    SET @Telefono = CONCAT('381', FLOOR(RAND() * 1000000000));

    -- Insertar el nuevo empleado en la tabla Staff
    INSERT INTO Staff (SucursalID, Nombre, Apellido, Rol, FechaIngreso, Email, Telefono)
    VALUES (@SucursalID, @Nombre, @Apellido, @Rol, @FechaIngreso, @Email, @Telefono);

    -- Incrementar el contador
    SET @i = @i + 1;
END

-- Repetir para las otras sucursales
SET @SucursalID = 2;
SET @i = 1;

WHILE @i <= 10
BEGIN
    -- Asignar un rol aleatorio
    SET @Rol = (CASE 
                    WHEN FLOOR(RAND() * 2) = 0 THEN 'Entrenador'
                    ELSE 'Recepcionista'
                END);

    -- Nombre y Apellido aleatorio
    SET @Nombre = (CASE 
                    WHEN @SucursalID = 1 THEN 'Juan'
                    WHEN @SucursalID = 2 THEN 'Ana'
                    ELSE 'Pedro'
                END);

    SET @Apellido = (CASE 
                    WHEN @SucursalID = 1 THEN 'Gomez'
                    WHEN @SucursalID = 2 THEN 'Lopez'
                    ELSE 'Perez'
                END);

    -- Fecha de ingreso aleatoria
    SET @FechaIngreso = DATEADD(YEAR, -(FLOOR(RAND() * 5) + 1), GETDATE());

    -- Generar un correo electrónico básico
    SET @Email = CONCAT(LOWER(@Nombre), '.', LOWER(@Apellido), '@gimnasio.com');

    -- Generar un teléfono aleatorio
    SET @Telefono = CONCAT('381', FLOOR(RAND() * 1000000000));

    -- Insertar el nuevo empleado en la tabla Staff
    INSERT INTO Staff (SucursalID, Nombre, Apellido, Rol, FechaIngreso, Email, Telefono)
    VALUES (@SucursalID, @Nombre, @Apellido, @Rol, @FechaIngreso, @Email, @Telefono);

    -- Incrementar el contador
    SET @i = @i + 1;
END

SET @SucursalID = 3;
SET @i = 1;

WHILE @i <= 10
BEGIN
    -- Asignar un rol aleatorio
    SET @Rol = (CASE 
                    WHEN FLOOR(RAND() * 2) = 0 THEN 'Entrenador'
                    ELSE 'Recepcionista'
                END);

    -- Nombre y Apellido aleatorio
    SET @Nombre = (CASE 
                    WHEN @SucursalID = 1 THEN 'Juan'
                    WHEN @SucursalID = 2 THEN 'Ana'
                    ELSE 'Pedro'
                END);

    SET @Apellido = (CASE 
                    WHEN @SucursalID = 1 THEN 'Gomez'
                    WHEN @SucursalID = 2 THEN 'Lopez'
                    ELSE 'Perez'
                END);

    -- Fecha de ingreso aleatoria
    SET @FechaIngreso = DATEADD(YEAR, -(FLOOR(RAND() * 5) + 1), GETDATE());

    -- Generar un correo electrónico básico
    SET @Email = CONCAT(LOWER(@Nombre), '.', LOWER(@Apellido), '@gimnasio.com');

    -- Generar un teléfono aleatorio
    SET @Telefono = CONCAT('381', FLOOR(RAND() * 1000000000));

    -- Insertar el nuevo empleado en la tabla Staff
    INSERT INTO Staff (SucursalID, Nombre, Apellido, Rol, FechaIngreso, Email, Telefono)
    VALUES (@SucursalID, @Nombre, @Apellido, @Rol, @FechaIngreso, @Email, @Telefono);

    -- Incrementar el contador
    SET @i = @i + 1;
END


CREATE TABLE Planes (
    PlanID INT PRIMARY KEY IDENTITY(1,1),
    SucursalID INT FOREIGN KEY REFERENCES Sucursales(SucursalID),
    NombrePlan VARCHAR(100),
    Descripcion VARCHAR(255),
    PrecioMensual DECIMAL(10,2)
);


CREATE TABLE Facturacion (
    FacturaID INT PRIMARY KEY IDENTITY(1,1),
    SocioID INT FOREIGN KEY REFERENCES Socios(SocioID),
    SucursalID INT FOREIGN KEY REFERENCES Sucursales(SucursalID),
    ProductoID INT, -- Puede ser NULL si es solo inscripción
    PlanID INT,     -- Puede ser NULL si es solo compra de productos
    FechaFactura DATE NOT NULL,
    Monto DECIMAL(10,2) NOT NULL,
    MetodoPago VARCHAR(50), -- Efectivo, tarjeta, transferencia, etc.
    Descripcion VARCHAR(255)
);

ALTER TABLE Facturacion
ADD FechaFactura DATETIME;

ALTER TABLE Facturacion
ADD Descripcion VARCHAR(255);

INSERT INTO Facturacion (VentaID, SucursalID, FechaFactura, Monto, MetodoPago, Descripcion)
SELECT 
    pv.VentaID,
    pv.SucursalID,
    pv.FechaVenta AS FechaFactura,  -- Usamos la fecha de venta para la factura
    pv.TotalVenta AS Monto,
    'Efectivo', -- Puedes cambiar el método de pago según sea necesario
    CONCAT('Venta de producto: ', pv.ProductoNombre, ' (x', pv.CantidadVendida, ')') AS Descripcion
FROM ProductosVendidos pv;


INSERT INTO Facturacion (VentaID, SucursalID, FechaFactura, Monto, MetodoPago, Descripcion)
SELECT 
    pv.VentaID,
    pv.SucursalID,
    pv.FechaVenta AS FechaFactura,  -- Usamos la fecha de venta como FechaFactura
    pv.TotalVenta AS Monto,
    'Efectivo', -- Método de pago, puede ajustarse según corresponda
    CONCAT('Venta de producto: ', pv.ProductoNombre, ' (x', pv.CantidadVendida, ')') AS Descripcion
FROM ProductosVendidos pv;


INSERT INTO Planes (SucursalID, NombrePlan, Descripcion, PrecioMensual)
VALUES 
-- Sede Park
(1, 'Fullpass', 'Acceso completo a todas las instalaciones y clases', 45000),
(1, 'Economy', 'Acceso a áreas básicas y clases limitadas', 35000),
(1, 'Musculación', 'Acceso solo a máquinas de musculación', 30000),

-- Av Patria
(2, 'Fullpass', 'Acceso completo a todas las instalaciones y clases', 45000),
(2, 'Economy', 'Acceso a áreas básicas y clases limitadas', 35000),
(2, 'Musculación', 'Acceso solo a máquinas de musculación', 30000),

-- 24 de Septiembre
(3, 'Fullpass', 'Acceso completo a todas las instalaciones y clases', 45000),
(3, 'Economy', 'Acceso a áreas básicas y clases limitadas', 35000),
(3, 'Musculación', 'Acceso solo a máquinas de musculación', 30000);


select * from Asistencia

-- Generar asistencias de mayo a diciembre 2024
-- Cantidad estable de socios activos hasta septiembre
-- Más asistencia desde octubre por nuevas inscripciones

DECLARE @FechaInicio DATE = '2024-05-01';
DECLARE @FechaFin DATE = '2024-12-31';

-- Simular por cada día
WHILE @FechaInicio <= @FechaFin
BEGIN
    -- Solo lunes a sábado
    IF DATENAME(WEEKDAY, @FechaInicio) NOT IN ('Sunday')
    BEGIN
        -- Insertar asistencia para socios activos a esa fecha
        INSERT INTO Asistencia (SocioID, Fecha, SucursalID)
        SELECT TOP (
            CASE 
                WHEN MONTH(@FechaInicio) < 10 THEN 100  -- Mayo a septiembre: 100 asistencias diarias aprox
                WHEN MONTH(@FechaInicio) BETWEEN 10 AND 11 THEN 130  -- Octubre-noviembre: sube
                ELSE 150  -- Diciembre más alto
            END
        ) 
        S.SocioID,
        @FechaInicio AS Fecha,
        FLOOR(RAND(CHECKSUM(NEWID())) * 3) + 1 AS SucursalID  -- SucursalID aleatorio del 1 al 3
        FROM Socios S
        WHERE S.FechaInscripcion <= @FechaInicio
        ORDER BY NEWID(); -- aleatoriza qué socios asisten
    END

    -- Mover asistencias de enero (mes 1) a octubre (mes 10)
UPDATE Asistencia
SET Fecha = DATEADD(MONTH, 9, Fecha)
WHERE MONTH(Fecha) = 1;

-- Mover asistencias de febrero (mes 2) a noviembre (mes 11)
UPDATE Asistencia
SET Fecha = DATEADD(MONTH, 9, Fecha)
WHERE MONTH(Fecha) = 2;

-- Mover asistencias de marzo (mes 3) a diciembre (mes 12)
UPDATE Asistencia
SET Fecha = DATEADD(MONTH, 9, Fecha)
WHERE MONTH(Fecha) = 3;

-- Mover asistencias de abril (mes 4) a enero del siguiente año (mes 1)
UPDATE Asistencia
SET Fecha = DATEADD(YEAR, 1, DATEADD(MONTH, -3, Fecha))
WHERE MONTH(Fecha) = 4;


SELECT * FROM Asistencia
