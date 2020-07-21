USE db_sistema_curso;

-- CADASTRANDO TIPOS DE CURSOS
ALTER TABLE tipos CHANGE tipo tipo varchar(50) not null;
INSERT INTO tipos (tipo) VALUES ("Banco de Dados");
INSERT INTO tipos (tipo) VALUES ("Programação");
INSERT INTO tipos (tipo) VALUES ("Modelagem de Dados");

-- CADASTRANDO INSTRUTORES
INSERT INTO instrutores (nome_instrutor, telefone) VALUES ("Marcos Braz", "(21) 99123-6541");
INSERT INTO instrutores (nome_instrutor, telefone) VALUES ("Paulo Braga", "(34) 98654-4585");
INSERT INTO instrutores (nome_instrutor, telefone) VALUES ("Lucas Milani", "(85) 99102-8743");
INSERT INTO instrutores (nome_instrutor, telefone) VALUES ("Luiza Maronni", "(11) 99105-9485");

-- CADASTRANDO CURSOS
INSERT INTO cursos (nome_curso, tipo_curso, instrutor_curso, preco_curso) VALUES ("Java Fundamentos", 2, 2, 270);
INSERT INTO cursos (nome_curso, tipo_curso, instrutor_curso, preco_curso) VALUES ("Java Avançado", 2, 2, 330);
INSERT INTO cursos (nome_curso, tipo_curso, instrutor_curso, preco_curso) VALUES ("SQL Completo", 1, 1, 170);
INSERT INTO cursos (nome_curso, tipo_curso, instrutor_curso, preco_curso) VALUES ("PHP Básico", 2, 1, 270);

-- CADASTRANDO ALUNOS
INSERT INTO alunos (nome_aluno, endereco_aluno, email_aluno, nascimento) VALUES ("José", "Rua XV de Novembro 72", "jose@softblue.com.br", "1976-01-08");
INSERT INTO alunos (nome_aluno, endereco_aluno, email_aluno, nascimento) VALUES ("Wagner", "Av. Paulista", "wagner@softblue.com.br", "1967-08-25");
INSERT INTO alunos (nome_aluno, endereco_aluno, email_aluno, nascimento) VALUES ("Emílio", "Rua Lajes 103, ap. 701", "emilio@softblue.com.br", "1996-11-24");
INSERT INTO alunos (nome_aluno, endereco_aluno, email_aluno, nascimento) VALUES ("Cris", "Rua Tauney 22", "cris@softblue.com.br", "1986-11-03");
INSERT INTO alunos (nome_aluno, endereco_aluno, email_aluno, nascimento) VALUES ("Regina", "Rua Salles 305", "regina@softblue.com.br", "1998-08-13");
INSERT INTO alunos (nome_aluno, endereco_aluno, email_aluno, nascimento) VALUES ("Fernando", "Av. Central 30", "fernando@softblue.com.br", "1975-03-31");

-- CADASTRANDO PEDIDOS
INSERT INTO pedidos (data_pedido, hora_pedido, aluno_id) VALUES ("2010-04-12", "11:23:32", 2);
INSERT INTO pedidos (data_pedido, hora_pedido, aluno_id) VALUES ("2010-03-10", "14:36:30", 2);
INSERT INTO pedidos (data_pedido, hora_pedido, aluno_id) VALUES ("2015-08-15", "11:17:45", 3);
INSERT INTO pedidos (data_pedido, hora_pedido, aluno_id) VALUES ("2018-12-15", "14:27:22", 4);
INSERT INTO pedidos (data_pedido, hora_pedido, aluno_id) VALUES ("2020-10-30", "11:18:19", 5);
INSERT INTO pedidos (data_pedido, hora_pedido, aluno_id) VALUES ("2020-09-12", "13:47:35", 6);
INSERT INTO pedidos (data_pedido, hora_pedido, aluno_id) VALUES ("2020-10-30", "18:13:44", 6);

SELECT * FROM pedidos;

INSERT INTO pedido_detalhes (pedido_id, curso_id, valor) VALUES (1,1,270);
INSERT INTO pedido_detalhes (pedido_id, curso_id, valor) VALUES (1,2,270);
INSERT INTO pedido_detalhes (pedido_id, curso_id, valor) VALUES (2,1,270);
INSERT INTO pedido_detalhes (pedido_id, curso_id, valor) VALUES (2,2,330);
INSERT INTO pedido_detalhes (pedido_id, curso_id, valor) VALUES (2,3,170);
INSERT INTO pedido_detalhes (pedido_id, curso_id, valor) VALUES (3,4,270);
INSERT INTO pedido_detalhes (pedido_id, curso_id, valor) VALUES (4,2,330);
INSERT INTO pedido_detalhes (pedido_id, curso_id, valor) VALUES (4,4,270);
INSERT INTO pedido_detalhes (pedido_id, curso_id, valor) VALUES (5,3,170);
INSERT INTO pedido_detalhes (pedido_id, curso_id, valor) VALUES (6,4,170);
INSERT INTO pedido_detalhes (pedido_id, curso_id, valor) VALUES (7,3,270);