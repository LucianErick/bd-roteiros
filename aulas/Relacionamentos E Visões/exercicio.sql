USE db_sistema_curso;

SELECT curso.nome_curso, categoria.tipo FROM cursos curso INNER JOIN tipos categoria ON curso.tipo_curso = categoria.id;
SELECT curso.nome_curso, categoria.tipo, instrutor.nome_instrutor, instrutor.telefone FROM cursos curso INNER JOIN instrutores instrutor ON curso.instrutor_curso = instrutor.id INNER JOIN tipos categoria ON curso.tipo_curso = categoria.id;
SELECT pedido.id, pedido.data_pedido, pedido.hora_pedido, detalhes.curso_id FROM pedidos pedido INNER JOIN pedido_detalhes detalhes ON pedido.id = detalhes.pedido_id;

SELECT pedido.id, pedido.data_pedido, pedido.hora_pedido, aluno.nome_aluno, curso.nome_curso FROM pedidos pedido
INNER JOIN pedido_detalhes detalhes ON pedido.id = detalhes.pedido_id
INNER JOIN cursos curso ON curso.id = detalhes.curso_id
INNER JOIN alunos aluno ON aluno.id = pedido.aluno_id;


CREATE VIEW nome_preco AS SELECT curso.nome_curso, curso.preco_curso FROM cursos curso WHERE curso.tipo_curso = 2;
SELECT * FROM nome_preco;

CREATE VIEW visao_b AS SELECT curso.nome_curso, curso.tipo_curso, instrutor.nome_instrutor FROM cursos curso 
INNER JOIN instrutores instrutor ON instrutor.id = curso.instrutor_curso;
SELECT * FROM visao_b;

SELECT aluno.nome_aluno, pedido.data_pedido, pedido.id FROM pedidos pedido INNER JOIN alunos aluno ON aluno.id = pedido.aluno_id;
