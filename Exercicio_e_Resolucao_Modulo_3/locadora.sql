CREATE DATABASE locadora;

USE locadora;

CREATE TABLE clientes
(
	codigo_cliente int unsigned not null auto_increment,
    cliente varchar(45) not null,
    telefone varchar(20) not null default '',
    saldo double not null default '0.00',
    PRIMARY KEY (codigo_cliente)
);

CREATE TABLE locacoes
(
	codigo_locacao int unsigned not null auto_increment,
    cliente_id int unsigned default null,
    pagamento varchar(20) not null default 'Dinheiro',
    CONSTRAINT fk_codigo_cliente FOREIGN KEY (cliente_id) REFERENCES clientes (codigo_cliente),
    PRIMARY KEY(codigo_locacao)
);

CREATE TABLE filmes
(
	codigo_filme int unsigned not null auto_increment,
    filme varchar(50) not null default '',
    categoria varchar(30) not null default '',
    PRIMARY KEY (codigo_filme)
);

CREATE TABLE detalhes
(
	id_locacao int unsigned default null,
    id_filme int unsigned default null,
    
    CONSTRAINT fk_codigo_locacao FOREIGN KEY (id_locacao) REFERENCES locacoes (codigo_locacao),
    CONSTRAINT fk_codigo_filme FOREIGN KEY (id_filme) REFERENCES filmes (codigo_filme)
);

