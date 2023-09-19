	SET FOREIGN_KEY_CHECKS=0; 
    -- sentencia de mysql, en 0 no identifica la identidad referencial
    -- en nuestro ejemplo todos los valores de ciudad_id de personas existe en tablaa ciudades
    -- entoces esta bien la identidad referencial
    -- si no existiese dicho id en la tabla cuidades NO me va a dejar crear el registro
    -- pero si pongo SET FOREIGN_KEY_CHECKS=0; SI me va a dejar
    
    DROP TABLE IF EXISTS personas;
    DROP TABLE IF EXISTS ciudades;

    SET FOREIGN_KEY_CHECKS=1; -- conviene tener esto en uno, vericica la identidad referencial


    DROP DATABASE IF EXISTS prueba_restricciones;
    CREATE DATABASE prueba_restricciones;

    USE prueba_restricciones; 

    CREATE TABLE IF NOT EXISTS ciudades -- primero tengo que crear esta tabla porque es la clave importante
    (
        ciudad_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT , -- por ser clave primaria ya tengo un indice 
        ciudad_nom VARCHAR(50),
        INDEX (ciudad_nom) 
        -- indice comun. toma todos los valores de ese campo y lo clona
        -- luego lo ordena 
        -- si yo consulto mucho un campo conviene indizarlo(se escribe asi?) y asi gano tiempo en las consultas
        -- esta bueno pero si son pocos registros. si son muchos no conviene
    )ENGINE=INNODB; 
    -- INNODB este motor de almacenamiento permite transacciones (comprime info y es mas facil luego)
    -- el otro es "MyISam" otro motor que no soporta  


    CREATE TABLE IF NOT EXISTS personas 
    (
        persona_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT , 
        persona_nom VARCHAR(70),
        ciudad_id INT,
        FOREIGN KEY fk_ciudad(ciudad_id) REFERENCES ciudades(ciudad_id)
		-- nombro como FOREIGN KEY a "ciudad_id" de la tabla "personas" (y lo llamo "fk_ciudad")
        -- y uso como referencia "ciudad_id" de la tabla "ciudades"
        ON DELETE  CASCADE -- cambiar para hacer pruebas ... CASCADE, SET NULL, NO ACTION 
        -- ON DELETE  CASCADE cuando borro un registro en la tabla ciudades lo borra en la tabla personas
        
    )ENGINE=INNODB;


    INSERT INTO ciudades (ciudad_nom)
        VALUES 
            ('Galilea'),
            ('Betsaida'),
            ('Patmos'),
            ('Jerusalén');

	INSERT INTO personas (persona_nom, ciudad_id)
        VALUES 
        ('Pedro',1),
        ('Santiago',2),
        ('Juan',3),
        ('Andrés',1);


    SELECT * FROM personas ORDER BY persona_id;
    SELECT * FROM ciudades ORDER BY ciudad_id;

    DELETE FROM ciudades WHERE ciudad_id=1; -- con esto verificamos el delete en cascada
    -- vamos a eliminaar galilea, entonces cuando boro tambien se borran las otras dos personas que vivian en galilea

	INSERT INTO personas (persona_nom, ciudad_id)
        VALUES 
        ('Lucho',25); -- intentamos crear una persona en una cuidad inexistente, ME DA ERROR
        -- Esto es porque tengo activado el "SET FOREIGN_KEY_CHECKS=1;"

	INSERT INTO personas (persona_nom, ciudad_id)
        VALUES
        ('Lucho',2); -- ahora intentamos insertar persona en cuidad que si exista. 
        -- SI SE PUEDE!, ya que se mantiene la 

    DELETE FROM personas WHERE ciudad_id=4;

    -- Consultas después de la acción de borrado
    SELECT * FROM personas ORDER BY persona_id;
    SELECT * FROM ciudades ORDER BY ciudad_id;