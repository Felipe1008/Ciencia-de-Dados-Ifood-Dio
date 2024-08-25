use ecommerce;

INSERT INTO Cliente (primeiroNome, inicialNomeMeio, sobrenome, cpf, dataNascimento, endereco)
VALUES
    ('Frodo', 'B', 'Bolseiro', '12345678901', '2980-09-22', 'Bolseiro, 1, Hobbiton, Condado'),
    ('Aragorn', 'E', 'Pardal', '10987654321', '2950-03-20', 'Caminho do Norte, 10, Minas Tirith'),
    ('Legolas', 'T', 'Verde', '11223344556', '2960-05-15', 'Floresta de Lothlórien, Galadriel');
    
-- Insere valores na tabela Produto
INSERT INTO Produto (nomeProduto, categoria, valor, avaliacao, descricao)
VALUES
    -- Acessórios
    ('Anel de Sauron', 'Acessórios', 999.99, 4.9, 'O poderoso Anel Único, com inscrições antigas. Tem o poder de controlar os outros anéis.'),
    ('Colete de Mithril', 'Acessórios', 750.00, 4.8, 'Colete feito de Mithril, conhecido por sua leveza e resistência. Usado por Frodo em sua jornada.'),
    -- Eletrônico
    ('Palantír', 'Eletrônico', 499.99, 4.7, 'Dispositivo de comunicação mágico que permite visualizar eventos distantes. Usado por Sauron e Saruman.'),
    -- Brinquedo
    ('Cavalo de Rohan', 'Brinquedos', 60.00, 4.5, 'Modelo detalhado de um cavalo de Rohan, frequentemente montado pelos cavaleiros de Rohan.'),
    -- Livro
    ('O Livro Vermelho dos Contos do Condado', 'Livros', 34.99, 4.8, 'Livro fictício mencionado em "O Senhor dos Anéis", escrito por Bilbo e Frodo Bolseiro. Contém histórias e poemas do Condado.');
    
-- Insere valores na tabela Vendedor
INSERT INTO Vendedor (razaoSocial, cnpj, regiao, contato)
VALUES
    ('Balin Minérios', '12345678000199', 'Moria', '555-1234'),
    ('Beregond Segurança', '23456789000188', 'Gondor', '555-5678'),
    ('Carrapicho', '34567890000177', 'Bri', '555-9012');
    
-- Insere valores na tabela Fornecedor
INSERT INTO Fornecedor (razaoSocial, cnpj, contato)
VALUES
    ('Gondor Forjados', '45678901000166', '555-3456'),
    ('Eldar Distribuições', '56789012000155', '555-7890'),
    ('Rohan Tecnologias', '67890123000144', '555-2345');
    
INSERT INTO Pedido (status, idCliente, pagamentoBoleto, descricao, frete)
VALUES
    ('Pedido Criado', 1, true, 'Pedido de anéis mágicos e espadas', 10.00),
    ('Em Processamento', 2, false, 'Compra de livros', 5.75),
    ('Enviado', 3, false, 'Equipamento de segurança e acessórios', 7.20),
    ('A Caminho', 1, true, 'Colete de mithril e poções', 12.00),
    ('Entregue', 3, false, 'Gadgets eletrônicos', 7.20);

INSERT INTO Produto_Pedido (idPedido, idProduto, quantidade)
VALUES
    (1, 1, 1),
    (2, 5, 2),
    (3, 2, 3),
    (4, 2, 1),
    (5, 3, 1);

-- Insere valores na tabela Estoque
INSERT INTO Estoque (localEstoque, quantidadeEstoque)
VALUES
    ('Armazém Central', 150),
    ('Depósito Sul', 80),
    ('Armazém Norte', 200),
    ('Centro de Distribuição Oeste', 120),
    ('Armazém Leste', 90);
    
-- Insere valores na tabela Produto_em_Estoque
INSERT INTO Produto_em_Estoque (idEstoque, idProduto, localizacao, quantidade)
VALUES
    (1, 1, 'Prateleira 1 - Seção A', 30), -- 30 unidades do Anel Único no Armazém Central
    (1, 2, 'Prateleira 2 - Seção B', 20), -- 20 unidades do Colete de Mithril no Armazém Central
    (2, 3, 'Prateleira 3 - Seção C', 50), -- 50 unidades do Palantír Mágico no Depósito Sul
    (3, 4, 'Prateleira 4 - Seção D', 15), -- 15 unidades do Cavalo de Rohan no Armazém Norte
    (4, 5, 'Prateleira 5 - Seção E', 25); -- 25 unidades do Livro 'O Senhor dos Anéis' no Centro de Distribuição Oeste

-- Trigger para calcular o valor total do pedido
DELIMITER //

CREATE TRIGGER after_insert_produto_pedido
AFTER INSERT ON Produto_Pedido
FOR EACH ROW
BEGIN
    DECLARE valor_total DECIMAL(10, 2);

    -- Calcula o valor total dos produtos associados ao pedido
    SELECT COALESCE(SUM(p.valor * pp.quantidade), 0)
    INTO valor_total
    FROM Produto_Pedido pp
    JOIN Produto p ON pp.idProduto = p.idProduto
    WHERE pp.idPedido = NEW.idPedido;

    -- Atualiza o valor total do pedido, incluindo o frete
    UPDATE Pedido
    SET valorTotalPedido = valor_total + frete
    WHERE idPedido = NEW.idPedido;
END//

DELIMITER ;

alter table Pagamento auto_increment = 1;
INSERT INTO Pagamento (idPedido, parcelas, valor, metodoPagamento, dataPagamento, confirmado)
VALUES
    (1, 1, 1009.99, 'Boleto', '3002-05-07', false), 
	(2, 1, 75.73,'Boleto', '3020-07-20', true),
    (3, 1, 2257.2,'Pix', '2997-01-11', true),
    (4, 2, 762.00,'Cartão', '2997-12-01', true),
    (5, 1, 507.19,'Boleto', '2990-08-25', true);
    
INSERT INTO Pagamento (idPedido, parcelas, valor, metodoPagamento, dataPagamento, confirmado) 
VALUES (6, 5, 1000.00, 'Cartão', "3002-12-20", true);
INSERT INTO Pagamento (idPedido, parcelas, valor, metodoPagamento, dataPagamento, confirmado) 
VALUES (6, 1, 14.98, 'Pix', "3002-12-20", true);

INSERT INTO Produto_Fornecedor (idFornecedor, idProduto, quantidade)
VALUES
    (1, 1, 50),  -- Gondor Forjados fornece 50 unidades do Anel Único
    (1, 2, 30),  -- Gondor Forjados fornece 30 unidades do Colete de Mithril
    (2, 3, 70),  -- Eldar Distribuições fornece 70 unidades do Palantír
    (3, 4, 20),  -- Rohan Tecnologias fornece 20 unidades do Cavalo de Rohan
    (3, 5, 10);  -- Rohan Tecnologias fornece 10 unidades do Livro 'O Senhor dos Anéis'
    
INSERT INTO Produto_por_Vendedor (idVendedor, idProduto, quantidade)
VALUES
    (1, 1, 25),  -- Balin Minérios tem 25 unidades do Anel Único
    (1, 2, 15),  -- Balin Minérios tem 15 unidades do Colete de Mithril
    (2, 3, 40),  -- Beregond Segurança tem 40 unidades do Palantír
    (2, 4, 10),  -- Beregond Segurança tem 10 unidades do Cavalo de Rohan
    (3, 5, 20);  -- Carrapicho tem 20 unidades do Livro 'O Senhor dos Anéis'
  
INSERT INTO Cliente (tipoCliente, primeiroNome, inicialNomeMeio, sobrenome, cnpj, dataNascimento, endereco)
VALUES ("PJ", "Mithrandir", "C", "Gandalf", "215786524563257", "2217-11-04", "Ainulindalë");

INSERT INTO Pedido (idCliente, descricao, frete, statusPedido, codigoRastreamento) 
VALUES (4, "Compra de Palantír", 15.00, "Enviado", "R123456789BR");

INSERT INTO Produto_Pedido (idPedido, idProduto, quantidade) 
VALUES (LAST_INSERT_ID(), 3, 2);

INSERT INTO Pedido (idCliente, descricao, frete, statusPedido) 
VALUES (2, "Colete de Mithril", 7.00, "Pedido Criado");
INSERT INTO Produto_Pedido (idPedido, idProduto, quantidade) 
VALUES (LAST_INSERT_ID(), 2, 1);

INSERT INTO Pagamento (idPedido, parcelas, valor, metodoPagamento, dataPagamento) 
VALUES (7, 2, 700.00, 'Cartão', "3003-01-15");

