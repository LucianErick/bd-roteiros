USE db_sistema_curso;

SELECT * FROM alunos; -- todas as informações de todos os alunos
SELECT nome_curso FROM cursos; -- todos os nomes de cursos
SELECT nome_curso, preco_curso FROM cursos WHERE preco_curso > 200 AND preco_curso < 300; -- Nome e preço dos cursos que tem preço entre 200 e 300 reais.
SELECT * FROM pedidos WHERE data_pedido >= "2015-04-15" and data_pedido <= "2020-10-21";

INSERT INTO pedidos (data_pedido, hora_pedido, aluno_id) VALUES ("2020-09-12", "19:57:35", 4);
SELECT * FROM pedidos WHERE data_pedido = "2020-09-12";