USE db_sistema_curso;

SELECT nome_curso, preco_curso FROM cursos;
SELECT * FROM cursos;

INSERT INTO cursos(nome_curso, tipo_curso, instrutor_curso) VALUES ("Web Moderno", 1, 4);
INSERT INTO cursos(nome_curso, tipo_curso, instrutor_curso) VALUES ("Programação em Bancos de dados", 2, 3);
INSERT INTO cursos(nome_curso, tipo_curso, instrutor_curso) VALUES ("Análise de Dados", 1, 2);
INSERT INTO cursos(nome_curso, tipo_curso, instrutor_curso) VALUES ("Ciência de Dados", 1, 2);
UPDATE cursos SET preco_curso = 165 WHERE id = 5;
UPDATE cursos SET preco_curso = 185 WHERE id = 6;
UPDATE cursos SET preco_curso = 140 WHERE id = 7;
UPDATE cursos SET preco_curso = 100 WHERE id = 3;
-- 2 a) 
SELECT curso.nome_curso, 
(
SELECT MIN(valor) FROM pedido_detalhes detalhes
WHERE detalhes.curso_id = curso.id
)
AS menor_valor
FROM cursos curso;

SELECT * FROM cursos;
SELECT * FROM tipos;

-- 2 b)
SELECT nome_curso FROM cursos
WHERE tipo_curso
IN
(
SELECT id FROM tipos WHERE tipos.tipo = "Programação"
);

-- 2 c)
SELECT nome_curso FROM cursos
WHERE EXISTS
(
SELECT id FROM tipos WHERE tipos.id = cursos.tipo_curso AND tipos.tipo = "Programação"
);

-- 2 d)
SELECT nome_instrutor, 
(SELECT SUM(detalhes.valor) FROM pedido_detalhes detalhes 
INNER JOIN cursos curso 
ON detalhes.curso_id = curso.id 
WHERE curso.instrutor_curso = instrutor.id) 
AS total_de_vendas 
FROM instrutores instrutor;

-- 2 e)
CREATE VIEW alunos_e_compras AS SELECT nome_aluno,
(SELECT SUM(detalhes.valor) FROM pedido_detalhes detalhes 
INNER JOIN pedidos pedido ON detalhes.pedido_id = pedido.id 
WHERE pedido.aluno_id = aluno.id) 
AS total_de_comopras FROM alunos aluno; 

SELECT * FROM alunos_e_compras;

SELECT * FROM pedido_detalhes INNER JOIN pedidos ON pedido_detalhes.pedido_id = pedidos.id INNER JOIN alunos;