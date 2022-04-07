--create database Sistemi_Autoshkolles
--use Sistemi_Autoshkolles

create table Klienti(
	id int primary key,
	emri varchar(255) not null ,
	mbiemri varchar(255),
	datelindja date not null,
	mobile_nr varchar(255) not null,
	fax_nr varchar(255),
	email varchar(255) ,
	--license_type_id int foreign key
	eshte_Aktiv char(1)

)


create table Adresa(
	id int primary key,
	rruga varchar(255) not null,
	qyteti varchar(255) not null,
	shteti varchar(255)not  null,
	zipcode varchar(255) not null
)

create table Stafi(
	id int primary key,
	emri varchar not null,
	mbiemri varchar(255) not null,
	email varchar(255) not null,
	--adresa_id foreing keyint
	nr_mobil varchar(255) not null,
	--job_title foreign key int
	eshte_Aktiv char(1)
)

create table  Job_title(
	id int primary key,
	job_title_desc varchar(255) not null
)


create table Kerkesa(
	id int primary key,
	modifikimiFundit_nga varchar(255) not null,
	dataFundit_modifikuar date not null,
	krijuar_nga varchar(255) not null,
	data_krijuar date not null,
	startDate date,
)

create table Rezervimi(
	id int primary key,
	modifikimiFundit_nga varchar(255) not null,
	dataFundit_modifikuar date not null,
	planifikimi_dates_ligjerates date not null,
	data_krijuar date not null ,
	krijuar_nga varchar(255) not null, 
)

create table Faturimi (
	id int primary key,
	vlera_zbritjes int not null,
	tax_sherbimi int not null,
	kostoja_fillestare int not null,
	data_krijimit date,
	krijuar_nga varchar(255),
	data_modifikimit_fundit date,
	modifikimi_fundit_nga varchar(255)

)

create table License_type(
	 id int primary key,
	license_type_desc varchar(255)
)

create table Statusi_Kerkesa(
	id int primary key,
	statusi_kerkesa_desc varchar(255),
	eshte_Aktiv char(1),
)


create table Automjeti (
	id int primary key,
	modeli_automjetit varchar(255),
	prodhuesi_automjetit varchar(255),
	regjistrimi varchar(255),
)


create table Lloji_Automjetit (
	id int primary key,
	lloji_automjetit_desc varchar(255)
)

create table Zenia_Automjetit(
	id int primary key,
	dataFillimit_zenies date,
	dataMbarimit_zenies date,
	data_krijimit date,
	krijuar_nga varchar(255),
	modifikimi_fundit_nga varchar(255),
	modfikimi_fundit_data date,
	eshte_Aktiv char(1) 

)

create table Satusi_Kerkesa(
	id int primary key,
	statusi_kerkesa_desc varchar(255),
	eshte_Aktvi char(1),
)


create table Statusi_Faturimit(
	id int primary key,
	statusi_fatures_desc varchar(255)
)


create table Statusi_Rezervimit(
	id int primary key,
	eshte_aktiv char(1),
	statusi_rezervimit_desc varchar(255)
)


create table Sherbimi (
	id int primary key,
	sherbimi_desc varchar(255),
	kostoja int,
	

)

create table Ligjerata(
	id int primary key,
	ligjerata_titulli varchar(255),
	kostoja int ,
	kohezgjatja varchar(255)
)


create table Lloji_Sherbimit(
	id int primary key,
	tax_sherbimit_lloji varchar(255)
)

create table Zenia_Stafit(
	id int primary key,
	dataFillimit_zenies date,
	dataMbarimit_zenies date,
	modifikimi_fundit_nga varchar(255),
	data_modifikimit_fundit date,
	eshte_aktiv char(1),
	krijuar_nga varchar(255),
	data_krijimit date
)

create table sherbimi_ligjerata(
	id int primary key,
	--sherbimi_id fk
	--ligjerata_id fk
)

create table Pagesa(
	id int primary key,

)