-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2020-11-05 11:49:20.618

-- tables
-- Table: Chaveamento
CREATE TABLE Chaveamento (
    id int  NOT NULL,
    mandante int  NOT NULL,
    visitante int  NOT NULL,
    data date  NOT NULL,
    CONSTRAINT Chaveamento_pk PRIMARY KEY (id)
);

-- Table: Equipe
CREATE TABLE Equipe (
    id int  NOT NULL,
    nome varchar(50)  NULL,
    tecnico varchar(50)  NULL,
    numeroJogadores int  NOT NULL,
    Estadio_id int  NOT NULL,
    CONSTRAINT Equipe_pk PRIMARY KEY (id)
);

-- Table: Estadio
CREATE TABLE Estadio (
    id int  NOT NULL,
    nome varchar(100)  NULL,
    capacidade int  NULL,
    cidade varchar(50)  NULL,
    estado varchar(50)  NULL,
    CONSTRAINT Estadio_pk PRIMARY KEY (id)
);

-- Table: Joga_em
CREATE TABLE Joga_em (
    posicao varchar(15)  NULL,
    numero int  NULL,
    salario real  NULL,
    Jogador_id int  NOT NULL,
    contrato int  NOT NULL,
    Equipe_id int  NOT NULL,
    CONSTRAINT Joga_em_pk PRIMARY KEY (contrato)
);

-- Table: Jogador
CREATE TABLE Jogador (
    id int  NOT NULL,
    nome varchar(100)  NOT NULL,
    dataNascimento date  NOT NULL,
    apelido varchar(30)  NOT NULL,
    CONSTRAINT Jogador_pk PRIMARY KEY (id)
);

-- Table: Jogou
CREATE TABLE Jogou (
    partida int  NOT NULL,
    posicao_partida varchar(15)  NOT NULL,
    minutos_em_campo int  NOT NULL,
    gols_partida int  NOT NULL,
    assistencias_partida int  NOT NULL,
    Jogador_id int  NOT NULL,
    CONSTRAINT Jogou_pk PRIMARY KEY (partida)
);

-- Table: Partida
CREATE TABLE Partida (
    id int  NOT NULL,
    estadio int  NOT NULL,
    horario time  NULL,
    resultado varchar(5)  NULL,
    Chaveamento_id int  NOT NULL,
    CONSTRAINT Partida_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: Equipe_Estadio (table: Equipe)
ALTER TABLE Equipe ADD CONSTRAINT Equipe_Estadio
    FOREIGN KEY (Estadio_id)
    REFERENCES Estadio (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Estadio_Partida (table: Partida)
ALTER TABLE Partida ADD CONSTRAINT Estadio_Partida
    FOREIGN KEY (estadio)
    REFERENCES Estadio (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Joga_em_Equipe (table: Joga_em)
ALTER TABLE Joga_em ADD CONSTRAINT Joga_em_Equipe
    FOREIGN KEY (Equipe_id)
    REFERENCES Equipe (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Joga_em_Jogador (table: Joga_em)
ALTER TABLE Joga_em ADD CONSTRAINT Joga_em_Jogador
    FOREIGN KEY (Jogador_id)
    REFERENCES Jogador (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Jogou_Jogador (table: Jogou)
ALTER TABLE Jogou ADD CONSTRAINT Jogou_Jogador
    FOREIGN KEY (Jogador_id)
    REFERENCES Jogador (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Partida_Chaveamento (table: Partida)
ALTER TABLE Partida ADD CONSTRAINT Partida_Chaveamento
    FOREIGN KEY (Chaveamento_id)
    REFERENCES Chaveamento (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Partida_Jogou (table: Jogou)
ALTER TABLE Jogou ADD CONSTRAINT Partida_Jogou
    FOREIGN KEY (partida)
    REFERENCES Partida (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: chaveamento_mandante (table: Chaveamento)
ALTER TABLE Chaveamento ADD CONSTRAINT chaveamento_mandante
    FOREIGN KEY (mandante)
    REFERENCES Equipe (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: chaveamento_visitante (table: Chaveamento)
ALTER TABLE Chaveamento ADD CONSTRAINT chaveamento_visitante
    FOREIGN KEY (visitante)
    REFERENCES Equipe (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;


-- Cadastrando jogadores
INSERT INTO Jogador (id, nome, dataNascimento, apelido) VALUES (1, 'Ricardo Gomes', '1985-09-05', 'Kaká');
INSERT INTO Jogador (id, nome, dataNascimento, apelido) VALUES (2, 'Edson Arantes', '1987-04-03', 'Pelé');
INSERT INTO Jogador (id, nome, dataNascimento, apelido) VALUES (3, 'Cristiano Ronaldo Aveiro', '1979-04-03', 'Cristiano Ronaldo');
INSERT INTO Jogador (id, nome, dataNascimento, apelido) VALUES (4, 'Leonel Messi', '1995-04-03', 'Messi');
INSERT INTO Jogador (id, nome, dataNascimento, apelido) VALUES (5, 'Paolo Maldini', '1976-04-03', 'Maldini');
INSERT INTO Jogador (id, nome, dataNascimento, apelido) VALUES (6, 'Franco Baresi', '1965-04-03', 'Baresi');
INSERT INTO Jogador (id, nome, dataNascimento, apelido) VALUES (7, 'Sergio Ramos', '1999-04-03', 'Sergio Ramos');
INSERT INTO Jogador (id, nome, dataNascimento, apelido) VALUES (8, 'Diego Maradona', '1987-04-03', 'Maradona');
INSERT INTO Jogador (id, nome, dataNascimento, apelido) VALUES (9, 'Frank Van Basten', '1997-04-03', 'Van Basten');
INSERT INTO Jogador (id, nome, dataNascimento, apelido) VALUES (10, 'Michel Platini', '1998-04-03', 'Platini');
INSERT INTO Jogador (id, nome, dataNascimento, apelido) VALUES (11, 'Zinedine Zidane', '1999-04-03', 'Zidane');
INSERT INTO Jogador (id, nome, dataNascimento, apelido) VALUES (12, 'Ronaldo Nazario', '1964-04-03', 'Ronaldo');
INSERT INTO Jogador (id, nome, dataNascimento, apelido) VALUES (13, 'Romario Baixo', '1948-04-03', 'Romário');
INSERT INTO Jogador (id, nome, dataNascimento, apelido) VALUES (14, 'Neymar Junior', '1978-04-03', 'Neymar');

-- Cadastrando estádios
INSERT INTO Estadio (id, nome, capacidade, cidade, estado) VALUES (1, 'Vila Belmiro', 25000, 'Santos', 'São Paulo');
INSERT INTO Estadio (id, nome, capacidade, cidade, estado) VALUES (2, 'Maracanã', 75000, 'Rio de Janeiro', 'Rio de Janeiro');
INSERT INTO Estadio (id, nome, capacidade, cidade, estado) VALUES (3, 'São Januário', 35000, 'Rio de Janeiro', 'Rio de Janeiro');
INSERT INTO Estadio (id, nome, capacidade, cidade, estado) VALUES (4, 'Arena Grêmio', 75000, 'Porto Alegre', 'Rio Grande do Sul');
INSERT INTO Estadio (id, nome, capacidade, cidade, estado) VALUES (5, 'Castelão', 55000, 'Fortaleza', 'Ceará');

-- Cadastrando equipes
INSERT INTO Equipe (id, nome, tecnico, numeroJogadores, Estadio_id) VALUES (1, 'Santos', 'Cuca', 21, 1);
INSERT INTO Equipe (id, nome, tecnico, numeroJogadores, Estadio_id) VALUES (2, 'Flamengo', 'Domenec', 28, 2);
INSERT INTO Equipe (id, nome, tecnico, numeroJogadores, Estadio_id) VALUES (3, 'Vasco', 'Pinto', 24, 3);
INSERT INTO Equipe (id, nome, tecnico, numeroJogadores, Estadio_id) VALUES (4, 'São Paulo', 'Fernando Diniz', 24, 1);
INSERT INTO Equipe (id, nome, tecnico, numeroJogadores, Estadio_id) VALUES (5, 'Grêmio', 'Renato Graúcho', 26, 4);
INSERT INTO Equipe (id, nome, tecnico, numeroJogadores, Estadio_id) VALUES (6, 'Ceará', 'Guto Ferreira', 20, 5);
INSERT INTO Equipe (id, nome, tecnico, numeroJogadores, Estadio_id) VALUES (7, 'Fortaleza', 'Rogério Ceni', 27, 5);
INSERT INTO Equipe (id, nome, tecnico, numeroJogadores, Estadio_id) VALUES (8, 'Fluminense', 'Odair Hellman', 23, 2);

-- Cadastrando contratos

INSERT INTO Joga_em (posicao, numero, salario, Jogador_id, contrato, Equipe_id) VALUES ('CA', 9, 120000, 1, 1, 2);
INSERT INTO Joga_em (posicao, numero, salario, Jogador_id, contrato, Equipe_id) VALUES ('PE', 11, 300000, 14, 2, 1);
INSERT INTO Joga_em (posicao, numero, salario, Jogador_id, contrato, Equipe_id) VALUES ('PD', 11, 120000, 3, 3, 3); 
INSERT INTO Joga_em (posicao, numero, salario, Jogador_id, contrato, Equipe_id) VALUES ('ATA', 99, 130000, 4, 4, 4);
INSERT INTO Joga_em (posicao, numero, salario, Jogador_id, contrato, Equipe_id) VALUES ('ATA', 97, 140000, 5, 5, 5);
INSERT INTO Joga_em (posicao, numero, salario, Jogador_id, contrato, Equipe_id) VALUES ('MEI', 96, 150000, 6, 6, 6);
INSERT INTO Joga_em (posicao, numero, salario, Jogador_id, contrato, Equipe_id) VALUES ('MEI', 95, 160000, 7, 7, 7);
INSERT INTO Joga_em (posicao, numero, salario, Jogador_id, contrato, Equipe_id) VALUES ('MEI', 94, 170000, 8, 8, 8);
INSERT INTO Joga_em (posicao, numero, salario, Jogador_id, contrato, Equipe_id) VALUES ('ZAG', 93, 180000, 9, 9, 4);
INSERT INTO Joga_em (posicao, numero, salario, Jogador_id, contrato, Equipe_id) VALUES ('ZAG', 92, 190000, 10, 10, 1); 
INSERT INTO Joga_em (posicao, numero, salario, Jogador_id, contrato, Equipe_id) VALUES ('ZAG', 91, 200000, 11, 11, 3); 
INSERT INTO Joga_em (posicao, numero, salario, Jogador_id, contrato, Equipe_id) VALUES ('MEI', 90, 210000, 12, 12, 5); 
INSERT INTO Joga_em (posicao, numero, salario, Jogador_id, contrato, Equipe_id) VALUES ('Atacante', 89, 160000, 13, 13, 2);
INSERT INTO Joga_em (posicao, numero, salario, Jogador_id, contrato, Equipe_id) VALUES ('Atacante', 88, 180000, 2, 14, 1);

-- Cadastrando chaveamentos
INSERT INTO Chaveamento (id,mandante,visitante,data) VALUES (1, 1, 2, '2020-04-11');
INSERT INTO Chaveamento (id,mandante,visitante,data) VALUES (2, 3, 4, '2020-04-11');
INSERT INTO Chaveamento (id,mandante,visitante,data) VALUES (3, 5, 6, '2020-04-11');
INSERT INTO Chaveamento (id,mandante,visitante,data) VALUES (4, 7, 8, '2020-04-11');

-- Cadastrando Partida
INSERT INTO Partida (id, estadio, horario, resultado, Chaveamento_id) VALUES (1, 1, '21:00:00', '03x00', 1);
INSERT INTO Partida (id, estadio, horario, resultado, Chaveamento_id) VALUES (2, 2, '21:00:00', '02x01', 2);
INSERT INTO Partida (id, estadio, horario, resultado, Chaveamento_id) VALUES (3, 3, '21:00:00', '01x04', 3);
INSERT INTO Partida (id, estadio, horario, resultado, Chaveamento_id) VALUES (4, 4, '21:00:00', '00x05', 4);

-- Cadastrando jogou
INSERT INTO Jogou (partida, posicao_partida, minutos_em_campo, gols_partida, assistencias_partida, Jogador_id) VALUES (1, 'ATA', 90, 2, 1, 14);
INSERT INTO Jogou (partida, posicao_partida, minutos_em_campo, gols_partida, assistencias_partida, Jogador_id) VALUES (2, 'ATA', 90, 2, 0, 13);
INSERT INTO Jogou (partida, posicao_partida, minutos_em_campo, gols_partida, assistencias_partida, Jogador_id) VALUES (3, 'ATA', 45, 0, 0, 3);
INSERT INTO Jogou (partida, posicao_partida, minutos_em_campo, gols_partida, assistencias_partida, Jogador_id) VALUES (4, 'ATA', 90, 5, 0, 4);
