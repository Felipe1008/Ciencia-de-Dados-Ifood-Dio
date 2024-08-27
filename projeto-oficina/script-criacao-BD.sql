CREATE DATABASE oficina;
use oficina;

CREATE TABLE Cliente(
	idCliente int primary key auto_increment,
    primeiroNome varchar(45) not null,
    sobrenome varchar(45) not null,
    cpf char(11) unique,
    cnpj char(15) unique,
    tipoCliente ENUM("PF", "PJ"),
    dataNascimento date,
    contato varchar(45) not null,
    endereco varchar(100),
    
	CONSTRAINT check_tipoCliente CHECK(
		(tipoCliente = "PF" AND cpf is not null AND cnpj is null) OR
        (tipoCliente = "PJ" AND cpf is null AND cnpj is not null)
    )
    
);

CREATE TABLE Veiculo(
	idVeiculo int primary key auto_increment,
    idCliente int,
    placa char(7) not null, -- considerando padrão Mercosul
    modelo varchar(50) not null,
    ano year not null,
    
    CONSTRAINT fk_veiculo_cliente FOREIGN KEY(idCliente) REFERENCES Cliente(idCliente)
);

CREATE TABLE Fornecedor(
	idFornecedor int primary key auto_increment,
	cnpj char(15) not null unique,
    nome varchar(45) not null,
    contato varchar(45) not null
);

CREATE TABLE Estoque(
	idEstoque int primary key auto_increment,
    quantidadeProduto int not null default 0
);

CREATE TABLE Produto(
	idProduto int primary key auto_increment,
    idEstoque int,
    nomeProduto varchar(50) not null,
    tipoProduto ENUM("Pneu", "Farol", "Lampada", "Bobina Ignicao", "Bico Injetor", "Aditivo", "Lubrificante") not null,
    valorVendaProduto float,
    custoCompraProduto float,
    
    CONSTRAINT fk_produto_estoque FOREIGN KEY(idEstoque) REFERENCES Estoque(idEstoque)
);

CREATE TABLE Produto_por_Fornecedor(
	idProduto int,
    idFornecedor int,
    quantidade int not null,
    primary key(idProduto, idFornecedor),
    constraint fk_produto_fornecedor_produto foreign key(idProduto) references Produto(idProduto),
    constraint fk_produto_fornecedor_fornecedor foreign key(idFornecedor) references Fornecedor(idFornecedor)
);

CREATE TABLE Servico(
	idServico int primary key auto_increment,
    tipoServico ENUM('Pintura', 'Balanceamento', 'Alinhamento', 'Reparo Mecanico', 'Troca de Oleo') NOT NULL,
	valorServico float not null
);

CREATE TABLE OrdemServico(
	idOrdemServico int primary key auto_increment,
    idCliente int,
    statusServico ENUM("Na Fila", "Em Andamento", "Concluido", "Cancelado") not null,
    valorTotalServico float not null,
    constraint fk_ordemServico_cliente foreign key(idCliente) references Cliente(idCliente)
);

CREATE TABLE Servico_por_OrdemServico(
	idOrdemServico int,
    idServico int,
    quantidade int not null default 1,
    primary key(idOrdemServico, idServico),
    constraint fk_servico_ordemServico_ordemServico foreign key(idOrdemServico) references OrdemServico(idOrdemServico),
    constraint fk_servico_ordemServico_Servico foreign key(idServico) references Servico(idServico)
);

CREATE TABLE Mecanico(
	idMecanico int primary key auto_increment,
    nome varchar(45) not null,
    cpf char(11) not null unique,
    telefone varchar(45) not null,
    salario float not null
);

CREATE TABLE Mecanico_por_OrdemServico(
	idMecanico int,
    idOrdemServico int,
    quantidade int not null default 1,
    primary key(idMecanico, idOrdemServico),
    constraint fk_mecanico_ordemServico_ordemServico foreign key(idOrdemServico) references OrdemServico(idOrdemServico),
    constraint fk_mecanico_ordemServico_Mecanico foreign key(idMecanico) references Mecanico(idMecanico)
);

CREATE TABLE Produto_por_OrdemServico(
	idProduto int,
    idOrdemServico int,
    quantidade int not null default 1,
    primary key(idProduto, idOrdemServico),
	constraint fk_produto_ordemServico_ordemServico foreign key(idOrdemServico) references OrdemServico(idOrdemServico),
	constraint fk_produto_ordemServico_produto foreign key(idProduto) references Produto(idProduto)
);

CREATE TABLE Pagamento(
	idPagamento int primary key auto_increment,
    idOrdemServico int,
    metodoPagamento ENUM("Cartao Credito", "Cartao Debito", "PIX", "Dinheiro") not null,
    parcelas int not null default 1,
    dataPagamento date,
    statusPagamento ENUM("Confirmado", "Aguardando") not null,
    
    constraint fk_pagamento_ordemServico foreign key(idOrdemServico) references OrdemServico(idOrdemServico),
    constraint check_statusPagamento check(
		(statusPagamento = "Confirmado" AND dataPagamento is not null) OR
        (statusPagamento = "Aguardando" AND dataPagamento is null)
	)
    
);