create database vendas;
use vendas;

create table clientes (
idClientes int primary key auto_increment,
nome varchar(45),
email varchar (45),
endereço varchar (45),
fkIndicados int,
constraint fkInd foreign key (fkIndicados) references clientes (idClientes));

insert into clientes values
(null,'jose','jose@gmail.com','rua da saudade 123 guainases',null),
(null,'maria','maria@gmail.com','rua sao joao 43 tatuape',1),
(null,'flavia','flavia@gmail.com','rua jiparana 776 itaquera',2);

select * from clientes;

create table vendas (
idVendas int primary key auto_increment,
totalVenda decimal(5,2),
dtVenda datetime,
fkClientes int,
constraint fkCli foreign key (fkClientes) references clientes (idClientes));

insert into vendas values 
(null,200,'2023-10-31 9:00:00',1),
(null,300,'2023-10-31 14:00:00',1),
(null,500,'2023-10-31 10:00:00',2),
(null,400,'2023-10-31 15:00:00',2),
(null,600,'2023-10-31 11:00:00',3),
(null,300,'2023-10-31 17:00:00',3);

select * from vendas;

create table produto (
idProduto int primary key auto_increment,
nome varchar(45),
descricao varchar(45),
preco decimal(5,2));

insert into produto values 
(null,'Short','short para muay thai','200'),
(null,'luva ','Luva bate saco','300'),
(null,'caneleira','caneleira para sparring','500'),
(null,'croang','cordão indicando a graduação','400'),
(null,'aparador top king','aparador profissional para treino','600'),
(null,'luva kings', 'luva intermediario profissional','300');


select * from produto;

create table historico_de_vendas (
idHistorico int,
fkVenda int,
fkProduto int,
primary key (idHistorico, fkVenda, fkProduto),
qtdvendida int,
valorDesc decimal (5,2),
constraint fkHisVen foreign key (fkVenda) references vendas (idVendas),
constraint fkHisProd foreign key (fkProduto) references produto (idProduto));

insert into historico_de_vendas values
(1,1,1,2,'50.00'),
(2,2,2,1,'00.00'),
(3,3,3,1,'10.00'),
(4,1,4,1,'5.00'),
(5,2,5,2,'20.00'),
(6,3,6,1,'30.00');

select * from historico_de_vendas;

select   cli.* ,  vend.* from clientes as cli join vendas as vend on idClientes = fkClientes;

--  Exibir os dados dos clientes e os dados de suas respectivas vendas
select clientes.nome as cliN, clientes.email as clie, clientes.endereço as cliEnd, 
vendas.totalVenda as TotalV , vendas.dtVenda as dataV 
from clientes join vendas on idClientes = fkClientes;

-- Exibir os dados de um determinado cliente (informar o nome do cliente na consulta) 
-- e os dados de suas respectivas vendas.
select clientes.nome as cliN, clientes.email as clie, clientes.endereço as cliEnd, 
vendas.totalVenda as TotalV , vendas.dtVenda as dataV 
from clientes join vendas on idClientes = fkClientes where nome like 'flavia%';

-- Exibir os dados dos clientes e de suas respectivas indicações de clientes.

select * from clientes as Cli join clientes as Cliindicador on cli.fkIndicados = Cliindicador.idClientes;

--  Exibir os dados dos clientes indicados e os dados dos respectivos clientes indicadores, porém somente 
-- de um determinado cliente indicador (informar o nome  do cliente que indicou na consulta)

select * from clientes as Cli join clientes as Cliindicador on cli.fkIndicados = Cliindicador.idClientes
where Cliindicador.nome = 'maria';

--  Exibir os dados dos clientes, os dados dos respectivos clientes que indicaram, os 
-- dados das respectivas vendas e dos produtos

select * from clientes as cli 
join clientes as cliindicador on cli.fkindicados = cliindicador.idclientes
join vendas as venda on venda.fkClientes = cli.idClientes
join historico_de_vendas on fkVenda =idVendas
join produto on fkProduto = idProduto;

-- Exibir apenas a data da venda, o nome do produto e a quantidade do produto  numa determinada venda.

select vendas.dtVenda, produto.nome, historico_de_vendas.qtdVendida from vendas
join historico_de_vendas on fkVenda = idVendas
join produto on fkProduto = idProduto 
where idVendas like 1;


