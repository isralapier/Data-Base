
CREATE DATABASE TPCOLECTIVOS;
USE TPCOLECTIVOS;

-- Creación de tablas

CREATE TABLE provincias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20)
);


CREATE TABLE ciudades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20),
    provincias_id INT,
    FOREIGN KEY (provincias_id) REFERENCES provincias(id)
);


CREATE TABLE empresas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_empresa VARCHAR(20)
);

CREATE TABLE colectivos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pisos INT,
    empresa_id INT,
    FOREIGN KEY (empresa_id) REFERENCES empresas(id)
);

use TPCOLECTIVOS;
ALTER TABLE colectivos 
    ADD COLUMN id_viajes int;

ALTER TABLE colectivos
    ADD CONSTRAINT fk_id_viajes 
FOREIGN KEY(id_viajes) REFERENCES viajes(id);

UPDATE colectivos SET id_viajes = 4 WHERE id = 1;
UPDATE colectivos SET id_viajes = 1 WHERE id = 2;
UPDATE colectivos SET id_viajes = 2 WHERE id = 3;

CREATE TABLE tipos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    precio_tipo DECIMAL(10,2)
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


CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    apellido VARCHAR(20)
);

ALTER TABLE clientes ADD COLUMN cantidad_pasajes int;


CREATE TABLE tramos (
    id_tramos INT AUTO_INCREMENT PRIMARY KEY,
    origen_id INT,
    destino_id INT,
    distancia_km DECIMAL(6,2),
    precio_tramo DECIMAL(10,2),
    FOREIGN KEY (origen_id) REFERENCES ciudades(id),
    FOREIGN KEY (destino_id) REFERENCES ciudades(id)
);


CREATE TABLE viajes (
    id_viajes INT AUTO_INCREMENT PRIMARY KEY,
    id_ciudad_origen INT,
    id_ciudad_destino INT,
    FOREIGN KEY (id_ciudad_origen) REFERENCES ciudades(id),
    FOREIGN KEY (id_ciudad_destino) REFERENCES ciudades(id)
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
    id_pasajes INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_viaje INT,
    id_asiento INT,
    fecha DATE,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id),
    FOREIGN KEY (id_viaje) REFERENCES viajes(id),
    FOREIGN KEY (id_asiento) REFERENCES asiento(id),
    UNIQUE (id_viaje, id_asiento)
);


CREATE TABLE pasaje_tramos (
    id_pasaje_tramos INT AUTO_INCREMENT PRIMARY KEY,
    id_pasaje INT,
    id_tramos INT,
    precio_pasaje DECIMAL(10,2),
    FOREIGN KEY (id_pasaje) REFERENCES pasajes(id),
    FOREIGN KEY (id_tramos) REFERENCES tramos(id)
);

-- INSERTS



INSERT INTO provincias (nombre)
VALUES
  ('Córdoba'),
  ('Buenos Aires'),
  ('Santa Fe');

INSERT INTO provincias (nombre)
VALUES ('Neuquén'), ('Río Negro');


INSERT INTO empresas (nombre_empresa)
VALUES
  ('Loco Viajes'),
  ('El Transportador'),
  ('DoggoFast');



INSERT INTO colectivos (pisos, empresa_id)
VALUES
  (1, 1),   -- colectivo Loco Viajes
  (2, 2),   -- colectivo El Transportador
  (1,3);    -- colectivo DoggoFast


  
  
INSERT INTO tipos (nombre, precio_tipo)
VALUES
  ('SemiCama', 1000.00),
  ('Cama',     2000.00),
  ('Ejecutivo', 5000.00);

INSERT INTO COLECTIVOS (pisos, id_empresa) VALUES
  (1, 1),
  (2, 2),
  (1, 3);

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



INSERT INTO asiento (disponible, fk_colectivos, fk_tipo, numero_asiento)
VALUES
  (TRUE,  1, 1, 1),
  (TRUE,  1, 1, 2),
  (TRUE,  1, 2, 3),
  (FALSE, 2, 1, 1);

INSERT INTO asiento (disponible, fk_colectivos, fk_tipo, numero_asiento) VALUES
  (TRUE,  1, 1, 1),
  (TRUE,  1, 2, 2),
  (TRUE,  1, 3, 3),
  (TRUE,  1, 1, 4),
  (TRUE,  1, 2, 5),
  (TRUE,  1, 3, 6),
  (TRUE,  1, 1, 7),
  (FALSE, 1, 2, 8),
  (FALSE, 1, 3, 9),
  (FALSE, 1, 1,10);

INSERT INTO asiento (disponible, fk_colectivos, fk_tipo, numero_asiento) VALUES
  (TRUE,  2, 2, 1),
  (TRUE,  2, 3, 2),
  (TRUE,  2, 1, 3),
  (TRUE,  2, 2, 4),
  (TRUE,  2, 3, 5),
  (TRUE,  2, 1, 6),
  (TRUE,  2, 2, 7),
  (FALSE, 2, 3, 8),
  (FALSE, 2, 1, 9),
  (FALSE, 2, 2,10);


INSERT INTO asiento (disponible, fk_colectivos, fk_tipo, numero_asiento) VALUES
  (TRUE,  3, 3, 1),
  (TRUE,  3, 1, 2),
  (TRUE,  3, 2, 3),
  (TRUE,  3, 3, 4),
  (TRUE,  3, 1, 5),
  (TRUE,  3, 2, 6),
  (TRUE,  3, 3, 7),
  (FALSE, 3, 1, 8),
  (FALSE, 3, 2, 9),
  (FALSE, 3, 3,10);


INSERT INTO ciudades (nombre, provincias_id) VALUES
  ('Buenos Aires', 1),
  ('Rosario', 3),
  ('Santa Fe', 3),
  ('Paraná', 3),
  ('Córdoba', 1),
  
  ('Mendoza', 1),
  ('San Luis', 1),
  ('Río Cuarto', 1),
  ('Villa María', 1),

  ('Mar del Plata', 2),
  ('Miramar', 2),
  ('Necochea', 2),
  ('Tres Arroyos', 2),
  ('Bahía Blanca', 2);

 INSERT INTO ciudades (nombre, provincias_id) VALUES
  ('Venado Tuerto', 3),    -- Santa Fe
  ('General Villegas', 1), -- Buenos Aires
  ('Neuquén', 7),          -- Neuquén
  ('Bariloche', 8);        -- Río Negro

  
  
  
INSERT INTO viajes (id_ciudad_origen, id_ciudad_destino) VALUES
  (1, 5),  -- Buenos Aires - Córdoba
  (6, 10), -- Mendoza - Córdoba
  (11, 14);-- Mar del Plata -Bahía Blanca

INSERT INTO viajes (id_ciudad_origen, id_ciudad_destino)
VALUES (2, 18); -- Rosario - Bariloche
  
  
  
-- Recorrido 1
INSERT INTO tramos (origen_id, destino_id, distancia_km, precio_tramo) VALUES
  (1, 2, 300, 3000),
  (2, 3, 170, 1700),
  (3, 4, 35,  350),
  (4, 5, 270, 2700);

-- Recorrido 2
INSERT INTO tramos (origen_id, destino_id, distancia_km, precio_tramo) VALUES
  (6, 7, 260, 2600),
  (7, 8, 220, 2200),
  (8, 9, 190, 1900);

-- Recorrido 12
INSERT INTO tramos (origen_id, destino_id, distancia_km, precio_tramo) VALUES
  (10, 11, 50,  500),
  (11, 12, 130, 1300),
  (12, 13, 140, 1400),
  (13, 14, 180, 1800);

INSERT INTO tramos (origen_id, destino_id, distancia_km, precio_tramo) VALUES
  (2, 15, 170, 1700), -- Rosario - Venado Tuerto
  (15, 16, 200, 2000), -- Venado tuerto - General Vallegas
  (16, 17, 470, 4700), -- General Vallegas -  Neuquén
  (17, 18, 440, 4400);  -- Neuquén - Bariloche


-- Tramos del viaje 1: Buenos Aires - Córdoba
INSERT INTO viajes_tramos (id_tramos, id_viajes, serie) VALUES
  (1, 1, 1),
  (2, 1, 2),
  (3, 1, 3),
  (4, 1, 4);

-- Tramos del viaje 2: Mendoza - Córdoba
INSERT INTO viajes_tramos (id_tramos, id_viajes, serie) VALUES
  (5, 2, 1),
  (6, 2, 2),
  (7, 2, 3);

-- Tramos del viaje 3: Mar del Plata - Bahía Blanca
INSERT INTO viajes_tramos (id_tramos, id_viajes, serie) VALUES
  (8, 3, 1),
  (9, 3, 2),
  (10, 3, 3),
  (11, 3, 4);

INSERT INTO viajes_tramos (id_tramos, id_viajes, serie) VALUES
  (13, 4, 1),
  (14, 4, 2),
  (15, 4, 3),
  (16, 4, 4);


SELECT id, origen_id, destino_id FROM tramos;


SELECT id, origen_id, destino_id FROM tramos;

show create table viajes;

SELECT 
  a.id AS id_asiento,
  e.nombre_empresa,
  t.precio_tipo AS precio_base,
  CASE e.id
    WHEN 1 THEN t.precio_tipo * 1
    WHEN 2 THEN t.precio_tipo * 1.3
    WHEN 3 THEN t.precio_tipo * 1.5
    ELSE t.precio_tipo
  END AS precio_final
FROM asiento a
JOIN colectivos c ON a.fk_colectivos = c.id
JOIN empresas e   ON c.empresa_id    = e.id
JOIN tipos t      ON a.fk_tipo       = t.id;





SELECT * FROM asiento WHERE disponible = TRUE;
SELECT * FROM viajes;

INSERT INTO pasajes (id_cliente, id_viaje, id_asiento, fecha)
VALUES (1, 1, 2, CURDATE());

SELECT id_tramos, precio_tramo
FROM viajes_tramos vt
JOIN tramos t ON vt.id_tramos = t.id
WHERE id_viajes = 4
ORDER BY serie;


SELECT * FROM pasajes WHERE id_cliente = 1 AND id_viaje = 1 ORDER BY id DESC LIMIT 1;

INSERT INTO pasaje_tramos (id_pasaje, id_tramos, precio_pasaje) VALUES
  (1, 1, 3000),
  (1, 2, 1700),
  (1, 3, 350),
  (1, 4, 2700);




SELECT 
  p.id AS id_pasaje,
  c.nombre,
  c.apellido,
  e.nombre_empresa,
  t.nombre AS tipo_asiento,
  SUM(pt.precio_pasaje) AS precio_base,
  CASE e.id
    WHEN 1 THEN SUM(pt.precio_pasaje) * 1
    WHEN 2 THEN SUM(pt.precio_pasaje) * 1.3
    WHEN 3 THEN SUM(pt.precio_pasaje) * 1.5
    ELSE SUM(pt.precio_pasaje)
  END AS precio_final
FROM pasajes p
JOIN clientes c        ON p.id   = c.id
JOIN asiento a         ON p.id_asiento    = a.id
JOIN colectivos col    ON a.fk_colectivos = col.id
JOIN empresas e        ON col.empresa_id  = e.id
JOIN tipos t           ON a.fk_tipo       = t.id
JOIN pasaje_tramos pt  ON p.id    = pt.id_pasaje
WHERE p.id = 1
GROUP BY p.id;





 
-- consigna 1.	Cantidad de servicios agrupados por empresa desde Rosario a Bariloche.

SELECT 
  e.nombre_empresa       AS empresa,
  o.nombre               AS origen,
  d.nombre               AS destino,
  t.nombre               AS tipo_servicio,
  COUNT(*)               AS cantidad_total
FROM asiento a
JOIN colectivos c        ON a.fk_colectivos = c.id
JOIN empresas e          ON c.empresa_id    = e.id
JOIN tipos t             ON a.fk_tipo       = t.id
JOIN viajes v            ON TRUE  
JOIN ciudades o          ON v.id_ciudad_origen  = o.id
JOIN ciudades d          ON v.id_ciudad_destino = d.id
WHERE o.nombre = 'Rosario'
  AND d.nombre = 'Bariloche'
GROUP BY e.nombre_empresa, o.nombre, d.nombre, t.nombre
ORDER BY e.nombre_empresa, tipo_servicio;
-- --------------------------------------------------------------------------------



INSERT INTO pasajes (id_cliente, id_viaje, id_asiento, fecha)
VALUES (2,2,2, CURDATE());



INSERT INTO pasaje_tramos (id_pasaje, id_tramos, precio_pasaje)

VALUES
(6, 5, 2600),
(6, 6, 2200);

INSERT INTO pasajes (id_cliente, id_viaje, id_asiento, fecha)
VALUES (3, 4, 2, CURDATE());

INSERT INTO pasaje_tramos (id_pasaje, id_tramos, precio_pasaje) VALUES
  (7, 12, 1700),  -- Rosario - Venado Tuerto
  (7, 13, 2000),  -- Venado Tuerto - General Villegas
  (7, 14, 4700),  -- General Villegas - Neuquén
  (7, 15, 4400);  -- Neuquén - Bariloche


INSERT INTO pasajes (id_cliente, id_viaje, id_asiento, fecha)
VALUES (3, 4,40, CURDATE());

USE TPCOLECTIVOS;

SELECT c.id, c.nombre, COUNT(p.id) AS viajes_comprados
FROM clientes c
LEFT JOIN pasajes p ON c.id = p.id_cliente
GROUP BY c.id, c.nombre;

-- CONSIGNA  2.	Listado de pasajeros frecuentes: Los tres viajeros (apellido, nombre y cantidad de viajes) con más viajes en el último año.


SELECT
  c.apellido,
  c.nombre,
  COUNT(p.id) AS cantidad_viajes
FROM clientes c
JOIN pasajes p
  ON c.id = p.id_cliente
JOIN colectivos_fechas cf
  ON p.id_colectivos_fechas = cf.id_colectivo_fecha
JOIN fechas f
  ON cf.id_fechas = f.id_fechas
WHERE f.fecha >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY
  c.id, c.apellido, c.nombre
ORDER BY cantidad_viajes DESC
LIMIT 3;
--      ---------------------------------------------------     

alter table clientes 
   drop column cantidad_pasajes ;

create table fechas 
  (id_fechas int auto_increment
  primary key, 
  fecha date);

create table colectivos_fechas (
  id_colectivo_fecha int AUTO_INCREMENT PRIMARY KEY,
  id_fechas int ,
  id_colectivos int , 
  CONSTRAINT fk_id_fechas FOREIGN KEY (id_fechas) REFERENCES fechas(id_fechas),
  CONSTRAINT fk_id_colectivos FOREIGN KEY (id_colectivos) REFERENCES colectivos(id)
  );

INSERT INTO fechas (fecha) VALUES ('2025-06-29');
INSERT INTO fechas (fecha) VALUES ('2025-07-29');
INSERT INTO fechas (fecha) VALUES ('2025-08-29');

insert INTO colectivos_fechas (id_fechas, id_colectivos) VALUES (1,1);
insert INTO colectivos_fechas (id_fechas, id_colectivos) VALUES (2,2);
insert INTO colectivos_fechas (id_fechas, id_colectivos) VALUES (3,3);

alter table pasajes drop fecha;

alter table pasajes add column id_colectivos_fechas int ,
add constraint fk_id_colectivos_fechas foreign key (id_colectivos_fechas) references colectivos_fechas(id_colectivo_fecha);

UPDATE pasajes SET id_colectivos_fechas = 3 where id=10;


-- consigna 3.	Servicios que aún no tienen reservas de asientos, indicando nombre de la empresa, fecha del viaje, origen y destino final.

SELECT
  e.nombre_empresa        AS empresa,
  t.nombre                AS tipo_servicio,
  f.fecha                 AS fecha_viaje,
  co.nombre               AS origen,
  cd.nombre               AS destino
FROM asiento a
JOIN colectivos c       ON a.fk_colectivos      = c.id
JOIN empresas e         ON c.empresa_id         = e.id
JOIN tipos t            ON a.fk_tipo            = t.id
JOIN colectivos_fechas cf ON c.id                = cf.id_colectivos
JOIN fechas f           ON cf.id_fechas         = f.id_fechas
JOIN viajes v           ON c.id_viajes          = v.id
JOIN ciudades co        ON v.id_ciudad_origen   = co.id
JOIN ciudades cd        ON v.id_ciudad_destino  = cd.id
WHERE a.disponible = TRUE
ORDER BY e.nombre_empresa, f.fecha;


-- -----------------------------------------------------------------------------------



-- Juan Pérez (cliente id 1)
INSERT INTO pasajes (id_cliente, id_viaje, id_asiento, id_colectivos_fechas) VALUES (1, 1, 45, 1);

-- María Gómez (id 2)
INSERT INTO pasajes (id_cliente, id_viaje, id_asiento, id_colectivos_fechas) VALUES (2, 2, 46, 2);

-- Roque Redruello (id 3)
INSERT INTO pasajes (id_cliente, id_viaje, id_asiento, id_colectivos_fechas) VALUES (3, 3, 47, 3);

-- Israel Lapier (id 4)
INSERT INTO pasajes (id_cliente, id_viaje, id_asiento, id_colectivos_fechas) VALUES (4, 4, 48, 1);

-- Carlos Ramirez (id 5)
INSERT INTO pasajes (id_cliente, id_viaje, id_asiento, id_colectivos_fechas) VALUES (6, 2, 56, 3);

-- Mateo Reipal (id 7)
INSERT INTO pasajes (id_cliente, id_viaje, id_asiento, id_colectivos_fechas) VALUES (7, 3, 57, 1);

-- Oscar Piastri (id 8)
INSERT INTO pasajes (id_cliente, id_viaje, id_asiento, id_colectivos_fechas) VALUES (8, 4, 58, 2);

-- Carlos Sainz (id 9)
INSERT INTO pasajes (id_cliente, id_viaje, id_asiento, id_colectivos_fechas) VALUES (9, 1, 59, 3);

-- Fernando Alonso (id 11)
INSERT INTO pasajes (id_cliente, id_viaje, id_asiento, id_colectivos_fechas) VALUES (11,2, 60, 1);

SELECT id FROM viajes
WHERE id NOT IN (SELECT DISTINCT id_viaje FROM pasajes);

-- Consigna 4.	Listado de localidades que incluyan la palabra “monte”, indicando la provincia a la que pertenecen.

use TPCOLECTIVOS;
SELECT 
  c.nombre AS ciudad,
  p.nombre AS provincia
FROM ciudades c
JOIN provincias p ON c.provincias_id = p.id
WHERE c.nombre LIKE '%Monte%';
-- ------------------------------------------------------------------------------------------------------------


INSERT INTO ciudades (nombre, provincias_id) VALUES
  ('Monte Hermoso',   1),  -- Buenos Aires
  ('Monte Buey',       2),  -- Córdoba
  ('Monte Vera',       3),  -- Santa Fe
  ('Monte Redondo',    4),  -- Entre Ríos
  ('Monte Comán',      5); -- Mendoza


