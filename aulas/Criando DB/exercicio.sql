CREATE DATABASE db_sistema_curso;

USE db_sistema_curso;

 CREATE TABLE cursos(
	id int unsigned not null auto_increment,
    nome_curso varchar(64) not null,
    tipo_curso int unsigned default null,
    instrutor_curso int(10) unsigned default null,
    preco_curso double unsigned not null default "0.00",
    
    PRIMARY KEY(id),
    INDEX fk_tipo (tipo_curso),
    INDEX fk_instrutor (instrutor_curso),
    FOREIGN KEY (tipo_curso) REFERENCES tipos (id),
    FOREIGN KEY (instrutor_curso) REFERENCES instrutores (id)
 );

CREATE INDEX instrutor ON cursos(instrutor_curso);

CREATE TABLE tipos(
	id int unsigned not null auto_increment,
    tipo varchar(15) not null default "",
    PRIMARY KEY (id)
);

CREATE TABLE instrutores(
	id int unsigned not null auto_increment,
    nome_instrutor varchar(50) not null default "",
    telefone varchar(15) not null default "Não possui",
    email_instrutor varchar(50) not null,
    PRIMARY KEY (id)
);

ALTER TABLE instrutores DROP COLUMN email_instrutor;

CREATE TABLE alunos(
	id int unsigned not null auto_increment,
    nome_aluno varchar(50) not null,
    endereco_aluno varchar(80) not null,
    email_aluno varchar(50) not null,
    
    PRIMARY KEY(id)
);

ALTER TABLE alunos
ADD COLUMN data_nascimento varchar(10) not null;

ALTER TABLE alunos
CHANGE COLUMN data_nascimento nascimento date not null;

CREATE INDEX aluno ON alunos (nome_aluno); 

CREATE TABLE pedidos(
	id int unsigned not null auto_increment,
    data_pedido date not null,
    hora_pedido time not null,
    aluno_id int unsigned default null,
    
    PRIMARY KEY (id),
    CONSTRAINT fk_aluno_pedido FOREIGN KEY (aluno_id) REFERENCES alunos (id)
);

CREATE TABLE pedido_detalhes(
	pedido_id int unsigned not null,
    curso_id int unsigned not null,
    valor double unsigned not null default "0.00",
    PRIMARY KEY (pedido_id, curso_id)
);