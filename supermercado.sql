CREATE DATABASE supermercado;
USE supermercado;

CREATE TABLE tbl_clientes (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  cpf VARCHAR(14) NOT NULL UNIQUE
);

CREATE TABLE tbl_funcionarios (
  id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  cpf VARCHAR(14) NOT NULL UNIQUE,
  cargo VARCHAR(50) NOT NULL,
  data_admissao DATE
);

CREATE TABLE tbl_fornecedores (
  id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  cnpj VARCHAR(18) NOT NULL UNIQUE
);

CREATE TABLE tbl_telefone_cliente (
  id_telefone INT AUTO_INCREMENT PRIMARY KEY,
  numero VARCHAR(20) NOT NULL,
  id_cliente INT NOT NULL,
  FOREIGN KEY (id_cliente) REFERENCES tbl_clientes(id_cliente)
);

CREATE TABLE tbl_email_cliente (
  id_email INT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(100) NOT NULL,
  id_cliente INT NOT NULL,
  FOREIGN KEY (id_cliente) REFERENCES tbl_clientes(id_cliente)
);

CREATE TABLE tbl_telefone_fornecedores (
  id_telefone INT AUTO_INCREMENT PRIMARY KEY,
  numero VARCHAR(20) NOT NULL,
  id_fornecedor INT NOT NULL,
  FOREIGN KEY (id_fornecedor) REFERENCES tbl_fornecedores(id_fornecedor)
);

CREATE TABLE tbl_email_fornecedores (
  id_email INT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(100) NOT NULL,
  id_fornecedor INT NOT NULL,
  FOREIGN KEY (id_fornecedor) REFERENCES tbl_fornecedores(id_fornecedor)
);

CREATE TABLE tbl_enderecos (
  id_endereco INT AUTO_INCREMENT PRIMARY KEY,
  logradouro VARCHAR(100) NOT NULL,
  numero VARCHAR(10) NOT NULL,
  complemento VARCHAR(50),
  bairro VARCHAR(50) NOT NULL,
  cidade VARCHAR(50) NOT NULL,
  estado VARCHAR(2) NOT NULL,
  cep VARCHAR(10) NOT NULL
);

CREATE TABLE tbl_enderecos_cliente (
  id_cliente INT NOT NULL,
  id_endereco INT NOT NULL,
  tipo_endereco VARCHAR(30),
  PRIMARY KEY (id_cliente, id_endereco),
  FOREIGN KEY (id_cliente) REFERENCES tbl_clientes(id_cliente),
  FOREIGN KEY (id_endereco) REFERENCES tbl_enderecos(id_endereco)
);

CREATE TABLE tbl_produtos (
  id_produto INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  codigo_barras VARCHAR(30) UNIQUE,
  preco DECIMAL(10,2) NOT NULL,
  estoque INT NOT NULL,
  id_fornecedor INT NOT NULL,
  FOREIGN KEY (id_fornecedor) REFERENCES tbl_fornecedores(id_fornecedor)
);

CREATE TABLE tbl_vendas (
  id_venda INT AUTO_INCREMENT PRIMARY KEY,
  data DATE NOT NULL,
  id_cliente INT NOT NULL,
  id_funcionario INT NOT NULL,
  valor_total DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (id_cliente) REFERENCES tbl_clientes(id_cliente),
  FOREIGN KEY (id_funcionario) REFERENCES tbl_funcionarios(id_funcionario)
);

CREATE TABLE tbl_itens_venda (
  id_item INT AUTO_INCREMENT PRIMARY KEY,
  id_venda INT NOT NULL,
  id_produto INT NOT NULL,
  quantidade INT NOT NULL,
  preco_unitario DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (id_venda) REFERENCES tbl_vendas(id_venda),
  FOREIGN KEY (id_produto) REFERENCES tbl_produtos(id_produto)
);
