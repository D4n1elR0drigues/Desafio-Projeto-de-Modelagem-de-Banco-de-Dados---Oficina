drop database oficina;
create database if not exists oficina;
use oficina;

-- -----------------------------------------------------
-- Table mydb.Cliente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Cliente(
  idCliente INT NOT NULL AUTO_INCREMENT,
  Nome VARCHAR(45) NOT NULL,
  CPFCNPJ VARCHAR(45) NULL,
  Telefone VARCHAR(45) NULL,
  CEP VARCHAR(45) NULL,
  Cidade VARCHAR(45) NULL,
  Estado VARCHAR(45) NULL,
  Logradouro VARCHAR(45) NULL,
  Num INT NULL,
  Bairro VARCHAR(45) NULL,
  PRIMARY KEY (idCliente),
  UNIQUE INDEX CPFCNPJ_UNIQUE (CPFCNPJ ASC) VISIBLE
);


-- -----------------------------------------------------
-- Table mydb.Equipe
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Equipe(
  idEquipe INT NOT NULL AUTO_INCREMENT,
  Descricao VARCHAR(45) NULL,
  Quantidade INT NOT NULL,
  PRIMARY KEY (idEquipe)
);


-- -----------------------------------------------------
-- Table mydb.Veiculo
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Veiculo(
  idVeiculo INT NOT NULL AUTO_INCREMENT,
  Marca VARCHAR(45) NOT NULL,
  Modelo VARCHAR(45) NOT NULL,
  Placa VARCHAR(45) NULL,
  Tipo VARCHAR(45) NULL,
  Cliente_idCliente INT NOT NULL,
  Equipe_idEquipe INT NOT NULL,
  PRIMARY KEY (idVeiculo, Cliente_idCliente, Equipe_idEquipe),
  CONSTRAINT fk_Veiculo_Cliente FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente (idCliente),
  CONSTRAINT fk_Veiculo_Equipe1 FOREIGN KEY (Equipe_idEquipe) REFERENCES Equipe (idEquipe)
);


-- -----------------------------------------------------
-- Table mydb.Mecanico
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Mecanico(
  idMecanico INT NOT NULL AUTO_INCREMENT,
  Nome VARCHAR(45) NOT NULL,
  Especialidade ENUM('Pintor', 'Motor', 'Eletronica') NOT NULL,
  CPF VARCHAR(45) NULL,
  Telefone VARCHAR(45) NOT NULL,
  CEP VARCHAR(45) NOT NULL,
  Cidade VARCHAR(45) NOT NULL,
  Estado VARCHAR(45) NOT NULL,
  Logradouro VARCHAR(45) NOT NULL,
  Num INT NOT NULL,
  Bairro VARCHAR(45) NOT NULL,
  InicioExpediente TIME NOT NULL,
  FimExpediente TIME NOT NULL,
  Trabalhando TINYINT NULL,
  Equipe_idEquipe INT NOT NULL,
  PRIMARY KEY (idMecanico, Equipe_idEquipe),
  UNIQUE INDEX CPFCNPJ_UNIQUE (CPF ASC) VISIBLE,
  CONSTRAINT fk_Funcionario_Equipe1 FOREIGN KEY (Equipe_idEquipe) REFERENCES Equipe (idEquipe)
);


-- -----------------------------------------------------
-- Table mydb.Peca
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Peca (
  idPeca INT NOT NULL AUTO_INCREMENT,
  Descricao VARCHAR(45) NOT NULL,
  FabricantePeca VARCHAR(45) NOT NULL,
  Valor FLOAT NOT NULL,
  MarcaCarro VARCHAR(45) NOT NULL,
  ModeloCarro VARCHAR(45) NOT NULL,
  Ano VARCHAR(45) NOT NULL,
  PRIMARY KEY (idPeca)
);


-- -----------------------------------------------------
-- Table mydb.OrdemServico
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS OrdemServico (
  idOrdemServico INT NOT NULL AUTO_INCREMENT,
  Numero INT NOT NULL,
  DataEmissao DATE NOT NULL,
  ValorTotal FLOAT NOT NULL,
  `Status` TINYINT NULL,
  AutorizacaoCliente TINYINT NOT NULL,
  DataConclusao DATE NULL,
  Equipe_idEquipe INT NOT NULL,
  Veiculo_idVeiculo INT NOT NULL,
  Veiculo_Cliente_idCliente INT NOT NULL,
  PRIMARY KEY (idOrdemServico, Equipe_idEquipe, Veiculo_idVeiculo, Veiculo_Cliente_idCliente),
  CONSTRAINT fk_OrdemServico_Equipe1 FOREIGN KEY (Equipe_idEquipe) REFERENCES Equipe (idEquipe),
  CONSTRAINT fk_OrdemServico_Veiculo1 FOREIGN KEY (Veiculo_idVeiculo , Veiculo_Cliente_idCliente) REFERENCES Veiculo (idVeiculo , Cliente_idCliente)
);


-- -----------------------------------------------------
-- Table mydb.MaoDeObra
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS MaoDeObra (
  idMaoDeObra INT NOT NULL AUTO_INCREMENT,
  Descricao VARCHAR(45) NOT NULL,
  Valor FLOAT NOT NULL,
  PRIMARY KEY (idMaoDeObra)
);


-- -----------------------------------------------------
-- Table mydb.Servico
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Servico (
  idServico INT NOT NULL AUTO_INCREMENT,
  Descricao VARCHAR(100) NOT NULL,
  MaoDeObra_idMaoDeObra INT NOT NULL,
  Equipe_idEquipe INT NOT NULL,
  PRIMARY KEY (idServico, MaoDeObra_idMaoDeObra, Equipe_idEquipe),
  CONSTRAINT fk_Servico_MaoDeObra1 FOREIGN KEY (MaoDeObra_idMaoDeObra) REFERENCES MaoDeObra (idMaoDeObra),
  CONSTRAINT fk_Servico_Equipe1 FOREIGN KEY (Equipe_idEquipe) REFERENCES Equipe (idEquipe)
);


-- -----------------------------------------------------
-- Table mydb.RelacaoOS/Servicos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS RelacaoOSServicos (
  Servico_idServico INT NOT NULL,
  OrdemServico_idOrdemServico INT NOT NULL,
  PRIMARY KEY (Servico_idServico, OrdemServico_idOrdemServico),
  CONSTRAINT fk_Servico_has_OrdemServico_Servico1 FOREIGN KEY (Servico_idServico) REFERENCES Servico (idServico),
  CONSTRAINT fk_Servico_has_OrdemServico_OrdemServico1 FOREIGN KEY (OrdemServico_idOrdemServico) REFERENCES OrdemServico (idOrdemServico)
);


-- -----------------------------------------------------
-- Table mydb.RelacaoOS/Pecas
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS RelacaoOSPecas(
  Peca_idPeca INT NOT NULL,
  OrdemServico_idOrdemServico INT NOT NULL,
  PRIMARY KEY (Peca_idPeca, OrdemServico_idOrdemServico),
  CONSTRAINT fk_Peca_has_OrdemServico_Peca1 FOREIGN KEY (Peca_idPeca) REFERENCES Peca (idPeca),
  CONSTRAINT fk_Peca_has_OrdemServico_OrdemServico1 FOREIGN KEY (OrdemServico_idOrdemServico) REFERENCES OrdemServico (idOrdemServico)
);



