use restaurante;

drop view BuscaIngredientesProduto;

CREATE VIEW resumo_pedido AS
SELECT pe.id_pedido, c.nome AS nome_cliente, c.email, f.nome AS funcionários, pr.nome AS produto_nome, pr.preço,pe.quantidade, round(sum(pe.quantidade * pr.preço),2) AS total_gasto
FROM pedidos pe
JOIN clientes c ON pe.id_pedido = c.id_cliente
JOIN produtos pr ON pr.id_produto = pe.id_pedido
JOIN funcionários f ON f.id_funcionario = pe.id_pedido
GROUP BY pe.id_pedido, pe.quantidade, nome_cliente, c.email,funcionários,produto_nome, pr.preço
ORDER BY pe.id_cliente, nome_cliente ASC;

select * from resumo_pedido;


SELECT pe.id_pedido, c.nome , round(sum(pe.quantidade * pr.preço),2) AS total_gasto
FROM clientes c
JOIN pedidos pe ON c.id_cliente = pe.id_pedido
JOIN produtos pr ON pr.id_produto = pe.id_pedido
GROUP BY id_pedido, c.nome
ORDER BY pe.id_pedido,c.nome ASC;



EXPLAIN
SELECT pe.id_pedido, c.nome , round(sum(pe.quantidade * pr.preço),2) AS total_gasto
FROM clientes c
JOIN pedidos pe ON c.id_cliente = pe.id_pedido
JOIN produtos pr ON pr.id_produto = pe.id_pedido
GROUP BY id_pedido, c.nome
ORDER BY pe.id_pedido,c.nome ASC;


DELIMITER $$
CREATE FUNCTION BuscaIngredientesProduto(IdProduto INT)
RETURNS VARCHAR (200)
READS SQL DATA
BEGIN 
DECLARE nomeProduto VARCHAR (200);
SELECT nome INTO nomeProduto FROM produtos WHERE id_produto = IdProduto;
RETURN nomeProduto; 
END $$
DELIMITER ;

drop function BuscaIngredientesProduto;

SELECT BuscaIngredientesProduto (10);




SELECT avg(quantidade) 
from pedidos;


DELIMITER $$
CREATE FUNCTION mediaPedido (IdPedido INT)
RETURNS VARCHAR (200)
READS SQL DATA 
BEGIN
DECLARE TotalPedidos DECIMAL (10,2);
DECLARE media VARCHAR (100);

SELECT COALESCE (avg(quantidade),0) INTO TotalPedidos
FROM pedidos
WHERE id_pedido = IdPedido;

SET media = 
CASE 
WHEN TotalPedidos <= 2.399 THEN 'Abaixo da Média'
WHEN TotalPedidos = 2.400 THEN 'Igual a média'
ELSE 'Acima da média' 
END;
RETURN media;
END $$
DELIMITER ;

SELECT mediaPedido (5);

SELECT mediaPedido(6);




















 

