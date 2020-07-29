USE db_sistema_curso;

UPDATE alunos SET endereco_aluno = "Av. Brasil 778" WHERE nome_aluno = "José";
UPDATE alunos SET email_aluno = "cristiano@softblue.com.br" WHERE nome_aluno = "Cris";

SET SQL_SAFE_UPDATES = 0;
UPDATE cursos SET preco_curso = preco_curso * 1.1 WHERE preco_curso < 300;
UPDATE pedido_detalhes SET valor = valor * 1.1 WHERE valor < 300;
UPDATE pedido_detalhes SET valor = round(valor, 2) WHERE valor < 300;
SELECT preco_curso FROM cursos;
SELECT valor FROM pedido_detalhes;

UPDATE cursos SET nome_curso = "PHP Fundamentos" WHERE nome_curso = "PHP Básico";

UPDATE cursos SET preco_curso = round(preco_curso, 2) WHERE preco_curso < 300;
SELECT * from cursos;
SELECT * FROM alunos;

SELECT *, id FROM tipos;