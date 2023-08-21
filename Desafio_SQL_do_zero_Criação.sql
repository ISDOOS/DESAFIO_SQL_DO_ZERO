-- Criação do Banco de Dados
CREATE DATABASE IF NOT EXISTS Desafio_Projeto_SQL_Do_Zero;

-- Seleciona o Banco de Dados
USE Desafio_Projeto_SQL_Do_Zero;

-- Tabela de Clientes
CREATE TABLE IF NOT EXISTS Clientes (
    IDCliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Telefone VARCHAR(15),
    Email VARCHAR(100),
    Endereco VARCHAR(255)
);

-- Tabela de Veículos
CREATE TABLE IF NOT EXISTS Veiculos (
    IDVeiculo INT AUTO_INCREMENT PRIMARY KEY,
    Placa VARCHAR(10) NOT NULL,
    Marca VARCHAR(50) NOT NULL,
    Modelo VARCHAR(50) NOT NULL,
    AnoFabricacao INT
);

-- Tabela de Funcionários
CREATE TABLE IF NOT EXISTS Funcionarios (
    IDFuncionario INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Cargo VARCHAR(50) NOT NULL
);

-- Tabela de Ordens de Serviço
CREATE TABLE IF NOT EXISTS OrdensServico (
    IDOrdemServico INT AUTO_INCREMENT PRIMARY KEY,
    IDCliente INT NOT NULL,
    IDVeiculo INT NOT NULL,
    IDFuncionario INT NOT NULL,
    DataEntrada DATE NOT NULL,
    DataSaida DATE,
    Observacoes TEXT,
    FOREIGN KEY (IDCliente) REFERENCES Clientes(IDCliente),
    FOREIGN KEY (IDVeiculo) REFERENCES Veiculos(IDVeiculo),
    FOREIGN KEY (IDFuncionario) REFERENCES Funcionarios(IDFuncionario)
);

-- Tabela de MovimentacaoVeiculo
CREATE TABLE IF NOT EXISTS MovimentacaoVeiculo (
    IDMovimentacao INT AUTO_INCREMENT PRIMARY KEY,
    Veiculo INT NOT NULL,
    DataEntrada DATE NOT NULL,
    DataSaida DATE,
    Observacoes TEXT,
    FOREIGN KEY (Veiculo) REFERENCES Veiculos(IDVeiculo)
);

-- Tabela de TipoServico
CREATE TABLE IF NOT EXISTS TipoServico (
    IDTipoServico INT AUTO_INCREMENT PRIMARY KEY,
    DescricaoTipo VARCHAR(100) NOT NULL
);

-- Atualização da Tabela de Ordens de Serviço
ALTER TABLE OrdensServico
ADD IDMovimentacao INT,
ADD IDTipoServico INT,
ADD FOREIGN KEY (IDMovimentacao) REFERENCES MovimentacaoVeiculo(IDMovimentacao),
ADD FOREIGN KEY (IDTipoServico) REFERENCES TipoServico(IDTipoServico);

