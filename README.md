# Projeto Desafio_SQL_do_Zero 🚗

Este é um projeto de banco de dados SQL para uma oficina de reparação de veículos. O objetivo é criar e gerenciar um banco de dados abrangente que permita à oficina acompanhar clientes, veículos, serviços, pedidos e relatórios de serviços. O projeto utiliza o MySQL e inclui tabelas, funções e consultas SQL para demonstrar a funcionalidade do banco de dados. 🛠️

## Conteúdo 📑

1. [Tabelas do Banco de Dados](#1-tabelas-do-banco-de-dados) 🗄️
2. [Funções SQL](#2-funções-sql) 📊
3. [Consultas SQL](#3-consultas-sql) 📈
4. [Como Usar](#4-como-usar) ⚙️
5. [Oportunidades de CRM e Facilidades](#5-oportunidades-de-crm-e-facilidades) 📈

## 1. Tabelas do Banco de Dados 🗄️

O projeto inclui as seguintes tabelas:

- `clientes`: Armazena informações sobre os clientes, incluindo nome, telefone, endereço, data de cadastro e email. 📋

- `veiculos`: Contém detalhes sobre os veículos dos clientes, incluindo marca, modelo, ano de fabricação e placa. Também está relacionada à tabela de clientes por meio de uma chave estrangeira. 🚙

- `servicos`: Registra os serviços realizados nos veículos, incluindo data, descrição e valor. Também está relacionada à tabela de veículos por meio de uma chave estrangeira. 🔧

- `pedidos`: Registra os pedidos de peças ou componentes dos clientes, incluindo data e status. Também está relacionada à tabela de clientes por meio de uma chave estrangeira. 📦

- `itensPedido`: Relaciona os produtos pedidos em cada pedido, incluindo a quantidade. Também está relacionada às tabelas de pedidos e serviços por meio de chaves estrangeiras. 🛒

- `situacaoPagamento`: Registra as situações de pagamento dos pedidos, incluindo data e valor. Também está relacionada à tabela de pedidos por meio de uma chave estrangeira. 💰

- `relatorioServicos`: Registra o histórico de serviços feitos em cada veículo, incluindo data de entrada, data de saída e descrição do serviço. Também está relacionada à tabela de veículos por meio de uma chave estrangeira. 📋🔧

## 2. Funções SQL 📊

O projeto inclui funções SQL personalizadas, que podem ser usadas para análises avançadas dos dados. Estas incluem:

- `calcularIdade`: Calcula a idade com base na data de nascimento. 🎂

- `clientesAntigos`: Conta o número de clientes com mais de 5 anos de cadastro. ⏳

- `agendarManutencaoPreventiva`: Agenda serviços de manutenção preventiva para os clientes. 📅

- `calcularMediaIdadeVeiculos`: Calcula a média de idade dos veículos. 🚗

- `contarTotalPedidosServicos`: Conta o número total de pedidos de serviços. 📦

- `veiculoAtendidoNoPeriodo`: Verifica se um veículo já foi atendido em um determinado período. 🚗📅

## 3. Consultas SQL 📈

O projeto apresenta várias consultas SQL para extrair informações úteis do banco de dados, incluindo:

- Consultas para identificar o último serviço realizado por cliente. 🛠️👤

- Consultas para contar a frequência de serviços por descrição. 📊🔧

- Consultas para encontrar os veículos mais bem cuidados. 🚗🔍

- Consultas para identificar clientes inativos. ⏳👤

- Uma consulta personalizada para análises adicionais. 📈📊

## 4. Como Usar ⚙️

Para usar este projeto, siga os seguintes passos:

1. Importe o esquema do banco de dados (SQL) no seu sistema de gerenciamento de banco de dados MySQL.

2. Execute as consultas SQL ou funções personalizadas fornecidas para extrair informações relevantes.

3. Personalize o projeto conforme necessário para atender às necessidades específicas da oficina de reparação de veículos.

Este projeto oferece uma estrutura sólida para gerenciar dados de clientes, veículos, serviços e pedidos em uma oficina de reparação de veículos. Use-o como base para criar relatórios, análises e tomar decisões informadas para o seu negócio. 🚀

## 5. Oportunidades de CRM e Facilidades 📈

Este projeto fornece uma base sólida para implementar um sistema de CRM (Customer Relationship Management) para a oficina de reparação de veículos. Com as informações armazenadas nas tabelas, é possível:

- Acompanhar o histórico de serviços de cada cliente.

- Agendar manutenções preventivas com base na data do último serviço.

- Analisar o comportamento de compra dos clientes e oferecer promoções personalizadas.

- Identificar clientes inativos e criar estratégias para reengajá-los.

- Avaliar a qualidade do atendimento com base nas avaliações dos serviços (requer adição de coluna na tabela de servicos).

Além disso, você pode explorar outras facilidades, como relatórios de desempenho, análises de lucratividade por serviço e muito mais, usando as consultas e funções personalizadas fornecidas neste projeto. 📊💼

---

Este README oferece uma visão abrangente do projeto Desafio_SQL_do_Zero, incluindo suas tabelas, funções, consultas e oportunidades de CRM. Use-o como guia para explorar e expandir este projeto para atender às suas necessidades específicas de gerenciamento de uma oficina de reparação de veículos. 🛠️🚗
