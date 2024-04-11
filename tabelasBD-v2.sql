create database projeto;
use projeto;

create table endereco(
idEndereco int primary key auto_increment not null,
cep char(9) not null,
numero varchar(10) not null,
complemento varchar(45) not null
);

create table empresa(
idEmpresa int primary key auto_increment not null,
nome varchar(45) not null,
cnpj char(18) unique not null,
email varchar(45) not null,
telefoneCelular varchar(20) not null,
telefoneFixo varchar(10),
senha varchar(30) not null
);

create table funcionario(
idUsuario int primary key auto_increment not null,
nome varchar(45) not null,
email varchar(45) not null,
cpf char(11) not null,
telefone varchar(20),
senha varchar(40),
fkEmpresa int
);

create table tanque(
idTanque int primary key auto_increment not null,
qtdLitros int not null,
qtdPeixes int not null,
fkEmpresa int not null,
constraint fkTanqueEmpresa foreign key (fkEmpresa)
	references empresa(idEmpresa)
);

create table horta(
idHorta int primary key auto_increment not null,
nomeVegetal varchar(40) not null,
qtdPlantada int not null,
fkTanque int,
constraint fkTanqueHorta foreign key (fkTanque)
	references tanque(idTanque)
);

create table sensor(
idSensor int primary key auto_increment not null,
nome varchar(5) not null,
constraint chkNomeSensor check (nome in('LM35', 'LDR')),
tipo varchar(12) not null,
constraint chkTipoSensor check (tipo in('Temperatura', 'Luminosidade')),
temperatura float,
luminosidade float,
fkTanque int,
constraint fkTanqueSensor foreign key (fkTanque)
	references tanque(idTanque),
fkHorta int,
constraint fkHortaSensor foreign key (fkHorta)
	references horta(idHorta)
);

insert into endereco values
(default, '18079-630', '155', 'Proximo ao mercado extra'),
(default, '29844-895', '812', 'Ao lado da concessionária'),
(default, '54897-544', '411', 'Em frente do Burguer King');

insert into empresa values
(default, 'Ronaldo', '27.480.347/0001-35','ronaldo.fenomeno@gmail.com', '11-955419758', 'ronaldo123', 1),
(default, 'Adalberto', '66.835.460/0001-48','adalberto.beto@gmail.com', '11-925621262', 'betinho125', 2),
(default, 'Marcos', '85.740.687/0001-54','marcao777@gmail.com', '11-974875223', 'marcasso78', 3);

insert into tanque values 
(default, 1000, 35, 1),
(default, 1000, 30, 2),
(default, 1500, 45, 3);

insert into horta values
(default, 'Alface', 20, 1),
(default, 'Couve', 25, 2),
(default, 'Coentro', 20, 3);

insert into sensor values
(default, 'LM35', 'Temperatura', 25.7, null, 1, null),
(default, 'LM35', 'Temperatura', 26.5, null, 2, null),
(default, 'LM35', 'Temperatura', 24.2, null, 3, null),
(default, 'LDR', 'Luminosidade', null, 485, null, 1),
(default, 'LDR', 'Luminosidade', null, 655, null, 2),
(default, 'LDR', 'Luminosidade', null, 844, null, 3);

select * from empresa;
select * from tanque;
select * from horta;
select * from sensor;