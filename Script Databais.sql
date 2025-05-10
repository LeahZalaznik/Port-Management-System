create database port
use database port

create table cargos
(
cargoId int identity(200,1),
cargoName varchar(15) not null,
importance int not null,
Constraint pk_cargos primary key(cargoId)
)
go
create table boats
(
boatId int identity(100,1) ,
boatName varchar(15) not null,
cargoId int not null,
content int not null,
Constraint pk_boats primary key(boatId),
Constraint fk_boats_cargos foreign key(cargoId) references cargos(cargoId)
)
go
create table entrys
(
boatId int not null,
dateTimeEntry datetime not null ,
dateTimePass datetime not null,
Constraint fk_entrys_boats foreign key(boatId) references boats(boatId)
)
go
create table exits
(
boatId int not null,
dateTimeExit datetime not null,
dateTimePass datetime not null,
Constraint fk_exits_boats foreign key(boatId) references boats(boatId)
)
go
create table tools
(
toolId int identity(1,1),
toolName varchar(15) not null,
amount int not null,
amountInUse int not null
Constraint pk_tools primary key(toolId)
)
go
create table unLoadingTools
(
toolId int not null,
cargoId int not null,
amout int not null,
Constraint fk_unLoadingTools_tools foreign key(toolId) references tools(toolId),
Constraint fk_unLoadingTools_cargos foreign key(cargoId) references cargos(cargoId)
)
go
create table definitions
(
contentPort bigint not null,
contentPass int not null
)
go
