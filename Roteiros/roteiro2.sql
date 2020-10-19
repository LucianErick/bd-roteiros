-- Questão 1

CREATE TABLE tarefas (id INTEGER NULL, descricao TEXT NULL, cpf CHAR(11) NULL, prioridade INTEGER NULL, status CHAR(1) NULL);

INSERT INTO tarefas VALUES(2147483646, 'limpar chão do corredor central', '98765432111', 0, 'F');
INSERT 0 1

INSERT INTO tarefas VALUES(2147483647, 'limpar janelas da sala 203', '98765432122', 1, 'F');

INSERT INTO tarefas VALUES(null, null, null, null, null);

INSERT INTO tarefas VALUES(2147483644, 'limpar chão do corredor superior', '987654323211', 0, 'F');

INSERT INTO tarefas VALUES(2147483643, 'limpar chão do corredor superior', '98765432321', 0, 'FF');

-- Questão 2

ALTER TABLE tarefas ALTER COLUMN id TYPE BIGINT;

INSERT INTO tarefas VALUES (2147483648, 'limpar portas do térreo', '32323232955', 4, 'A');

-- Questão 3

INSERT INTO tarefas VALUES (2147483648, 'limpar portas do térreo', '32323232955', 4, 'A');

ALTER TABLE tarefas ALTER COLUMN prioridade TYPE SMALLINT;

INSERT INTO tarefas VALUES (2147483649, 'limpar portas da entrada principal', '32322525199', 32768, 'A');

INSERT INTO tarefas VALUES (2147483649, 'limpar portas da entrada principal', '32333233288', 32769, 'A');

INSERT INTO tarefas VALUES (2147483651, 'limpar portas do 1º andar', '32323232911', 32767, 'A');

INSERT INTO tarefas VALUES (2147483652, 'limpar portas do 2º andar', '32323232911', 32766, 'A');

-- Questão 4

ALTER TABLE tarefas RENAME COLUMN cpf TO func_resp_cpf;
ALTER TABLE tarefas ALTER COLUMN id SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN descricao SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN func_resp_cpf SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN prioridade SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN status SET NOT NULL;

DELETE FROM tarefas WHERE id is NULL;

-- Questão 5

ALTER TABLE tarefas ADD PRIMARY KEY (id);

INSERT INTO tarefas VALUES (21474883653, 'limpar portas do 1º andar', '32323232911', 2, 'A');

INSERT INTO tarefas VALUES (21474883653, 'Apagar a grama da área frontal', '32323232911', 3, 'A');

-- Questão 6
-- Letra A
ALTER TABLE tarefas ADD CONSTRAINT tamanho_numero_cpf_valido CHECK (CHAR_LENGTH(func_resp_cpf) = 11);

INSERT INTO tarefas VALUES (21474883654, 'Genérico 1', '3232323291', 3, 'A');

INSERT INTO tarefas VALUES (21474883655, 'Genérico 2', '323232329112', 3, 'A');

--Letra B

UPDATE tarefas SET status = 'P' WHERE status = 'A';
UPDATE tarefas SET status = 'E' WHERE status = 'R';
UPDATE tarefas SET status = 'C' WHERE status = 'F';

ALTER TABLE tarefas ADD CONSTRAINT status_possiveis_check CHECK (status = 'P' or status = 'E' or status = 'C');

-- Questão 7

UPDATE tarefas SET prioridade = 5 WHERE prioridade > 5;

ALTER TABLE tarefas ADD CONSTRAINT prioridade_valores_possiveis_check CHECK (prioridade >= 0 AND prioridade <= 5);

-- Questão 8

CREATE TABLE funcionario (cpf CHAR(11) PRIMARY KEY, data_nasc DATE NOT NULL, nome TEXT NOT NULL, funcao VARCHAR(11), nivel CHAR(1) NOT NULL, superior_cpf CHAR(11) REFERENCES funcionario (cpf));

ALTER TABLE funcionario ADD CONSTRAINT funcao_ter_superior_check CHECK ((funcao = 'LIMPEZA' and superior_cpf IS NOT NULL) OR (funcao = 'SUP_LIMPEZA' and superior_cpf IS NULL));

ALTER TABLE funcionario ADD CONSTRAINT niveis_possiveis_check CHECK (nivel = 'J' OR nivel = 'P' OR nivel = 'S');

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678911', '1980-05-07', 'Pedro da Silva', 'SUP_LIMPEZA', 'S', null);

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678912', '1980-03-08', 'Jose da Silva', 'LIMPEZA', 'J', '12345678911');

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678913', '1980-04-09', 'joao da Silva', 'LIMPEZA', 'J', null);

-- Questão 9

-- Exemplos de sucesso

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678914', '1981-06-07', 'Henrique da Silva', 'SUP_LIMPEZA', 'S', null);

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678915', '1982-09-09', 'Pedro da Costa', 'LIMPEZA', 'J', '12345678914');

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678916', '1980-05-08', 'Mariana Nascimento', 'SUP_LIMPEZA', 'P', null);

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678917', '1980-05-07', 'Pedro Nascimento', 'LIMPEZA', 'P', 12345678916);

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678918', '1990-05-07', 'José Marconi', 'LIMPEZA', 'J', 12345678916);

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678919', '1970-06-07', 'Antônio Amílcar', 'SUP_LIMPEZA', 'S', null);

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678920', '1990-05-07', 'Pedro Américo', 'LIMPEZA', 'P', 12345678919);

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678921', '1990-05-01', 'Thais Silveira', 'LIMPEZA', 'P', 12345678919);

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678922', '1993-05-07', 'Joana Nascimento', 'LIMPEZA', 'J', 12345678919);

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678923', '1995-05-08', 'Pedro Henrique', 'LIMPEZA', 'J', 12345678919);

-- Exemplos de fracasso

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678924', '1980-04-09', 'joao da Nascimento', 'LIMPEZA', 'J', null);

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678925', '1980-04-09', 'joao da Silva', 'LIMPEZA', 'T', '12345678919');

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678926', null , 'joao da Silva', 'LIMPEZA', 'J', '12345678919');

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678923', '1980-04-09', 'joao da Silva', 'LIMPEZA', 'J', '12345678919');

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678927', '1980-04-09', null, 'LIMPEZA', 'J', '12345678919');

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678928', '1980-04-09', 'joao da Silva', 'SUP_LIMPEZA', 'J', '12345678919');

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678913', '1980-04-09', 'joao da Silva', 'LIMPEZA', null, '12345678919');

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678913', '1980-04-09', 'joao da Silva', 'LIMPEZA', 'Q', '12345678919');

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678913', '1980-04-09', 'joao da Silva', 'LIMPEZA', 'V', '12345678919');

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678913', '1980-04-09', null, 'LIMPEZA', 'J', '12345678919');


-- Questão 10


INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('32323232955', '1980-04-09', 'Maria da Silva', 'SUP_LIMPEZA', 'S', null);

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('32323232911', '1980-04-09', 'Maria da Costa', 'LIMPEZA', 'J', '32323232955');

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('98765432111', '1980-04-09', 'Maria Severina', 'LIMPEZA', 'J', '32323232955');

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('98765432122', '1980-04-09', 'Daniel Barbosa', 'LIMPEZA', 'J', '32323232955');

ALTER TABLE tarefas ADD CONSTRAINT fk_tarefa_funcionario FOREIGN KEY (func_resp_cpf) REFERENCES funcionario (cpf) ON DELETE CASCADE;

ALTER TABLE tarefas DROP CONSTRAINT fk_tarefa_funcionario;

-- OPÇÃO 1
ALTER TABLE tarefas ADD CONSTRAINT fk_tarefa_funcionario FOREIGN KEY (func_resp_cpf) REFERENCES funcionario (cpf) ON DELETE CASCADE;

DELETE FROM funcionario WHERE cpf = '98765432111';

--OPCAO 2

ALTER TABLE tarefas DROP CONSTRAINT fk_tarefa_funcionario;

ALTER TABLE tarefas ADD CONSTRAINT fk_tarefa_funcionario_restrict FOREIGN KEY (func_resp_cpf) REFERENCES funcionario (cpf) ON DELETE RESTRICT;

DELETE FROM funcionario WHERE cpf = '32323232955';

ERROR:  update or delete on table "funcionario" violates foreign key constraint "funcionario_superior_cpf_fkey" on table "funcionario"
DETAIL:  Key (cpf)=(32323232955) is still referenced from table "funcionario".

-- Questão 11

ALTER TABLE tarefas ALTER COLUMN func_resp_cpf DROP NOT NULL;

-- AJEITAR ISSO AQUI
-- *
ALTER TABLE tarefas ADD CONSTRAINT func_resp_cpf_null CHECK (((status = 'C' OR status = 'E') AND (func_resp_cpf IS NOT NULL)) OR status = 'P');
-- *
ALTER TABLE tarefas DROP CONSTRAINT fk_tarefa_funcionario_restrict;

ALTER TABLE tarefas ADD CONSTRAINT fk_tarefa_funcionario_null FOREIGN KEY (func_resp_cpf) REFERENCES funcionario (cpf) ON DELETE SET NULL;

ALTER TABLE tarefas DROP CONSTRAINT fk_tarefa_funcionario_null;

DELETE FROM tarefas WHERE (func_resp_cpf = '32323232911' and status = 'P');

INSERT INTO tarefas VALUES (21474883653, 'limpar portas do 3º andar', '32323232955', 2, 'P');

INSERT INTO tarefas VALUES (21474883653, 'limpar portas do 4º andar', '12345678923', 2, 'E');

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678923', '1980-04-09', 'joao da Silva', 'LIMPEZA', 'J', '12345678919');

DELETE FROM funcionario WHERE (cpf = '32323232955');
DELETE FROM funcionario WHERE (cpf = '12345678923');
DELETE FROM funcionario WHERE (cpf = '98765432122');

new row for relation "tarefas" violates check constraint "func_resp_cpf_null"
DETAIL:  Failing row contains (2147483647, limpar janelas da sala 203, null, 1, C).
CONTEXT:  SQL statement "UPDATE ONLY "public"."tarefas" SET "func_resp_cpf" = NULL WHERE $1 OPERATOR(pg_catalog.=) "func_resp_cpf""
