USE curso_sql;

INSERT INTO funcionarios (id, nome, salario, departamento) VALUES (1, "Fernando", 1400, "TI");
INSERT INTO funcionarios (id, nome, salario, departamento) VALUES (2, "Guilherme", 2500, "Jurídico");
INSERT INTO funcionarios (id, nome, salario, departamento) VALUES (3,"Luciano", 2000, "TI");
INSERT INTO funcionarios (id, nome, salario, departamento) VALUES (4,"Isabela", 2200, "Marketing");

SELECT * FROM funcionarios;
SELECT * FROM funcionarios WHERE salario >= 2000;
SELECT * FROM funcionarios WHERE nome = "Guilherme";
SELECT * FROM funcionarios WHERE id = 3;

UPDATE funcionarios SET salario = salario * 1.1 WHERE id = 1;

SET SQL_SAFE_UPDATES = 0; -- liberar atualização de tabela sem usar o id
UPDATE funcionarios SET salario = salario * 1.1;
UPDATE funcionarios SET salario = round(salario * 1.1, 2);

DELETE FROM funcionarios WHERE id = 1;

-- SET SQL_SAFE_UPDATES = 1; -- habilita o safe update


INSERT INTO veiculos (funcionario_id, veiculo, placa) VALUES (2, "Carro", "SB-0001");
INSERT INTO veiculos (funcionario_id, veiculo, placa) VALUES (3, "Carro", "AFF-2020");

UPDATE veiculos SET funcionario_id = 4 WHERE id = 2;

SELECT * FROM veiculos;

INSERT INTO salarios (faixa, inicio, fim) VALUES ("Analista Júnior", 1000, 2000);
INSERT INTO salarios (faixa, inicio, fim) VALUES ("Analista Pleno", 2000, 4000);

SELECT * FROM salarios;

SELECT nome AS 'Funcionário', salario FROM funcionarios func WHERE func.salario > 2000;

SELECT * FROM funcionarios WHERE nome = "Guilherme" 
UNION
SELECT * FROM funcionarios WHERE id = "4";
