CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE Cliente(
    idCliente int primary key auto_increment, 
    primeiroNome varchar(15) not null, 
    inicialNomeMeio char(1), 
    sobrenome varchar(30) not null, 
    cpf char(11) not null unique, 
    dataNascimento date not null, 
    endereco varchar(100) not null 
);

CREATE TABLE Pedido (
    idPedido int primary key auto_increment, 
    status enum("Pedido Criado", "Em Processamento", "Enviado", "A Caminho", "Entregue") 
    default("Pedido Criado") not null, 
    idCliente int not null, 
    pagamentoBoleto bool not null default(false), 
    descricao varchar(150), 
    frete float not null, 
    constraint fk_pedido_cliente foreign key (idCliente) references Cliente(idCliente) on update cascade
);

CREATE TABLE Produto(
    idProduto int primary key auto_increment, 
    nomeProduto varchar(45) not null, 
    categoria enum("Eletrônico", "Acessórios", "Livros", "Brinquedos", "Jogos") not null, 
    valor decimal(10, 2) not null, 
    avaliacao float check(avaliacao >=0 AND avaliacao <= 5), 
    descricao varchar(45) 
);

CREATE TABLE Estoque(
    idEstoque int primary key auto_increment, 
    localEstoque varchar(45), 
    quantidadeEstoque int not null 
);

CREATE TABLE Fornecedor(
    idFornecedor int primary key auto_increment, 
    razaoSocial varchar(45), 
    cnpj char(15) not null unique, 
    contato char(11) not null 
);

CREATE TABLE Vendedor(
    idVendedor int primary key auto_increment, 
    razaoSocial varchar(45) not null, 
    cnpj char(15) unique, 
    cpf char(11) unique, 
    regiao varchar(45) not null, 
    contato char(11) not null 
);

CREATE TABLE Pagamento(
    idPagamento int primary key auto_increment, 
    idPedido int not null, 
    parcelas int not null default 1, 
    valor float not null, 
    metodoPagamento enum('Cartão', 'Boleto', 'Pix') not null, 
    dataPagamento date not null, 
    confirmado bool not null default false, 
    constraint fk_pagamento_pedido foreign key (idPedido) references Pedido(idPedido) on delete cascade 
);
-- Ajusta o ID de pagamento para iniciar do 1
ALTER TABLE Pagamento AUTO_INCREMENT = 1;

-- Criação da tabela Produto_por_Vendedor (relação entre produtos e vendedores)
CREATE TABLE Produto_por_Vendedor(
    idVendedor int, -- Chave estrangeira referenciando o vendedor
    idProduto int, -- Chave estrangeira referenciando o produto
    quantidade int not null default 1, -- Quantidade de produtos fornecidos pelo vendedor
    primary key(idVendedor, idProduto), 
    CONSTRAINT fk_produto_vendedor_vendedor FOREIGN KEY (idVendedor) REFERENCES Vendedor(idVendedor), 
    CONSTRAINT fk_produto_vendedor_produto FOREIGN KEY (idProduto) REFERENCES Produto(idProduto) 
);

-- Criação da tabela Produto_Fornecedor (relação entre produtos e fornecedores)
CREATE TABLE Produto_Fornecedor(
    idFornecedor int, -- Chave estrangeira referenciando o fornecedor
    idProduto int, -- Chave estrangeira referenciando o produto
    quantidade int not null, -- Quantidade de produtos fornecidos pelo fornecedor
    primary key(idFornecedor, idProduto), 
    constraint fk_produto_fornecedor_fornecedor foreign key (idFornecedor) references Fornecedor(idFornecedor), 
    constraint fk_produto_fornecedor_produto foreign key (idProduto) references Produto(idProduto) 
);

-- Criação da tabela Produto_Pedido (relação entre produtos e pedidos)
CREATE TABLE Produto_Pedido(
    idPedido int, -- Chave estrangeira referenciando o pedido
    idProduto int, -- Chave estrangeira referenciando o produto
    quantidade int not null default 1, -- Quantidade de produtos em um pedido
    primary key(idPedido, idProduto), 
    constraint fk_produto_pedido_pedido foreign key (idPedido) references Pedido(idPedido), 
    constraint fk_produto_pedido_produto foreign key (idProduto) references Produto(idProduto) 
);

-- Criação da tabela Produto_em_Estoque (relação entre produtos e estoque)
CREATE TABLE Produto_em_Estoque(
    idEstoque int, -- Chave estrangeira referenciando o local de estoque
    idProduto int, -- Chave estrangeira referenciando o produto
    localizacao varchar(150) not null, -- Localização detalhada do produto dentro do estoque
    primary key(idEstoque, idProduto), 
    constraint fk_produto_estoque_estoque foreign key (idEstoque) references Estoque(idEstoque), 
    constraint fk_produto_estoque_produto foreign key (idProduto) references Produto(idProduto) 
);

-- Adiciona a coluna quantidade na tabela Produto_em_Estoque
ALTER TABLE Produto_em_Estoque
    ADD COLUMN quantidade int not null default 0; -- Quantidade de produtos em estoque

-- Adiciona a coluna código de rastreamento ao pedido
ALTER TABLE Pedido 
    ADD COLUMN codigoRastreamento VARCHAR(50) AFTER status;

-- Altera o nome do atributo status para statusPedido, para evitar o uso de uma palavra reservada
ALTER TABLE Pedido 
    CHANGE COLUMN status statusPedido ENUM('Pedido Criado', 'Em Processamento', 'Enviado', 'A Caminho', 'Entregue') 
    NOT NULL DEFAULT 'Pedido Criado';

-- Adiciona a coluna tipoCliente para distinguir entre Pessoa Física (PF) e Pessoa Jurídica (PJ)
ALTER TABLE Cliente 
    ADD COLUMN tipoCliente ENUM('PF', 'PJ') NOT NULL AFTER idCliente;

-- Adiciona a coluna CNPJ para clientes PJ
ALTER TABLE Cliente 
    ADD COLUMN cnpj CHAR(15) UNIQUE AFTER cpf;

-- Garante que um cliente seja apenas PF ou PJ
ALTER TABLE Cliente
    ADD CONSTRAINT chk_tipoCliente CHECK (
        (tipoCliente = 'PF' AND cpf IS NOT NULL AND cnpj IS NULL) OR
        (tipoCliente = 'PJ' AND cnpj IS NOT NULL AND cpf IS NULL)
    );

-- Permite que o CPF seja nulo para clientes PJ
ALTER TABLE Cliente
    MODIFY COLUMN cpf CHAR(11) NULL;

-- Adiciona a coluna valorTotalPedido para armazenar o valor total de cada pedido
ALTER TABLE Pedido
ADD COLUMN valorTotalPedido DECIMAL(10, 2) NOT NULL DEFAULT 0;

-- Atualiza o valor total de cada pedido com base nos pagamentos associados
UPDATE Pedido p
JOIN (
    SELECT idPedido, SUM(valor) AS valorTotalPedido
    FROM Pagamento
    GROUP BY idPedido
) AS pg
ON p.idPedido = pg.idPedido
SET p.valorTotalPedido = pg.valorTotalPedido
WHERE p.idPedido = pg.idPedido;

-- Criação de uma trigger para controlar o avanço do status de um pedido
-- Esta trigger impede que o status de um pedido avance para "Em Processamento" ou adiante
-- caso não haja um pagamento confirmado associado ao pedido
DELIMITER //

CREATE TRIGGER before_update_pedido_status
BEFORE UPDATE ON Pedido
FOR EACH ROW
BEGIN
    DECLARE pagamento_confirmado BOOLEAN;

    -- Verifica se o pedido está tentando avançar para "Em Processamento" ou além
    IF NEW.statusPedido IN ('Em Processamento', 'Enviado', 'A Caminho', 'Entregue') THEN

        -- Verifica se existe algum pagamento confirmado para o pedido
        SELECT COUNT(*)
        INTO pagamento_confirmado
        FROM Pagamento
        WHERE idPedido = NEW.idPedido AND confirmado = true;

        -- Se não houver pagamento confirmado, impede a atualização do status
        IF pagamento_confirmado = 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Não é possível avançar o status do pedido sem um pagamento confirmado.';
        END IF;

    END IF;
END//

DELIMITER ;
