--
-- 1. CREACIÓN DE LA BASE DE DATOS Y TABLAS
--
-- Se crean las tablas en el orden correcto para evitar errores de llaves foráneas.
--

CREATE DATABASE EMPRESA_VIAJES;
USE EMPRESA_VIAJES;

-- Tablas principales (sin dependencias)
CREATE TABLE provincias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL
);

CREATE TABLE empresas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_empresa VARCHAR(50) NOT NULL
);

CREATE TABLE tipos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    precio_tipo DECIMAL(10,2)
);

CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    apellido VARCHAR(20) NOT NULL
);

CREATE TABLE fechas (
  id_fechas INT AUTO_INCREMENT PRIMARY KEY,
  fecha DATE NOT NULL
);

-- Tablas que dependen de las anteriores
CREATE TABLE ciudades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    provincias_id INT,
    FOREIGN KEY (provincias_id) REFERENCES provincias(id)
);

CREATE TABLE tramos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    origen_id INT,
    destino_id INT,
    distancia_km DECIMAL(6,2),
    precio_tramo DECIMAL(10,2),
    FOREIGN KEY (origen_id) REFERENCES ciudades(id),
    FOREIGN KEY (destino_id) REFERENCES ciudades(id)
);

CREATE TABLE viajes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_ciudad_origen INT,
    id_ciudad_destino INT,
    FOREIGN KEY (id_ciudad_origen) REFERENCES ciudades(id),
    FOREIGN KEY (id_ciudad_destino) REFERENCES ciudades(id)
);

CREATE TABLE colectivos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pisos INT,
    empresa_id INT,
    id_viajes INT,
    FOREIGN KEY (empresa_id) REFERENCES empresas(id),
    FOREIGN KEY (id_viajes) REFERENCES viajes(id)
);

CREATE TABLE colectivos_fechas (
  id_colectivo_fecha INT AUTO_INCREMENT PRIMARY KEY,
  id_fechas INT,
  id_colectivos INT,
  FOREIGN KEY (id_fechas) REFERENCES fechas(id_fechas),
  FOREIGN KEY (id_colectivos) REFERENCES colectivos(id)
);

CREATE TABLE asiento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    disponible BOOLEAN,
    fk_colectivos INT,
    fk_tipo INT,
    numero_asiento INT,
    FOREIGN KEY (fk_colectivos) REFERENCES colectivos(id),
    FOREIGN KEY (fk_tipo) REFERENCES tipos(id)
);

CREATE TABLE viajes_tramos (
    id_tramos INT,
    id_viajes INT,
    serie INT,
    PRIMARY KEY (id_tramos, id_viajes, serie),
    FOREIGN KEY (id_tramos) REFERENCES tramos(id),
    FOREIGN KEY (id_viajes) REFERENCES viajes(id)
);

CREATE TABLE pasajes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_viaje INT,
    id_asiento INT,
    id_colectivos_fechas INT,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id),
    FOREIGN KEY (id_viaje) REFERENCES viajes(id),
    FOREIGN KEY (id_asiento) REFERENCES asiento(id),
    FOREIGN KEY (id_colectivos_fechas) REFERENCES colectivos_fechas(id_colectivo_fecha),
    UNIQUE (id_viaje, id_asiento)
);

CREATE TABLE pasaje_tramos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_pasaje INT,
    id_tramos INT,
    precio_pasaje DECIMAL(10,2),
    FOREIGN KEY (id_pasaje) REFERENCES pasajes(id),
    FOREIGN KEY (id_tramos) REFERENCES tramos(id)
);


--
-- 2. INSERCIÓN DE DATOS
--
-- Se insertan los datos en el mismo orden que se crearon las tablas.
--

-- Provincias
INSERT INTO provincias (nombre)
VALUES
  ('Córdoba'),
  ('Buenos Aires'),
  ('Santa Fe'),
  ('Neuquén'),
  ('Río Negro'),
  ('Entre Ríos'),
  ('Mendoza');

-- Empresas
INSERT INTO empresas (nombre_empresa)
VALUES
  ('Loco Viajes'),
  ('El Transportador'),
  ('DoggoFast');

-- Tipos de asiento
INSERT INTO tipos (nombre, precio_tipo)
VALUES
  ('SemiCama', 1000.00),
  ('Cama', 2000.00),
  ('Ejecutivo', 5000.00);

-- Clientes
INSERT INTO clientes (nombre, apellido)
VALUES
  ('Juan', 'Pérez'),
  ('María','Gómez'),
  ('Roque','Redruello'),
  ('Israel','Lapier'),
  ('Carlos','Ramirez'),
  ('Emilia','Dominguez'),
  ('Mateo','Reipal'),
  ('Oscar','Piastri'),
  ('Carlos','Sainz'),
  ('Franco','Colapinto'),
  ('Fernando','Alonso');

--Repetidos
INSERT INTO clientes (nombre,apellido) VALUES 
('Peter','Chero'),
('Clara','Lapier'),
('Blanca','Quevedo');



-- Fechas
INSERT INTO fechas (fecha) VALUES
  ('2025-06-29'),
  ('2025-07-29'),
  ('2025-08-29');

-- Ciudades
-- Se ajustó el provincias_id a los nuevos datos insertados
INSERT INTO ciudades (nombre, provincias_id) VALUES
  ('Córdoba', 1),
  ('Rosario', 3),
  ('Santa Fe', 3),
  ('Paraná', 6),
  ('Buenos Aires', 2),
  ('Mendoza', 7),
  ('San Luis', 7),
  ('Río Cuarto', 1),
  ('Villa María', 1),
  ('Mar del Plata', 2),
  ('Miramar', 2),
  ('Necochea', 2),
  ('Tres Arroyos', 2),
  ('Bahía Blanca', 2),
  ('Venado Tuerto', 3),
  ('General Villegas', 2),
  ('Neuquén', 4),
  ('Bariloche', 5),
  ('Monte Hermoso', 2),
  ('Monte Buey', 1),
  ('Monte Vera', 3),
  ('Monte Redondo', 6),
  ('Monte Comán', 7);

-- Viajes (Se crea la tabla antes de colectivos)
INSERT INTO viajes (id_ciudad_origen, id_ciudad_destino) VALUES
  (5, 1),  -- Buenos Aires - Córdoba
  (6, 1),  -- Mendoza - Córdoba
  (10, 14), -- Mar del Plata - Bahía Blanca
  (2, 18); -- Rosario - Bariloche

-- Colectivos
-- Ahora sí podemos insertar en colectivos, ya que la tabla viajes existe
INSERT INTO colectivos (pisos, empresa_id, id_viajes)
VALUES
  (1, 1, 1),   -- colectivo Loco Viajes, viaje 1
  (2, 2, 2),   -- colectivo El Transportador, viaje 2
  (1, 3, 3),   -- colectivo DoggoFast, viaje 3
  (2, 1, 4);   -- colectivo Loco Viajes, viaje 4

-- Asientos
-- Se insertan los asientos para los 4 colectivos creados
INSERT INTO asiento (disponible, fk_colectivos, fk_tipo, numero_asiento)
VALUES
  (TRUE,  1, 1, 1),
  (TRUE,  1, 2, 2),
  (TRUE,  1, 3, 3),
  (TRUE,  1, 1, 4),
  (TRUE,  2, 1, 1),
  (TRUE,  2, 2, 2),
  (TRUE,  2, 3, 3),
  (TRUE,  2, 1, 4),
  (TRUE,  3, 1, 1),
  (TRUE,  3, 2, 2),
  (TRUE,  3, 3, 3),
  (TRUE,  3, 1, 4),
  (TRUE,  4, 1, 1),
  (TRUE,  4, 2, 2),
  (TRUE,  4, 3, 3),
  (TRUE,  4, 1, 4);

-- Tramos
-- Se cambió el nombre de la columna 'id_tramos' a 'id'
INSERT INTO tramos (origen_id, destino_id, distancia_km, precio_tramo) VALUES
  (5, 2, 300, 3000), -- Tramo 1: Buenos Aires - Rosario
  (2, 3, 170, 1700), -- Tramo 2: Rosario - Santa Fe
  (3, 4, 35,  350),  -- Tramo 3: Santa Fe - Paraná
  (4, 1, 270, 2700), -- Tramo 4: Paraná - Córdoba
  (6, 7, 260, 2600), -- Tramo 5: Mendoza - San Luis
  (7, 8, 220, 2200), -- Tramo 6: San Luis - Río Cuarto
  (8, 1, 190, 1900), -- Tramo 7: Río Cuarto - Córdoba
  (10, 11, 50,  500), -- Tramo 8: Mar del Plata - Miramar
  (11, 12, 130, 1300),-- Tramo 9: Miramar - Necochea
  (12, 13, 140, 1400),-- Tramo 10: Necochea - Tres Arroyos
  (13, 14, 180, 1800),-- Tramo 11: Tres Arroyos - Bahía Blanca
  (2, 15, 170, 1700),  -- Tramo 12: Rosario - Venado Tuerto
  (15, 16, 200, 2000), -- Tramo 13: Venado tuerto - General Villegas
  (16, 17, 470, 4700), -- Tramo 14: General Villegas - Neuquén
  (17, 18, 440, 4400); -- Tramo 15: Neuquén - Bariloche

-- Tramos de los viajes
INSERT INTO viajes_tramos (id_tramos, id_viajes, serie) VALUES
  (1, 1, 1), (2, 1, 2), (3, 1, 3), (4, 1, 4), -- Tramos del viaje 1
  (5, 2, 1), (6, 2, 2), (7, 2, 3),             -- Tramos del viaje 2
  (8, 3, 1), (9, 3, 2), (10, 3, 3), (11, 3, 4), -- Tramos del viaje 3
  (12, 4, 1), (13, 4, 2), (14, 4, 3), (15, 4, 4); -- Tramos del viaje 4

-- Colectivos_fechas
-- Asocia un colectivo a una fecha de viaje
INSERT INTO colectivos_fechas (id_fechas, id_colectivos) VALUES
(1, 1), -- Colectivo 1 (viaje 1) para la fecha 1
(2, 2), -- Colectivo 2 (viaje 2) para la fecha 2
(3, 3), -- Colectivo 3 (viaje 3) para la fecha 3
(1, 4); -- Colectivo 4 (viaje 4) para la fecha 1


-- Pasajes
INSERT INTO pasajes (id_cliente, id_viaje, id_asiento, id_colectivos_fechas) VALUES
-- Juan Pérez (cliente 1) - Viaje 1 (Buenos Aires - Córdoba), Asiento 1, Fecha 1
(1, 1, 1, 1),
-- María Gómez (cliente 2) - Viaje 2 (Mendoza - Córdoba), Asiento 5, Fecha 2
(2, 2, 5, 2),
-- Roque Redruello (cliente 3) - Viaje 4 (Rosario - Bariloche), Asiento 13, Fecha 1
(3, 4, 13, 1);

-- Pasaje duplicado
INSERT INTO pasajes (id_cliente, id_viaje, id_asiento, id_colectivos_fechas) VALUES 

-- Pedro Chero (cliente 12) - Viaje 1 (Buenos Aires - Cordoba), Asiento 1 Fecha 1
(12,1,1,1);


-- Pasaje_tramos
-- Inserta los tramos para el pasaje de Juan Pérez (pasaje 1)
INSERT INTO pasaje_tramos (id_pasaje, id_tramos, precio_pasaje) VALUES
  (1, 1, 3000), (1, 2, 1700), (1, 3, 350), (1, 4, 2700);

-- Inserta los tramos para el pasaje de María Gómez (pasaje 2)
INSERT INTO pasaje_tramos (id_pasaje, id_tramos, precio_pasaje) VALUES
  (2, 5, 2600), (2, 6, 2200), (2, 7, 1900);

-- Inserta los tramos para el pasaje de Roque Redruello (pasaje 3)
INSERT INTO pasaje_tramos (id_pasaje, id_tramos, precio_pasaje) VALUES
  (3, 12, 1700), (3, 13, 2000), (3, 14, 4700), (3, 15, 4400);

--
-- 3. CONSULTAS Y LÓGICA DE NEGOCIO
--

-- Consigna 1: Cantidad de servicios agrupados por empresa desde Rosario a Bariloche.
SELECT
    e.nombre_empresa AS empresa,
    v.id AS id_viaje,
    o.nombre AS origen,
    d.nombre AS destino,
    COUNT(a.id) AS cantidad_asientos
FROM empresas e
JOIN colectivos c ON e.id = c.empresa_id
JOIN asiento a ON c.id = a.fk_colectivos
JOIN viajes v ON c.id_viajes = v.id
JOIN ciudades o ON v.id_ciudad_origen = o.id
JOIN ciudades d ON v.id_ciudad_destino = d.id
WHERE o.nombre = 'Rosario' AND d.nombre = 'Bariloche'
GROUP BY e.nombre_empresa, v.id, o.nombre, d.nombre;


-- Consigna 2: Listado de pasajeros frecuentes: Los tres viajeros con más viajes en el último año.
-- Se corrige la consulta original, ya que la tabla "colectivos_fechas" es necesaria para vincular los viajes a una fecha.
SELECT
  c.apellido,
  c.nombre,
  COUNT(p.id) AS cantidad_viajes
FROM clientes c
JOIN pasajes p ON c.id = p.id_cliente
JOIN colectivos_fechas cf ON p.id_colectivos_fechas = cf.id_colectivo_fecha
JOIN fechas f ON cf.id_fechas = f.id_fechas
WHERE f.fecha >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY
  c.id, c.apellido, c.nombre
ORDER BY cantidad_viajes DESC
LIMIT 3;

-- Consigna 3: Servicios que aún no tienen reservas de asientos, indicando nombre de la empresa, fecha del viaje, origen y destino final.
-- Se ajusta la consulta para que muestre los viajes que no tienen pasajes.
SELECT
    e.nombre_empresa AS empresa,
    f.fecha AS fecha_viaje,
    co.nombre AS origen,
    cd.nombre AS destino
FROM viajes v
JOIN colectivos c ON v.id = c.id_viajes
JOIN empresas e ON c.empresa_id = e.id
JOIN colectivos_fechas cf ON c.id = cf.id_colectivos
JOIN fechas f ON cf.id_fechas = f.id_fechas
WHERE v.id NOT IN (SELECT DISTINCT id_viaje FROM pasajes);


-- Consigna 4: Listado de localidades que incluyan la palabra “monte”, indicando la provincia a la que pertenecen.
SELECT
  c.nombre AS ciudad,
  p.nombre AS provincia
FROM ciudades c
JOIN provincias p ON c.provincias_id = p.id
WHERE c.nombre LIKE '%Monte%';

-- Consiga extra
SELECT  *, COUNT(*) AS cantidad
FROM pasajes
GROUP BY  id_asiento
HAVING COUNT (*) > 1;

SHOW CREATE TABLE pasajes;

ALTER TABLE pasajes DROP FOREIGN KEY pasajes_ibfk_2;

ALTER TABLE pasajes DROP  INDEX id_viaje;

ALTER TABLE pasajes ADD CONSTRAINT pasajes_ibfk_2 FOREIGN KEY(id_viaje) REFERENCES viajes(id);	

-- Consigna-promocion Numero 1 
SELECT  
		c.nombre AS NombrePasajero,
		p.id_asiento AS NumeroAsiento,
		o.nombre AS CiudadOrigen,
		d.nombre AS CiudadDestino,
		f.fecha AS FechaViaje,
		em.nombre_empresa AS NombreEmpresa
FROM pasajes p
JOIN clientes c ON p.id_cliente = c.id
JOIN viajes v ON p.id_viaje = v.id 
JOIN ciudades o ON v.id_ciudad_origen = o.id
JOIN ciudades d ON v.id_ciudad_destino = d.id
JOIN colectivos_fechas cf ON p.id_colectivos_fechas = cf.id_colectivo_fecha
JOIN fechas f ON cf.id_fechas = f.id_fechas 
JOIN colectivos co ON cf.id_colectivos = co.id
JOIN empresas em ON co.empresa_id = em.id
WHERE (p.id_viaje, p.id_asiento) IN  (
	SELECT 
	id_viaje,
	id_asiento
	FROM
	pasajes
	GROUP BY
	id_viaje,
	id_asiento 
	HAVING
	COUNT(*) > 1 
	
);

-- Consigna-promocion Numero 2
SELECT
  a.numero_asiento AS NumeroAsiento,
  t.nombre AS TipoAsiento
FROM asiento a
JOIN colectivos c ON a.fk_colectivos = c.id
LEFT JOIN pasajes p ON a.id = p.id_asiento AND p.id_viaje = c.id_viajes
JOIN tipos t ON a.fk_tipo = t.id
WHERE
  c.id_viajes = 334
  AND p.id IS NULL;

-- Valores nuevos viaje

-- Nuevo viaje: Córdoba -> Mendoza
INSERT INTO viajes (id_ciudad_origen, id_ciudad_destino) VALUES (1, 6);
-- Nuevo colectivo para este viaje
INSERT INTO colectivos (pisos, empresa_id, id_viajes) VALUES (1, 1, (SELECT id FROM viajes ORDER BY id DESC LIMIT 1));
-- Nueva fecha 
INSERT INTO fechas (fecha) VALUES ('2025-09-18');
-- Asociar el colectivo y la fecha
INSERT INTO colectivos_fechas (id_fechas, id_colectivos) VALUES ((SELECT id_fechas FROM fechas ORDER BY id_fechas DESC LIMIT 1), (SELECT id FROM colectivos ORDER BY id DESC LIMIT 1));

-- Valores nuevos asientos

-- Asientos para el nuevo colectivo (suponiendo que su id es 5)
INSERT INTO asiento (disponible, fk_colectivos, fk_tipo, numero_asiento) VALUES
(TRUE, 5, 1, 15),
(TRUE, 5, 2, 16);


-- Pasaje duplicado

-- Venta del pasaje original
INSERT INTO pasajes (id_cliente, id_viaje, id_asiento, id_colectivos_fechas) VALUES
(1, (SELECT id FROM viajes ORDER BY id DESC LIMIT 1), (SELECT id FROM asiento WHERE numero_asiento = 15 AND fk_colectivos = 5), (SELECT id_colectivo_fecha FROM colectivos_fechas ORDER BY id_colectivo_fecha DESC LIMIT 1));
-- Venta del pasaje duplicado para el mismo asiento y viaje
INSERT INTO pasajes (id_cliente, id_viaje, id_asiento, id_colectivos_fechas) VALUES
(2, (SELECT id FROM viajes ORDER BY id DESC LIMIT 1), (SELECT id FROM asiento WHERE numero_asiento = 15 AND fk_colectivos = 5), (SELECT id_colectivo_fecha FROM colectivos_fechas ORDER BY id_colectivo_fecha DESC LIMIT 1));

-- pasajes extra para el viaje Buenos Aires - Córdoba
INSERT INTO pasajes (id_cliente, id_viaje, id_asiento, id_colectivos_fechas) VALUES
(4, 1, 2, 1),
(5, 1, 3, 1),
(6, 1, 4, 1);

-- Inserta un nuevo viaje con el ID 334
INSERT INTO viajes (id, id_ciudad_origen, id_ciudad_destino)
VALUES (334, 2, 18); -- Ejemplo: Rosario a Bariloche

-- Inserta un nuevo colectivo para el viaje 334
INSERT INTO colectivos (pisos, empresa_id, id_viajes)
VALUES (2, 2, 334); -- Ejemplo: 2 pisos, de la empresa 2 (El Transportador)

--  Inserta una nueva fecha para el viaje
INSERT INTO fechas (fecha)
VALUES ('2025-06-23');

--  colectivo con la fecha en colectivos_fechas
INSERT INTO colectivos_fechas (id_fechas, id_colectivos)
VALUES ((SELECT id_fechas FROM fechas ORDER BY id_fechas DESC LIMIT 1), (SELECT id FROM colectivos ORDER BY id DESC LIMIT 1));

--  Inserta asientos para el nuevo colectivo

INSERT INTO asiento (disponible, fk_colectivos, fk_tipo, numero_asiento)
VALUES
(TRUE, (SELECT id FROM colectivos ORDER BY id DESC LIMIT 1), 1, 12),
(TRUE, (SELECT id FROM colectivos ORDER BY id DESC LIMIT 1), 2, 18),
(TRUE, (SELECT id FROM colectivos ORDER BY id DESC LIMIT 1), 3, 22),
(TRUE, (SELECT id FROM colectivos ORDER BY id DESC LIMIT 1), 1, 23);

 Insertar pasajes para demostrar que algunos asientos están "ocupados"
INSERT INTO pasajes (id_cliente, id_viaje, id_asiento, id_colectivos_fechas)
VALUES
(1, 334, (SELECT id FROM asiento WHERE numero_asiento = 12 AND fk_colectivos = (SELECT id FROM colectivos ORDER BY id DESC LIMIT 1)), (SELECT id_colectivo_fecha FROM colectivos_fechas ORDER BY id_colectivo_fecha DESC LIMIT 1));



