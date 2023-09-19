-- Trabajo Practico Integridad Referencial
drop database if exists editoriales;
create database editoriales;
use editoriales;

SET FOREIGN_KEY_CHECKS=1;

drop table if exists editoriales;
drop table if exists empleados;
drop table if exists libros;

create table if not exists editoriales(
	id_editorial int primary key not null auto_increment,
	nombre_editorial varchar(50)
    -- index()
)engine=innodb
;

create table if not exists empleados(
	id_empleado int primary key not null auto_increment,
	nombre_empleado varchar(50),
    id_editorial int,
    foreign key fk_editorial_empleados(id_editorial) references editoriales(id_editorial)
	on delete cascade
    -- index()
)engine=innodb
;

create table if not exists libros(
	id_libro int primary key not null auto_increment,
	titulo_libro varchar(50),
    id_editorial int,
    foreign key fk_editorial_libros(id_editorial) references editoriales(id_editorial)
    on delete cascade
    -- index()
)engine=innodb
;

insert into editoriales (id_editorial, nombre_editorial)
values
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
    
    
insert into empleados (id_empleado, nombre_empleado, id_editorial)
values
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

insert into libros (id_libro, titulo_libro, id_editorial)
values
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

-- Ejercicios sobre integridad referencial:

-- 1.	Eliminar una editorial: Si se elimina una editorial de la tabla editoriales, ¿qué sucede con los libros asociados? Escriba una consulta SQL que elimine una editorial y sus libros relacionados.
select * from editoriales; -- 10 editoriales
select * from empleados; -- 10 empleados
select * from libros;-- 10 libros

delete from editoriales where id_editorial=5; -- boro la "Editorial Fondo de Cultura Económica"
select * from editoriales; -- 9 editoriales
select * from empleados; -- 8 empleados
select * from libros;-- 8 libros
-- rta: Si elimino una editorial, todos los libros y empleados de dicha editorial tambien se eliminan, ya que se utiliza "on delete cascade"

-- 2.  Actualizar el nombre de una editorial: Si se actualiza el nombre de una editorial en la tabla editoriales, ¿qué sucede con los libros relacionados?
update editoriales 
set nombre_editorial='Editorial Boquita Campeon'
where nombre_editorial='Editorial Planeta';

select * from editoriales; -- 9 editoriales, una cambio de nombre
select * from empleados; -- 8 empleados
select * from libros;-- 8 libros
-- rta: los libros asociados no cambian, siguen existiendo y se llaman igual solo que ahora perenecen a una editorial con otro nombre y el mismo ID

-- 3.	Eliminar un empleado: Si se elimina un empleado de la tabla empleados, ¿qué sucede con los libros relacionados con esa editorial?
select * from editoriales; -- 9 editoriales
select * from empleados; -- 8 empleados 
select * from libros;-- 8 libros

delete from empleados where id_empleado=8;-- ahora voy a eliminar a la empleada "8	Elena Sánchez	4"
select * from editoriales; -- 9 editoriales
select * from empleados; -- 7 empleados 
select * from libros;-- 8 libros
-- rta: los libros no se modifican

-- 4.	Actualizar el nombre de un empleado: Si se actualiza el nombre de un empleado en la tabla empleados, ¿qué sucede con los libros relacionados con esa editorial?
update empleados 
set nombre_empleado='Sebástian el cangrejo cubano'
where id_empleado=1;
select * from empleados; -- 7 empleados 
select * from libros;-- 8 libros
-- rta: los libros no se modifican

-- 5.	Eliminar un libro: Si se elimina un libro de la tabla libros, ¿qué sucede con la relación con la editorial?

-- 6.	Cambiar la editorial de un libro: Si se cambia la editorial a la que está asociado un libro en la tabla libros, ¿qué sucede con la relación con la editorial anterior?

-- 7.	Eliminar una editorial con empleados: Si se intenta eliminar una editorial que tiene empleados asociados, ¿qué sucede?

-- 8.	Eliminar un empleado con libros: Si se intenta eliminar un empleado que tiene libros asociados, ¿qué sucede?

-- 9.	Eliminar una editorial y sus empleados: ¿Cómo se eliminaría una editorial y todos sus empleados?

-- 10.	Eliminar una editorial y transferir sus empleados a otra editorial: ¿Cómo se eliminaría una editorial y reasignaría a sus empleados a otra editorial?



