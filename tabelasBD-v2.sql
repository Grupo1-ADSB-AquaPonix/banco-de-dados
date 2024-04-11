create database projeto;
use projeto;

create table usuario(
idUsuario int primary key auto_increment not null,
nome varchar(45) not null,
email varchar(45) not null,
cpf char(14) unique not null,
telefone varchar(20) not null,
senha varchar(40) not null,
cep char(9),
numero varchar(10),
complemento varchar(45)
);

create table tanque(
idTanque int primary key auto_increment not null,
qtdLitros int not null,
qtdPeixes int not null,
fkUsuario int not null,
constraint fkTanqueUsuario foreign key (fkUsuario)
	references usuario(idUsuario)
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

insert into usuario values
(default, 'Ronaldo', 'ronaldo.fenomeno@gmail.com', '774.874.574-15', '11-955419758', 'ronaldo123', '18079-630', '155', 'Apto. 109'),
(default, 'Adalberto', 'adalberto.beto@gmail.com', '125.351.241-16', '11-925621262', 'betinho125', '29844-895', '812', 'Próximo ao bar do zé'),
(default, 'Marcos', 'marcao777@gmail.com', '541.635.825-12', '11-974875223', 'marcasso78', '54897-544', '411', 'Casa cinza');

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

select * from usuario;
select * from tanque;
select * from horta;
select * from sensor;