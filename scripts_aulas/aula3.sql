USE curso_sql;

SELECT * FROM funcionarios;
SELECT * FROM veiculos;

-- INNER JOIN
SELECT * FROM funcionarios INNER JOIN veiculos ON veiculos.funcionario_id = funcionarios.id;
SELECT * FROM funcionarios f INNER JOIN veiculos v ON v.funcionario_id = f.id;

-- LEFT / RIGTH JOIN 
SELECT * FROM funcionarios LEFT JOIN veiculos ON funcionario_id = funcionarios.id;
SELECT * FROM funcionarios RIGHT JOIN veiculos ON funcionario_id = funcionarios.id;

INSERT INTO veiculos (funcionario_id, veiculo, placa) VALUES (null, "Moto", "SB-0003");

-- FULL JOIN
SELECT * FROM funcionarios LEFT JOIN veiculos ON funcionario_id = funcionarios.id
UNION
SELECT * FROM funcionarios RIGHT JOIN veiculos ON funcionario_id = funcionarios.id;

CREATE TABLE cpfs (
	id int unsigned not null,
    cpf varchar(14) not null,
    PRIMARY KEY(id),
    CONSTRAINT fk_cpf FOREIGN KEY (id) REFERENCES funcionarios (id)
);

INSERT INTO cpfs (id, cpf) VALUES (2, '222.222.222-22');
INSERT INTO cpfs (id, cpf) VALUES (3, '333.333.333-33');
INSERT INTO cpfs (id, cpf) VALUES (4, '444.444.444-44');

-- EQUI JOIN

SELECT * FROM funcionarios INNER JOIN cpfs ON funcionarios.id = cpfs.id;
SELECT * FROM funcionarios INNER JOIN cpfs USING (id);

-- SELF JOIN

CREATE TABLE clientes (
	id int unsigned not null auto_increment,
    nome varchar(45) not null,
    quem_indicou int unsigned,
    PRIMARY KEY (id),
    CONSTRAINT fk_quem_indicou FOREIGN KEY (quem_indicou) REFERENCES clientes (id)
); 

INSERT INTO clientes (id, nome, quem_indicou) VALUES (1, 'André', NULL);
INSERT INTO clientes (id, nome, quem_indicou) VALUES (2, 'Paula', 1);
INSERT INTO clientes (id, nome, quem_indicou) VALUES (3, 'Lídia', 3);
INSERT INTO clientes (id, nome, quem_indicou) VALUES (4, 'Rafael', 2);

SELECT * FROM clientes;

SELECT c1.nome, c2.nome FROM clientes c1 JOIN clientes c2 ON c1.quem_indicou = c2.id; 

CREATE VIEW funcionarios_a AS SELECT * FROM funcionarios WHERE salario <= 3000;

SELECT * FROM funcionarios_a;

UPDATE funcionarios SET salario = 2650 WHERE id = 4;