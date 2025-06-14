# 🛒 Supermercado - Modelagem de Banco de Dados

## ✅ 1. Levantamento de Requisitos

1. **Quais informações dos clientes precisam ser armazenadas?**  
👉 Nome completo, CPF, telefone, e-mail e endereço (com rua, número, bairro, cidade, estado e CEP).

2. **O sistema precisa armazenar múltiplos telefones e e-mails por cliente?**  
👉 Sim, um cliente pode ter mais de um telefone e mais de um e-mail.

3. **Quais dados dos funcionários devem ser registrados?**  
👉 Nome, CPF, cargo (ex: caixa, gerente), data de admissão.

4. **E sobre os fornecedores? O que é necessário armazenar?**  
👉 Nome da empresa, CNPJ, telefones, e-mails e produtos fornecidos.

5. **Um fornecedor pode fornecer vários produtos?**  
👉 Sim, um único fornecedor pode fornecer diversos produtos.

6. **Quais dados de produtos devem ser registrados?**  
👉 Nome, código de barras, preço unitário, quantidade em estoque, e fornecedor.

7. **Como funciona uma venda no supermercado?**  
👉 A venda envolve um cliente, um funcionário (que realiza a venda), data, valor total e os itens comprados.

8. **Os itens da venda precisam ter alguma informação além da quantidade?**  
👉 Sim, precisam registrar o produto vendido, a quantidade e o preço unitário no momento da venda.

9. **Um cliente pode ter mais de um endereço?**  
👉 Sim. Por exemplo, um endereço residencial e um de entrega.

10. **O sistema precisa controlar o estoque dos produtos?**  
👉 Sim. Sempre que uma venda for registrada, a quantidade em estoque deve ser atualizada.

---

## ✅ 2. Modelagens

### 👉 Modelo Conceitual

[Inserir imagem ou diagrama aqui]

### 👉 Modelo Lógico

[Inserir imagem ou diagrama aqui]

---

## ✅ 3. Modelo Físico

### 👉 Código SQL

```sql
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
````

### 👉 Insert

```sql
-- Inserindo clientes
INSERT INTO tbl_clientes (nome, cpf) VALUES 
('Maria Silva', '123.456.789-00'),
('João Souza', '987.654.321-00');

-- Telefones dos clientes
INSERT INTO tbl_telefone_cliente (numero, id_cliente) VALUES 
('21999990000', 1),
('21988887777', 2);

-- Emails dos clientes
INSERT INTO tbl_email_cliente (email, id_cliente) VALUES 
('maria@email.com', 1),
('joao@email.com', 2);

-- Funcionários
INSERT INTO tbl_funcionarios (nome, cpf, cargo, data_admissao) VALUES 
('Carlos Mendes', '111.222.333-44', 'Caixa', '2024-01-15'),
('Fernanda Lima', '555.666.777-88', 'Gerente', '2023-11-20');

-- Fornecedores
INSERT INTO tbl_fornecedores (nome, cnpj) VALUES 
('Fornecedor A', '12.345.678/0001-99'),
('Fornecedor B', '98.765.432/0001-11');

-- Telefones dos fornecedores
INSERT INTO tbl_telefone_fornecedores (numero, id_fornecedor) VALUES 
('2133334444', 1),
('2134445555', 2);

-- Emails dos fornecedores
INSERT INTO tbl_email_fornecedores (email, id_fornecedor) VALUES 
('contato@fornecedora.com', 1),
('vendas@fornecedorb.com', 2);

-- Endereços
INSERT INTO tbl_enderecos (logradouro, numero, complemento, bairro, cidade, estado, cep) VALUES 
('Rua A', '100', 'Apto 101', 'Centro', 'Rio de Janeiro', 'RJ', '20000-000'),
('Rua B', '200', NULL, 'Copacabana', 'Rio de Janeiro', 'RJ', '22000-000');

-- Associação cliente-endereço
INSERT INTO tbl_enderecos_cliente (id_cliente, id_endereco, tipo_endereco) VALUES 
(1, 1, 'Residencial'),
(2, 2, 'Residencial');

-- Produtos
INSERT INTO tbl_produtos (nome, codigo_barras, preco, estoque, id_fornecedor) VALUES 
('Arroz 5kg', '7891234567890', 25.90, 50, 1),
('Feijão 1kg', '7899876543210', 8.50, 100, 2);

-- Vendas
INSERT INTO tbl_vendas (data, id_cliente, id_funcionario, valor_total) VALUES 
('2025-06-01', 1, 1, 60.30),
('2025-06-02', 2, 2, 17.00);

-- Itens da venda
INSERT INTO tbl_itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES 
(1, 1, 2, 25.90),
(1, 2, 1, 8.50),
(2, 2, 2, 8.50);
```

---

## ✅ 4. Consultas SQL de Teste

```sql
-- Listar todos os clientes
SELECT * FROM tbl_clientes;

-- Listar todos os produtos
SELECT * FROM tbl_produtos;

-- Listar todos os funcionários
SELECT * FROM tbl_funcionarios;

-- Listar todas as vendas realizadas
SELECT * FROM tbl_vendas;

-- Listar todos os fornecedores
SELECT * FROM tbl_fornecedores;

-- Mostrar os telefones de todos os clientes
SELECT c.nome, t.numero AS telefone
FROM tbl_clientes c
JOIN tbl_telefone_cliente t ON c.id_cliente = t.id_cliente;

-- Mostrar os emails de todos os clientes
SELECT c.nome, e.email
FROM tbl_clientes c
JOIN tbl_email_cliente e ON c.id_cliente = e.id_cliente;

-- Produtos com estoque menor que 10
SELECT nome, estoque FROM tbl_produtos WHERE estoque < 10;

-- Produtos com seus fornecedores
SELECT p.nome AS produto, p.preco, f.nome AS fornecedor
FROM tbl_produtos p
JOIN tbl_fornecedores f ON p.id_fornecedor = f.id_fornecedor;

-- Ver todas as vendas com nome do cliente e funcionário
SELECT v.id_venda, v.data, c.nome AS cliente, f.nome AS funcionario, v.valor_total
FROM tbl_vendas v
JOIN tbl_clientes c ON v.id_cliente = c.id_cliente
JOIN tbl_funcionarios f ON v.id_funcionario = f.id_funcionario;

-- Detalhes dos itens da venda 1
SELECT i.id_venda, p.nome AS produto, i.quantidade, i.preco_unitario,
       (i.quantidade * i.preco_unitario) AS total_item
FROM tbl_itens_venda i
JOIN tbl_produtos p ON i.id_produto = p.id_produto
WHERE i.id_venda = 1;

-- Total de vendas por data
SELECT data, COUNT(id_venda) AS total_vendas, SUM(valor_total) AS valor_total
FROM tbl_vendas
GROUP BY data
ORDER BY data DESC;

-- Total de vendas por funcionário
SELECT f.nome AS funcionario, COUNT(v.id_venda) AS total_vendas, SUM(v.valor_total) AS total_arrecadado
FROM tbl_funcionarios f
LEFT JOIN tbl_vendas v ON f.id_funcionario = v.id_funcionario
GROUP BY f.id_funcionario, f.nome;

-- Total gasto por cliente
SELECT c.nome AS cliente, SUM(v.valor_total) AS total_gasto
FROM tbl_vendas v
JOIN tbl_clientes c ON v.id_cliente = c.id_cliente
GROUP BY c.id_cliente, c.nome
ORDER BY total_gasto DESC;

-- Produtos mais vendidos por quantidade
SELECT p.nome AS produto, SUM(i.quantidade) AS total_vendido
FROM tbl_itens_venda i
JOIN tbl_produtos p ON i.id_produto = p.id_produto
GROUP BY p.id_produto, p.nome
ORDER BY total_vendido DESC;
```

---

## ✅ 5. Exemplo de Solução de Mercado

A empresa **TOTVS** fornece um sistema de gestão chamado **TOTVS Varejo**, que atende supermercados e grandes redes varejistas. Ele oferece:

* Controle de estoque
* Gestão de vendas
* Cadastro de clientes
* Fidelização e integração com sistema fiscal (SAT/ECF)

Isso mostra como um banco de dados bem modelado é essencial para automatizar operações, reduzir perdas e aumentar o relacionamento com o cliente.

---

## ✅ 6. Plano de Ação

**Plano para Implementação:**

1. Criação do banco de dados: executar o modelo físico no MySQL
2. População inicial com dados fictícios
3. Testes com consultas SQL
4. Integração com sistema web (ex: PDV)
5. Validação das entidades e regras de negócio

---

## ✅ 7. Autoavaliação

Durante o desenvolvimento deste estudo de caso, pude aprofundar meu conhecimento em modelagem de dados, principalmente na construção de modelos conceitual, lógico e físico. A maior dificuldade foi entender todas as relações entre as tabelas e garantir que os relacionamentos fossem bem definidos.

Achei interessante perceber como um bom banco de dados pode facilitar a gestão de um supermercado. Se eu pudesse melhorar algo, seria o uso de ferramentas de modelagem gráfica desde o início. Com certeza aplicarei esse aprendizado em projetos futuros e me sinto mais preparado para desafios reais de banco de dados.