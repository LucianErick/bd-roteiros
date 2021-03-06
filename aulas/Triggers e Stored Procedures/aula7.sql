USE curso_sql;

CREATE TABLE PEDIDOS
(
	ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    DESCRICAO VARCHAR(100) NOT NULL,
    VALOR DOUBLE NOT NULL DEFAULT '0',
    PAGO VARCHAR(3) NOT NULL DEFAULT 'Não',
    PRIMARY KEY(ID)
);

INSERT INTO PEDIDOS(DESCRICAO, VALOR) VALUES ('TV', 3000);
INSERT INTO PEDIDOS(DESCRICAO, VALOR) VALUES ('GELADEIRA', 1800);
INSERT INTO PEDIDOS(DESCRICAO, VALOR) VALUES ('AIR FRYER', 250);

CALL LIMPA_PEDIDOS();

SELECT * FROM PEDIDOS;

CREATE TABLE ESTOQUE
(
	ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
    DESCRICAO VARCHAR(50) NOT NULL,
    QUANTIDADE INT NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TRIGGER GATILHO_LIMPA_PEDIDOS
BEFORE INSERT
ON ESTOQUE
FOR EACH ROW 
CALL LIMPA_PEDIDOS();

SELECT * FROM PEDIDOS;

INSERT INTO PEDIDOS(DESCRICAO, VALOR) VALUES ('TV', 3000);
INSERT INTO PEDIDOS(DESCRICAO, VALOR) VALUES ('GELADEIRA', 1800);
INSERT INTO PEDIDOS(DESCRICAO, VALOR, PAGO) VALUES ('AIR FRYER', 250, 'Sim');
INSERT INTO PEDIDOS(DESCRICAO, VALOR) VALUES ('PC GAMER', 5000);
INSERT INTO PEDIDOS(DESCRICAO, VALOR) VALUES ('FOGAO', 1600);
INSERT INTO ESTOQUE(DESCRICAO, QUANTIDADE) VALUES ('MICROONDAS CARO', 2);

SELECT * FROM ESTOQUE;