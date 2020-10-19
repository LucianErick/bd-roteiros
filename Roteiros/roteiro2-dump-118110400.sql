-- Comentários
--
-- Questão 1:
--	Criei uma tabela tarefas com os campos id (integer), descrição(text podendo ser null), cpf (char com tamanho 11 podendo ser null), prioridade (integer podendo ser null) e status (char com tamanho 1 podendo ser null). 
-- Além da criação, houve a inserção de os valores citados na descrição do roteiro.
--
-- Questão 2:
--	Mudei o tipo do atributo id para bigint
--	Inseri o valor citado.
--
-- Questão 3:
--	Mudei o tipo de dado do atributo propriedade para smallint
--	Inseri os valores citados.
--
-- Questão 4:
--	Alterei o nome da coluna cpf para func_resp_cpf
--	Alterei todas os atributos para aceitar receber valores nulos.
--
-- Questão 5:
--	Adicionei uma Primary Key - o ID
--	Inseri os valores citados no documento.
--
-- Questão 6:
--	Letra A:
--		Adicionei uma constraint tamanho_numero_cpf_valido que checa se o tamanho da string de func_resp_cpf é 11.
--		Inseri os valores citados no documento
--	Letra B:
--		Atualizei os valores dos status de A, R, F para P, E e C, respectivamente.
--		Criei uma constraint status_possiveis_check que checa se os valores de status são P, E ou C.
--
-- Questão 7:
--	Atualizei o atributo prioridade para que ele mude para 5 valores que são maiores que 5.
--	Criei uma constraint prioridade_valores_possiveis_check que checa se 0 <= prioridade <= 5
--
-- Questão 8:
--	Criei uma tabela funcionário com cpf (char de 11 caracteres), data_nasc (date que não pode ser null), nome (text que não pode ser null), funcao (varchar de 11 caracteres), nivel (char de 1 caractere que não pode ser null), superior_cpf (char que pode ser de 11 caracteres e que é uma chave estrangeira) 
--	Criei uma constraint funcao_ter_superior_check para checar se a função ser limpeza, o superior não pode ser null.
--	Criei uma constraint niveis_possiveis_check onde o nivel pode ser J, P ou S.
--	Inseri os valores citados.
-- Questão 9:
--	Adicionei 10 dados que deram sucesso e depois fiz 10 tentativas de inserções que deram choque com a constraint.	
--
-- Questão 10:
--	Inseri os valores citados
--	adicionei uma constraint fk_tarefa_funcionario tanto para ON DELETE CASCADE quanto pra o RESTRICT
--	Ao realizar o procedimento citado no documento, cheguei no seguinte erro:
--	ERROR:  update or delete on table "funcionario" violates foreign key constraint "funcionario_superior_cpf_fkey" on table "funcionario" DETAIL:  Key (cpf)=(32323232955) is still referenced from table "funcionario".	
--
-- Questão 11:
--	Tirei a restrição NOT NULL da coluna func_resp_cpf
--	adicionei uma constraint func_resp_cpf_null que checa se o status é P, e se for, func_resp_cpf pode ser nulo.
--	Adicionei uma constraint fk_tarefa_funcionario_null ON DELETE SET NULL
--	Adicionei valores e tentei deletar dados seguindo o documento.
--	O erro que eu encontrei ao tentar deletar funcionários que tem tarefas atribuidas de status C ou E foi:
--	new row for relation "tarefas" violates check constraint "func_resp_cpf_null" DETAIL:  Failing row contains (2147483647, limpar janelas da sala 203, null, 1, C). CONTEXT:  SQL statement "UPDATE ONLY "public"."tarefas" SET "func_resp_cpf" = NULL WHERE $1 OPERATOR(pg_catalog.=) "func_resp_cpf""
--
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

ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_superior_cpf_fkey;
ALTER TABLE ONLY public.tarefas DROP CONSTRAINT fk_tarefa_funcionario_null;
ALTER TABLE ONLY public.tarefas DROP CONSTRAINT tarefas_pkey;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_pkey;
DROP TABLE public.tarefas;
DROP TABLE public.funcionario;
SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: funcionario; Type: TABLE; Schema: public; Owner: lucianoesff
--

CREATE TABLE public.funcionario (
    cpf character(11) NOT NULL,
    data_nasc date NOT NULL,
    nome text NOT NULL,
    funcao character varying(11),
    nivel character(1) NOT NULL,
    superior_cpf character(11),
    CONSTRAINT funcao_ter_superior_check CHECK (((((funcao)::text = 'LIMPEZA'::text) AND (superior_cpf IS NOT NULL)) OR (((funcao)::text = 'SUP_LIMPEZA'::text) AND (superior_cpf IS NULL)))),
    CONSTRAINT niveis_possiveis_check CHECK (((nivel = 'J'::bpchar) OR (nivel = 'P'::bpchar) OR (nivel = 'S'::bpchar)))
);


ALTER TABLE public.funcionario OWNER TO lucianoesff;

--
-- Name: tarefas; Type: TABLE; Schema: public; Owner: lucianoesff
--

CREATE TABLE public.tarefas (
    id bigint NOT NULL,
    descricao text NOT NULL,
    func_resp_cpf character(11),
    prioridade smallint NOT NULL,
    status character(1) NOT NULL,
    CONSTRAINT func_resp_cpf_null CHECK (((((status = 'C'::bpchar) OR (status = 'E'::bpchar)) AND (func_resp_cpf IS NOT NULL)) OR (status = 'P'::bpchar))),
    CONSTRAINT prioridade_valores_possiveis_check CHECK (((prioridade >= 0) AND (prioridade <= 5))),
    CONSTRAINT status_possiveis_check CHECK (((status = 'P'::bpchar) OR (status = 'E'::bpchar) OR (status = 'C'::bpchar))),
    CONSTRAINT tamanho_numero_cpf_valido CHECK ((char_length(func_resp_cpf) = 11))
);


ALTER TABLE public.tarefas OWNER TO lucianoesff;

--
-- Data for Name: funcionario; Type: TABLE DATA; Schema: public; Owner: lucianoesff
--

INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678911', '1980-05-07', 'Pedro da Silva', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678912', '1980-03-08', 'Jose da Silva', 'LIMPEZA', 'J', '12345678911');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678914', '1981-06-07', 'Henrique da Silva', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678915', '1982-09-09', 'Pedro da Costa', 'LIMPEZA', 'J', '12345678914');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678916', '1980-05-08', 'Mariana Nascimento', 'SUP_LIMPEZA', 'P', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678917', '1980-05-07', 'Pedro Nascimento', 'LIMPEZA', 'P', '12345678916');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678918', '1990-05-07', 'José Marconi', 'LIMPEZA', 'J', '12345678916');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678919', '1970-06-07', 'Antônio Amílcar', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678920', '1990-05-07', 'Pedro Américo', 'LIMPEZA', 'P', '12345678919');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678921', '1990-05-01', 'Thais Silveira', 'LIMPEZA', 'P', '12345678919');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678922', '1993-05-07', 'Joana Nascimento', 'LIMPEZA', 'J', '12345678919');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('32323232955', '1980-04-09', 'Maria da Silva', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('32323232911', '1980-04-09', 'Maria da Costa', 'LIMPEZA', 'J', '32323232955');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('98765432122', '1980-04-09', 'Daniel Barbosa', 'LIMPEZA', 'J', '32323232955');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678923', '1980-04-09', 'joao da Silva', 'LIMPEZA', 'J', '12345678919');


--
-- Data for Name: tarefas; Type: TABLE DATA; Schema: public; Owner: lucianoesff
--

INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483648, 'limpar portas do térreo', '32323232955', 4, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483647, 'limpar janelas da sala 203', '98765432122', 1, 'C');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (21474883653, 'limpar portas do 4º andar', '12345678923', 2, 'E');


--
-- Name: funcionario_pkey; Type: CONSTRAINT; Schema: public; Owner: lucianoesff
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_pkey PRIMARY KEY (cpf);


--
-- Name: tarefas_pkey; Type: CONSTRAINT; Schema: public; Owner: lucianoesff
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT tarefas_pkey PRIMARY KEY (id);


--
-- Name: fk_tarefa_funcionario_null; Type: FK CONSTRAINT; Schema: public; Owner: lucianoesff
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT fk_tarefa_funcionario_null FOREIGN KEY (func_resp_cpf) REFERENCES public.funcionario(cpf) ON DELETE SET NULL;


--
-- Name: funcionario_superior_cpf_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lucianoesff
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_superior_cpf_fkey FOREIGN KEY (superior_cpf) REFERENCES public.funcionario(cpf);


--
-- PostgreSQL database dump complete
--

