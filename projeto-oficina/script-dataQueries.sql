use oficina;

-- Consultando todos clientes da oficina
SELECT idCliente, CONCAT(primeiroNome, ' ', sobrenome) as nome, tipoCliente, contato, cep FROM Cliente;

-- Consultando todas ordens serviços em andamento
SELECT * FROM ordemservico WHERE statusServico = "Em Andamento";

-- Consultando Cliente e seu respectivo veiculo associado à esta ordem de serviço 
SELECT
	c.idCliente,
    CONCAT(primeiroNome, ' ', sobrenome) as nomeCliente,
    v.marca as marcaVeiculo,
    os.valorTotalServico
FROM
	ordemServico os INNER JOIN Cliente c ON
    os.idCliente = c.idCliente INNER JOIN Veiculo v ON
    v.idCliente = c.idCliente
WHERE
	os.statusServico = "Em Andamento";
    
-- Consultando todos produtos adquiridos dos fornecedores e seus respectivos custos de compra]
SELECT 
	f.nome,
    pf.quantidade,
    p.nomeProduto,
    p.custoCompraProduto
FROM
	Fornecedor f INNER JOIN produto_por_fornecedor pf ON
    f.idFornecedor = pf.idFornecedor INNER JOIN Produto p ON
    pf.idProduto = p.idProduto;
    
-- Calculando margem de lucro para cada produto
SELECT
	nomeProduto,
	ROUND(((valorVendaProduto - custoCompraProduto)/custoCompraProduto)*100, 2) as MargemLucro
FROM 
	produto
	
    