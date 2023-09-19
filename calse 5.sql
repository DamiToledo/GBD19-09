-- Create the database
CREATE DATABASE editoriales;

-- Switch to the newly created database
use editoriales;

-- Create the editoriales table with PK constraint
CREATE TABLE editoriales (
    id_editorial INT PRIMARY KEY,
    nombre_editorial VARCHAR(100) NOT NULL
);

-- Create the empleados table with PK and FK constraints
CREATE TABLE empleados (
    id_empleado INT PRIMARY KEY,
    nombre_empleado VARCHAR(100) NOT NULL,
    id_editorial INT,
    CONSTRAINT fk_id_editorial FOREIGN KEY (id_editorial) REFERENCES editoriales (id_editorial) 
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create the libros table with PK and FK constraints
CREATE TABLE libros (
    id_libro INT PRIMARY KEY,
    titulo_libro VARCHAR(100) NOT NULL,
    id_editorial INT,
    CONSTRAINT fk_id_editorial_libros FOREIGN KEY (id_editorial) REFERENCES editoriales (id_editorial) 
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- Insert records into the editoriales table
INSERT INTO editoriales (id_editorial, nombre_editorial)
VALUES
    (1, 'Editorial Planeta'),
    (2, 'Editorial Santillana'),
    (3, 'Editorial Anaya'),
    (4, 'Editorial Alfaguara'),
    (5, 'Editorial SM'),
    (6, 'Editorial Fondo de Cultura Económica'),
    (7, 'Editorial Siglo XXI'),
    (8, 'Editorial Cátedra'),
    (9, 'Editorial Tecnos'),
    (10, 'Editorial Ariel');

-- Insert records into the empleados table
INSERT INTO empleados (id_empleado, nombre_empleado, id_editorial)
VALUES
    (1, 'Juan Pérez', 1),
    (2, 'María Rodríguez', 1),
    (3, 'Pedro López', 2),
    (4, 'Ana Martínez', 2),
    (5, 'Carlos García', 3),
    (6, 'Laura González', 3),
    (7, 'Luis Fernández', 4),
    (8, 'Elena Sánchez', 4),
    (9, 'Javier Ruiz', 5),
    (10, 'Sofía Torres', 5);

-- Insert records into the libros table
INSERT INTO libros (id_libro, titulo_libro, id_editorial)
VALUES
    (1, 'Cien años de soledad', 1),
    (2, 'Don Quijote de la Mancha', 1),
    (3, 'La sombra del viento', 2),
    (4, 'Rayuela', 2),
    (5, 'Crónica de una muerte anunciada', 3),
    (6, 'Los detectives salvajes', 3),
    (7, 'Ficciones', 4),
    (8, 'La casa de los espíritus', 4),
    (9, 'La ciudad y los perros', 5),
    (10, 'Cien años de soledad', 5);

-- 1) Eliminar una editorial: Si se elimina una editorial de la tabla editoriales, 
-- ¿qué sucede con los libros asociados? Escriba una consulta SQL que elimine una editorial 
-- y sus libros relacionados.

   CREATE TABLE libros (
       id_libro INT PRIMARY KEY,
       titulo_libro VARCHAR(100) NOT NULL,
       id_editorial INT,
       CONSTRAINT fk_id_editorial_libros FOREIGN KEY (id_editorial) REFERENCES editoriales (id_editorial) ON DELETE CASCADE
   );

-- Con esta configuración, cuando eliminas un registro de la tabla "editoriales", 
-- todos los registros asociados en la tabla "libros" se eliminarán automáticamente.
-- Establecer registros asociados a NULL: Alternativamente, puedes utilizar la opción 
-- ON DELETE SET NULL al definir la restricción de clave externa. 
-- Esto establecerá el valor de la clave externa en NULL en los registros asociados 
-- en la tabla "libros" cuando se elimine el registro referenciado en la tabla "editoriales". 
-- Aquí tienes un ejemplo:

--    CREATE TABLE libros (
--       id_libro INT PRIMARY KEY,
  --     titulo_libro VARCHAR(100) NOT NULL,
    --   id_editorial INT,
      -- CONSTRAINT fk_id_editorial_libros FOREIGN KEY (id_editorial) REFERENCES editoriales (id_editorial) ON DELETE SET NULL
   -- );

-- Con esta configuración, cuando eliminas un registro de la tabla "editoriales", 
-- el valor de "id_editorial" en los registros asociados en la tabla "libros" se establecerá en NULL.
-- Restringir la eliminación: Si deseas evitar la eliminación de una editorial si hay registros 
-- asociados en la tabla "libros", puedes utilizar la opción ON DELETE RESTRICT 
-- al definir la restricción de clave externa. Esto evitará que elimines una editorial 
-- si hay registros asociados en la tabla "libros". Aquí tienes un ejemplo:

--    CREATE TABLE libros (
--       id_libro INT PRIMARY KEY,
  --     titulo_libro VARCHAR(100) NOT NULL,
    --   id_editorial INT,
      -- CONSTRAINT fk_id_editorial_libros FOREIGN KEY (id_editorial) REFERENCES editoriales (id_editorial) ON DELETE RESTRICT
   -- );

-- Con esta configuración, si intentas eliminar una editorial que tiene registros asociados en la tabla 
-- "libros", recibirás un error y la eliminación se evitará.
-- Para eliminar una editorial y sus registros asociados de la tabla "libros" utilizando SQL, 
-- puedes utilizar la siguiente consulta:

-- DELETE editoriales, libros
-- FROM editoriales
-- LEFT JOIN libros ON editoriales.id_editorial = libros.id_editorial
-- WHERE editoriales.id_editorial = [id_editorial];

-- ---------------------------------------------------------------------------------------------

-- 2) Actualizar el nombre de una editorial: Si se actualiza el nombre de una editorial 
-- en la tabla editoriales, ¿qué sucede con los libros relacionados?

UPDATE editoriales
SET nombre_editorial = 'New Name'
WHERE id_editorial = 1;

-- -----------------------------------------------------------------------------------------------

-- 3) Eliminar un empleado: Si se elimina un empleado de la tabla empleados,
-- ¿qué sucede con los libros relacionados con esa editorial?

DELETE FROM empleados
WHERE id_empleado = 1;

-- ----------------------------------------------------------------------------------------------------

-- 4) 4) Actualizar el nombre de un empleado: Si se actualiza el nombre de un empleado en 
-- la tabla empleados, ¿qué sucede con los libros relacionados con esa editorial?

update empleados
SET nombre_empleado = "Maria Marta Sela Lima"
where id_empleado = 2;

-- -----------------------------------------------------------------------------------------------------

-- 5) 

DELETE FROM libros
WHERE id_libro = 1;

DELETE FROM libros
WHERE id_editorial = 1 AND titulo_libro LIKE '%Cien años%';


-- ---------------------------------------------------------------------------------------------------


UPDATE libros
SET editorial = 'Nueva Editorial'
WHERE id_libro = 1;

UPDATE libros
SET editorial = 'Nueva Editorial'
WHERE autor = 'Gabriel García Márquez' AND año_publicacion < 2000;

-- ----------------------------------

