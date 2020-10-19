-- Aluno: Luciano Erick Sousa Figueiredo Filho
-- Matrícula: 118110400

-- Questão 1, 2


-- Como o segurado pode ou não ser o dono do veículo, não estabeleci uma comunicação direta entre eles.
CREATE TABLE automovel (codigo_veiculo CHAR(17), cpf_dono CHAR(11), modelo VARCHAR(60), marca VARCHAR(20), ano INTEGER);


-- Como é o segurado que contrata o seguro, pensei numa relação nesse mesmo esquema, em que um segurado contém o seguro. Porém, fico meio em dúvida em relação a essa decisão, sinceramente.
CREATE TABLE segurado ( cpf CHAR(11), nome VARCHAR(100), telefone VARCHAR(15), email VARCHAR(50), endereco VARCHAR(60), codigo_seguro INTEGER);


-- O seguro tem que, obrigatoriamente, conhecer o veículo em que ele atua
CREATE TABLE seguro (codigo_seguro SERIAL, tipo_seguro INTEGER, vencimento DATE, codigo_veiculo CHAR(17));

-- Um perito é uma entidade trivial
CREATE TABLE perito (codigo_perito SERIAL, nome VARCHAR(100), telefone VARCHAR(15), email varchar(50));

-- Quanto à oficina, achei melhor relacionar com um reparo específico, assim fica mais simples de saber quais serviços foram disponibilizados em tal local.
CREATE TABLE oficina (codigo_oficina SERIAL, endereco VARCHAR(100), telefone VARCHAR(15), codigo_reparo INTEGER);

-- O reparo é uma das entidades mais importantes do sistema, afinal, é a partir do valor do conserto que é definido se vai pagar-se o conserto ou não.
CREATE TABLE reparo (codigo_reparo SERIAL, valor NUMERIC,	codigo_veiculo CHAR(17)
);

-- Essencial pra última entidade, conde liga o conserto à decisão final.
CREATE TABLE pericia(codigo_pericia SERIAL, codigo_perito INTEGER, codigo_oficina INTEGER);

-- Entidade essencial pro sistema, onde contém um relação com o seguro e com a perícia
CREATE TABLE sinistro(codigo_sinistro SERIAL, codigo_seguro INTEGER, tipo INTEGER, codigo_pericia INTEGER);

-- Questão 3

ALTER TABLE automovel ADD CONSTRAINT pk_automovel PRIMARY KEY (numero_de_serie);

ALTER TABLE seguro ADD CONSTRAINT pk_seguro PRIMARY KEY (codigo_seguro);

ALTER TABLE segurado ADD CONSTRAINT pk_segurado PRIMARY KEY (cpf);

ALTER TABLE pericia ADD CONSTRAINT pk_pericia PRIMARY KEY (codigo_pericia);

ALTER TABLE perito ADD CONSTRAINT pk_perito PRIMARY KEY (codigo_perito);

ALTER TABLE oficina ADD CONSTRAINT pk_oficina PRIMARY KEY (codigo_oficina);

ALTER TABLE reparo ADD CONSTRAINT pk_reparo PRIMARY KEY (codigo_reparo);

ALTER TABLE sinistro ADD CONSTRAINT pk_sinistro PRIMARY KEY (codigo_sinistro);

-- Questão 4

ALTER TABLE segurado ADD CONSTRAINT fk_segurado_seguro FOREIGN KEY (codigo_seguro) REFERENCES seguro(codigo_seguro);

ALTER TABLE seguro ADD CONSTRAINT fk_seguro_veiculo FOREIGN KEY (codigo_veiculo) REFERENCES automovel(codigo_veiculo);

ALTER TABLE reparo ADD CONSTRAINT fk_reparo_veiculo FOREIGN KEY (codigo_veiculo) REFERENCES automovel(codigo_veiculo);

ALTER TABLE oficina ADD CONSTRAINT fk_oficina_reparo FOREIGN KEY (codigo_reparo) REFERENCES reparo(codigo_reparo);

ALTER TABLE pericia ADD CONSTRAINT fk_pericia_perito FOREIGN KEY (codigo_perito) REFERENCES perito(codigo_perito);

ALTER TABLE pericia ADD CONSTRAINT fk_pericia_oficina FOREIGN KEY (codigo_oficina) REFERENCES oficina(codigo_oficina);

ALTER TABLE sinistro ADD CONSTRAINT fk_sinistro_seguro FOREIGN KEY (codigo_seguro) REFERENCES seguro(codigo_seguro);

ALTER TABLE sinistro ADD CONSTRAINT fk_sinistro_pericia FOREIGN KEY (codigo_pericia) REFERENCES pericia(codigo_pericia);

-- Questão 5, 6
DROP TABLE automovel;
DROP TABLE segurado CASCADE;
DROP TABLE seguro CASCADE;
DROP TABLE oficina CASCADE;
DROP TABLE perito CASCADE;
DROP TABLE pericia CASCADE;
DROP TABLE sinistro CASCADE;
DROP TABLE reparo CASCADE;

-- Questão 7,8

CREATE TABLE automovel (codigo_veiculo CHAR(17) CONSTRAINT pk_automovel PRIMARY KEY, cpf_dono CHAR(11) NOT NULL, modelo VARCHAR(60), marca VARCHAR(20), ano INTEGER);

CREATE TABLE seguro (codigo_seguro SERIAL CONSTRAINT pk_seguro PRIMARY KEY, tipo_seguro INTEGER NOT NULL, vencimento DATE NOT NULL, codigo_veiculo CHAR(17), CONSTRAINT fk_seguro_veiculo FOREIGN KEY (codigo_veiculo) REFERENCES automovel(codigo_veiculo));

CREATE TABLE segurado ( cpf CHAR(11) CONSTRAINT pk_segurado PRIMARY KEY, nome VARCHAR(100) NOT NULL, telefone VARCHAR(15) NOT NULL, email VARCHAR(50), endereco VARCHAR(60) NOT NULL, codigo_seguro INTEGER, CONSTRAINT fk_segurado_seguro FOREIGN KEY (codigo_seguro) REFERENCES seguro(codigo_seguro));


CREATE TABLE perito (codigo_perito SERIAL CONSTRAINT pk_perito PRIMARY KEY, nome VARCHAR(100) NOT NULL, telefone VARCHAR(15) NOT NULL, email varchar(50));

CREATE TABLE reparo (codigo_reparo SERIAL CONSTRAINT pk_reparo PRIMARY KEY, valor NUMERIC, codigo_veiculo CHAR(17), CONSTRAINT fk_reparo_veiculo FOREIGN KEY (codigo_veiculo) REFERENCES automovel(codigo_veiculo));

CREATE TABLE oficina (codigo_oficina SERIAL CONSTRAINT pk_oficina PRIMARY KEY, endereco VARCHAR(100) NOT NULL, telefone VARCHAR(15) NOT NULL, codigo_reparo INTEGER, CONSTRAINT fk_oficina_reparo FOREIGN KEY (codigo_reparo) REFERENCES reparo(codigo_reparo));

CREATE TABLE pericia(codigo_pericia SERIAL CONSTRAINT pk_pericia PRIMARY KEY, codigo_perito INTEGER, codigo_oficina INTEGER, CONSTRAINT fk_pericia_perito FOREIGN KEY (codigo_perito) REFERENCES perito(codigo_perito), CONSTRAINT fk_pericia_oficina FOREIGN KEY (codigo_oficina) REFERENCES oficina(codigo_oficina));

CREATE TABLE sinistro(codigo_sinistro SERIAL CONSTRAINT pk_sinistro PRIMARY KEY, codigo_seguro INTEGER, tipo INTEGER, codigo_pericia INTEGER, CONSTRAINT fk_sinistro_seguro FOREIGN KEY (codigo_seguro) REFERENCES seguro(codigo_seguro), CONSTRAINT fk_sinistro_pericia FOREIGN KEY (codigo_pericia) REFERENCES pericia(codigo_pericia));

--Questão 9

DROP TABLE seguro CASCADE;
DROP TABLE segurado CASCADE;
DROP TABLE reparo CASCADE;
DROP TABLE oficina CASCADE;
DROP TABLE pericia CASCADE;
DROP TABLE sinistro CASCADE;
DROP TABLE automovel;
DROP TABLE perito;

-- Questão 10

-- Sim, algumas delas são:

-- 1) Tipos de Seguro, pois dependendo do tipo do seguro contratado pelo segurado, alguns sinistros não são aplicáveis. Nessa tabela eu colocaria um ID e um nome da categoria: ex: categorias roubo, acidente, ambos, etc.

-- 2) Tipos de Sinistro, pois é a mesma ideia do Tipos de Seguro, sendo que nessa eu colocaria um Id e nome de sinistro.

-- Essas modificações não iriam influenciar muito na tabela, mas fariam ficar mais entendível no que diz respeito a sinistro.

