# Descrição do Projeto: Sistema de Gerenciamento de Oficina Mecânica
## Visão Geral:

- Este projeto consiste no desenvolvimento de um sistema de gerenciamento de uma oficina mecânica. O objetivo principal é fornecer uma solução robusta e flexível para gerenciar operações diárias da oficina, incluindo o controle de clientes, veículos, ordens de serviço, mecânicos, peças, fornecedores e pagamentos. O modelo de banco de dados foi desenvolvido para refletir de maneira precisa a realidade operacional de uma oficina, possibilitando o armazenamento, recuperação e análise de informações essenciais para a gestão eficiente dos serviços oferecidos.

## Principais Entidades e Relacionamentos:

- Cliente: Armazena informações dos clientes da oficina, incluindo dados pessoais como nome, CPF, CNPJ (para clientes PJ), data de nascimento e informações de contato.

- Veículo: Registra detalhes dos veículos pertencentes aos clientes, como placa, modelo, ano, e uma referência ao proprietário (cliente). Esse relacionamento é crucial para vincular os serviços realizados a veículos específicos.

- Ordem de Serviço: Representa o coração do sistema, registrando todas as ordens de serviço geradas pela oficina. Cada ordem de serviço pode estar associada a um ou mais serviços específicos (como troca de óleo, balanceamento, etc.), um cliente e seu respectivo veículo. Também inclui informações sobre o valor total da ordem e o status do serviço.

- Serviço: Define os diferentes tipos de serviços que a oficina oferece. Através de uma tabela associativa (Servicos_por_Ordem), cada ordem de serviço pode estar associada a múltiplos serviços, refletindo a realidade de que mais de um tipo de serviço pode ser realizado em um único atendimento.

- Mecânico: Registra os mecânicos que trabalham na oficina, incluindo informações pessoais e profissionais, como telefone e salário. Uma tabela associativa (Mecanicos_no_Servico) permite associar múltiplos mecânicos a diferentes ordens de serviço, garantindo o controle sobre quem realizou quais serviços.

- Produto: Detalha os produtos utilizados nos serviços, armazenando informações como descrição, valor e quantidade disponível em estoque. Uma tabela associativa (Produtos_por_Servico) rastreia quais produtos foram usados em cada serviço, além de associar fornecedores aos produtos.

- Fornecedor: Contém informações sobre os fornecedores dos produtos, incluindo nome, CNPJ e dados de contato. Relaciona-se com a tabela de produtos através de uma tabela associativa (Produto_por_Fornecedor), possibilitando o rastreamento de origem dos produtos.

- Estoque:
-- Gerencia o inventário de produtos disponíveis na oficina. Cada registro de produto inclui a quantidade em estoque, permitindo um controle rigoroso dos materiais disponíveis para o uso nos serviços.

- Pagamento: Registra os pagamentos realizados pelos clientes. Cada pagamento é associado a uma ordem de serviço e inclui detalhes como método de pagamento e o valor pago.

## Funcionalidades do Sistema:

- Gerenciamento de Clientes e Veículos: Permite cadastrar, consultar e manter os dados dos clientes e seus veículos, facilitando o acesso rápido às informações necessárias durante o atendimento.

- Controle de Ordens de Serviço: Oferece uma forma estruturada de registrar, rastrear e gerenciar ordens de serviço, desde a criação até a finalização, com detalhes sobre os serviços realizados, produtos usados e mecânicos envolvidos.

- Gestão de Mecânicos: Proporciona um controle sobre os mecânicos da oficina, possibilitando a alocação de profissionais a diferentes ordens de serviço de acordo com suas especializações.

- Controle de Estoque e Produtos: Mantém um controle preciso dos produtos disponíveis em estoque e suas utilizações em serviços, garantindo que a oficina esteja sempre abastecida com os materiais necessários para operar.

- Gestão de Fornecedores: Facilita o gerenciamento dos fornecedores dos produtos, permitindo rastrear de onde cada produto foi adquirido e manter um relacionamento eficiente com os parceiros de fornecimento.

- Processamento de Pagamentos: Registra pagamentos realizados pelos clientes, com suporte para múltiplos métodos de pagamento, e associa esses pagamentos às ordens de serviço correspondentes.

