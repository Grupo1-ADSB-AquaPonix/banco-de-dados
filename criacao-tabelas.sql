create database projeto;
use projeto;

create table endereco(
idEndereco int primary key auto_increment not null,
cep char(9) not null,
numero int not null,
complemento varchar(45) not null
);

create table empresa(
idEmpresa int primary key auto_increment not null,
razaoSocial varchar(45) not null,
cnpj char(18) unique not null,
telefoneCelular varchar(20),
telefoneFixo varchar(20),
senha varchar(30) not null,
fkEndereco int,
constraint fkEmpresaEndereco foreign key (fkEndereco)
	references endereco (idEndereco)
);

create table funcionario(
idFuncionario int,
fkEmpresa int,
constraint pkFuncionarioEmpresa primary key (idFuncionario, fkEmpresa),
nome varchar(45) not null,
email varchar(45) not null,
cpf char(11) unique not null,
telefoneCelular varchar(20),
senha varchar(30),
constraint fkFuncionarioEmpresa foreign key (fkEmpresa)
	references empresa (idEmpresa)
);

create table tanque(
idTanque int primary key auto_increment,
qtdLitros int not null,
qtdPeixes int not null,
fkEmpresa int not null,
constraint fkTanqueEmpresa foreign key (fkEmpresa)
	references empresa (idEmpresa)
);

create table horta(
idHorta int,
fkTanque int,
constraint pkHortaTanque primary key (idHorta, fkTanque),
nomeVegetal varchar(40) not null,
qtdPlantada int not null,
constraint fkHortaTanque foreign key (fkTanque)
	references tanque(idTanque)
);

create table sensor_tanque(
idSensor int primary key auto_increment,
nome varchar(5),
tipo varchar(12),
fkTanque int,
constraint fkTanqueSensor foreign key (fkTanque)
	references tanque(idTanque),
constraint tpSensorTanque check (nome = 'LM35')
);

create table sensor_horta(
idSensor int primary key auto_increment,
nome varchar(5),
tipo varchar(12),
fkHorta int,
fkTanque int,
constraint fkHortaSensor foreign key (fkHorta)
	references horta(idHorta),
constraint fkTanqueHorta foreign key (fkTanque)
	references tanque(idTanque),
constraint tpSensorHorta check (nome = 'LDR')
);

create table dados(
	idDado int,
    fkSensorTanque int,
    fkSensorHorta int,
    constraint pkDadosSensores primary key (idDado, fkSensorTanque, fkSensorHorta),
    temperatura float(5,2),
    luminosidade int,
    dtColeta datetime default current_timestamp
);

create unique index pkCompostaDados on dados(idDado, fkSensorTanque, fkSensorHorta);

insert into endereco values
(default, '18079-630', '155', 'Proximo ao mercado extra'),
(default, '29844-895', '812', 'Ao lado da concessionária');

insert into empresa values
(default, 'AquaCulture Connections', '27.480.347/0001-35', '11-955419758', '11-955419758', 'ronaldo123', 1),
(default, 'Sustainable AquaGrow', '66.835.460/0001-48', '11-925621262', '11-955419758', 'betinho125', 2);

insert into funcionario values
(1, 1, 'Pedro Rocha', 'pedroRocha@gmail.com', '12312312300', '11 90001-1234', '12345678'),
(2, 1, 'Gustavo Barreto', 'GustavoBarreto@gmail.com', '99999999999', '11 91234-4321', '987654321'),
(1, 2, 'Paula Fernandes', 'contato.Paula@gmail.com', '32132132199', '11 90909-8799', '147258369'),
(2, 2, 'Ronaldo', 'ronaldo.fenomeno@gmail.com', '22222288800', '11 97878-9874', '1010101010');

insert into tanque values
(default, 1000, 10, 1),
(default, 1000, 10, 1),
(default, 1000, 10, 2);
    
insert into horta values
(1, 1, 'Alface', '25'),
(1, 2, 'Cenoura', '25'),
(1, 3, 'Quiabo', '25');

insert into sensor_tanque values
(default, 'LM35', 'Temperatura', 1),
(default, 'LM35', 'Temperatura', 2),
(default, 'LM35', 'Temperatura', 3);

insert into sensor_horta values
(default, 'LDR', 'Luminosidade', 1, 1),
(default, 'LDR', 'Luminosidade', 1, 2),
(default, 'LDR', 'Luminosidade', 1, 3);

insert into dados values 
(1, 1, 1, 16.5, 230, '2024-04-19 20:00:00'),
(2, 1, 1, 18.5, 220, '2024-04-19 21:00:00'),
(3, 1, 1, 19.5, 245, '2024-04-19 22:00:00'),
(4, 1, 1, 17.5, 310, '2024-04-19 23:00:00'),
(1, 2, 2, 18, 290, '2024-04-19 20:00:00'),
(2, 2, 2, 18.5, 278, '2024-04-19 21:00:00'),
(3, 2, 2, 15.5, 270, '2024-04-19 22:00:00'),
(1, 3, 3, 16, 280, '2024-04-19 20:00:00'),
(2, 3, 3, 15.5, 300, '2024-04-19 21:00:00');

select * from empresa;
select * from tanque;
select * from horta;
select * from sensor;
select * from funcionario;
select * from dados;

-- Select para ver quais funcionários trabalham em quais empresas
  
select empresa.idEmpresa as IDEmpresa, 
	empresa.razaoSocial as Empresa,
	empresa.cnpj as CNPJ,
    funcionario.idFuncionario as IDFuncionario,
    funcionario.nome as Funcionario,
    funcionario.email as 'Email Funcionario',
    funcionario.telefoneCelular as 'Telefone Funcionário'
    from empresa join funcionario
    on empresa.idEmpresa = funcionario.fkEmpresa;
    
-- Select para ver os tanques e hortas de cada empresa
select empresa.idEmpresa as IDEmpresa, 
	empresa.razaoSocial as Empresa,
	empresa.cnpj as CNPJ,
    tanque.idTanque as IDTanque,
    tanque.qtdLItros as QTDlitros,
    tanque.qtdPeixes as QTDpeixes,
    horta.idHorta as IDHorta,
    horta.nomeVegetal as 'Nome Vegetal',
    horta.nomeVegetal as qtdPlantada
    from empresa join tanque
    on empresa.idEmpresa = tanque.fkEmpresa
    join horta
    on tanque.idTanque = horta.fkTanque;