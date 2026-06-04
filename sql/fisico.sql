DROP DATABASE IF EXISTS buffet_eventos;
CREATE DATABASE buffet_eventos;
USE buffet_eventos;


/* Lógico_1(Corrijido): */

CREATE TABLE Cliente (
    id_cliente INTEGER AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    telefone VARCHAR(15) NOT NULL
);

CREATE TABLE Evento (
    id_evento INTEGER AUTO_INCREMENT PRIMARY KEY,
    data_evento DATE NOT NULL,
    horario_inicio TIME NOT NULL,
    local VARCHAR(50) NOT NULL,
    status ENUM('Confirmado', 'Pendente', 'Cancelado') NOT NULL,
    n_convidados SMALLINT UNSIGNED NOT NULL,
    horario_fim TIME NOT NULL,
    fk_Cliente_id_cliente INTEGER,
    fk_Cidade_id_cidade INTEGER
);

CREATE TABLE Servico (
    id_servico INTEGER  AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(30) NOT NULL,
    descricao VARCHAR(300),
    preco_base DECIMAL(5,2) UNSIGNED NOT NULL,
    fk_Categoria_id_categoria INTEGER
);

CREATE TABLE Orcamento (
    id_orcamento INTEGER AUTO_INCREMENT PRIMARY KEY,
    valor_total DECIMAL(7,2) UNSIGNED NOT NULL,
    desconto DECIMAL(5,2) UNSIGNED NOT NULL,
    valor_final DECIMAL(7,2) UNSIGNED NOT NULL,
    sinal_pagamento DECIMAL(7,2) UNSIGNED NOT NULL,
    fk_Evento_id_evento INTEGER UNIQUE
);

CREATE TABLE Carrinho (
    id_carrinho INTEGER AUTO_INCREMENT PRIMARY KEY,
    tipo_base VARCHAR(20) NOT NULL,
    capacidade SMALLINT UNSIGNED NOT NULL,
    ativo BOOLEAN NOT NULL
);

CREATE TABLE Categoria (
    nome_categoria VARCHAR(20) NOT NULL,
    descricao VARCHAR(300),
    id_categoria INTEGER AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE Produto (
    id_produto INTEGER AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(30) NOT NULL
);

CREATE TABLE Cidade (
    id_cidade INTEGER AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(30),
    taxa_deslocamento DECIMAL(6,2) UNSIGNED NOT NULL
);

CREATE TABLE Preco_convidado (
    preco_por_pessoa DECIMAL(4,2) UNSIGNED NOT NULL,
    qtd_max_convidados SMALLINT UNSIGNED NOT NULL,
    qtd_min_Convidados SMALLINT UNSIGNED NOT NULL,
    id_preco_convidado INTEGER AUTO_INCREMENT PRIMARY KEY,
    fk_Servico_id_servico INTEGER 
);

CREATE TABLE Terceirizado (
    id_terceirizado INTEGER AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(30) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    trabalho_hora DECIMAL(4,2) UNSIGNED NOT NULL
);

CREATE TABLE EVENTO_CARRINHO (
    FK_Evento_id_evento INTEGER,
    FK_Carrinho_id_carrinho INTEGER,
    PRIMARY KEY (FK_Evento_id_evento, FK_Carrinho_id_carrinho)
);

CREATE TABLE EVENTO_SERVICO (
    FK_Servico_id_servico INTEGER ,
    FK_Evento_id_evento INTEGER,
    quantidade SMALLINT UNSIGNED NOT NULL,
    preco_praticado DECIMAL(6,2) UNSIGNED NOT NULL,
    PRIMARY KEY (FK_Servico_id_servico, FK_Evento_id_evento)
);

CREATE TABLE SERVICO_PRODUTO (
    FK_Produto_id_produto INTEGER,
    FK_Servico_id_servico INTEGER ,
    quantidade_insumo SMALLINT UNSIGNED NOT NULL,
    custo_unitario DECIMAL(4,2) UNSIGNED NOT NULL,
    PRIMARY KEY (FK_Servico_id_servico, FK_Produto_id_produto)
);

CREATE TABLE EVENTO_TERCEIRIZADO (
    FK_Terceirizado_id_terceirizado INTEGER,
    FK_Evento_id_evento INTEGER,
    Custo_mao_de_obra DECIMAL(4,2) UNSIGNED NOT NULL,
    PRIMARY KEY (FK_Terceirizado_id_terceirizado, FK_Evento_id_evento)
);
 
ALTER TABLE Evento ADD CONSTRAINT FK_Evento_2
    FOREIGN KEY (fk_Cliente_id_cliente)
    REFERENCES Cliente (id_cliente)
    ON DELETE RESTRICT;
 
ALTER TABLE Evento ADD CONSTRAINT FK_Evento_3
    FOREIGN KEY (fk_Cidade_id_cidade)
    REFERENCES Cidade (id_cidade);
 
ALTER TABLE Servico ADD CONSTRAINT FK_Servico_3
    FOREIGN KEY (fk_Categoria_id_categoria)
    REFERENCES Categoria (id_categoria);
 
ALTER TABLE Orcamento ADD CONSTRAINT FK_Orcamento_2
    FOREIGN KEY (fk_Evento_id_evento)
    REFERENCES Evento (id_evento)
    ON DELETE CASCADE;
 
ALTER TABLE Preco_convidado ADD CONSTRAINT FK_Preco_convidado_2
    FOREIGN KEY (fk_Servico_id_servico)
    REFERENCES Servico (id_servico);
 
ALTER TABLE EVENTO_CARRINHO ADD CONSTRAINT FK_EVENTO_CARRINHO_1
    FOREIGN KEY (FK_Evento_id_evento)
    REFERENCES Evento (id_evento)
    ON DELETE RESTRICT;
 
ALTER TABLE EVENTO_CARRINHO ADD CONSTRAINT FK_EVENTO_CARRINHO_2
    FOREIGN KEY (FK_Carrinho_id_carrinho)
    REFERENCES Carrinho (id_carrinho)
    ON DELETE RESTRICT;
 
ALTER TABLE EVENTO_SERVICO ADD CONSTRAINT FK_EVENTO_SERVICO_1
    FOREIGN KEY (FK_Servico_id_servico)
    REFERENCES Servico (id_servico)
    ON DELETE RESTRICT;
 
ALTER TABLE EVENTO_SERVICO ADD CONSTRAINT FK_EVENTO_SERVICO_2
    FOREIGN KEY (FK_Evento_id_evento)
    REFERENCES Evento (id_evento)
    ON DELETE RESTRICT;
 
ALTER TABLE SERVICO_PRODUTO ADD CONSTRAINT FK_SERVICO_PRODUTO_1
    FOREIGN KEY (FK_Produto_id_produto)
    REFERENCES Produto (id_produto)
    ON DELETE RESTRICT;
 
ALTER TABLE SERVICO_PRODUTO ADD CONSTRAINT FK_SERVICO_PRODUTO_2
    FOREIGN KEY (FK_Servico_id_servico)
    REFERENCES Servico (id_servico)
    ON DELETE RESTRICT;
 
ALTER TABLE EVENTO_TERCEIRIZADO ADD CONSTRAINT FK_EVENTO_TERCEIRIZADO_1
    FOREIGN KEY (FK_Terceirizado_id_terceirizado)
    REFERENCES Terceirizado (id_terceirizado)
    ON DELETE RESTRICT;
 
ALTER TABLE EVENTO_TERCEIRIZADO ADD CONSTRAINT FK_EVENTO_TERCEIRIZADO_2
    FOREIGN KEY (FK_Evento_id_evento)
    REFERENCES Evento (id_evento)
    ON DELETE RESTRICT;

USE buffet_eventos;

/* =========================================================
   POVOAMENTO DO BANCO - 10 REGISTROS
========================================================= */

/* =========================
   CLIENTE
========================= */
INSERT INTO Cliente (nome, telefone)
VALUES
('Maria Silva', '77999990001'),
('João Souza', '77999990002'),
('Ana Oliveira', '77999990003'),
('Carlos Pereira', '77999990004'),
('Fernanda Lima', '77999990005'),
('Lucas Santos', '77999990006'),
('Patricia Alves', '77999990007'),
('Ricardo Gomes', '77999990008'),
('Juliana Costa', '77999990009'),
('Bruno Rocha', '77999990010');

/* =========================
   CIDADE
========================= */
INSERT INTO Cidade (nome, taxa_deslocamento)
VALUES
('Vitória da Conquista', 50.00),
('Barra do Choça', 30.00),
('Itapetinga', 80.00),
('Poções', 60.00),
('Planalto', 40.00),
('Jequié', 90.00),
('Itambé', 70.00),
('Brumado', 120.00),
('Guanambi', 150.00),
('Ilhéus', 200.00);

/* =========================
   CATEGORIA
========================= */
INSERT INTO Categoria (nome_categoria, descricao)
VALUES
('Bebidas', 'Serviços de bebidas e drinks'),
('Sobremesas', 'Serviços doces e sobremesas'),
('Salgados', 'Lanches e refeições'),
('Infantil', 'Serviços voltados para crianças'),
('Corporativo', 'Serviços para empresas');

/* =========================
   SERVICO
========================= */
INSERT INTO Servico (
nome,
descricao,
fk_Categoria_id_categoria
)
VALUES
('Bar de Drinks', 'Drinks alcoólicos e não alcoólicos', 1),
('Coffee Break Executivo', 'Coffee break para empresas', 5),
('Açaí Premium', 'Estação completa de açaí', 2),
('Sorvete Tropical', 'Ilha de sorvetes', 2),
('Churros Fest', 'Churros recheados', 2),
('Hambúrguer Artesanal', 'Mini hambúrguer gourmet', 3),
('Pizza Express', 'Rodízio de pizza', 3),
('Crepe Gourmet', 'Crepes doces e salgados', 3),
('Algodão Doce Kids', 'Algodão doce colorido', 4),
('Pipoca Gourmet', 'Pipocas especiais', 4);

/* =========================
   PRECO_CONVIDADO
========================= */
INSERT INTO Preco_convidado (
preco_por_pessoa,
qtd_max_convidados,
qtd_min_Convidados,
fk_Servico_id_servico
)
VALUES
(15.00, 50, 1, 1),
(12.00, 100, 51, 1),
(18.00, 50, 1, 2),
(15.00, 100, 51, 2),
(20.00, 50, 1, 3),
(17.00, 100, 51, 3),
(25.00, 50, 1, 4),
(22.00, 100, 51, 4),
(30.00, 50, 1, 5),
(28.00, 100, 51, 5);

/* =========================
   PRODUTO
========================= */
INSERT INTO Produto (nome)
VALUES
('Leite Condensado'),
('Granola'),
('Morango'),
('Vodka'),
('Leite'),
('Chocolate'),
('Refrigerante'),
('Queijo'),
('Presunto'),
('Café');

/* =========================
   CARRINHO
========================= */
INSERT INTO Carrinho (
tipo_base,
capacidade,
ativo
)
VALUES
('Pequeno', 50, TRUE),
('Pequeno', 50, TRUE),
('Pequeno', 50, FALSE),
('Medio', 100, TRUE),
('Medio', 100, TRUE),
('Medio', 100, TRUE),
('Grande', 200, TRUE),
('Grande', 200, TRUE),
('Grande', 250, FALSE),
('Grande', 300, TRUE);

/* =========================
   TERCEIRIZADO
========================= */
INSERT INTO Terceirizado (nome, telefone, trabalho_hora)
VALUES
('Carlos Drinks', '77999991111', 50.00),
('Pedro Garçom', '77999992222', 40.00),
('Lucas Bartender', '77999993333', 60.00),
('Rafael Cozinheiro', '77999994444', 55.00),
('Thiago Eventos', '77999995555', 45.00),
('Marcos Buffet', '77999996666', 70.00),
('Felipe Chef', '77999997777', 65.00),
('André Garçom', '77999998888', 50.00),
('Diego Drinks', '77999999999', 75.00),
('Paulo Churrasqueiro', '77999990000', 80.00);

/* =========================
   EVENTO
========================= */
INSERT INTO Evento (
data_evento,
horario_inicio,
local,
status,
n_convidados,
horario_fim,
fk_Cliente_id_cliente,
fk_Cidade_id_cidade
)
VALUES
('2026-06-10', '18:00:00', 'Salão Imperial', 'Confirmado', 120, '23:00:00', 1, 1),
('2026-07-15', '19:00:00', 'Espaço Fest', 'Confirmado', 80, '00:00:00', 2, 2),
('2026-08-20', '17:00:00', 'Chácara Verde', 'Pendente', 150, '22:00:00', 3, 3),
('2026-09-05', '18:30:00', 'Buffet Real', 'Confirmado', 90, '23:30:00', 4, 4),
('2026-10-11', '16:00:00', 'Área Vip', 'Cancelado', 60, '21:00:00', 5, 5),
('2026-11-01', '20:00:00', 'Casa de Eventos', 'Confirmado', 200, '02:00:00', 6, 6),
('2026-11-15', '15:00:00', 'Espaço Kids', 'Pendente', 70, '20:00:00', 7, 7),
('2026-12-03', '19:30:00', 'Salão Ouro', 'Pendente', 110, '00:30:00', 8, 8),
('2026-12-20', '18:00:00', 'Fazenda Bela Vista', 'Cancelado', 180, '01:00:00', 9, 9),
('2026-12-31', '21:00:00', 'Clube Central', 'Confirmado', 250, '05:00:00', 10, 10);

/* =========================
   ORCAMENTO
========================= */
INSERT INTO Orcamento (
valor_total,
desconto,
valor_final,
sinal_pagamento,
fk_Evento_id_evento
)
VALUES
(3000.00, 200.00, 2800.00, 1000.00, 1),
(2500.00, 100.00, 2400.00, 800.00, 2),
(5000.00, 500.00, 4500.00, 1500.00, 3),
(3500.00, 0, 3500.00, 1000.00, 4),
(2000.00, 150.00, 1850.00, 700.00, 5),
(7000.00, 700.00, 6300.00, 2500.00, 6),
(2800.00, 200.00, 2600.00, 900.00, 7),
(4200.00, 350.00, 3850.00, 1200.00, 8),
(6500.00, 500.00, 6000.00, 2000.00, 9),
(9000.00, 1000.00, 8000.00, 3000.00, 10);

/* =========================
   EVENTO_CARRINHO
========================= */
INSERT INTO EVENTO_CARRINHO
VALUES

(1,1),
(2,4),
(2,5),
(3,2),
(4,7),
(4,8),
(5,4),
(6,7),
(6,10),
(7,2),
(8,8),
(8,10),
(9,5),
(10,7),
(10,8),
(10,10);

/* =========================
   EVENTO_SERVICO
========================= */
INSERT INTO EVENTO_SERVICO
(FK_Servico_id_servico, FK_Evento_id_evento,
quantidade, preco_praticado)
VALUES

(3,1,120,14.00),
(10,1,120,8.00),
(1,2,80,18.00),
(6,2,80,20.00),
(8,3,150,17.00),
(6,4,90,25.00),
(7,4,90,22.00),
(2,5,60,15.00),
(1,6,200,20.00),
(6,6,200,22.00),
(7,6,200,25.00),
(9,7,70,10.00),
(3,8,110,14.00),
(4,8,110,12.00),
(5,9,180,18.00),
(2,10,250,18.00),
(1,10,250,20.00);

/* =========================
   SERVICO_PRODUTO
========================= */
INSERT INTO SERVICO_PRODUTO (
FK_Produto_id_produto,
FK_Servico_id_servico,
quantidade_insumo,
custo_unitario
)
VALUES
(1,1,10,8.00),
(2,1,5,12.00),
(3,1,20,15.00),
(4,2,8,40.00),
(5,3,10,6.00),
(6,4,15,10.00),
(7,5,30,7.00),
(8,6,12,20.00),
(9,7,8,5.00),
(10,10,20,18.00);

/* =========================
   EVENTO_TERCEIRIZADO
========================= */
INSERT INTO EVENTO_TERCEIRIZADO
(FK_Terceirizado_id_terceirizado,
FK_Evento_id_evento,
Custo_mao_de_obra)
VALUES

(1,2,300.00),
(2,2,250.00),
(3,4,500.00),
(4,6,700.00),
(5,6,600.00),
(6,6,550.00),
(7,8,450.00),
(8,10,600.00),
(9,10,500.00);
