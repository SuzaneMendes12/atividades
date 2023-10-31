-- AULA 11 RELACIONAMENTO N PARA N
-- conceito de tabela associativa 

-- N para M a tabela que se cria chama tabela associativa ela une as duas tabelas 
-- repetir a chave primaria - ex paciente precisa voltar no mesmo medico mas n pode repetir a pk  ent dar um id pra tabela consulta
-- todo relacionamento fraco a fk é chave primaria 
-- chave primaria no datetime é quando nao podemos fazer algo no mesmo horario e pk n pode se repeir.


create database consultaMedica;
use consultaMedica;

create table paciente (
idPaciente int primary key auto_increment,
nome varchar (45));

insert into paciente (nome) values 
('chuck'),
('Jason'),
('Freira');

create table medico (
idMedico int primary key auto_increment,
nome varchar(45),
salario decimal(10,2)) auto_increment = 100;

insert into medico (nome,salario) values
('Bonnie',100.99),
('Freddy',500.99),
('Foxy',1000.99);

select * from paciente;
select * from medico;


-- criar tabela associativa para unir as duas tabelas
-- constraint garante a integridade do banco para nao ficar inserindo dados aleatorios somene os dados que estao na tabelas referenciadas
-- so cria auto incremetn co  a chave primaria com uma unica coluna ent em chave primaria composta nao da
-- conceito de chave primaria composta tenho 3 campos e esses 3 campos nao podem se repetir 


create table consulta (
idConsulta int,
fkPaciente int,
fkMedico int,
primary key (idConsulta, fkPaciente, fkMedico),
dtConsulta datetime,
constraint fkPacCons foreign key (fkPaciente) references paciente (idPaciente),
constraint fkMedCons foreign key (fkMedico) references medico (idMedico));

insert into consulta values 
(1,1,100,'2023-10-31 8:00:00'),
(2,1,100,'2023-11-07 8:00:00'),
(1,2,101,'2023-10-31 8:00:00'),
(1,1,101,'2023-10-31 11:00:00');

select * from consulta;

select paciente.nome as Paciente, medico.nome as Medico, consulta.dtConsulta as Consulta from paciente join Consulta on idPaciente = fkPaciente
join medico on idMedico = fkMedico;

-- se quiser mostrar so as consultas de hj 

select paciente.nome as Paciente, medico.nome as Medico, consulta.dtConsulta as Consulta from paciente join Consulta on idPaciente = fkPaciente
join medico on idMedico = fkMedico where dtConsulta like '2023-10-31%';





