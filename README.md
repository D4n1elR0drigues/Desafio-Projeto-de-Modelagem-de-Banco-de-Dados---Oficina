# Desafio-Projeto-de-Modelagem-de-Banco-de-Dados---Oficina

---

# 🔧 Projeto de Modelagem de Banco de Dados – Oficina Mecânica

Este repositório apresenta um projeto completo de modelagem e implementação de um banco de dados para um sistema de **oficina mecânica**. O projeto abrange desde a definição do modelo lógico até a implementação de consultas SQL complexas, com o objetivo de simular o funcionamento de uma oficina real, incluindo clientes, veículos, ordens de serviço, peças, equipes técnicas e muito mais.

---

## 🧠 Objetivos do Projeto

* Modelar um banco de dados relacional para uma oficina mecânica;
* Criar o **esquema lógico** em SQL (DDL);
* Popular o banco com **dados de teste realistas** (DML);
* Desenvolver **consultas SQL complexas** que respondam a perguntas reais do negócio;
* Consolidar o uso de comandos `SELECT`, `JOIN`, `WHERE`, `GROUP BY`, `HAVING`, `ORDER BY` e expressões derivadas.

---

## 🛠️ Funcionalidades Modeladas

* Cadastro completo de **clientes** com CPF/CNPJ e endereço;
* Registro de **veículos** vinculados a clientes;
* Criação e gerenciamento de **equipes técnicas**;
* Cadastro de **mecânicos** com especialidades e horários de expediente;
* Controle de **peças** e **serviços**;
* Criação de **ordens de serviço (OS)** com status e data de conclusão;
* Relacionamento entre ordens, peças e serviços prestados;
* Cálculo de valores totais, agrupamentos e indicadores operacionais.

---

## ⚙️ Tecnologias Utilizadas

* **SGBD**: MySQL
* **Scripts SQL**: Criação de tabelas, inserção de dados e execução de consultas
* **Ferramentas recomendadas**: MySQL Workbench
---

## 📊 Consultas SQL Implementadas

As consultas foram organizadas de forma didática e funcional, cobrindo os seguintes temas:

### 🔍 SELECIONE (`SELECT`)

* Todos os nomes de clientes cadastrados
* Modelos distintos de veículos registrados
* Nome e especialidade dos mecânicos

### 🎯 ONDE (`WHERE`)

* Clientes da cidade de São Paulo
* Veículos do tipo *Sedan* e de clientes de SP
* Mecânicos que começam o expediente antes das 8h30 na equipe 1

### ➕ Atributos Derivados (expressões)

* CEP formatado com hífen
* Valor total com taxa adicional
* Marca e modelo do veículo concatenados

### 📑 ORDEM POR (`ORDER BY`)

* Clientes ordenados por nome
* Ordens de serviço por data (mais recente primeiro)
* Mecânicos ordenados por especialidade e nome

### 🗂️ AGRUPAR POR (`GROUP BY`)

* Quantidade de veículos por marca
* Total de ordens de serviço por equipe
* Valor faturado por equipe

### 🔍 TENDO (`HAVING`)

* Equipes com mais de 2 ordens de serviço
* Fabricantes com mais de 1 peça cadastrada
* Equipes com faturamento acima de R\$ 1.000 em ordens concluídas

### 🔗 JUNÇÕES (`JOIN`)

* Clientes com os modelos dos seus veículos
* Ordens de serviço com nome do cliente e modelo do veículo
* Serviços prestados com descrição, equipe e nome do cliente

