USE curso_sql;

SELECT * FROM funcionarios;

SELECT COUNT(*) FROM funcionarios;
SELECT COUNT(*) FROM funcionarios funcionario WHERE funcionario.salario > 2500;
SELECT COUNT(*) FROM funcionarios funcionario WHERE funcionario.salario > 2500 AND departamento = "Jurídico";
SELECT * FROM funcionarios funcionario WHERE funcionario.salario > 2500 AND departamento = "Jurídico";

SELECT SUM(salario) FROM funcionarios;
SELECT SUM(salario) FROM funcionarios WHERE departamento = "TI";

SELECT AVG(salario) FROM funcionarios;

SELECT MAX(salario) FROM funcionarios;
SELECT MIN(salario) FROM funcionarios;

SELECT departamento FROM funcionarios;
SELECT DISTINCT(departamento) FROM funcionarios;

INSERT INTO funcionarios(id, nome, salario, departamento) VALUES (5,"Michael", "4200", "Jurídico");
INSERT INTO funcionarios(nome, salario, departamento) VALUES ("Pam", "2300", "Marketing");
INSERT INTO funcionarios(nome, salario, departamento) VALUES ("Jim", "3100", "TI");
INSERT INTO funcionarios(nome, salario, departamento) VALUES ("Ryan", "2100", "TI");
INSERT INTO funcionarios(nome, salario, departamento) VALUES ("Dwigth", "3000", "Jurídico");
INSERT INTO funcionarios(nome, salario, departamento) VALUES ("Alice", "3300", "Marketing");
INSERT INTO funcionarios(nome, salario, departamento) VALUES ("Andrielly", "2800", "TI");

UPDATE funcionarios SET salario = round(salario * 1, 2) WHERE id = 3;

SELECT * FROM funcionarios ORDER BY nome; --  CRESCENTE
SELECT * FROM funcionarios ORDER BY nome DESC; -- DECRESCENTE

SELECT * FROM funcionarios ORDER BY departamento, salario;

SELECT * FROM funcionarios LIMIT 2 OFFSET 1;
SELECT * FROM funcionarios LIMIT 1, 2;

SELECT AVG(salario) FROM funcionarios WHERE departamento = "TI";

SELECT departamento, AVG(salario) FROM funcionarios GROUP BY departamento;
SELECT departamento, AVG(salario) FROM funcionarios GROUP BY departamento HAVING AVG(salario) > 2743;

SELECT departamento, AVG(salario) FROM funcionarios GROUP BY departamento;
SELECT nome FROM funcionarios WHERE departamento = "TI" OR departamento = "Jurídico";


SELECT nome FROM funcionarios WHERE departamento IN (SELECT departamento FROM funcionarios GROUP BY departamento HAVING AVG(salario) > 2743);
