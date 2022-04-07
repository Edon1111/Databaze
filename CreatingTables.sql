--create database Sistemi_Autoshkolles
--use Sistemi_Autoshkolles

create table License_type(
	License_id int primary key not null,
	license_type_desc varchar(255) not null,
)

create table Adresa(
	Adresa_id int primary key not null,
	rruga varchar(255) not null,
	qyteti varchar(255)not null,
	shteti varchar(255)not null,
	zipcode varchar(255)not null
)

create table Klienti (
	Klienti_id int primary key not null,
	emri varchar(255)  not null,
	mbiemri varchar(255)  not null,
	email varchar(255)  not null,
	dataLindjes date  not null,
	mobile_nr varchar(255)  not null,
	fix_nr varchar(255)  not null,
	eshte_aktiv char(1)  not null,
	License_id int  not null,
	Adresa_id int  not null,
	foreign key(License_id) references License_type(License_id)  ,
	foreign key(Adresa_id) references Adresa(Adresa_id) 
	
)


create table Statusi_Kerkesa(
	Statusi_Kerkesa_id int primary key  not null,
	statusi_kerkesa_desc varchar(255)  not null,
	eshte_aktiv char(1)  not null
)

create table Automjeti(
	Automjeti_Id int primary key  not null,
	modeli_automjetit varchar(255)  not null,
	prodhuesi_automjetit varchar(255)  not null,
	regjistrimi varchar(255)  not null
)


create table Lloji_Automjetit(
	Lloji_Automjetit int primary key  not null,
	lloji_automjetit_desc varchar(255)  not null,
	Automjeti_id int  not null,
	foreign key(Automjeti_id) references Automjeti(Automjeti_id)

)
create table Kerkesa(
	Kerkesa_id int primary key  not null,
	data_krijuar date  not null,
	Klienti_id int  not null,
	Statusi_Kerkesa_id int  not null,
	Lloji_automjetit_id int  not null,
	Sherbimi_ligjerata_id int  not null,
	foreign key(Klienti_id) references Klienti(Klienti_id),
	foreign key(Statusi_Kerkesa_id) references Statusi_Kerkesa(Statusi_Kerkesa_id),
	foreign key(Lloji_automjetit_id) references Lloji_Automjetit(Lloji_Automjetit)
)


create table Ligjerata(
	Ligjerata_id int primary key  not null,
	ligjerata_titulli varchar(255)  not null,
	kostoja int  not null,
	kohezgjatja date  not null
)

create table Sherbimi(
	Sherbimi_id int primary key  not null,
	sherbimi_desc varchar(255)  not null,
	kostoja int  not null
)
create table Sherbimi_ligjerata(
	Ligjerata_id int  not null,
	Sherbimi_id int  not null,
	constraint PK_Shebimi_ligjerata primary key(
		Sherbimi_id,
		Ligjerata_id
	),
	foreign key(Ligjerata_id) references Ligjerata(Ligjerata_id),
	foreign key(Sherbimi_id) references Sherbimi(Sherbimi_id)
)

create table Aprovimi(
	Kerkesa_id int  not null,
	Sherbimi_id int  not null,
	Ligjerata_id int  not null,
	constraint PK_Aprovimi primary key(
		Kerkesa_id,
		Sherbimi_id,
		Ligjerata_id
	),

	foreign key(Kerkesa_id) references Kerkesa(Kerkesa_id),
	foreign key(Sherbimi_id) references Sherbimi(Sherbimi_id),
	foreign key(Ligjerata_id) references Ligjerata(Ligjerata_id)
	

)

create table Statusi_Faturimit(
	Statusi_faturimit_id int primary key  not null,
	statusi_fatures_desc varchar(255)  not null
)

create table Faturimi(
	Faturimi_id int primary key  not null,
	data_krijimit date  not null,
	kostoja_fillestare int  not null,
	tax_sherbimi varchar(255)  not null,
	vlera_zbritjes int  not null,
	Statusi_Faturimit_id int  not null,
	foreign key (Statusi_Faturimit_id) references Statusi_Faturimit(Statusi_faturimit_id)
)


create table Statusi_Rezervimit(
	statusi_rezervimit_id int primary key  not null,
	eshte_aktiv char(1)  not null,
	statusi_rezervimit_desc varchar(255)  not null

)

create table Stafi(
  Stafi_id int primary key  not null,
  Adresa_id int   not null,
  emri varchar(255)  not null,
  mbiemri varchar(255)  not null,
  email varchar(255)  not null,
  telefoni varchar(255)  not null,
  eshte_aktiv char(1)  not null,
  foreign key (Adresa_id) references Adresa(Adresa_id)
)


create table Rezervimi(
	Rezervimi_id int primary key  not null,
	planifikimi_dates_ligjerates date  not null,
	data_krijuar date  not null,
	Kerkesa_id int  not null,
	Faturimi_id int  not null,
	Statusi_Rezervimit_id int  not null,

	foreign key(Kerkesa_id) references Kerkesa(Kerkesa_id),
	foreign key(Faturimi_id) references Faturimi(Faturimi_id),
	foreign key (Statusi_Rezervimit_id) references Statusi_Rezervimit(statusi_rezervimit_id),
	
)

create table Zenia_Stafit(
	Zenia_Stafit_id int primary key  not null,
	Rezervimi_id int null,
	Stafi_id int  not null,
	dataFillimit_zenies date  not null,
	dataMbarimit_zenies date  not null,
	eshte_aktiv char(1)  not null,
	foreign key(Stafi_id) references Stafi(Stafi_id),
	foreign key(Rezervimi_id) references Rezervimi(Rezervimi_id)
)

create table Zenia_Automjetit(
	zenia_automjetit_id int primary key  not null,
	Rezervimi_id int null,
	Automjeti_id int  not null,
	dataFillimit_zenies date  not null,
	dataMbarimit_zenies date  not null,
	eshte_aktiv char(1)  not null,
	foreign key(Automjeti_id) references Automjeti(Automjeti_id),
	foreign key(Rezervimi_id) references Rezervimi(Rezervimi_id)

)




/* weak entity */
create table Pagesa(
	Pagesa_id int   not null,
	lloji_pageses varchar(255)  not null,
	Faturimi_id int  not null,
	constraint PK_Pagesa primary key(
		Pagesa_id,
		Faturimi_id
	),

	foreign key(Faturimi_id) references Faturimi(Faturimi_id)

)



create table Lloji_Sherbimit(
	Lloji_sherbimit int primary key  not null,
	tax_lloji_sherbimit varchar(255)  not null,
	Sherbimi_id int  not null,
	foreign key(Sherbimi_id) references Sherbimi(Sherbimi_id)
)


create table Job_Title(

Job_title_id int primary key  not null,
Stafi_id int  not null,
job_title_desc varchar(255)  not null,
foreign key(Stafi_id) references Stafi(Stafi_id)
)


  