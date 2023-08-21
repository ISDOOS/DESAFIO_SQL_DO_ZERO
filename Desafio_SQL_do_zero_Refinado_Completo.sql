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


