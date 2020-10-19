--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.23
-- Dumped by pg_dump version 9.5.23

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.farmacias DROP CONSTRAINT fk_gerente;
ALTER TABLE ONLY public.funcionarios DROP CONSTRAINT fk_farmacia;
ALTER TABLE ONLY public.enderecos DROP CONSTRAINT fk_endereco_cliente;
ALTER TABLE ONLY public.vendas DROP CONSTRAINT fk_compra_vendedor;
ALTER TABLE ONLY public.vendas DROP CONSTRAINT fk_compra_produto;
ALTER TABLE ONLY public.vendas DROP CONSTRAINT fk_compra_cliente;
ALTER TABLE ONLY public.vendas DROP CONSTRAINT vendas_pkey;
ALTER TABLE ONLY public.farmacias DROP CONSTRAINT unica_sede;
ALTER TABLE ONLY public.medicamentos DROP CONSTRAINT medicamentos_pkey;
ALTER TABLE ONLY public.funcionarios DROP CONSTRAINT funcionarios_pkey;
ALTER TABLE ONLY public.farmacias DROP CONSTRAINT farmacias_pkey;
ALTER TABLE ONLY public.farmacias DROP CONSTRAINT farmacias_bairro_key;
ALTER TABLE ONLY public.enderecos DROP CONSTRAINT enderecos_pkey;
ALTER TABLE ONLY public.clientes DROP CONSTRAINT clientes_pkey;
DROP TABLE public.vendas;
DROP TABLE public.medicamentos;
DROP TABLE public.funcionarios;
DROP TABLE public.farmacias;
DROP TABLE public.entregas;
DROP TABLE public.enderecos;
DROP TABLE public.clientes;
DROP TYPE public.tipos_endereco;
DROP TYPE public.funcoes;
DROP TYPE public.estados_nordeste;
DROP EXTENSION btree_gist;
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: btree_gist; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS btree_gist WITH SCHEMA public;


--
-- Name: EXTENSION btree_gist; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION btree_gist IS 'support for indexing common datatypes in GiST';


--
-- Name: estados_nordeste; Type: TYPE; Schema: public; Owner: lucianoesff
--

CREATE TYPE public.estados_nordeste AS ENUM (
    'Alagoas',
    'Bahia',
    'Ceará',
    'Maranhão',
    'Paraíba',
    'Pernambuco',
    'Piauí',
    'Rio Grande do Norte',
    'Sergipe'
);


ALTER TYPE public.estados_nordeste OWNER TO lucianoesff;

--
-- Name: funcoes; Type: TYPE; Schema: public; Owner: lucianoesff
--

CREATE TYPE public.funcoes AS ENUM (
    'Farmacêutico',
    'Vendedor',
    'Entregador',
    'Caixa',
    'Administrador'
);


ALTER TYPE public.funcoes OWNER TO lucianoesff;

--
-- Name: tipos_endereco; Type: TYPE; Schema: public; Owner: lucianoesff
--

CREATE TYPE public.tipos_endereco AS ENUM (
    'Residência',
    'Trabalho',
    'Outro'
);


ALTER TYPE public.tipos_endereco OWNER TO lucianoesff;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: clientes; Type: TABLE; Schema: public; Owner: lucianoesff
--

CREATE TABLE public.clientes (
    cpf character(11) NOT NULL,
    nome text NOT NULL,
    data_nascimento timestamp without time zone NOT NULL,
    telefone character varying(15) NOT NULL,
    email text,
    CONSTRAINT cliente_maior_de_idade CHECK ((age(data_nascimento) > '18 years'::interval))
);


ALTER TABLE public.clientes OWNER TO lucianoesff;

--
-- Name: enderecos; Type: TABLE; Schema: public; Owner: lucianoesff
--

CREATE TABLE public.enderecos (
    id integer NOT NULL,
    cliente character(11) NOT NULL,
    cidade text NOT NULL,
    bairro text NOT NULL,
    rua text NOT NULL,
    numero integer NOT NULL,
    tipo public.tipos_endereco NOT NULL
);


ALTER TABLE public.enderecos OWNER TO lucianoesff;

--
-- Name: entregas; Type: TABLE; Schema: public; Owner: lucianoesff
--

CREATE TABLE public.entregas (
    id integer NOT NULL,
    cliente_entrega character(11) NOT NULL,
    proprietario_endereco character(11) NOT NULL,
    CONSTRAINT cliente_valido CHECK (((cliente_entrega IS NOT NULL) AND (proprietario_endereco = cliente_entrega)))
);


ALTER TABLE public.entregas OWNER TO lucianoesff;

--
-- Name: farmacias; Type: TABLE; Schema: public; Owner: lucianoesff
--

CREATE TABLE public.farmacias (
    id integer NOT NULL,
    tipo character varying(6) NOT NULL,
    gerente character(11),
    funcao_gerente public.funcoes NOT NULL,
    cidade text NOT NULL,
    bairro text NOT NULL,
    estado public.estados_nordeste NOT NULL,
    CONSTRAINT funcoes_gerente CHECK (((funcao_gerente = 'Farmacêutico'::public.funcoes) OR (funcao_gerente = 'Administrador'::public.funcoes)))
);


ALTER TABLE public.farmacias OWNER TO lucianoesff;

--
-- Name: funcionarios; Type: TABLE; Schema: public; Owner: lucianoesff
--

CREATE TABLE public.funcionarios (
    cpf character(11) NOT NULL,
    nome text NOT NULL,
    funcao public.funcoes NOT NULL,
    farmacia integer
);


ALTER TABLE public.funcionarios OWNER TO lucianoesff;

--
-- Name: medicamentos; Type: TABLE; Schema: public; Owner: lucianoesff
--

CREATE TABLE public.medicamentos (
    id integer NOT NULL,
    nome text NOT NULL,
    exclusivo boolean NOT NULL,
    preco numeric NOT NULL
);


ALTER TABLE public.medicamentos OWNER TO lucianoesff;

--
-- Name: vendas; Type: TABLE; Schema: public; Owner: lucianoesff
--

CREATE TABLE public.vendas (
    id integer NOT NULL,
    cliente character(11),
    produto integer,
    vendedor character(11),
    funcao_funcionario public.funcoes NOT NULL,
    venda_exclusiva boolean NOT NULL,
    CONSTRAINT funcao_vendedor CHECK ((funcao_funcionario = 'Vendedor'::public.funcoes)),
    CONSTRAINT venda_receita CHECK ((((cliente IS NOT NULL) AND (venda_exclusiva = true)) OR (venda_exclusiva = false)))
);


ALTER TABLE public.vendas OWNER TO lucianoesff;

--
-- Data for Name: clientes; Type: TABLE DATA; Schema: public; Owner: lucianoesff
--



--
-- Data for Name: enderecos; Type: TABLE DATA; Schema: public; Owner: lucianoesff
--



--
-- Data for Name: entregas; Type: TABLE DATA; Schema: public; Owner: lucianoesff
--



--
-- Data for Name: farmacias; Type: TABLE DATA; Schema: public; Owner: lucianoesff
--



--
-- Data for Name: funcionarios; Type: TABLE DATA; Schema: public; Owner: lucianoesff
--



--
-- Data for Name: medicamentos; Type: TABLE DATA; Schema: public; Owner: lucianoesff
--



--
-- Data for Name: vendas; Type: TABLE DATA; Schema: public; Owner: lucianoesff
--



--
-- Name: clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: lucianoesff
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (cpf);


--
-- Name: enderecos_pkey; Type: CONSTRAINT; Schema: public; Owner: lucianoesff
--

ALTER TABLE ONLY public.enderecos
    ADD CONSTRAINT enderecos_pkey PRIMARY KEY (id);


--
-- Name: farmacias_bairro_key; Type: CONSTRAINT; Schema: public; Owner: lucianoesff
--

ALTER TABLE ONLY public.farmacias
    ADD CONSTRAINT farmacias_bairro_key UNIQUE (bairro);


--
-- Name: farmacias_pkey; Type: CONSTRAINT; Schema: public; Owner: lucianoesff
--

ALTER TABLE ONLY public.farmacias
    ADD CONSTRAINT farmacias_pkey PRIMARY KEY (id);


--
-- Name: funcionarios_pkey; Type: CONSTRAINT; Schema: public; Owner: lucianoesff
--

ALTER TABLE ONLY public.funcionarios
    ADD CONSTRAINT funcionarios_pkey PRIMARY KEY (cpf);


--
-- Name: medicamentos_pkey; Type: CONSTRAINT; Schema: public; Owner: lucianoesff
--

ALTER TABLE ONLY public.medicamentos
    ADD CONSTRAINT medicamentos_pkey PRIMARY KEY (id);


--
-- Name: unica_sede; Type: CONSTRAINT; Schema: public; Owner: lucianoesff
--

ALTER TABLE ONLY public.farmacias
    ADD CONSTRAINT unica_sede EXCLUDE USING gist (tipo WITH =) WHERE (((tipo)::text = 'Sede'::text));


--
-- Name: vendas_pkey; Type: CONSTRAINT; Schema: public; Owner: lucianoesff
--

ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT vendas_pkey PRIMARY KEY (id);


--
-- Name: fk_compra_cliente; Type: FK CONSTRAINT; Schema: public; Owner: lucianoesff
--

ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT fk_compra_cliente FOREIGN KEY (cliente) REFERENCES public.clientes(cpf);


--
-- Name: fk_compra_produto; Type: FK CONSTRAINT; Schema: public; Owner: lucianoesff
--

ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT fk_compra_produto FOREIGN KEY (produto) REFERENCES public.medicamentos(id);


--
-- Name: fk_compra_vendedor; Type: FK CONSTRAINT; Schema: public; Owner: lucianoesff
--

ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT fk_compra_vendedor FOREIGN KEY (vendedor) REFERENCES public.funcionarios(cpf);


--
-- Name: fk_endereco_cliente; Type: FK CONSTRAINT; Schema: public; Owner: lucianoesff
--

ALTER TABLE ONLY public.enderecos
    ADD CONSTRAINT fk_endereco_cliente FOREIGN KEY (cliente) REFERENCES public.clientes(cpf);


--
-- Name: fk_farmacia; Type: FK CONSTRAINT; Schema: public; Owner: lucianoesff
--

ALTER TABLE ONLY public.funcionarios
    ADD CONSTRAINT fk_farmacia FOREIGN KEY (farmacia) REFERENCES public.farmacias(id);


--
-- Name: fk_gerente; Type: FK CONSTRAINT; Schema: public; Owner: lucianoesff
--

ALTER TABLE ONLY public.farmacias
    ADD CONSTRAINT fk_gerente FOREIGN KEY (gerente) REFERENCES public.funcionarios(cpf);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

-- Essa linha deve funcionar, pois o tipo de farmácia é Sede e o nome do estado é um válido do nordeste. 
INSERT INTO farmacias(id, tipo, gerente, funcao_gerente, cidade, bairro, estado) VALUES (1, 'Sede', null, null, 'Campina Grande', 'Santa Rosa', 'Paraíba');

-- Essa linha deve funcionar, pois a função do funcionário é válida e só está alocado em uma farmácia.
INSERT INTO funcionarios (cpf, nome, farmacia, funcao) VALUES 
('01234567891', 'Marcos Nascimento', 1, 'Vendedor');

-- Essa linha deve funcionar, pois a função do funcionário é válida e só está alocado em uma farmácia.
INSERT INTO funcionarios (cpf, nome, farmacia, funcao) VALUES ('01234567892', 'Alexandre Peixoto', 1, 'Entregador');

-- Essa linha deve funcionar, pois a função do funcionário é válida e só está alocado em uma farmácia.
INSERT INTO funcionarios (cpf, nome, farmacia, funcao) VALUES ('01234567893', 'Maria Paiva', 1, 'Caixa');

-- Essa linha deve funcionar, pois a função do funcionário é válida e só está alocado em uma farmácia.
INSERT INTO funcionarios (cpf, nome, farmacia, funcao) VALUES ('01234567894', 'Ana Peixoto', 1, 'Farmacêutico');

-- Essa linha deve funcionar, pois a função do funcionário é válida e só está alocado em uma farmácia.
INSERT INTO funcionarios (cpf, nome, farmacia, funcao) VALUES ('01234567895', 'Hoanna Michelle', 1, 'Administrador');

-- Adicionando um gerente à farmácia de id 1. Observe que nesse banco, pode-se criar uma farmácia sem gerente.
UPDATE farmacias SET gerente = '01234567895' WHERE id = 1;
UPDATE farmacias SET funcao_gerente = 'Administrador' WHERE id = 1;

-- Essa linha não deve funcionar, pois a função do funcionário não é válida.
	--ERROR:  invalid input value for enum funcoes: "Pedreiro"
	--LINE 1: ...funcao) VALUES ('01234567896', 'Marcos Paulo', 1, 'Pedreiro'...
INSERT INTO funcionarios (cpf, nome, farmacia, funcao) VALUES ('01234567896', 'Marcos Paulo', 1, 'Pedreiro');


-- Essa linha deve funcinonar, pois o tipo de farmácia é válida.
INSERT INTO farmacias(id, tipo, gerente, funcao_gerente, cidade, bairro, estado) VALUES (2, 'Filial', null, null, 'João Pessoa', 'Cabo Branco', 'Paraíba');

-- Essa linha não deve funcinonar, pois o estado não é válido.
	--ERROR:  invalid input value for enum estados_nordeste: "São Paulo"
	--LINE 1: ...Filial', null, null, 'São Paulo', 'Av. Paulista', 'São Paulo...
INSERT INTO farmacias(id, tipo, gerente, funcao_gerente, cidade, bairro, estado) VALUES (3, 'Filial', null, null, 'São Paulo', 'Av. Paulista', 'São Paulo');

-- Essa linha não deve funcionar, pois o tipo de farmácia não é válida.
	--ERROR:  value too long for type character varying(6)
INSERT INTO farmacias(id, tipo, gerente, funcao_gerente, cidade, bairro, estado) VALUES (4, 'Qualquer outra', null, null, 'João Pessoa', 'Cabo Branco', 'Paraíba');

-- Essa linha não deve funcionar, pois só pode ter uma sede.
	--ERROR:  conflicting key value violates exclusion constraint "unica_sede"
	--DETAIL:  Key (tipo)=(Sede) conflicts with existing key (tipo)=(Sede).
INSERT INTO farmacias(id, tipo, gerente, funcao_gerente, cidade, bairro, estado) VALUES (5, 'Sede', null, null, 'Campina Grande', 'Cruzeiro', 'Paraíba');

-- Essa linha não deve funcionar, pois só pode ter uma farmácia por bairro.
	--ERROR:  duplicate key value violates unique constraint "farmacias_bairro_key"
	--DETAIL:  Key (bairro)=(Santa Rosa) already exists.
INSERT INTO farmacias(id, tipo, gerente, funcao_gerente, cidade, bairro, estado) VALUES (6, 'Filial', null, null, 'Campina Grande', 'Santa Rosa', 'Paraíba');

-- Essa linha deve funcionar.
INSERT INTO clientes(cpf, nome, data_nascimento, telefone, email) VALUES ('12345678910', 'Marcos Alexandre', '1990-04-10', '993129366', null);

-- Essa linha deve funcionar.
INSERT INTO clientes(cpf, nome, data_nascimento, telefone, email) VALUES ('12345678911', 'Ana Marconi', '1996-05-11', '993129367', null);

-- Essa linha deve funcionar.
INSERT INTO clientes(cpf, nome, data_nascimento, telefone, email) VALUES ('12345678912', 'André Bulini', '1997-04-10', '991129366', null);

-- Essa linha não deve funcionar, pois o usuário é menor de idade.
	--ERROR:  new row for relation "clientes" violates check constraint "cliente_maior_de_idade"
--DETAIL:  Failing row contains (12345678913, Enzo Genérico, 2009-04-10 00:00:00, 993129360, null).
INSERT INTO clientes(cpf, nome, data_nascimento, telefone, email) VALUES ('12345678913', 'Enzo Genérico', '2009-04-10', '993129360', null);

-- Essa linha deve executar.
INSERT INTO enderecos(id, cliente, cidade, bairro, rua, numero, tipo) VALUES (1, '12345678912', 'Campina Grande', 'Cruzeiro', 'Antônio Amílcar de Almeida', 600, 'Residência');
-- Essa linha deve executar.
INSERT INTO enderecos(id, cliente, cidade, bairro, rua, numero, tipo) VALUES (2, '12345678912', 'Campina Grande', 'Cruzeiro', 'Av. Almirante Barroso', 1801, 'Trabalho');

-- Essa linha deve executar.
INSERT INTO enderecos(id, cliente, cidade, bairro, rua, numero, tipo) VALUES (3, '12345678911', 'Campina Grande', 'Jardim Tavares', 'Orestes Fialho', 170, 'Outro');

-- Essa linha não deve funcionar, pois o tipo de endereço não é válido.
-- ERROR:  invalid input value for enum tipos_endereco: "Genérico"
--LINE 1: ...Grande', 'Jardim Tavares', 'Orestes Fialho', 171, 'Genérico'...
INSERT INTO enderecos(id, cliente, cidade, bairro, rua, numero, tipo) VALUES (4, '12345678910', 'Campina Grande', 'Jardim Tavares', 'Orestes Fialho', 171, 'Genérico');

-- Essa linha deve executar
INSERT INTO medicamentos (id, nome, exclusivo, preco) VALUES (1, 'Cinegripe', false, 5.50);

-- Essa linha deve executar
INSERT INTO medicamentos (id, nome, exclusivo, preco) VALUES (2, 'Cataflan', false, 11.00);

-- Essa linha deve executar
INSERT INTO medicamentos (id, nome, exclusivo, preco) VALUES (3, 'Sorine', false, 5.50);

-- Essa linha deve executar
INSERT INTO medicamentos (id, nome, exclusivo, preco) VALUES (4, 'Roacutan', true, 150);

-- Essa linha deve executar
INSERT INTO medicamentos (id, nome, exclusivo, preco) VALUES (5, 'gardenal', true, 100);

-- Essa linha deve executar
INSERT INTO medicamentos (id, nome, exclusivo, preco) VALUES (6, 'Dipirona', false, 5.50);

-- Essa linha deve executar
INSERT INTO vendas (id, cliente, produto, vendedor, funcao_funcionario, venda_exclusiva) VALUES (1, null, 2, '01234567891', 'Vendedor', false);


-- Essa linha deve executar
INSERT INTO vendas (id, cliente, produto, vendedor, funcao_funcionario, venda_exclusiva) VALUES (2, '12345678911', 2, '01234567891', 'Vendedor', true);

-- Essa linha não deve executar, pois a função do funcionário não é vendedor
--ERROR:  new row for relation "vendas" violates check constraint "funcao_vendedor"
--DETAIL:  Failing row contains (1, null, 2, 01234567893, Caixa, f).

INSERT INTO vendas (id, cliente, produto, vendedor, funcao_funcionario, venda_exclusiva) VALUES (1, null, 2, '01234567893', 'Caixa', false);

-- Essa linha deve executar
INSERT INTO entregas (id, cliente_entrega, proprietario_endereco) VALUES (1, '12345678911', '12345678911');

-- Essa linha deve executar, pois o cliente não é o mesmo.
--ERROR:  new row for relation "entregas" violates check constraint "cliente_valido"
--DETAIL:  Failing row contains (1, 12345678911, 12346578910).

INSERT INTO entregas (id, cliente_entrega, proprietario_endereco) VALUES (1, '12345678911', '12346578910');


-- Essa linha deve executar
DELETE FROM funcionarios WHERE funcao = 'Entregador';
-- Essa linha não deve executar
--ERROR:  update or delete on table "funcionarios" violates foreign key constraint "fk_compra_vendedor" on table "vendas"
--DETAIL:  Key (cpf)=(01234567891) is still referenced from table "vendas".
DELETE FROM funcionarios WHERE funcao = 'Vendedor';

-- Essa linha não deve executar
--ERROR:  update or delete on table "medicamentos" violates foreign key constraint "fk_compra_produto" on table "vendas"
--DETAIL:  Key (id)=(2) is still referenced from table "vendas".

DELETE FROM medicamentos WHERE id = 2;

-- Essa linha deve executar.
DELETE FROM medicamentos WHERE id = 4;
