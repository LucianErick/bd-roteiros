CREATE DATABASE curso_sql;  

USE curso_sql; -- NECESSARIO usar e executar ANTES DE TODOS para nao dar erro

CREATE TABLE funcionarios 
(
	id int unsigned not null auto_increment,
    nome varchar(45) not null,
    salario double not null default '0',
	departamento varchar(45) not null,
    PRIMARY KEY (id)
);


CREATE TABLE veiculos
(
	id int unsigned not null auto_increment,
    funcionario_id int unsigned default null, -- chave estrangeira
    -- essa chave precisa ser do mesmo tipo que a referencia
    veiculo varchar(45) not null default '',
    placa varchar(10) not null default '',
    PRIMARY KEY (id),
    CONSTRAINT fk_veiculos_funcionarios FOREIGN KEY (funcionario_id) REFERENCES funcionarios (id)
    -- CONSTRAINT nome_chave_estrangeira == criando a chave
    -- FOREIGN KEY (chave) == indica que eh uma chave estrangeira
    -- REFERENCES (referencia) == indica em qual chave da outra tabela vai se estabelecer o relacionamento. 
    -- IMPORTANTE: necessario que os campos referenciados ja existam
);

CREATE TABLE salarios
(
	faixa varchar(45) not null,
    inicio double not null,
    fim double not null,
    PRIMARY KEY (faixa)
);

ALTER TABLE funcionarios CHANGE COLUMN nome nome_funcionario varchar(50) not null;
ALTER TABLE funcionarios CHANGE COLUMN nome_funcionario nome varchar(50) not null;

DROP TABLE salarios;

CREATE INDEX departamentos ON funcionarios (departamento);
CREATE INDEX nomes ON funcionarios (nome(6));