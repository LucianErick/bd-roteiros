-- Questão 1
-- 	A)

CREATE VIEW vw_dptmgr AS SELECT dno, (fname || ' ' || minit || ' ' || lname) AS mgr_name  FROM employee WHERE superssn IS NULL;  -- Assumindo que com 'nome' significa uma concatenação do primeiro, meio e ultimos nomes.

-- 	B)
CREATE VIEW vw_empl_houston AS SELECT ssn, fname FROM employee WHERE address LIKE '%Houston%';

-- 	C)
CREATE VIEW vw_deptstats AS SELECT dept.dnumber, dept.dname, count(emp.dno) AS num_employees FROM department AS dept INNER JOIN employee AS emp ON emp.dno = dept.dnumber GROUP BY dept.dnumber;

-- 	D)
CREATE VIEW vw_projstats AS SELECT pno, count(essn) AS num_employees FROM works_on GROUP BY pno;




-- Questão 2
SELECT * FROM vw_dptmgr;
SELECT * FROM vw_empl_houston;
SELECT * FROM vw_deptstats;
SELECT * FROM vw_projstats;




-- Questão 3
DROP VIEW vw_dptmgr;
DROP VIEW vw_empl_houston;
DROP VIEW vw_deptstats;
DROP VIEW vw_projstats;


-- Questão 4

CREATE OR REPLACE FUNCTION check_age(IN employee_ssn CHAR(9))
RETURNS VARCHAR(10) AS
$$
DECLARE 
employee_age INTEGER;
BEGIN
	SELECT extract(year from age(employee.bdate)) INTO employee_age FROM employee WHERE emoyee.ssn = employee_ssn;
	
	IF (employee_age >= 50) THEN RETURN 'SENIOR';
	ELSIF (employee_age > 0 AND employee_age < 50) THEN RETURN 'YOUNG';
	ELSIF (employee_age IS NULL) THEN RETURN 'UNKNOWN';	
	ELSE RETURN 'INVALID';
	END IF;
END;
$$ LANGUAGE 'plpgsql';


-- Questão 5

CREATE OR REPLACE FUNCTION check_mgr() RETURNS trigger AS $check_mgr$
   DECLARE
	employee_dno INTEGER;
	supevisees_count INTEGER;
   BEGIN
	SELECT dno FROM employee INTO employee_dno WHERE NEW.mgrssn = employee.ssn;
	SELECT count(*) FROM employee AS emp INTO supevisees_count INNER JOIN employee AS sup ON sup.ssn = emp.superssn GROUP BY sup.ssn HAVING sup.ssn = NEW.mgrssn;

        IF employee_dno != NEW.dnumber OR NEW.mgrssn IS NULL THEN
            RAISE EXCEPTION 'manager must be a department''s employee';
	END IF;
        IF(supevisees_count = 0 OR supervisees_count IS NULL) THEN
            RAISE EXCEPTION 'manager must have supevisees';
	END IF;
        IF check_age(NEW.mgrssn) != 'SENIOR' THEN
            RAISE EXCEPTION 'manager must be a SENIOR employee';
        END IF;

	RETURN NEW;
    END;
$check_mgr$ LANGUAGE plpgsql;

CREATE TRIGGER check_mgr BEFORE INSERT OR UPDATE ON department
    FOR EACH ROW EXECUTE PROCEDURE check_mgr(); 


