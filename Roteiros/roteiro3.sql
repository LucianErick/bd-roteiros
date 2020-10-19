-- Monolito
-- Web-commerce
-- Cloud
-- Micro-serviços

CREATE TYPE estados_nordeste AS ENUM ('Alagoas', 'Bahia', 'Ceará', 'Maranhão', 'Paraíba', 'Pernambuco', 'Piauí', 'Rio Grande do Norte', 'Sergipe'); 
CREATE TYPE funcoes AS ENUM ('Farmacêutico', 'Vendedor', 'Entregador', 'Caixa', 'Administrador');
CREATE TYPE tipos_endereco AS ENUM ('Residência', 'Trabalho', 'Outro');


CREATE TABLE funcionarios (
	cpf CHAR(11) PRIMARY KEY, 
	nome TEXT NOT NULL, 
	funcao funcoes NOT NULL);

ALTER TABLE funcionarios ADD COLUMN farmacia INTEGER;
ALTER TABLE funcionarios ADD CONSTRAINT fk_farmacia FOREIGN KEY (farmacia) REFERENCES farmacias(id);


CREATE TABLE farmacias(
	id INTEGER PRIMARY KEY,
	tipo VARCHAR(6) NOT NULL,
 	gerente CHAR(11),
	funcao_gerente funcoes,
	cidade TEXT NOT NULL, 
	bairro TEXT NOT NULL UNIQUE,
	estado estados_nordeste NOT NULL,
	CONSTRAINT fk_gerente FOREIGN KEY (gerente) REFERENCES funcionarios(cpf));

	ALTER TABLE farmacias ADD CONSTRAINT unica_sede EXCLUDE USING gist(tipo with =) WHERE (tipo='Sede');

	ALTER TABLE farmacias ADD CONSTRAINT funcoes_gerente CHECK (funcao_gerente = 'Farmacêutico' OR funcao_gerente = 'Administrador');

CREATE TABLE clientes (
	cpf CHAR(11) PRIMARY KEY,
	nome TEXT NOT NULL,
	data_nascimento TIMESTAMP NOT NULL,
	telefone VARCHAR(15) NOT NULL,
	email TEXT,
	CONSTRAINT cliente_maior_de_idade CHECK (AGE(data_nascimento) > '18 years'));

CREATE TABLE medicamentos (
	id INTEGER PRIMARY KEY,
	nome TEXT NOT NULL,
	exclusivo BOOLEAN NOT NULL,
	preco NUMERIC NOT NULL);

CREATE TABLE enderecos (
	id INTEGER PRIMARY KEY,
	cliente CHAR(11) NOT NULL,
	cidade TEXT NOT NULL,
	bairro TEXT NOT NULL,
	rua TEXT NOT NULL,
	numero INTEGER NOT NULL,
	tipo tipos_endereco NOT NULL,
	CONSTRAINT fk_endereco_cliente FOREIGN KEY (cliente) REFERENCES clientes(cpf));

CREATE TABLE entregas (
	id INTEGER NOT NULL,
	cliente_entrega CHAR(11) NOT NULL,
	proprietario_endereco CHAR(11) NOT NULL);

ALTER TABLE entregas ADD CONSTRAINT cliente_valido CHECK ((cliente_entrega IS NOT NULL) AND (proprietario_endereco = cliente_entrega));

CREATE TABLE vendas (
	id INTEGER PRIMARY KEY,
	cliente CHAR(11),
	produto INTEGER,
	vendedor CHAR(11),
	funcao_funcionario funcoes NOT NULL,
	venda_exclusiva BOOLEAN NOT NULL,
	CONSTRAINT fk_compra_cliente FOREIGN KEY (cliente) REFERENCES clientes(cpf),
	CONSTRAINT fk_compra_produto FOREIGN KEY (produto) REFERENCES medicamentos(id),
	CONSTRAINT fk_compra_vendedor FOREIGN KEY (vendedor) REFERENCES funcionarios(cpf));

ALTER TABLE vendas ADD CONSTRAINT fk_venda_exclusiva_check FOREIGN KEY (venda_exclusiva) REFERENCES medicamentos(exclusivo);
ALTER TABLE vendas ADD CONSTRAINT venda_receita CHECK ((cliente IS NOT NULL AND venda_exclusiva = TRUE) OR (venda_exclusiva = FALSE));
ALTER TABLE vendas ADD CONSTRAINT funcao_vendedor_exclusiva FOREIGN KEY (funcao_funcionario) REFERENCES funcionarios(funcao);
ALTER TABLE vendas ADD CONSTRAINT funcao_vendedor CHECK (funcao_funcionario = 'Vendedor');

