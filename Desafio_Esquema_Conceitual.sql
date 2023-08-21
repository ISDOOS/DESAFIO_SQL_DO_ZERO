-- Esquema Conceitual para uma Oficina de Reparação de Veículos

-- Tabela de Clientes
CREATE TABLE clientes (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    endereco VARCHAR(255),
    telefone VARCHAR(15),
    dataCadastro DATE,
    email VARCHAR(100) UNIQUE
);

-- Tabela de Veículos
CREATE TABLE veiculos (
    idVeiculo INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    anoFabricacao YEAR,
    placa VARCHAR(10) NOT NULL UNIQUE,
    FOREIGN KEY (idCliente) REFERENCES clientes(idCliente)
);

-- Tabela de Serviços
CREATE TABLE servicos (
    idServico INT AUTO_INCREMENT PRIMARY KEY,
    idVeiculo INT,
    dataServico DATE,
    descricao TEXT,
    valor DECIMAL(10, 2),
    FOREIGN KEY (idVeiculo) REFERENCES veiculos(idVeiculo)
);

-- Tabela de Pedidos
CREATE TABLE pedidos (
    idPedido INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT,
    dataPedido DATE,
    statusPedido ENUM('Em andamento', 'Concluído') DEFAULT 'Em andamento',
    FOREIGN KEY (idCliente) REFERENCES clientes(idCliente)
);

-- Tabela de Itens do Pedido
CREATE TABLE itensPedido (
    idPedido INT,
    idServico INT,
    quantidade INT DEFAULT 1,
    FOREIGN KEY (idPedido) REFERENCES pedidos(idPedido),
    FOREIGN KEY (idServico) REFERENCES servicos(idServico)
);

-- Tabela de Situação do Pagamento
CREATE TABLE situacaoPagamento (
    idPedido INT,
    dataPagamento DATE,
    valorPago DECIMAL(10, 2),
    FOREIGN KEY (idPedido) REFERENCES pedidos(idPedido)
);

-- Tabela de Relatório de Serviços
CREATE TABLE relatorioServicos (
    idVeiculo INT,
    dataEntrada DATE,
    dataSaida DATE,
    servicoRealizado TEXT,
    FOREIGN KEY (idVeiculo) REFERENCES veiculos(idVeiculo)
);
