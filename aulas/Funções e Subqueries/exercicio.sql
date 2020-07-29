USE db_sistema_curso;

-- 1 a)
SELECT DISTINCT(nome_aluno) FROM pedidos
INNER JOIN alunos ON pedidos.aluno_id = alunos.id;

-- 1 b)
SELECT DISTINCT(nome_aluno), data_pedido FROM pedidos
INNER JOIN alunos ON pedidos.aluno_id = alunos.id
ORDER BY data_pedido ASC LIMIT 1;

-- 1 c)
SELECT DISTINCT(nome_aluno), data_pedido FROM pedidos
INNER JOIN alunos ON pedidos.aluno_id = alunos.id
ORDER BY data_pedido DESC LIMIT 1;

-- 1 d) 
SELECT DISTINCT(nome_aluno), data_pedido FROM pedidos
INNER JOIN alunos ON pedidos.aluno_id = alunos.id
ORDER BY data_pedido DESC LIMIT 1 OFFSET 2;

-- 1 e)
SELECT COUNT(*) FROM pedido_detalhes;

-- 1 f)
SELECT SUM(valor) FROM pedido_detalhes;

-- 1 g)

SELECT * FROM pedido_detalhes;
SELECT count(valor) FROM pedido_detalhes WHERE pedido_id = 2;

-- 1 h)

SELECT * FROM cursos;
SELECT MAX(preco_curso) FROM cursos;

-- 1 i)
SELECT MIN(preco_curso) FROM cursos;

-- 1 j)
SELECT pedido_id, SUM(valor) FROM pedido_detalhes GROUP BY pedido_id;

-- 1 k)
SELECT * FROM cursos;
SELECT * FROM instrutores;
SELECT instrutor.nome_instrutor, COUNT(*) FROM cursos curso INNER JOIN instrutores instrutor ON curso.instrutor_curso = instrutor.id GROUP BY instrutor.id; 

-- 1 l)
SELECT * FROM pedido_detalhes;

SELECT detalhes.pedido_id, aluno.nome_aluno, SUM(detalhes.valor) FROM pedido_detalhes detalhes 
INNER JOIN pedidos pedido ON detalhes.pedido_id = pedido.id 
INNER JOIN alunos aluno ON pedido.aluno_id = aluno.id
GROUP BY detalhes.pedido_id
HAVING SUM(detalhes.valor) > 500;

-- 1 m)
SELECT detalhes.pedido_id, aluno.nome_aluno, COUNT(*) FROM pedido_detalhes detalhes
INNER JOIN pedidos pedido ON detalhes.pedido_id = pedido.id
INNER JOIN alunos aluno ON pedido.aluno_id = aluno.id
GROUP BY detalhes.pedido_id
HAVING COUNT(*) >= 2;

-- 1 n)
SELECT nome_aluno, endereco_aluno FROM alunos WHERE endereco_aluno LIKE 'Av%';

-- 1 o)
SELECT nome_curso FROM cursos WHERE nome_curso LIKE 'Java%';