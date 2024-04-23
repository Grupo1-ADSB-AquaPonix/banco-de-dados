create database projeto;

use projeto;

create table endereco(
idEndereco int primary key auto_increment not null,
cep varchar(9) not null,
numero int not null,
complemento varchar(45) not null
);

create table empresa(
idEmpresa int primary key auto_increment not null,
razaoSocial varchar(45) not null,
cnpj varchar(18) unique not null,
email varchar(45) not null,
telefoneCelular varchar(20),
telefoneFixo varchar(20),
senha varchar(30) not null,
fkEndereco int,
constraint fkEmpresaEndereco foreign key (fkEndereco)
	references endereco (idEndereco)
);

create table funcionario(
idFuncionario int primary key auto_increment not null,
nome varchar(45) not null,
email varchar(45) not null,
telefoneCelular varchar(20),
senha varchar(30),
fkEmpresa int,
constraint fkFuncionarioEmpresa foreign key (fkEmpresa)
	references empresa (idEmpresa)
);

create table tanque(
idTanque int primary key auto_increment not null,
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

create table sensor(
idSensor int primary key auto_increment not null,
nome varchar(4) not null,
constraint chkNomeSensor check (nome in('LM35', 'LDR')),
tipo varchar(12) not null,
constraint chkTipoSensor check (tipo in('Temperatura', 'Luminosidade')),
fkTanque int,
constraint fkTanqueSensor foreign key (fkTanque)
	references tanque (idTanque),
fkHorta int,
constraint fkHortaSensor foreign key (fkHorta)
	references horta(idHorta)
);

create table dados(
idDado int,
fkSensor int, 
constraint pkDadosSensor primary key (idDado, fkSensor),
temperatura float,
luminosidade int,
dtColeta datetime,
constraint fkDadosSensor foreign key (fkSensor)
	references sensor (idSensor)
);

insert into endereco values
(default, '18079-630', '155', 'Proximo ao mercado extra'),
(default, '29844-895', '812', 'Ao lado da concessionária'),
(default, '54897-544', '411', 'Em frente do Burguer King');

insert into empresa values
(default, 'AquaCulture Connections', '27.480.347/0001-35','AquaCulture@gmail.com', '11-955419758', '11-955419758', 'cultureAqua#', 1),
(default, 'Sustainable AquaGrow', '66.835.460/0001-48','AquaGrow@gmail.com', '11-925621262', '11-955419758', 'subtainable!', 2),
(default, 'AquaVida Solutions', '85.740.687/0001-54','AquaVida.Solutions@gmail.com', '11-974875223', '11-955419758', 'aquaVida!@', 3);

insert into funcionario values
	(default, 'Pedro Rocha', 'pedroRocha@gmail.com', '11 90001-1234', '120932!', 1),
	(default, 'Gustavo Barreto', 'GustavoBarreto@gmail.com', '11 91234-4321', 'barreto@', 2),
	(default, 'Paula Fernandes', 'contato.Paula@gmail.com', '11 90909-8799', '391238##', 2),
	(default, 'Ronaldo', 'ronaldo.fenomeno@gmail.com', '11 97878-9874', '2dawrROnil@', 3);
    
insert into tanque values 
(default, 1000, 35, 1),
(default, 1000, 30, 2),
(default, 1500, 45, 3);

insert into horta values
(1, 1, 'Alface', 20),
(1, 2, 'Couve', 25),
(1, 3, 'Coentro', 20);

insert into sensor(nome, tipo, fkTanque) values
('LM35', 'Temperatura', 1),
('LM35', 'Temperatura', 2),
('LM35', 'Temperatura', 3);
            
insert into sensor(nome, tipo, fkTanque, fkHorta) values
('LDR', 'Luminosidade', 1, 1),
('LDR', 'Luminosidade', 2, 1),
('LDR', 'Luminosidade', 3, 1);
          
insert into dados values 
(1, 1, 16.5, 200, '2024-04-19 20:00:00'),
(1, 2, 18.5, 150, '2024-04-19 20:00:00'),
(1, 3, 19.5, 157, '2024-04-19 20:00:00'),
(2, 1, 17.5, 325, '2024-04-19 21:00:00'),
(2, 2, 18, 244, '2024-04-19 21:00:00'),
(2, 3, 18.5, 115, '2024-04-19 21:00:00'),
(3, 1, 15.5, 400, '2024-04-19 22:00:00'),
(3, 2, 16, 287, '2024-04-19 22:00:00'),
(3, 3, 15.5, 265, '2024-04-19 22:00:00');

select * from empresa;
select * from tanque;
select * from horta;
select * from sensor;
select * from funcionario;
select * from dados;

<<<<<<< HEAD
-- Select para ver quais funcionários trabalham em quais empresas
select     funcionario.idFuncionario as IDFuncionario,
=======
  -- Select para ver quais funcionários trabalham em quais empresas -- 
  
select empresa.idEmpresa as IDEmpresa, 
	empresa.nome as Empresa,
	empresa.cnpj as CNPJ,
    empresa.email as Email,
    funcionario.idFuncionario as IDFuncionario,
>>>>>>> 175f22e3e3318c760d6bd598c64b7d977eb436dd
    funcionario.nome as Funcionario,
    funcionario.email as 'Email Funcionario',
    funcionario.telefoneCelular as 'Telefone Funcionário',
    empresa.idEmpresa as IDEmpresa, 
	empresa.razaoSocial as Empresa,
	empresa.cnpj as CNPJ,
    empresa.email as Email
    from empresa join funcionario
    on empresa.idEmpresa = funcionario.fkEmpresa;
    
-- Select para ver os tanques e hortas de cada empresa --

select empresa.idEmpresa as IDEmpresa, 
	empresa.razaoSocial as Empresa,
	empresa.cnpj as CNPJ,
    empresa.email as Email,
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
    
<<<<<<< HEAD
-- Select para ver os dados de temperatura dos tanques
=======
    
-- Select para ver os dados de temperatura dos tanques -- 

>>>>>>> 175f22e3e3318c760d6bd598c64b7d977eb436dd
select tanque.idTanque as Tanque,
	tanque.qtdPeixes as QTDPeixes,
    sensorTanque.nome as 'Nome Sensor Tanque',
    sensorTanque.tipo as 'Tipo Sensor Tanque',
    dados.temperatura as Temperatura,
    dados.dtColeta as 'Data de Coleta'
    from tanque join sensor as sensorTanque
    on tanque.idTanque = sensorTanque.fkTanque
    join dados 
    on sensorTanque.idSensor = dados.fkSensor;

-- Select para ver os dados de luminosidade das hortas -- 

select horta.idHorta as Horta,
	tanque.idTanque as Tanque,
	horta.nomeVegetal as 'Nome do Vegetal',
    sensorHorta.nome as 'Nome Sensor Tanque',
    dados.luminosidade as 'Luminosidade',
    dados.dtColeta as 'Data de Coleta'
    from horta join sensor as sensorHorta
    on horta.fkTanque = sensorHorta.fkTanque
    join dados 
    on dados.fkSensor = sensorHorta.idSensor
    join tanque 
    on tanque.idTanque = horta.fkTanque;