-- Criação do Banco de Dados para uma Oficina de Reparação de Veículos

-- DROP DATABASE IF EXISTS Desafio_Projeto_SQL_Do_Zero;
-- Verifica se um banco de dados chamado "Desafio_Projeto_SQL_Do_Zero" já existe e, se existir, exclui-o.

CREATE DATABASE IF NOT EXISTS Desafio_Projeto_SQL_Do_Zero;
-- Cria um novo banco de dados chamado "Desafio_Projeto_SQL_Do_Zero" se ele ainda não existir.

USE Desafio_Projeto_SQL_Do_Zero;
-- Seleciona o banco de dados "Desafio_Projeto_SQL_Do_Zero" para uso.

-- Tabela de Clientes
-- Esta tabela armazena informações sobre os clientes da oficina.

CREATE TABLE clientes (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(15),
    endereco VARCHAR(255),
    dataCadastro DATE,
    email VARCHAR(100),
    CONSTRAINT unique_email UNIQUE (email)
);

-- Tabela de Veículos
-- Esta tabela contém detalhes sobre os veículos dos clientes.

CREATE TABLE veiculos (
    idVeiculo INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    anoFabricacao YEAR,
    placa VARCHAR(10) NOT NULL UNIQUE,
    CONSTRAINT fk_cliente FOREIGN KEY (idCliente) REFERENCES clientes(idCliente)
);

-- Tabela de Serviços
-- Esta tabela registra os serviços realizados nos veículos.

CREATE TABLE servicos (
    idServico INT AUTO_INCREMENT PRIMARY KEY,
    idVeiculo INT,
    dataServico DATE,
    descricao TEXT,
    valor DECIMAL(10, 2),
    CONSTRAINT fk_veiculo FOREIGN KEY (idVeiculo) REFERENCES veiculos(idVeiculo)
);

-- Tabela de Pedidos
-- Esta tabela registra os pedidos de peças ou componentes.

CREATE TABLE pedidos (
    idPedido INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT,
    dataPedido DATE,
    statusPedido ENUM('Em andamento', 'Concluído') DEFAULT 'Em andamento',
    CONSTRAINT fk_cliente_pedido FOREIGN KEY (idCliente) REFERENCES clientes(idCliente)
);

-- Tabela de Itens do Pedido
-- Esta tabela relaciona os produtos pedidos em cada pedido.

CREATE TABLE itensPedido (
    idPedido INT,
    idServico INT,
    quantidade INT DEFAULT 1,
    CONSTRAINT fk_pedido FOREIGN KEY (idPedido) REFERENCES pedidos(idPedido),
    CONSTRAINT fk_servico FOREIGN KEY (idServico) REFERENCES servicos(idServico)
);

-- Tabela de Situação do Pagamento
-- Esta tabela registra as situações de pagamento dos pedidos.

CREATE TABLE situacaoPagamento (
    idPedido INT,
    dataPagamento DATE,
    valorPago DECIMAL(10, 2),
    CONSTRAINT fk_pedido_pagamento FOREIGN KEY (idPedido) REFERENCES pedidos(idPedido)
);

-- Tabela de Relatório de Serviços
-- Esta tabela registra o histórico de serviços feitos em cada veículo.

CREATE TABLE relatorioServicos (
    idVeiculo INT,
    dataEntrada DATE,
    dataSaida DATE,
    servicoRealizado TEXT,
    CONSTRAINT fk_veiculo_relatorio FOREIGN KEY (idVeiculo) REFERENCES veiculos(idVeiculo)
);

-- Função para calcular a idade dos clientes com base na data de nascimento
DELIMITER //
CREATE FUNCTION calcularIdade(dataNascimento DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE idade INT;
    SET idade = YEAR(CURDATE()) - YEAR(dataNascimento);
    IF (MONTH(CURDATE()) < MONTH(dataNascimento) OR (MONTH(CURDATE()) = MONTH(dataNascimento) AND DAY(CURDATE()) < DAY(dataNascimento))) THEN
        SET idade = idade - 1;
    END IF;
    RETURN idade;
END;
//
DELIMITER ;

-- Função para identificar clientes antigos (com mais de 5 anos de cadastro)
DELIMITER //
CREATE FUNCTION clientesAntigos()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE totalClientesAntigos INT;
    SET totalClientesAntigos = 0;
    SELECT COUNT(*) INTO totalClientesAntigos FROM clientes WHERE calcularIdade(dataCadastro) > 5;
    RETURN totalClientesAntigos;
END;
//
DELIMITER ;

-- Função para agendar serviços de manutenção preventiva
DELIMITER //
CREATE FUNCTION agendarManutencaoPreventiva()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE totalAgendamentos INT;
    SET totalAgendamentos = 0;
    INSERT INTO pedidos (idCliente, dataPedido) SELECT idCliente, DATE_ADD(CURDATE(), INTERVAL 6 MONTH) FROM clientes;
    SET totalAgendamentos = ROW_COUNT();
    RETURN totalAgendamentos;
END;
//
DELIMITER ;

-- Função para calcular a média de idade dos veículos
DELIMITER //
CREATE FUNCTION calcularMediaIdadeVeiculos()
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE mediaIdade DECIMAL(10, 2);
    SET mediaIdade = 0.0;
    SELECT AVG(YEAR(CURDATE()) - YEAR(anoFabricacao)) INTO mediaIdade FROM veiculos;
    RETURN mediaIdade;
END;
//
DELIMITER ;

-- Função para contar o total de pedidos de serviços
DELIMITER //
CREATE FUNCTION contarTotalPedidosServicos()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE totalPedidos INT;
    SET totalPedidos = 0;
    SELECT COUNT(*) INTO totalPedidos FROM pedidos;
    RETURN totalPedidos;
END;
//
DELIMITER ;

-- Função para verificar se um veículo já foi atendido em um determinado período
DELIMITER //
CREATE FUNCTION veiculoAtendidoNoPeriodo(idVeiculo INT, dataInicio DATE, dataFim DATE)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE atendido BOOLEAN;
    SET atendido = FALSE;
    SELECT 1 INTO atendido FROM relatorioServicos WHERE idVeiculo = idVeiculo AND dataEntrada BETWEEN dataInicio AND dataFim;
    RETURN atendido;
END;
//
DELIMITER ;

USE Desafio_Projeto_SQL_Do_Zero;

-- Inserir dados fictícios na tabela clientes
INSERT INTO clientes (nome, telefone, endereco, dataCadastro, email)
VALUES
     ('Machado de Assis', '(11) 1234-5678', 'Rua das Flores, 123', '2023-01-01', 'machado@email.com'),
    ('George Orwell', '(11) 9876-5432', 'Rua das Árvores, 789', '2023-01-02', 'george@email.com'),
    ('William Shakespeare', '(11) 1111-2222', 'Rua dos Mares, 101', '2023-01-03', 'william@email.com'),
    ('Jane Austen', '(11) 5555-6666', 'Rua do Sol, 55', '2023-01-04', 'jane@email.com'),
    ('Charles Dickens', '(11) 9999-8888', 'Rua das Estrelas, 77', '2023-01-05', 'charles@email.com'),
    ('Leo Tolstoy', '(11) 7777-8888', 'Rua das Montanhas, 12', '2023-01-06', 'leo@email.com'),
    ('Franz Kafka', '(11) 4444-3333', 'Avenida da Praia, 23', '2023-01-07', 'franz@email.com'),
    ('Emily Brontë', '(11) 5555-4444', 'Rua das Colinas, 56', '2023-01-08', 'emily@email.com'),
    ('Hermann Hesse', '(11) 9999-7777', 'Rua dos Lagos, 34', '2023-01-09', 'hermann@email.com'),
    ('Gabriel García Márquez', '(11) 1111-5555', 'Avenida Central, 67', '2023-01-10', 'gabriel@email.com');

-- Inserir dados fictícios na tabela veiculos
INSERT INTO veiculos (idCliente, marca, modelo, anoFabricacao, placa)
VALUES
     (1, 'Fiat', 'Fiat 500', 2020, 'ABC1234'),
    (2, 'Volkswagen', 'VW Passat', 2019, 'XYZ5678'),
    (3, 'BMW', 'BMW Série 7', 2021, 'DEF4321'),
    (4, 'Mercedes-Benz', 'Mercedes-Benz Classe S', 2022, 'HIJ9876'),
    (5, 'Audi', 'Audi A8', 2020, 'LMN6543'),
    (6, 'Lexus', 'Lexus LS', 2021, 'OPQ7890'),
    (7, 'Tesla', 'Tesla Model S', 2022, 'RST5432'),
    (8, 'Porsche', 'Porsche Panamera', 2019, 'UVW8765'),
    (9, 'Jaguar', 'Jaguar XJ', 2022, 'JKL2109'),
    (10, 'Maserati', 'Maserati Quattroporte', 2021, 'MNO7891');

-- Inserir dados fictícios na tabela servicos
INSERT INTO servicos (idVeiculo, dataServico, descricao, valor)
VALUES
    (1, '2023-01-05', 'Troca de Óleo', 100.00),
    (2, '2023-01-06', 'Alinhamento e Balanceamento', 80.00),
    (3, '2023-01-10', 'Troca de Pneus', 200.00),
    (4, '2023-01-15', 'Troca de Correia Dentada', 250.00),
    (5, '2023-01-20', 'Revisão Geral', 400.00),
    (6, '2023-01-25', 'Reparo de Freios', 150.00),
    (7, '2023-01-30', 'Troca de Bateria', 120.00),
    (8, '2023-02-05', 'Reparo do Motor', 300.00),
    (9, '2023-02-10', 'Limpeza de Filtros', 60.00),
    (10, '2023-02-15', 'Troca de Lâmpadas', 40.00);

-- Inserir dados fictícios na tabela pedidos
INSERT INTO pedidos (idCliente, dataPedido, statusPedido)
VALUES
    (1, '2023-01-05', 'Em andamento'),
    (2, '2023-01-06', 'Em andamento'),
    (3, '2023-01-10', 'Concluído'),
    (4, '2023-01-15', 'Concluído'),
    (5, '2023-01-20', 'Em andamento'),
    (6, '2023-01-25', 'Concluído'),
    (7, '2023-01-30', 'Concluído'),
    (8, '2023-02-05', 'Em andamento'),
    (9, '2023-02-10', 'Concluído'),
    (10, '2023-02-15', 'Em andamento');

-- Inserir dados fictícios na tabela itensPedido
INSERT INTO itensPedido (idPedido, idServico, quantidade)
VALUES
    (1, 1, 1),
    (2, 3, 2),
    (3, 5, 1),
    (4, 7, 1),
    (5, 9, 3),
    (6, 2, 2),
    (7, 4, 1),
    (8, 6, 1),
    (9, 8, 1),
    (10, 10, 4);

-- Inserir dados fictícios na tabela situacaoPagamento
INSERT INTO situacaoPagamento (idPedido, dataPagamento, valorPago)
VALUES
    (1, '2023-01-05', 100.00),
    (2, '2023-01-07', 240.00),
    (3, '2023-01-11', 200.00),
    (4, '2023-01-16', 250.00),
    (5, '2023-01-22', 480.00),
    (6, '2023-01-26', 300.00),
    (7, '2023-01-31', 120.00),
    (8, '2023-02-06', 300.00),
    (9, '2023-02-12', 60.00),
    (10, '2023-02-16', 160.00);

-- Inserir dados fictícios na tabela relatorioServicos
INSERT INTO relatorioServicos (idVeiculo, dataEntrada, dataSaida, servicoRealizado)
VALUES
    (1, '2023-01-05', '2023-01-05', 'Troca de Óleo'),
    (2, '2023-01-06', '2023-01-07', 'Alinhamento e Balanceamento'),
    (3, '2023-01-10', '2023-01-11', 'Troca de Pneus'),
    (4, '2023-01-15', '2023-01-16', 'Troca de Correia Dentada'),
    (5, '2023-01-20', '2023-01-22', 'Revisão Geral'),
    (6, '2023-01-25', '2023-01-26', 'Reparo de Freios'),
    (7, '2023-01-30', '2023-01-31', 'Troca de Bateria'),
    (8, '2023-02-05', '2023-02-06', 'Reparo do Motor'),
    (9, '2023-02-10', '2023-02-12', 'Limpeza de Filtros'),
    (10, '2023-02-15', '2023-02-16', 'Troca de Lâmpadas');
