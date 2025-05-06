use Genesis

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