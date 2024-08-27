use oficina;

INSERT INTO Cliente(primeiroNome, sobrenome, cpf, cnpj, tipoCliente, dataNascimento, contato, cep, estado)
VALUES("Ademir", "Da Guia", "50782894230", NULL, "PF", "1942-04-03", "1198765506", "17512886", "RJ"),
	("Luís", "Pereira", "71292517221", NULL, "PF", "1949-06-21", "1199642212", "12809007", "SP"),
    ("Marcos", "Reis", NULL, "412908505755427", "PJ", "1973-08-04", "11904274837", "15416878", "SP"),
    ("Jorge", "Valdivia", "40682426310", NULL, "PF", "1983-10-19", "11994253502", "10312095", "SP");

INSERT INTO Veiculo(idCliente, placa, modelo, ano, marca)
VALUES (1, "JKI4525", "SUV", "2020", "Volkswagen"),
(2, "ELM4J19", "Sedan", "2024", "Audi"),
(3, "BRA7L20", "Hatch", "2012", "Chevrolet"),
(4, "CHI8L10", "Sedan", "2023", "Aston Martin");

INSERT INTO Fornecedor(cnpj, nome, contato)
VALUES("714079614527632", "Alex Autopecas", "997656487"),
("520778523445782", "Djalma Automotivos", "957247484");

INSERT INTO Estoque(quantidadeProduto)
VALUES(5),
(100),
(20),
(12);

INSERT INTO Produto(idEstoque, nomeProduto, tipoProduto, valorVendaProduto, custoCompraProduto)
VALUES(1, "Pneu Misto Michelin", "Pneu", 800.00, 650.50),
(2, "Aditivo Radiador Paraflu", "Aditivo", 26.99, 20.50),
(3, "Lampada OSRAM H4", "Lampada", 145.60, 115.20),
(4, "Spray Pintura", "Diversos", 32.50, 28.50);

INSERT INTO Produto_por_Fornecedor(idProduto, idFornecedor, quantidade)
VALUES(1, 1, 5),
(2, 2, 100),
(3, 2, 20),
(4, 2, 12);

INSERT INTO Servico(tipoServico, valorServico)
VALUES('Pintura', 1500.00),
('Balanceamento', 100.00),
('Alinhamento', 120.00),
('Reparo Mecanico', 2000.00),
('Troca de Oleo', 150.00);

INSERT INTO OrdemServico(idCliente, statusServico, valorTotalServico)
VALUES
(1, "Na Fila", 1665.00),
(2, "Em Andamento", 900.00),
(3, "Concluido", 120.00),
(4, "Cancelado", 0.00),
(2, "Concluido", 150.00);

INSERT INTO Servico_por_OrdemServico(idOrdemServico, idServico, quantidade)
VALUES (1, 1, 1),
(1, 2, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 0),
(5, 5, 1);

INSERT INTO Mecanico(nome, cpf, telefone, salario)
VALUES
('Danilo dos Santos', '98765432100', '11987654321', 3500.00),
('Edmundo', '12345678900', '11976543210', 4000.00),
('Evair', '11223344556', '11985476543', 4200.00);

INSERT INTO Mecanico_por_OrdemServico(idMecanico, idOrdemServico, quantidade)
VALUES
(1, 2, 1),
(2, 1, 1),
(3, 3, 1),
(1, 5, 1);

INSERT INTO Produto_por_OrdemServico(idProduto, idOrdemServico, quantidade)
VALUES
(4, 1, 2),
(1, 2, 1),
(2, 5, 1);

INSERT INTO Pagamento(idOrdemServico, metodoPagamento, parcelas, dataPagamento, statusPagamento)
VALUES
(1, 'Cartao Credito', 3, NULL, 'Aguardando'),
(2, 'PIX', 1, '2024-08-16', 'Confirmado'),
(3, 'Dinheiro', 1, '2024-08-17', 'Confirmado'),
(5, 'Cartao Debito', 1, '2024-08-27', 'Confirmado');

