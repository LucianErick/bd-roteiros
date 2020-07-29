USE curso_sql;

SHOW ENGINES;

CREATE TABLE contas_bancarias
(
	id int unsigned not null auto_increment,
    titular varchar(45) not null,
    saldo double not null,
    PRIMARY KEY (id)
) engine = InnoDB;

INSERT INTO contas_bancarias (titular, saldo) VALUES ('luciano', 1000);
INSERT INTO contas_bancarias (titular, saldo) VALUES ('Paula', 800);

SELECT * FROM contas_bancarias;

start transaction;
UPDATE contas_bancarias SET saldo = saldo - 100 WHERE id = 1;
UPDATE contas_bancarias SET saldo = saldo +  100 WHERE id = 2;
rollback;

start transaction;
UPDATE contas_bancarias SET saldo = saldo - 100 WHERE id = 1;
UPDATE contas_bancarias SET saldo = saldo +  100 WHERE id = 2;
commit;