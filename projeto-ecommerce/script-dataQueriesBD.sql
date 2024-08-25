use ecommerce;

-- Visão inicial dos produtos disponíveis
SELECT * 
FROM Produto;

-- Quantos pedidos foram feitos por cada cliente?
SELECT CONCAT(c.primeiroNome, " ", c.sobrenome) AS nomeCliente, COUNT(p.idPedido) AS totalPedidos
FROM Cliente c
INNER JOIN Pedido p ON c.idCliente = p.idCliente
GROUP BY c.idCliente
ORDER BY nomeCliente;

-- Algum vendedor também é fornecedor?
SELECT v.razaoSocial
FROM Vendedor v
INNER JOIN Fornecedor f ON v.cnpj = f.cnpj;

-- Relação de produtos, fornecedores e estoques
SELECT p.nomeProduto, f.razaoSocial AS fornecedor, e.localEstoque, pe.quantidade
FROM Produto p
INNER JOIN Produto_Fornecedor pf ON p.idProduto = pf.idProduto
INNER JOIN Fornecedor f ON pf.idFornecedor = f.idFornecedor
INNER JOIN Produto_em_Estoque pe ON p.idProduto = pe.idProduto
INNER JOIN Estoque e ON pe.idEstoque = e.idEstoque;

-- Relação de nomes dos fornecedores e nomes dos produtos
SELECT f.razaoSocial AS fornecedor, p.nomeProduto
FROM Produto p
INNER JOIN Produto_Fornecedor pf ON p.idProduto = pf.idProduto
INNER JOIN Fornecedor f ON pf.idFornecedor = f.idFornecedor;

-- Visão geral de pedidos e pagamentos
SELECT p.idPedido,nomeProduto, statusPedido, pr.valor AS valorProduto, 
quantidade AS qtdadePedida, frete, valorTotalPedido, pa.valor AS valorPago , pa.confirmado AS pagamentoConfirmado
FROM Pedido p 
INNER JOIN Produto_Pedido pp ON p.idPedido = pp.idPedido 
INNER JOIN Produto pr ON pp.idProduto = pr.idProduto 
INNER JOIN Pagamento pa ON pa.idPedido = p.idPedido;

-- Todos clientes que possuam a letra "A" no seu primeiro nome
SELECT tipoCliente, CONCAT(primeiroNome, " ", inicialNomeMeio, ".", " ", sobrenome) AS nomeCliente,
cpf, cnpj, endereco
FROM Cliente
WHERE primeiroNome LIKE "%a%";
 
 -- Mostrando todos clientes que fizeram mais do que 1 pedido
SELECT CONCAT(c.primeiroNome, " ", c.sobrenome) AS nomeCliente, COUNT(p.idPedido) AS totalPedidos
FROM Cliente c
INNER JOIN Pedido p ON c.idCliente = p.idCliente
GROUP BY c.idCliente
HAVING COUNT(p.idPedido) > 1
ORDER BY nomeCliente;