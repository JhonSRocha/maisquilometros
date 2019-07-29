create database mais_quilometros
go

use mais_quilometros

create table empresa(
	idEmpresa int primary key IDENTITY,
	nomeEmpresa varchar(100),
	seguimentoEmpresa varchar(50)
);
go

create table cliente(
	idCliente int primary key IDENTITY,
	nomeCliente varchar(100),
	generoCliente varchar(9) CHECK(generoCliente IN('Masculino', 'Feminino')),
	cpfCliente varchar(11),
	senhaCliente varchar(20),
	nascimentoCliente DATE,
	emailCliente varchar(50)
);
go

create table endereco(
	idEndereco int primary key IDENTITY,
	cepEndereco varchar(8),
	ufEndereco varchar(100) CHECK(ufEndereco IN('Acre','Alagoas','Amapá','Amazonas','Bahia','Ceará','Distrito Federal','Espírito Santo','Goiás','Maranhão','Mato Grosso','Mato Grosso do Sul','Minas Gerais','Pará','Paraíba','Paraná','Pernambuco','Piauí','Rio de Janeiro','Rio Grande do Norte','Rio Grande do Sul','Rondônia','Roraima','Santa Catarina','São Paulo','Sergipe','Tocantins')),
	cidadeEndereco varchar(100),
	bairroEndereco varchar(100),
	logradouroEndereco varchar(100),
	numeroEndereco varchar(10),
	complementoEndereco varchar(50),
	empresa_idEmpresa int unique,
	cliente_idCliente int unique
);
go

alter table endereco
add constraint fk_endereco_idCliente
foreign key (cliente_idCliente)
references cliente(idCliente)
go

alter table endereco
add constraint fk_endereco_idEmpresa
foreign key (empresa_idEmpresa)
references empresa(idEmpresa)
go

create table telefone(
	idTelefone int primary key IDENTITY,
	tipoTelefone varchar(11) check(tipoTelefone in('Residencial', 'Comercial', 'Celular')),
	numeroTelefone varchar(11),
	empresa_idEmpresa int unique,
	cliente_idCliente int unique
);
go

alter table telefone
add constraint fk_telefone_idCliente
foreign key (cliente_idCliente)
references cliente(idCliente)
go

alter table telefone
add constraint fk_telefone_idEmpresa
foreign key (empresa_idEmpresa)
references empresa(idEmpresa)
go

create table mecanico(
	idMecanico int primary key IDENTITY,
	nomeMecanico varchar(100),
	cpfMecanico varchar(11),
	especialidadeMecanico varchar(50),
	empresa_idEmpresa int unique
);
go

alter table mecanico
	add constraint fk_mecanico_idEmpresa
	foreign key (empresa_idEMpresa)
	references empresa(idEmpresa)
go

create table agenda(
	idAgenda int primary key IDENTITY,
	dataAgenda date,
	empresa_idEmpresa int unique
);
go

alter table agenda
add constraint fk_agenda_idEmpresa
foreign key (empresa_idEmpresa)
references empresa(idEmpresa)
go

create table horario(
	idHorario int primary key IDENTITY,
	inicioHorario time,
	fimHorario time,
	situacaoHorario int, /*Arrumar depois*/
	agenda_idAgenda int unique
);
go

alter table horario
	add constraint fk_horario_idAgenda
	foreign key (agenda_idAgenda)
	references agenda(idAgenda)
go

create table veiculo(
	idVeiculo int primary key IDENTITY,
	placaVeiculo varchar(7),
	tipoVeiculo int, /*Arrumar depois*/
	corVeiculo varchar(20),
	chassiVeiculo varchar(50),
	cliente_idCliente int unique
);
go

alter table veiculo
	add constraint fk_veiculo_idCliente
	foreign key (cliente_idCliente)
	references cliente(idCliente)
go

create table modelo(
	idModelo int primary key identity,
	anoModelo varchar(4),
	fabricacaoModelo varchar(4),
	marcaModelo varchar(20),
	nomeModelo varchar(20),
	veiculo_idVeiculo int unique
);
go

alter table modelo
	add constraint fk_modelo_idVeiculo
	foreign key (veiculo_idVeiculo)
	references veiculo(idVeiculo)
go

create table manutencao(
	idManutencao int primary key identity,
	situacaoManutencao int, /*Arrumar depois*/
	servicoManutencao varchar(100),
	horaManutencao time,
	dataManutencao date,
	veiculo_idVeiculo int unique,
	empresa_idEmpresa int unique
);
go

alter table manutencao
	add constraint fk_manutencao_idVeiculo
	foreign key (veiculo_idVeiculo)
	references veiculo(idVeiculo)
go

alter table manutencao
	add constraint fk_manutencao_idEmpresa
	foreign key (empresa_idEmpresa)
	references empresa(idEmpresa)
go

create table os(
	idOs int primary key identity,
	valorOs float,
	detalheOs varchar(200),
	manutencao_idManutencao int unique
);
go

alter table os
	add constraint fk_os_idManutencao
	foreign key (manutencao_idManutencao)
	references manutencao(idManutencao)
go

create table servico(
	idServico int primary key identity,
	nomeServico varchar(45),
	descricaoServico varchar(45),
	os_idOs int unique
);
go

alter table servico
	add constraint fk_servico_idOs
	foreign key (os_idOs)
	references os(idOs)
go

create table peca(
	idPeca int primary key identity,
	nomePeca varchar(50),
	precoPeca float,
	servico_idServico int unique
);
go

alter table peca
	add constraint fk_peca_idServico
	foreign key (servico_idServico)
	references servico(idServico)
go


create table maoDeObra(
	idMaoDeObra int primary key identity,
	valorMaoDeObra float,
	nomeMaoDeObra varchar(50),
	servico_idServico int unique
);
go

alter table maoDeObra
	add constraint fk_maoDeObra_idServico
	foreign key (servico_idServico)
	references servico(idServico)
go

create table administracao(
	idAdministracao int primary key IDENTITY,
	nome varchar(50),
	email varchar(100),
	senha varchar(100)
);
go

insert into administracao(nome, email, senha) values('Jhonata de Souza Rocha', 'jhonsrocha30@gmail.com', 'Jhonata30')

select * from administracao

drop table administracao