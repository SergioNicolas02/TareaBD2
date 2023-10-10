-- Crear una tabla de empleados ficticia para este ejemplo
CREATE TABLE empleados (
    empleado_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    salario DECIMAL(10, 2)
);

-- Insertar datos ficticios en la tabla de empleados
INSERT INTO empleados (nombre, salario) VALUES
    ('Juan', 3000.50),
    ('María', 2500.75),
    ('Carlos', 3500.00),
    ('Sofía', 2800.25);

-- Definir las variables necesarias
DECLARE done INT DEFAULT 0;
DECLARE total_salary DECIMAL(10, 2) DEFAULT 0;
DECLARE current_salary DECIMAL(10, 2);

-- Declarar un cursor para recorrer los registros
DECLARE employee_cursor CURSOR FOR
    SELECT salario FROM empleados;

-- Manejar errores con un bloque CONTINUE HANDLER
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

-- Abrir el cursor
OPEN employee_cursor;

-- Iniciar el bucle para recorrer los registros
read_loop: LOOP
    FETCH employee_cursor INTO current_salary;

    -- Si no hay más registros, salir del bucle
    IF done = 1 THEN
        LEAVE read_loop;
    END IF;

    -- Sumar el salario actual al salario total
    SET total_salary = total_salary + current_salary;
END LOOP;

-- Cerrar el cursor
CLOSE employee_cursor;

-- Mostrar el resultado
SELECT total_salary AS 'Salario Total de Empleados';
