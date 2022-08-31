/*ej1

CREATE DATABASE clase16;

USE clase16;

CREATE TABLE
    `employees` (
        `employeeNumber` int(11) NOT NULL,
        `lastName` varchar(50) NOT NULL,
        `firstName` varchar(50) NOT NULL,
        `extension` varchar(10) NOT NULL,
        `email` varchar(100) NOT NULL,
        `officeCode` varchar(10) NOT NULL,
        `reportsTo` int(11) DEFAULT NULL,
        `jobTitle` varchar(50) NOT NULL,
        PRIMARY KEY (`employeeNumber`)
    );

insert into
    `employees`(
        `employeeNumber`,
        `lastName`,
        `firstName`,
        `extension`,
        `email`,
        `officeCode`,
        `reportsTo`,
        `jobTitle`
    )
values (
        1002,
        'Murphy',
        'Diane',
        'x5800',
        'dmurphy@classicmodelcars.com',
        '1',
        NULL,
        'President'
    ), (
        1056,
        'Patterson',
        'Mary',
        'x4611',
        'mpatterso@classicmodelcars.com',
        '1',
        1002,
        'VP Sales'
    ), (
        1076,
        'Firrelli',
        'Jeff',
        'x9273',
        'jfirrelli@classicmodelcars.com',
        '1',
        1002,
        'VP Marketing'
    );

CREATE TABLE
    employees_audit (
        id INT AUTO_INCREMENT PRIMARY KEY,
        employeeNumber INT NOT NULL,
        lastname VARCHAR(50) NOT NULL,
        changedat DATETIME DEFAULT NULL,
        action VARCHAR(50) DEFAULT NULL
    );

INSERT INTO
    employees(
        employeeNumber,
        lastName,
        firstName,
        extension,
        email,
        officecode,
        reportsTo,
        jobTitle
    )
VALUES (
        1,
        'Carbel',
        'Matias',
        'a',
        NULL,
        '1',
        1002,
        'Worker'
    );

/*Column 'email' cannot be null. el campo email no permite ser null al ser una contstraint

/*2 ej

UPDATE employees SET employeeNumber = employeeNumber - 20;

#se le resto 20 a los employeeNumber de todos los employee
UPDATE employees
SET
    employeeNumber = employeeNumber + 20;

#Duplicate entry '1056' for key 'PRIMARY'. no sucede nada ya que si se sumaran 20
#habria 2 primary keys exactas por un momento
SELECT *
FROM employees;


/*Ej3

ALTER TABLE employees ADD age int CHECK(
        age >= 16
        AND age <= 70
    );

ALTER TABLE employees DROP age;


INSERT INTO
    employees(
        employeeNumber,
        lastName,
        firstName,
        extension,
        email,
        officecode,
        reportsTo,
        jobTitle,
        age
    )
VALUES (
        2,
        'Pedro',
        'Sanchez',
        'b',
        'pedroGmail',
        '1',
        1002,
        'Worker',
        1
    );


DELETE FROM employees WHERE employeeNumber = 2;



/*Ej5

ALTER TABLE employees ADD COLUMN lastUpdate TIMESTAMP;
ALTER TABLE employees ADD COLUMN lastUpdateUser VARCHAR(255);

DELIMITER $$
CREATE Trigger before_employee_update BEFORE UPDATE ON employees FOR EACH ROW
BEGIN
SET NEW.lastUpdate = CURRENT_TIMESTAMP;
SET NEW.lastUpdateUser = CURRENT_USER;
END$$
DELIMITER;

UPDATE employees SET age = 15 WHERE employeeNumber = 2;



/*Ej6

SHOW TRIGGERS FROM sakila;

/* ins_film after a film is inserted this trigger inserts the film_id,title and description to film_text */
BEGIN
    INSERT INTO film_text (film_id, title, description)
        VALUES (new.film_id, new.title, new.description);
  END

BEGIN
    IF (old.title != new.title) OR (old.description != new.description) OR (old.film_id != new.film_id)
    THEN
        UPDATE film_text
            SET title=new.title,
                description=new.description,
                film_id=new.film_id
        WHERE film_id=old.film_id;
    END IF;
  END
  BEGIN
    DELETE FROM film_text WHERE film_id = old.film_id;
  END