
use oficina;


-- Clientes
INSERT INTO Cliente (idCliente, Nome, CPFCNPJ, Telefone, CEP, Cidade, Estado, Logradouro, Num, Bairro) VALUES
(1, 'João Silva', '12345678901', '11999998888', '01001000', 'São Paulo', 'SP', 'Rua A', 100, 'Centro'),
(2, 'Maria Oliveira', '98765432100', '21988887777', '20040002', 'Rio de Janeiro', 'RJ', 'Av. B', 250, 'Copacabana'),
(3, 'Empresa XYZ Ltda', '12345678000199', '1133332222', '04567001', 'São Paulo', 'SP', 'Rua C', 500, 'Itaim');

-- Equipes
INSERT INTO Equipe (idEquipe, Descricao, Quantidade) VALUES
(1, 'Equipe Manutenção Geral', 5),
(2, 'Equipe Pintura', 3),
(3, 'Equipe Eletrônica', 4);

-- Veículos
INSERT INTO Veiculo (idVeiculo, Marca, Modelo, Placa, Tipo, Cliente_idCliente, Equipe_idEquipe) VALUES
(1, 'Toyota', 'Corolla', 'ABC1234', 'Sedan', 1, 1),
(2, 'Honda', 'Civic', 'DEF5678', 'Sedan', 2, 2),
(3, 'Ford', 'Fiesta', 'GHI9012', 'Hatch', 3, 1);

-- Mecânicos
INSERT INTO Mecanico (idMecanico, Nome, Especialidade, CPF, Telefone, CEP, Cidade, Estado, Logradouro, Num, Bairro, InicioExpediente, FimExpediente, Trabalhando, Equipe_idEquipe) VALUES
(1, 'Carlos Pereira', 'Motor', '11122233344', '11988887766', '01001000', 'São Paulo', 'SP', 'Rua A', 100, 'Centro', '08:00:00', '17:00:00', 1, 1),
(2, 'Ana Souza', 'Pintor', '55566677788', '21977776655', '20040002', 'Rio de Janeiro', 'RJ', 'Av. B', 250, 'Copacabana', '09:00:00', '18:00:00', 1, 2),
(3, 'Pedro Lima', 'Eletronica', '99988877766', '1133332222', '04567001', 'São Paulo', 'SP', 'Rua C', 500, 'Itaim', '07:30:00', '16:30:00', 0, 3);

-- Peças
INSERT INTO Peca (idPeca, Descricao, FabricantePeca, Valor, MarcaCarro, ModeloCarro, Ano) VALUES
(1, 'Filtro de óleo', 'Bosch', 50.0, 'Toyota', 'Corolla', '2019'),
(2, 'Pastilha de freio', 'Brembo', 150.0, 'Honda', 'Civic', '2020'),
(3, 'Bateria', 'Hercules', 300.0, 'Ford', 'Fiesta', '2018');

-- Ordem de Serviço
INSERT INTO OrdemServico (idOrdemServico, Numero, DataEmissao, ValorTotal, `Status`, AutorizacaoCliente, DataConclusao, Equipe_idEquipe, Veiculo_idVeiculo, Veiculo_Cliente_idCliente) VALUES
(1, 1001, '2025-06-01', 500.0, 1, 1, '2025-06-05', 1, 1, 1),
(2, 1002, '2025-06-03', 300.0, 0, 1, NULL, 2, 2, 2),
(3, 1003, '2025-06-10', 400.0, 1, 0, NULL, 3, 3, 3);

-- Mão de Obra
INSERT INTO MaoDeObra (idMaoDeObra, Descricao, Valor) VALUES
(1, 'Troca de óleo', 100.0),
(2, 'Reparo freios', 150.0),
(3, 'Diagnóstico elétrico', 200.0);

-- Serviços
INSERT INTO Servico (idServico, Descricao, MaoDeObra_idMaoDeObra, Equipe_idEquipe) VALUES
(1, 'Troca de óleo e filtros', 1, 1),
(2, 'Troca de pastilhas de freio', 2, 1),
(3, 'Revisão elétrica geral', 3, 3);

-- Relação Ordem Serviço - Serviços
INSERT INTO RelacaoOSServicos (Servico_idServico, OrdemServico_idOrdemServico) VALUES
(1, 1),
(2, 1),
(3, 3);

-- Relação Ordem Serviço - Peças
INSERT INTO RelacaoOSPecas (Peca_idPeca, OrdemServico_idOrdemServico) VALUES
(1, 1),
(2, 1),
(3, 3);


-- ============================================
-- 1. Recuperações simples com SELECT Statement
-- ============================================

-- Fácil: Qual o nome de todos os clientes cadastrados?
SELECT Nome FROM Cliente;

-- Intermediário: Quais são os modelos de veículos disponíveis na oficina?
SELECT DISTINCT Modelo FROM Veiculo;

-- Difícil: Quais são os nomes dos mecânicos e suas especialidades?
SELECT Nome, Especialidade FROM Mecanico;

-- ============================================
-- 2. Filtros com WHERE Statement
-- ============================================

-- Fácil: Quais clientes moram na cidade de São Paulo?
SELECT Nome FROM Cliente WHERE Cidade = 'São Paulo';

-- Intermediário: Quais veículos são do tipo 'Sedan' e pertencem a clientes do estado 'SP'?
SELECT v.Marca, v.Modelo
FROM Veiculo v
JOIN Cliente c ON v.Cliente_idCliente = c.idCliente
WHERE v.Tipo = 'Sedan' AND c.Estado = 'SP';

-- Difícil: Liste os mecânicos que trabalham na equipe 1 e que começam expediente antes das 08:30
SELECT Nome FROM Mecanico
WHERE Equipe_idEquipe = 1 AND InicioExpediente < '08:30:00';

-- ============================================
-- 3. Expressões para gerar atributos derivados
-- ============================================

-- Fácil: Liste os clientes junto com o código postal formatado (CEP com hífen)
SELECT Nome, CONCAT(SUBSTRING(CEP,1,5), '-', SUBSTRING(CEP,6,3)) AS CEP_formatado FROM Cliente;

-- Intermediário: Calcule o valor total de cada ordem de serviço somando o valor dos serviços e peças (exemplo simplificado)
SELECT idOrdemServico, ValorTotal, ValorTotal * 1.1 AS ValorComTaxa FROM OrdemServico;

-- Difícil: Crie uma expressão que concatena a marca e modelo do carro para cada veículo
SELECT idVeiculo, CONCAT(Marca, ' ', Modelo) AS MarcaModelo FROM Veiculo;

-- ============================================
-- 4. Ordenação dos dados com ORDER BY
-- ============================================

-- Fácil: Liste todos os clientes ordenados por nome em ordem alfabética
SELECT Nome FROM Cliente ORDER BY Nome ASC;

-- Intermediário: Liste as ordens de serviço ordenadas pela data de emissão, da mais recente para a mais antiga
SELECT idOrdemServico, DataEmissao FROM OrdemServico ORDER BY DataEmissao DESC;

-- Difícil: Liste os mecânicos ordenados por especialidade e depois por nome
SELECT Nome, Especialidade FROM Mecanico ORDER BY Especialidade ASC, Nome ASC;

-- ============================================
-- 5. Queries com GROUP BY
-- ============================================

-- Fácil: Quantos veículos existem para cada marca?
SELECT Marca, COUNT(*) AS Quantidade FROM Veiculo GROUP BY Marca;

-- Intermediário: Qual o número de ordens de serviço realizadas por cada equipe?
SELECT Equipe_idEquipe, COUNT(*) AS TotalOrdens FROM OrdemServico GROUP BY Equipe_idEquipe;

-- Difícil: Qual o valor total faturado por cada equipe nas ordens de serviço?
SELECT Equipe_idEquipe, SUM(ValorTotal) AS TotalFaturado FROM OrdemServico GROUP BY Equipe_idEquipe;

-- ============================================
-- 6. Condições de filtros aos grupos – HAVING Statement
-- ============================================

-- Fácil: Quais equipes têm mais de 2 ordens de serviço registradas?
SELECT Equipe_idEquipe, COUNT(*) AS TotalOrdens FROM OrdemServico GROUP BY Equipe_idEquipe HAVING COUNT(*) > 2;

-- Intermediário: Quais fabricantes de peças possuem mais de 1 peça cadastrada?
SELECT FabricantePeca, COUNT(*) AS QtdePecas FROM Peca GROUP BY FabricantePeca HAVING COUNT(*) > 1;

-- Difícil: Quais equipes faturaram mais de R$1000 em ordens de serviço concluídas?
SELECT Equipe_idEquipe, SUM(ValorTotal) AS TotalFaturado
FROM OrdemServico
WHERE `Status` = 1 -- supondo 1 = concluído
GROUP BY Equipe_idEquipe
HAVING SUM(ValorTotal) > 1000;

-- ============================================
-- 7. Junções entre tabelas para perspectivas mais complexas
-- ============================================

-- Fácil: Liste os nomes dos clientes e os modelos dos seus veículos
SELECT c.Nome, v.Modelo
FROM Cliente c
JOIN Veiculo v ON c.idCliente = v.Cliente_idCliente;

-- Intermediário: Liste as ordens de serviço com o nome do cliente, modelo do veículo e valor total
SELECT o.idOrdemServico, c.Nome, v.Modelo, o.ValorTotal
FROM OrdemServico o
JOIN Cliente c ON o.Veiculo_Cliente_idCliente = c.idCliente
JOIN Veiculo v ON o.Veiculo_idVeiculo = v.idVeiculo AND v.Cliente_idCliente = c.idCliente;

-- Difícil: Liste todos os serviços prestados em cada ordem, com a descrição do serviço, nome da equipe e o nome do cliente
SELECT o.idOrdemServico, s.Descricao AS ServicoDescricao, e.Descricao AS EquipeDescricao, c.Nome
FROM RelacaoOSServicos ros
JOIN OrdemServico o ON ros.OrdemServico_idOrdemServico = o.idOrdemServico
JOIN Servico s ON ros.Servico_idServico = s.idServico AND s.Equipe_idEquipe = o.Equipe_idEquipe
JOIN Equipe e ON s.Equipe_idEquipe = e.idEquipe
JOIN Cliente c ON o.Veiculo_Cliente_idCliente = c.idCliente;
