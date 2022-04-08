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
	fix_nr varchar(255)   null,
	eshte_aktiv char(1)  not null,
	License_id int  not null,
	Adresa_id int  not null,
	foreign key(License_id) references License_type(License_id)  ,
	foreign key(Adresa_id) references Adresa(Adresa_id) 
	
)

--alter table Klienti alter column fix_nr varchar(255) null

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
	kohezgjatja varchar(255)
)

--ALTER TABLE Ligjerata
--ALTER COLUMN kohezgjatja varchar(255);

create table Sherbimi(
	Sherbimi_id int primary key  not null,
	sherbimi_desc varchar(255)  not null,
	kostoja int  not null
)
create table Sherbimi_ligjerata(
	Ligjerata_id int  not null,
	Sherbimi_id int  not null,
	constraint PK_Sherbimi_ligjerata primary key(
		Sherbimi_id,
		Ligjerata_id
	),
	foreign key(Ligjerata_id) references Ligjerata(Ligjerata_id),
	foreign key(Sherbimi_id) references Sherbimi(Sherbimi_id)
)

create table Aprovimi(
	Kerkesa_id int  not null,
	Sherbimi_id int  not null,

	constraint PK_Aprovimi primary key(
		Kerkesa_id,
		Sherbimi_id
		
	),

	foreign key(Kerkesa_id) references Kerkesa(Kerkesa_id),
	foreign key(Sherbimi_id) references Sherbimi(Sherbimi_id),
	
	
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
	data_krijuar date   null,
	Kerkesa_id int  not null,
	Faturimi_id int  not null,
	Statusi_Rezervimit_id int  not null,
	Ligjerata_id int  not null,
	Sherbimi_id int  not null,

	foreign key(Kerkesa_id) references Kerkesa(Kerkesa_id),
	foreign key(Faturimi_id) references Faturimi(Faturimi_id),
	foreign key (Statusi_Rezervimit_id) references Statusi_Rezervimit(statusi_rezervimit_id),
	

	constraint FK_Rezervimi foreign key(
		Sherbimi_id,
		Ligjerata_id
	) references Sherbimi_ligjerata
	

)
--alter table Rezervimi alter column data_krijuar date null


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


--Insertimin e minimumit 10 setesh te te dhenave ne secilen tabele prind

insert into Statusi_Rezervimit(statusi_rezervimit_id,eshte_aktiv,statusi_rezervimit_desc) values(1,'Y','open');
insert into Statusi_Rezervimit(statusi_rezervimit_id,eshte_aktiv,statusi_rezervimit_desc) values(2,'N','in-procces');
insert into Statusi_Rezervimit(statusi_rezervimit_id,eshte_aktiv,statusi_rezervimit_desc) values(3,'Y','cancel');
insert into Statusi_Rezervimit(statusi_rezervimit_id,eshte_aktiv,statusi_rezervimit_desc) values(4,'Y','complete');
insert into Statusi_Rezervimit(statusi_rezervimit_id,eshte_aktiv,statusi_rezervimit_desc) values(5,'Y','complete');
insert into Statusi_Rezervimit(statusi_rezervimit_id,eshte_aktiv,statusi_rezervimit_desc) values(6,'Y','complete');
insert into Statusi_Rezervimit(statusi_rezervimit_id,eshte_aktiv,statusi_rezervimit_desc) values(7,'N','open');
insert into Statusi_Rezervimit(statusi_rezervimit_id,eshte_aktiv,statusi_rezervimit_desc) values(8,'N','in-procces');
insert into Statusi_Rezervimit(statusi_rezervimit_id,eshte_aktiv,statusi_rezervimit_desc) values(9,'N','open');
insert into Statusi_Rezervimit(statusi_rezervimit_id,eshte_aktiv,statusi_rezervimit_desc) values(10,'Y','open');
insert into Statusi_Rezervimit(statusi_rezervimit_id,eshte_aktiv,statusi_rezervimit_desc) values(11,'Y','open');
insert into Statusi_Rezervimit(statusi_rezervimit_id,eshte_aktiv,statusi_rezervimit_desc) values(12,'N','in-procces');
insert into Statusi_Rezervimit(statusi_rezervimit_id,eshte_aktiv,statusi_rezervimit_desc) values(13,'Y','cancel');
insert into Statusi_Rezervimit(statusi_rezervimit_id,eshte_aktiv,statusi_rezervimit_desc) values(14,'Y','complete');
insert into Statusi_Rezervimit(statusi_rezervimit_id,eshte_aktiv,statusi_rezervimit_desc) values(15,'Y','complete');
insert into Statusi_Rezervimit(statusi_rezervimit_id,eshte_aktiv,statusi_rezervimit_desc) values(16,'Y','complete');
insert into Statusi_Rezervimit(statusi_rezervimit_id,eshte_aktiv,statusi_rezervimit_desc) values(17,'N','open');
insert into Statusi_Rezervimit(statusi_rezervimit_id,eshte_aktiv,statusi_rezervimit_desc) values(18,'N','in-procces');
insert into Statusi_Rezervimit(statusi_rezervimit_id,eshte_aktiv,statusi_rezervimit_desc) values(19,'N','open');
insert into Statusi_Rezervimit(statusi_rezervimit_id,eshte_aktiv,statusi_rezervimit_desc) values(20,'Y','open');
insert into Statusi_Rezervimit(statusi_rezervimit_id,eshte_aktiv,statusi_rezervimit_desc) values(21,'Y','open');
insert into Statusi_Rezervimit(statusi_rezervimit_id,eshte_aktiv,statusi_rezervimit_desc) values(22,'N','in-procces');
insert into Statusi_Rezervimit(statusi_rezervimit_id,eshte_aktiv,statusi_rezervimit_desc) values(23,'Y','cancel');
insert into Statusi_Rezervimit(statusi_rezervimit_id,eshte_aktiv,statusi_rezervimit_desc) values(24,'Y','complete');
insert into Statusi_Rezervimit(statusi_rezervimit_id,eshte_aktiv,statusi_rezervimit_desc) values(25,'Y','complete');


select * from Statusi_Rezervimit


insert into Statusi_Faturimit(Statusi_faturimit_id,statusi_fatures_desc) values (1,'complete');
insert into Statusi_Faturimit(Statusi_faturimit_id,statusi_fatures_desc) values (2,'open');
insert into Statusi_Faturimit(Statusi_faturimit_id,statusi_fatures_desc) values (3,'open');
insert into Statusi_Faturimit(Statusi_faturimit_id,statusi_fatures_desc) values (4,'in-procces');
insert into Statusi_Faturimit(Statusi_faturimit_id,statusi_fatures_desc) values (5,'complete');
insert into Statusi_Faturimit(Statusi_faturimit_id,statusi_fatures_desc) values (6,'complete');
insert into Statusi_Faturimit(Statusi_faturimit_id,statusi_fatures_desc) values (7,'in-procces');
insert into Statusi_Faturimit(Statusi_faturimit_id,statusi_fatures_desc) values (8,'complete');
insert into Statusi_Faturimit(Statusi_faturimit_id,statusi_fatures_desc) values (9,'open');
insert into Statusi_Faturimit(Statusi_faturimit_id,statusi_fatures_desc) values (10,'complete');
insert into Statusi_Faturimit(Statusi_faturimit_id,statusi_fatures_desc) values (11,'open');
insert into Statusi_Faturimit(Statusi_faturimit_id,statusi_fatures_desc) values (12,'complete');
insert into Statusi_Faturimit(Statusi_faturimit_id,statusi_fatures_desc) values (13,'cancel');
insert into Statusi_Faturimit(Statusi_faturimit_id,statusi_fatures_desc) values (14,'cancel');
insert into Statusi_Faturimit(Statusi_faturimit_id,statusi_fatures_desc) values (15,'complete');
insert into Statusi_Faturimit(Statusi_faturimit_id,statusi_fatures_desc) values (16,'procces');
insert into Statusi_Faturimit(Statusi_faturimit_id,statusi_fatures_desc) values (17,'complete');
insert into Statusi_Faturimit(Statusi_faturimit_id,statusi_fatures_desc) values (18,'open');
insert into Statusi_Faturimit(Statusi_faturimit_id,statusi_fatures_desc) values (19,'cancel');
insert into Statusi_Faturimit(Statusi_faturimit_id,statusi_fatures_desc) values (20,'complete');
insert into Statusi_Faturimit(Statusi_faturimit_id,statusi_fatures_desc) values (21,'cancel');
insert into Statusi_Faturimit(Statusi_faturimit_id,statusi_fatures_desc) values (22,'complete');
insert into Statusi_Faturimit(Statusi_faturimit_id,statusi_fatures_desc) values (23,'cancel');
insert into Statusi_Faturimit(Statusi_faturimit_id,statusi_fatures_desc) values (24,'cancel');
insert into Statusi_Faturimit(Statusi_faturimit_id,statusi_fatures_desc) values (25,'cancel');

select * from Statusi_Faturimit


insert into Ligjerata(Ligjerata_id,ligjerata_titulli,kostoja,kohezgjatja) values (1,'Shenjat e Komunikacionit',20,'90min');
insert into Ligjerata(Ligjerata_id,ligjerata_titulli,kostoja,kohezgjatja) values (2,'Nocionet',20,'90min');
insert into Ligjerata(Ligjerata_id,ligjerata_titulli,kostoja,kohezgjatja) values (3,'Sinjalizimi Horizontal',20,'90min');
insert into Ligjerata(Ligjerata_id,ligjerata_titulli,kostoja,kohezgjatja) values (4,'Sinjalizimi Vertikal',20,'90min');
insert into Ligjerata(Ligjerata_id,ligjerata_titulli,kostoja,kohezgjatja) values (5,'Shenjat nga personat e autorizuar',20,'90min');
insert into Ligjerata(Ligjerata_id,ligjerata_titulli,kostoja,kohezgjatja) values (6,'Rregullat e Trafikut, Siguria dhe mjetet motorike',20,'90min');
insert into Ligjerata(Ligjerata_id,ligjerata_titulli,kostoja,kohezgjatja) values (7,'Shenjat e tabeles se instrumenteve',20,'90min');
insert into Ligjerata(Ligjerata_id,ligjerata_titulli,kostoja,kohezgjatja) values (8,'Ilustrimet',20,'90min');
insert into Ligjerata(Ligjerata_id,ligjerata_titulli,kostoja,kohezgjatja) values (9,'Praktika ne vozitje',20,'90min');
insert into Ligjerata(Ligjerata_id,ligjerata_titulli,kostoja,kohezgjatja) values (10,'Praktika ne vozitje',20,'90min');
insert into Ligjerata(Ligjerata_id,ligjerata_titulli,kostoja,kohezgjatja) values (11,'Praktika ne vozitje',20,'90min');
insert into Ligjerata(Ligjerata_id,ligjerata_titulli,kostoja,kohezgjatja) values (12,'Praktika ne vozitje',20,'90min');
insert into Ligjerata(Ligjerata_id,ligjerata_titulli,kostoja,kohezgjatja) values (13,'Praktika ne vozitje',20,'90min');
insert into Ligjerata(Ligjerata_id,ligjerata_titulli,kostoja,kohezgjatja) values (14,'Praktika ne vozitje',20,'90min');
insert into Ligjerata(Ligjerata_id,ligjerata_titulli,kostoja,kohezgjatja) values (15,'Praktika ne vozitje',20,'90min');
insert into Ligjerata(Ligjerata_id,ligjerata_titulli,kostoja,kohezgjatja) values (16,'Praktika ne vozitje',20,'90min');
insert into Ligjerata(Ligjerata_id,ligjerata_titulli,kostoja,kohezgjatja) values (17,'Praktika ne vozitje',20,'90min');
insert into Ligjerata(Ligjerata_id,ligjerata_titulli,kostoja,kohezgjatja) values (18,'Praktika ne vozitje',20,'90min');
insert into Ligjerata(Ligjerata_id,ligjerata_titulli,kostoja,kohezgjatja) values (19,'Praktika ne vozitje',20,'90min');
insert into Ligjerata(Ligjerata_id,ligjerata_titulli,kostoja,kohezgjatja) values (20,'Praktika ne vozitje',20,'90min');
insert into Ligjerata(Ligjerata_id,ligjerata_titulli,kostoja,kohezgjatja) values (21,'Praktika ne vozitje',20,'90min');
insert into Ligjerata(Ligjerata_id,ligjerata_titulli,kostoja,kohezgjatja) values (22,'Praktika ne vozitje',20,'90min');
insert into Ligjerata(Ligjerata_id,ligjerata_titulli,kostoja,kohezgjatja) values (23,'Praktika ne vozitje',20,'90min');
insert into Ligjerata(Ligjerata_id,ligjerata_titulli,kostoja,kohezgjatja) values (24,'Praktika ne vozitje',20,'90min');
insert into Ligjerata(Ligjerata_id,ligjerata_titulli,kostoja,kohezgjatja) values (25,'Praktika ne vozitje',20,'90min');

select * from Ligjerata


insert into Sherbimi(Sherbimi_id,sherbimi_desc,kostoja) values(1,'Mjetet ndihmese',30);
insert into Sherbimi(Sherbimi_id,sherbimi_desc,kostoja) values(2,'Certified license',30);
insert into Sherbimi(Sherbimi_id,sherbimi_desc,kostoja) values(3,'Winter driving School',30);
insert into Sherbimi(Sherbimi_id,sherbimi_desc,kostoja) values(4,'Refreshers Lessons',30);
insert into Sherbimi(Sherbimi_id,sherbimi_desc,kostoja) values(5,'Private Lessons',30);
insert into Sherbimi(Sherbimi_id,sherbimi_desc,kostoja) values(6,'Skill Builder Program',30);
insert into Sherbimi(Sherbimi_id,sherbimi_desc,kostoja) values(7,'Defense Driving Course',30);
insert into Sherbimi(Sherbimi_id,sherbimi_desc,kostoja) values(8,'CDL In-Classroom Training',30);
insert into Sherbimi(Sherbimi_id,sherbimi_desc,kostoja) values(9,'Class A and Class B Behind the Wheel (Road)',30);
insert into Sherbimi(Sherbimi_id,sherbimi_desc,kostoja) values(10,'',30);
insert into Sherbimi(Sherbimi_id,sherbimi_desc,kostoja) values(11,'Ligjerata shtese',30);
insert into Sherbimi(Sherbimi_id,sherbimi_desc,kostoja) values(12,'Online Autoschool',30);
insert into Sherbimi(Sherbimi_id,sherbimi_desc,kostoja) values(13,'Literatura',30);
insert into Sherbimi(Sherbimi_id,sherbimi_desc,kostoja) values(14,'E-Books',30);
insert into Sherbimi(Sherbimi_id,sherbimi_desc,kostoja) values(15,'Leje Qarkullimi per Vetura',30);
insert into Sherbimi(Sherbimi_id,sherbimi_desc,kostoja) values(16,'Siguri',30);
insert into Sherbimi(Sherbimi_id,sherbimi_desc,kostoja) values(17,'',30);
insert into Sherbimi(Sherbimi_id,sherbimi_desc,kostoja) values(18,'Leje Qarkullimi per Autobus',30);
insert into Sherbimi(Sherbimi_id,sherbimi_desc,kostoja) values(19,'Leje Qarkullimi per Kamion',30);
insert into Sherbimi(Sherbimi_id,sherbimi_desc,kostoja) values(20,'Leje Qarkullimi All-Inclusive',30);
insert into Sherbimi(Sherbimi_id,sherbimi_desc,kostoja) values(21,'Driving-Simulator',30);
insert into Sherbimi(Sherbimi_id,sherbimi_desc,kostoja) values(22,'Garancion 10 vjecar te kursit',30);
insert into Sherbimi(Sherbimi_id,sherbimi_desc,kostoja) values(23,'Automatic transmission ',30);
insert into Sherbimi(Sherbimi_id,sherbimi_desc,kostoja) values(24,'Manual Transmission',30);
insert into Sherbimi(Sherbimi_id,sherbimi_desc,kostoja) values(25,'Tips for better driving',30);
select * from Sherbimi

insert into Automjeti(Automjeti_Id,modeli_automjetit,prodhuesi_automjetit,regjistrimi) values(1,'Golf','Volkswagen','06-886-DF');
insert into Automjeti(Automjeti_Id,modeli_automjetit,prodhuesi_automjetit,regjistrimi) values(2,'Golf','Volkswagen','01-186-FF');
insert into Automjeti(Automjeti_Id,modeli_automjetit,prodhuesi_automjetit,regjistrimi) values(3,'Golf','Volkswagen','02-836-FD');
insert into Automjeti(Automjeti_Id,modeli_automjetit,prodhuesi_automjetit,regjistrimi) values(4,'Focus','Ford','03-693-FG');
insert into Automjeti(Automjeti_Id,modeli_automjetit,prodhuesi_automjetit,regjistrimi) values(5,'Focus','Ford','06-943-UY');
insert into Automjeti(Automjeti_Id,modeli_automjetit,prodhuesi_automjetit,regjistrimi) values(6,'Focus','Ford','06-235-FS');
insert into Automjeti(Automjeti_Id,modeli_automjetit,prodhuesi_automjetit,regjistrimi) values(7,'308','Peugeot','07-653-OI');
insert into Automjeti(Automjeti_Id,modeli_automjetit,prodhuesi_automjetit,regjistrimi) values(8,'207','Peugeot','04-642-QQ');
insert into Automjeti(Automjeti_Id,modeli_automjetit,prodhuesi_automjetit,regjistrimi) values(9,'206','Peugeot','04-432-FG');
insert into Automjeti(Automjeti_Id,modeli_automjetit,prodhuesi_automjetit,regjistrimi) values(10,'Bus','Volvo','04-342-GG');
insert into Automjeti(Automjeti_Id,modeli_automjetit,prodhuesi_automjetit,regjistrimi) values(11,'Bus','Volvo','04-432-GG');
insert into Automjeti(Automjeti_Id,modeli_automjetit,prodhuesi_automjetit,regjistrimi) values(12,'Bus','Volvo','04-542-GG');
insert into Automjeti(Automjeti_Id,modeli_automjetit,prodhuesi_automjetit,regjistrimi) values(13,'Bus','Volvo','04-432-GG');
insert into Automjeti(Automjeti_Id,modeli_automjetit,prodhuesi_automjetit,regjistrimi) values(14,'Kamion','Volvo','04-545-GG');
insert into Automjeti(Automjeti_Id,modeli_automjetit,prodhuesi_automjetit,regjistrimi) values(15,'Kamion','Mercedes','04-654-GG');
insert into Automjeti(Automjeti_Id,modeli_automjetit,prodhuesi_automjetit,regjistrimi) values(16,'Bus','Mercedes','04-875-GG');
insert into Automjeti(Automjeti_Id,modeli_automjetit,prodhuesi_automjetit,regjistrimi) values(17,'Bus','Volvo','04-23-GG');
insert into Automjeti(Automjeti_Id,modeli_automjetit,prodhuesi_automjetit,regjistrimi) values(18,'Bus','Mercedes','02-886-GG');
insert into Automjeti(Automjeti_Id,modeli_automjetit,prodhuesi_automjetit,regjistrimi) values(19,'Bus','Mercedes','01-432-FD');
insert into Automjeti(Automjeti_Id,modeli_automjetit,prodhuesi_automjetit,regjistrimi) values(20,'Kamion','Volvo','04-563-GF');
insert into Automjeti(Automjeti_Id,modeli_automjetit,prodhuesi_automjetit,regjistrimi) values(21,'Kamion','Mercedes','05-765-IU');
insert into Automjeti(Automjeti_Id,modeli_automjetit,prodhuesi_automjetit,regjistrimi) values(22,'Bus','Mercedes','04-886-HF');
insert into Automjeti(Automjeti_Id,modeli_automjetit,prodhuesi_automjetit,regjistrimi) values(23,'Bus','Mercedes','04-886-HH');
insert into Automjeti(Automjeti_Id,modeli_automjetit,prodhuesi_automjetit,regjistrimi) values(24,'Kamion','Mercedes','04-886-IY');
insert into Automjeti(Automjeti_Id,modeli_automjetit,prodhuesi_automjetit,regjistrimi) values(25,'Bus','Mercedes','02-54-AS');

select * from Automjeti

insert into Statusi_Kerkesa(Statusi_Kerkesa_id,statusi_kerkesa_desc,eshte_aktiv) values (1,'open','Y');
insert into Statusi_Kerkesa(Statusi_Kerkesa_id,statusi_kerkesa_desc,eshte_aktiv) values (2,'complete','N');
insert into Statusi_Kerkesa(Statusi_Kerkesa_id,statusi_kerkesa_desc,eshte_aktiv) values (3,'complete','N');
insert into Statusi_Kerkesa(Statusi_Kerkesa_id,statusi_kerkesa_desc,eshte_aktiv) values (4,'complete','Y');
insert into Statusi_Kerkesa(Statusi_Kerkesa_id,statusi_kerkesa_desc,eshte_aktiv) values (5,'in-procces','N');
insert into Statusi_Kerkesa(Statusi_Kerkesa_id,statusi_kerkesa_desc,eshte_aktiv) values (6,'in-procces','Y');
insert into Statusi_Kerkesa(Statusi_Kerkesa_id,statusi_kerkesa_desc,eshte_aktiv) values (7,'cancel','N');
insert into Statusi_Kerkesa(Statusi_Kerkesa_id,statusi_kerkesa_desc,eshte_aktiv) values (8,'cancel','N');
insert into Statusi_Kerkesa(Statusi_Kerkesa_id,statusi_kerkesa_desc,eshte_aktiv) values (9,'open','Y');
insert into Statusi_Kerkesa(Statusi_Kerkesa_id,statusi_kerkesa_desc,eshte_aktiv) values (10,'complete','Y');
insert into Statusi_Kerkesa(Statusi_Kerkesa_id,statusi_kerkesa_desc,eshte_aktiv) values (11,'complete','Y');
insert into Statusi_Kerkesa(Statusi_Kerkesa_id,statusi_kerkesa_desc,eshte_aktiv) values (12,'in-procces','N');
insert into Statusi_Kerkesa(Statusi_Kerkesa_id,statusi_kerkesa_desc,eshte_aktiv) values (13,'open','Y');
insert into Statusi_Kerkesa(Statusi_Kerkesa_id,statusi_kerkesa_desc,eshte_aktiv) values (14,'cancel','Y');
insert into Statusi_Kerkesa(Statusi_Kerkesa_id,statusi_kerkesa_desc,eshte_aktiv) values (15,'open','N');
insert into Statusi_Kerkesa(Statusi_Kerkesa_id,statusi_kerkesa_desc,eshte_aktiv) values (16,'cancel','Y');
insert into Statusi_Kerkesa(Statusi_Kerkesa_id,statusi_kerkesa_desc,eshte_aktiv) values (17,'cancel','N');
insert into Statusi_Kerkesa(Statusi_Kerkesa_id,statusi_kerkesa_desc,eshte_aktiv) values (18,'in-procces','Y');
insert into Statusi_Kerkesa(Statusi_Kerkesa_id,statusi_kerkesa_desc,eshte_aktiv) values (19,'open','N');
insert into Statusi_Kerkesa(Statusi_Kerkesa_id,statusi_kerkesa_desc,eshte_aktiv) values (20,'in-procces','Y');
insert into Statusi_Kerkesa(Statusi_Kerkesa_id,statusi_kerkesa_desc,eshte_aktiv) values (21,'cancel','N');
insert into Statusi_Kerkesa(Statusi_Kerkesa_id,statusi_kerkesa_desc,eshte_aktiv) values (22,'in-procces','Y');
insert into Statusi_Kerkesa(Statusi_Kerkesa_id,statusi_kerkesa_desc,eshte_aktiv) values (23,'open','N');
insert into Statusi_Kerkesa(Statusi_Kerkesa_id,statusi_kerkesa_desc,eshte_aktiv) values (24,'in-procces','N');
insert into Statusi_Kerkesa(Statusi_Kerkesa_id,statusi_kerkesa_desc,eshte_aktiv) values (25,'open','N');

select * from Statusi_Kerkesa


insert into Adresa(Adresa_id,rruga,qyteti,shteti,zipcode) values (1,'Skifter Arifi','Gjilan','Kosova','60000');
insert into Adresa(Adresa_id,rruga,qyteti,shteti,zipcode) values (2,'Bregu Diellit','Prishtine','Kosova','10000');
insert into Adresa(Adresa_id,rruga,qyteti,shteti,zipcode) values (3,'Chichester Reach','New York','USA','9002');
insert into Adresa(Adresa_id,rruga,qyteti,shteti,zipcode) values (4,'Lindisfarne Garth','New Yersey','USA','8003');
insert into Adresa(Adresa_id,rruga,qyteti,shteti,zipcode) values (5,'Yew Approach','Paris','France','5555');
insert into Adresa(Adresa_id,rruga,qyteti,shteti,zipcode) values (6,'Earnshaw Clough','Berlin','Germany','44422');
insert into Adresa(Adresa_id,rruga,qyteti,shteti,zipcode) values (7,'Powies Path','Bern','Switzerland','94888');
insert into Adresa(Adresa_id,rruga,qyteti,shteti,zipcode) values (8,'Haven Exchange South','Sofia','China','49922');
insert into Adresa(Adresa_id,rruga,qyteti,shteti,zipcode) values (9,'Burnham Reach','Gjilan','Kosova','60000');
insert into Adresa(Adresa_id,rruga,qyteti,shteti,zipcode) values (10,'Random Garth','Prishtine','Kosova','10000');
insert into Adresa(Adresa_id,rruga,qyteti,shteti,zipcode) values (11,'kefk heslg','Tirane','Albania','1000');
insert into Adresa(Adresa_id,rruga,qyteti,shteti,zipcode) values (12,'husk oilk','Prishtine','Kosova','10000');
insert into Adresa(Adresa_id,rruga,qyteti,shteti,zipcode) values (13,' Garth','Gjakove','Albania','70000');
insert into Adresa(Adresa_id,rruga,qyteti,shteti,zipcode) values (14,'Norwood Garth','Peje','Albania','40000');
insert into Adresa(Adresa_id,rruga,qyteti,shteti,zipcode) values (15,'Newport  Garth','Ferizaj','Albania','50000');
insert into Adresa(Adresa_id,rruga,qyteti,shteti,zipcode) values (16,'Northumberland  Garth','Ksamil','Albania','4000');
insert into Adresa(Adresa_id,rruga,qyteti,shteti,zipcode) values (17,'Nythfa Y-Bedol','Ulqin','Albania','9888');
insert into Adresa(Adresa_id,rruga,qyteti,shteti,zipcode) values (18,'Nantybwla Avenue','Durres','Albania','3000');
insert into Adresa(Adresa_id,rruga,qyteti,shteti,zipcode) values (19,'Newlands  Mount','Shkoder','Albania','5000');
insert into Adresa(Adresa_id,rruga,qyteti,shteti,zipcode) values (20,'North  Alley','Berat','Albania','6000');
insert into Adresa(Adresa_id,rruga,qyteti,shteti,zipcode) values (21,'Nant  Avenue','Lezhe','Albania','1003');
insert into Adresa(Adresa_id,rruga,qyteti,shteti,zipcode) values (22,'Drumber Ridge','Dukagjini','Albania','6999');
insert into Adresa(Adresa_id,rruga,qyteti,shteti,zipcode) values (23,'Thelma  Garth','Skenderaj','Albania','9333');
insert into Adresa(Adresa_id,rruga,qyteti,shteti,zipcode) values (24,'Tunstall  Leeway','Prizren','Albania','94994');
insert into Adresa(Adresa_id,rruga,qyteti,shteti,zipcode) values (25,'Tara  Court','Ferizaj','Kosova','0303');

select * from Adresa

insert into License_type(License_id,license_type_desc) values(1,'Passport');
insert into License_type(License_id,license_type_desc) values(2,'Nr_leternjoftimit');
insert into License_type(License_id,license_type_desc) values(3,'Passport');
insert into License_type(License_id,license_type_desc) values(4,'Passport');
insert into License_type(License_id,license_type_desc) values(5,'Nr_leternjoftimit');
insert into License_type(License_id,license_type_desc) values(6,'Passport');
insert into License_type(License_id,license_type_desc) values(7,'Nr_leternjoftimit');
insert into License_type(License_id,license_type_desc) values(8,'Nr_leternjoftimit');
insert into License_type(License_id,license_type_desc) values(9,'Passport');
insert into License_type(License_id,license_type_desc) values(10,'Nr_leternjoftimit');
insert into License_type(License_id,license_type_desc) values(11,'Passport');
insert into License_type(License_id,license_type_desc) values(12,'Passport');
insert into License_type(License_id,license_type_desc) values(13,'Passport');
insert into License_type(License_id,license_type_desc) values(14,'Nr_leternjoftimit');
insert into License_type(License_id,license_type_desc) values(15,'Nr_leternjoftimit');
insert into License_type(License_id,license_type_desc) values(16,'Nr_leternjoftimit');
insert into License_type(License_id,license_type_desc) values(17,'Passport');
insert into License_type(License_id,license_type_desc) values(18,'Passport');
insert into License_type(License_id,license_type_desc) values(19,'Passport');
insert into License_type(License_id,license_type_desc) values(20,'Nr_leternjoftimit');
insert into License_type(License_id,license_type_desc) values(21,'Nr_leternjoftimit');
insert into License_type(License_id,license_type_desc) values(22,'Passport');
insert into License_type(License_id,license_type_desc) values(23,'Nr_leternjoftimit');
insert into License_type(License_id,license_type_desc) values(24,'Nr_leternjoftimit');
insert into License_type(License_id,license_type_desc) values(25,'Passport');


select * from License_type


-- Insertimi minimum 25 setesh tek tabelat e nderthurura

insert into Klienti(Klienti_id,emri,mbiemri,email,dataLindjes,mobile_nr,fix_nr,eshte_aktiv,License_id,Adresa_id)values(1,'Edon','Terstena','edon@gmail.com','2001-01-24','045-993-423',NULL,'Y',1,1);
insert into Klienti(Klienti_id,emri,mbiemri,email,dataLindjes,mobile_nr,fix_nr,eshte_aktiv,License_id,Adresa_id)values(2,'Kayla ','Kayla ','Kayla@gmail.com','2001-02-24','045-432-423',NULL,'N',2,2);
insert into Klienti(Klienti_id,emri,mbiemri,email,dataLindjes,mobile_nr,fix_nr,eshte_aktiv,License_id,Adresa_id)values(3,'Colleen ','Cuevas','Colleen@gmail.com','2001-03-24','453-993-423',NULL,'Y',3,3);
insert into Klienti(Klienti_id,emri,mbiemri,email,dataLindjes,mobile_nr,fix_nr,eshte_aktiv,License_id,Adresa_id)values(4,'Renee ','Roberson','Renee@gmail.com','2001-04-24','045-653-423',NULL,'N',4,4);
insert into Klienti(Klienti_id,emri,mbiemri,email,dataLindjes,mobile_nr,fix_nr,eshte_aktiv,License_id,Adresa_id)values(5,'Donna ','Diaz','Donna@gmail.com','2001-05-24','045-993-74',NULL,'N',5,5);
insert into Klienti(Klienti_id,emri,mbiemri,email,dataLindjes,mobile_nr,fix_nr,eshte_aktiv,License_id,Adresa_id)values(6,'Natalie ','Berry','Natalie@gmail.com','2001-06-24','045-234-423',NULL,'N',6,6);
insert into Klienti(Klienti_id,emri,mbiemri,email,dataLindjes,mobile_nr,fix_nr,eshte_aktiv,License_id,Adresa_id)values(7,'Adrian ','Mccarthy','Adrian@gmail.com','2001-07-24','045-653-423',NULL,'Y',7,7);
insert into Klienti(Klienti_id,emri,mbiemri,email,dataLindjes,mobile_nr,fix_nr,eshte_aktiv,License_id,Adresa_id)values(8,'Cassandra ','Ramirez','Cassandra@gmail.com','2001-08-24','045-764-423',NULL,'Y',8,8);
insert into Klienti(Klienti_id,emri,mbiemri,email,dataLindjes,mobile_nr,fix_nr,eshte_aktiv,License_id,Adresa_id)values(9,'Ronald ','Molina','Ronald@gmail.com','2001-09-24','045-744-423',NULL,'Y',9,9);
insert into Klienti(Klienti_id,emri,mbiemri,email,dataLindjes,mobile_nr,fix_nr,eshte_aktiv,License_id,Adresa_id)values(10,'Matthew ','Greer','Matthew@gmail.com','2001-10-24','045-876-423',NULL,'Y',10,10);
insert into Klienti(Klienti_id,emri,mbiemri,email,dataLindjes,mobile_nr,fix_nr,eshte_aktiv,License_id,Adresa_id)values(11,'Nicholas ','Ware','Nicholas@gmail.com','2001-11-24','045-234-423',NULL,'N',11,11);
insert into Klienti(Klienti_id,emri,mbiemri,email,dataLindjes,mobile_nr,fix_nr,eshte_aktiv,License_id,Adresa_id)values(12,'Karen ','Martinez','Karen@gmail.com','2001-12-24','045-993-423',NULL,'N',12,12);
insert into Klienti(Klienti_id,emri,mbiemri,email,dataLindjes,mobile_nr,fix_nr,eshte_aktiv,License_id,Adresa_id)values(13,'Cindy ','Smith','Cindy@gmail.com','1998-01-24','045-543-764',NULL,'N',13,13);
insert into Klienti(Klienti_id,emri,mbiemri,email,dataLindjes,mobile_nr,fix_nr,eshte_aktiv,License_id,Adresa_id)values(14,'Caitlin ','Nelson','Caitlin@gmail.com','1999-01-24','045-324-423',NULL,'N',14,14);
insert into Klienti(Klienti_id,emri,mbiemri,email,dataLindjes,mobile_nr,fix_nr,eshte_aktiv,License_id,Adresa_id)values(15,'Priscilla ','Luna','Priscilla@gmail.com','2000-01-24','045-6543-423',NULL,'N',15,15);
insert into Klienti(Klienti_id,emri,mbiemri,email,dataLindjes,mobile_nr,fix_nr,eshte_aktiv,License_id,Adresa_id)values(16,'Jamie ','Nelson','Jamie@gmail.com','1997-01-24','045-7653-423',NULL,'N',16,16);
insert into Klienti(Klienti_id,emri,mbiemri,email,dataLindjes,mobile_nr,fix_nr,eshte_aktiv,License_id,Adresa_id)values(17,'William ','Jones','William@gmail.com','1996-01-22','045-643-423',NULL,'N',17,17);
insert into Klienti(Klienti_id,emri,mbiemri,email,dataLindjes,mobile_nr,fix_nr,eshte_aktiv,License_id,Adresa_id)values(18,'Amber ','Scott','Amber@gmail.com','2002-02-14','045-453-765',NULL,'N',18,18);
insert into Klienti(Klienti_id,emri,mbiemri,email,dataLindjes,mobile_nr,fix_nr,eshte_aktiv,License_id,Adresa_id)values(19,'Jeff ','Baldwin','Jeff@gmail.com','2002-01-24','045-993-765',NULL,'N',19,19);
insert into Klienti(Klienti_id,emri,mbiemri,email,dataLindjes,mobile_nr,fix_nr,eshte_aktiv,License_id,Adresa_id)values(20,'Jennifer ','Roberts','Jennifer@gmail.com','2000-02-24','045-324-423',NULL,'N',20,20);
insert into Klienti(Klienti_id,emri,mbiemri,email,dataLindjes,mobile_nr,fix_nr,eshte_aktiv,License_id,Adresa_id)values(21,'Aaron ','Smith','Aaron@gmail.com','1995-01-24','045-993-6543',NULL,'Y',21,21);
insert into Klienti(Klienti_id,emri,mbiemri,email,dataLindjes,mobile_nr,fix_nr,eshte_aktiv,License_id,Adresa_id)values(22,'Robert ','Murray','Robert@gmail.com','2002-01-12','045-765-423',NULL,'Y',22,22);
insert into Klienti(Klienti_id,emri,mbiemri,email,dataLindjes,mobile_nr,fix_nr,eshte_aktiv,License_id,Adresa_id)values(23,'Dustin ','Meyer','Dustin@gmail.com','2002-01-11','045-875-423',NULL,'Y',23,23);
insert into Klienti(Klienti_id,emri,mbiemri,email,dataLindjes,mobile_nr,fix_nr,eshte_aktiv,License_id,Adresa_id)values(24,'Cheryl ','Krause','Cheryl@gmail.com','2001-01-05','045-993-543','03003-994-39','Y',24,24);
insert into Klienti(Klienti_id,emri,mbiemri,email,dataLindjes,mobile_nr,fix_nr,eshte_aktiv,License_id,Adresa_id)values(25,'Kevin ','Heart','Kevin@gmail.com','1999-02-05','045-939-543','9949-323-432','N',25,25);


select * from Klienti


insert into Lloji_Automjetit(Lloji_Automjetit,lloji_automjetit_desc,Automjeti_id) values(1,'Veture',1);
insert into Lloji_Automjetit(Lloji_Automjetit,lloji_automjetit_desc,Automjeti_id) values(2,'Kamion',2);
insert into Lloji_Automjetit(Lloji_Automjetit,lloji_automjetit_desc,Automjeti_id) values(3,'Veture',3);
insert into Lloji_Automjetit(Lloji_Automjetit,lloji_automjetit_desc,Automjeti_id) values(4,'Kamion',4);
insert into Lloji_Automjetit(Lloji_Automjetit,lloji_automjetit_desc,Automjeti_id) values(5,'Veture',5);
insert into Lloji_Automjetit(Lloji_Automjetit,lloji_automjetit_desc,Automjeti_id) values(6,'Veture',6);
insert into Lloji_Automjetit(Lloji_Automjetit,lloji_automjetit_desc,Automjeti_id) values(7,'Veture',7);
insert into Lloji_Automjetit(Lloji_Automjetit,lloji_automjetit_desc,Automjeti_id) values(8,'Kamion',8);
insert into Lloji_Automjetit(Lloji_Automjetit,lloji_automjetit_desc,Automjeti_id) values(9,'Veture',9);
insert into Lloji_Automjetit(Lloji_Automjetit,lloji_automjetit_desc,Automjeti_id) values(10,'Veture',10);
insert into Lloji_Automjetit(Lloji_Automjetit,lloji_automjetit_desc,Automjeti_id) values(11,'Autobus',11);
insert into Lloji_Automjetit(Lloji_Automjetit,lloji_automjetit_desc,Automjeti_id) values(12,'Kamion',12);
insert into Lloji_Automjetit(Lloji_Automjetit,lloji_automjetit_desc,Automjeti_id) values(13,'Veture',13);
insert into Lloji_Automjetit(Lloji_Automjetit,lloji_automjetit_desc,Automjeti_id) values(14,'Autobus',14);
insert into Lloji_Automjetit(Lloji_Automjetit,lloji_automjetit_desc,Automjeti_id) values(15,'Veture',15);
insert into Lloji_Automjetit(Lloji_Automjetit,lloji_automjetit_desc,Automjeti_id) values(16,'Veture',16);
insert into Lloji_Automjetit(Lloji_Automjetit,lloji_automjetit_desc,Automjeti_id) values(17,'Kamion',17);
insert into Lloji_Automjetit(Lloji_Automjetit,lloji_automjetit_desc,Automjeti_id) values(18,'Autobus',18);
insert into Lloji_Automjetit(Lloji_Automjetit,lloji_automjetit_desc,Automjeti_id) values(19,'Veture',19);
insert into Lloji_Automjetit(Lloji_Automjetit,lloji_automjetit_desc,Automjeti_id) values(20,'Kamion',20);
insert into Lloji_Automjetit(Lloji_Automjetit,lloji_automjetit_desc,Automjeti_id) values(21,'Autobus',21);
insert into Lloji_Automjetit(Lloji_Automjetit,lloji_automjetit_desc,Automjeti_id) values(22,'Veture',22);
insert into Lloji_Automjetit(Lloji_Automjetit,lloji_automjetit_desc,Automjeti_id) values(23,'Autobus',23);
insert into Lloji_Automjetit(Lloji_Automjetit,lloji_automjetit_desc,Automjeti_id) values(24,'Veture',24);
insert into Lloji_Automjetit(Lloji_Automjetit,lloji_automjetit_desc,Automjeti_id) values(25,'Veture',25);


select * from Lloji_Automjetit


insert into Sherbimi_ligjerata(Ligjerata_id,Sherbimi_id) values(1,1)
insert into Sherbimi_ligjerata(Ligjerata_id,Sherbimi_id) values(2,2)
insert into Sherbimi_ligjerata(Ligjerata_id,Sherbimi_id) values(3,3)
insert into Sherbimi_ligjerata(Ligjerata_id,Sherbimi_id) values(4,4)
insert into Sherbimi_ligjerata(Ligjerata_id,Sherbimi_id) values(5,5)
insert into Sherbimi_ligjerata(Ligjerata_id,Sherbimi_id) values(6,6)
insert into Sherbimi_ligjerata(Ligjerata_id,Sherbimi_id) values(7,7)
insert into Sherbimi_ligjerata(Ligjerata_id,Sherbimi_id) values(8,8)
insert into Sherbimi_ligjerata(Ligjerata_id,Sherbimi_id) values(9,9)
insert into Sherbimi_ligjerata(Ligjerata_id,Sherbimi_id) values(10,10)
insert into Sherbimi_ligjerata(Ligjerata_id,Sherbimi_id) values(11,11)
insert into Sherbimi_ligjerata(Ligjerata_id,Sherbimi_id) values(12,12)
insert into Sherbimi_ligjerata(Ligjerata_id,Sherbimi_id) values(13,13)
insert into Sherbimi_ligjerata(Ligjerata_id,Sherbimi_id) values(14,14)
insert into Sherbimi_ligjerata(Ligjerata_id,Sherbimi_id) values(15,15)
insert into Sherbimi_ligjerata(Ligjerata_id,Sherbimi_id) values(16,16)
insert into Sherbimi_ligjerata(Ligjerata_id,Sherbimi_id) values(17,17)
insert into Sherbimi_ligjerata(Ligjerata_id,Sherbimi_id) values(18,18)
insert into Sherbimi_ligjerata(Ligjerata_id,Sherbimi_id) values(19,19)
insert into Sherbimi_ligjerata(Ligjerata_id,Sherbimi_id) values(20,20)
insert into Sherbimi_ligjerata(Ligjerata_id,Sherbimi_id) values(21,21)
insert into Sherbimi_ligjerata(Ligjerata_id,Sherbimi_id) values(22,22)
insert into Sherbimi_ligjerata(Ligjerata_id,Sherbimi_id) values(23,23)
insert into Sherbimi_ligjerata(Ligjerata_id,Sherbimi_id) values(24,24)
insert into Sherbimi_ligjerata(Ligjerata_id,Sherbimi_id) values(25,25)

select *from  Sherbimi_ligjerata


insert into Kerkesa(Kerkesa_id,data_krijuar,Klienti_id,Statusi_Kerkesa_id,Lloji_automjetit_id,Sherbimi_ligjerata_id) values(1,'2022-04-07',1,1,1,1);
insert into Kerkesa(Kerkesa_id,data_krijuar,Klienti_id,Statusi_Kerkesa_id,Lloji_automjetit_id,Sherbimi_ligjerata_id) values(2,'2022-04-07',2,2,2,2);
insert into Kerkesa(Kerkesa_id,data_krijuar,Klienti_id,Statusi_Kerkesa_id,Lloji_automjetit_id,Sherbimi_ligjerata_id) values(3,'2022-04-07',3,3,3,3);
insert into Kerkesa(Kerkesa_id,data_krijuar,Klienti_id,Statusi_Kerkesa_id,Lloji_automjetit_id,Sherbimi_ligjerata_id) values(4,'2022-04-07',4,4,4,4);
insert into Kerkesa(Kerkesa_id,data_krijuar,Klienti_id,Statusi_Kerkesa_id,Lloji_automjetit_id,Sherbimi_ligjerata_id) values(5,'2022-04-07',5,5,5,5);
insert into Kerkesa(Kerkesa_id,data_krijuar,Klienti_id,Statusi_Kerkesa_id,Lloji_automjetit_id,Sherbimi_ligjerata_id) values(6,'2022-04-07',6,6,6,6);
insert into Kerkesa(Kerkesa_id,data_krijuar,Klienti_id,Statusi_Kerkesa_id,Lloji_automjetit_id,Sherbimi_ligjerata_id) values(7,'2022-04-07',7,7,7,7);
insert into Kerkesa(Kerkesa_id,data_krijuar,Klienti_id,Statusi_Kerkesa_id,Lloji_automjetit_id,Sherbimi_ligjerata_id) values(8,'2022-04-07',8,8,8,8);
insert into Kerkesa(Kerkesa_id,data_krijuar,Klienti_id,Statusi_Kerkesa_id,Lloji_automjetit_id,Sherbimi_ligjerata_id) values(9,'2022-04-07',9,9,9,9);
insert into Kerkesa(Kerkesa_id,data_krijuar,Klienti_id,Statusi_Kerkesa_id,Lloji_automjetit_id,Sherbimi_ligjerata_id) values(10,'2022-04-07',10,10,10,10);
insert into Kerkesa(Kerkesa_id,data_krijuar,Klienti_id,Statusi_Kerkesa_id,Lloji_automjetit_id,Sherbimi_ligjerata_id) values(11,'2022-04-07',11,11,11,11);
insert into Kerkesa(Kerkesa_id,data_krijuar,Klienti_id,Statusi_Kerkesa_id,Lloji_automjetit_id,Sherbimi_ligjerata_id) values(12,'2022-04-07',12,12,12,12);
insert into Kerkesa(Kerkesa_id,data_krijuar,Klienti_id,Statusi_Kerkesa_id,Lloji_automjetit_id,Sherbimi_ligjerata_id) values(13,'2022-04-07',13,13,13,13);
insert into Kerkesa(Kerkesa_id,data_krijuar,Klienti_id,Statusi_Kerkesa_id,Lloji_automjetit_id,Sherbimi_ligjerata_id) values(14,'2022-04-07',14,14,14,14);
insert into Kerkesa(Kerkesa_id,data_krijuar,Klienti_id,Statusi_Kerkesa_id,Lloji_automjetit_id,Sherbimi_ligjerata_id) values(15,'2022-04-07',15,15,15,15);
insert into Kerkesa(Kerkesa_id,data_krijuar,Klienti_id,Statusi_Kerkesa_id,Lloji_automjetit_id,Sherbimi_ligjerata_id) values(16,'2022-04-07',16,16,16,16);
insert into Kerkesa(Kerkesa_id,data_krijuar,Klienti_id,Statusi_Kerkesa_id,Lloji_automjetit_id,Sherbimi_ligjerata_id) values(17,'2022-04-07',17,17,17,17);
insert into Kerkesa(Kerkesa_id,data_krijuar,Klienti_id,Statusi_Kerkesa_id,Lloji_automjetit_id,Sherbimi_ligjerata_id) values(18,'2022-04-07',18,18,18,18);
insert into Kerkesa(Kerkesa_id,data_krijuar,Klienti_id,Statusi_Kerkesa_id,Lloji_automjetit_id,Sherbimi_ligjerata_id) values(19,'2022-04-07',19,19,19,19);
insert into Kerkesa(Kerkesa_id,data_krijuar,Klienti_id,Statusi_Kerkesa_id,Lloji_automjetit_id,Sherbimi_ligjerata_id) values(20,'2022-04-07',20,20,20,20);
insert into Kerkesa(Kerkesa_id,data_krijuar,Klienti_id,Statusi_Kerkesa_id,Lloji_automjetit_id,Sherbimi_ligjerata_id) values(21,'2022-04-07',21,21,21,21);
insert into Kerkesa(Kerkesa_id,data_krijuar,Klienti_id,Statusi_Kerkesa_id,Lloji_automjetit_id,Sherbimi_ligjerata_id) values(22,'2022-04-07',22,22,22,22);
insert into Kerkesa(Kerkesa_id,data_krijuar,Klienti_id,Statusi_Kerkesa_id,Lloji_automjetit_id,Sherbimi_ligjerata_id) values(23,'2022-04-07',23,23,23,23);
insert into Kerkesa(Kerkesa_id,data_krijuar,Klienti_id,Statusi_Kerkesa_id,Lloji_automjetit_id,Sherbimi_ligjerata_id) values(24,'2022-04-07',24,24,24,24);
insert into Kerkesa(Kerkesa_id,data_krijuar,Klienti_id,Statusi_Kerkesa_id,Lloji_automjetit_id,Sherbimi_ligjerata_id) values(25,'2022-04-07',25,25,25,25);

select * from Kerkesa




insert into Aprovimi(Kerkesa_id,Sherbimi_id) values(1,1)
insert into Aprovimi(Kerkesa_id,Sherbimi_id) values(2,2)
insert into Aprovimi(Kerkesa_id,Sherbimi_id) values(3,3)
insert into Aprovimi(Kerkesa_id,Sherbimi_id) values(4,4)
insert into Aprovimi(Kerkesa_id,Sherbimi_id) values(5,5)
insert into Aprovimi(Kerkesa_id,Sherbimi_id) values(6,6)
insert into Aprovimi(Kerkesa_id,Sherbimi_id) values(7,7)
insert into Aprovimi(Kerkesa_id,Sherbimi_id) values(8,8)
insert into Aprovimi(Kerkesa_id,Sherbimi_id) values(9,9)
insert into Aprovimi(Kerkesa_id,Sherbimi_id) values(10,10)
insert into Aprovimi(Kerkesa_id,Sherbimi_id) values(11,11)
insert into Aprovimi(Kerkesa_id,Sherbimi_id) values(12,12)
insert into Aprovimi(Kerkesa_id,Sherbimi_id) values(13,13)
insert into Aprovimi(Kerkesa_id,Sherbimi_id) values(14,14)
insert into Aprovimi(Kerkesa_id,Sherbimi_id) values(15,15)
insert into Aprovimi(Kerkesa_id,Sherbimi_id) values(16,16)
insert into Aprovimi(Kerkesa_id,Sherbimi_id) values(17,17)
insert into Aprovimi(Kerkesa_id,Sherbimi_id) values(18,18)
insert into Aprovimi(Kerkesa_id,Sherbimi_id) values(19,19)
insert into Aprovimi(Kerkesa_id,Sherbimi_id) values(20,20)
insert into Aprovimi(Kerkesa_id,Sherbimi_id) values(21,21)
insert into Aprovimi(Kerkesa_id,Sherbimi_id) values(22,22)
insert into Aprovimi(Kerkesa_id,Sherbimi_id) values(23,23)
insert into Aprovimi(Kerkesa_id,Sherbimi_id) values(24,24)
insert into Aprovimi(Kerkesa_id,Sherbimi_id) values(25,25)

select * from Aprovimi

insert into Faturimi(Faturimi_id,data_krijimit,kostoja_fillestare,tax_sherbimi,vlera_zbritjes,Statusi_Faturimit_id) values(1,'2022-02-07',300,'EFX23',20,1)
insert into Faturimi(Faturimi_id,data_krijimit,kostoja_fillestare,tax_sherbimi,vlera_zbritjes,Statusi_Faturimit_id) values(2,'2022-02-10',300,'EFX23',20,2)
insert into Faturimi(Faturimi_id,data_krijimit,kostoja_fillestare,tax_sherbimi,vlera_zbritjes,Statusi_Faturimit_id) values(3,'2022-03-18',300,'EFX23',20,3)
insert into Faturimi(Faturimi_id,data_krijimit,kostoja_fillestare,tax_sherbimi,vlera_zbritjes,Statusi_Faturimit_id) values(4,'2022-01-15',300,'EFX23',20,4)
insert into Faturimi(Faturimi_id,data_krijimit,kostoja_fillestare,tax_sherbimi,vlera_zbritjes,Statusi_Faturimit_id) values(5,'2022-03-18',300,'EFX23',20,5)
insert into Faturimi(Faturimi_id,data_krijimit,kostoja_fillestare,tax_sherbimi,vlera_zbritjes,Statusi_Faturimit_id) values(6,'2022-03-16',300,'EFX23',20,6)
insert into Faturimi(Faturimi_id,data_krijimit,kostoja_fillestare,tax_sherbimi,vlera_zbritjes,Statusi_Faturimit_id) values(7,'2022-02-17',300,'EFX23',20,7)
insert into Faturimi(Faturimi_id,data_krijimit,kostoja_fillestare,tax_sherbimi,vlera_zbritjes,Statusi_Faturimit_id) values(8,'2022-03-24',300,'EFX23',20,8)
insert into Faturimi(Faturimi_id,data_krijimit,kostoja_fillestare,tax_sherbimi,vlera_zbritjes,Statusi_Faturimit_id) values(9,'2022-03-15',300,'EFX23',20,9)
insert into Faturimi(Faturimi_id,data_krijimit,kostoja_fillestare,tax_sherbimi,vlera_zbritjes,Statusi_Faturimit_id) values(10,'2022-02-13',300,'EFX23',20,10)
insert into Faturimi(Faturimi_id,data_krijimit,kostoja_fillestare,tax_sherbimi,vlera_zbritjes,Statusi_Faturimit_id) values(11,'2022-03-10',300,'EFX23',20,11)
insert into Faturimi(Faturimi_id,data_krijimit,kostoja_fillestare,tax_sherbimi,vlera_zbritjes,Statusi_Faturimit_id) values(12,'2022-03-06',300,'EFX23',20,12)
insert into Faturimi(Faturimi_id,data_krijimit,kostoja_fillestare,tax_sherbimi,vlera_zbritjes,Statusi_Faturimit_id) values(13,'2022-03-16',300,'EFX23',20,13)
insert into Faturimi(Faturimi_id,data_krijimit,kostoja_fillestare,tax_sherbimi,vlera_zbritjes,Statusi_Faturimit_id) values(14,'2022-02-16',300,'EFX23',20,14)
insert into Faturimi(Faturimi_id,data_krijimit,kostoja_fillestare,tax_sherbimi,vlera_zbritjes,Statusi_Faturimit_id) values(15,'2022-01-05',300,'EFX23',20,15)
insert into Faturimi(Faturimi_id,data_krijimit,kostoja_fillestare,tax_sherbimi,vlera_zbritjes,Statusi_Faturimit_id) values(16,'2022-02-21',300,'EFX23',20,16)
insert into Faturimi(Faturimi_id,data_krijimit,kostoja_fillestare,tax_sherbimi,vlera_zbritjes,Statusi_Faturimit_id) values(17,'2022-03-01',300,'EFX23',20,17)
insert into Faturimi(Faturimi_id,data_krijimit,kostoja_fillestare,tax_sherbimi,vlera_zbritjes,Statusi_Faturimit_id) values(18,'2022-04-05',300,'EFX23',20,18)
insert into Faturimi(Faturimi_id,data_krijimit,kostoja_fillestare,tax_sherbimi,vlera_zbritjes,Statusi_Faturimit_id) values(19,'2022-02-19',300,'EFX23',20,19)
insert into Faturimi(Faturimi_id,data_krijimit,kostoja_fillestare,tax_sherbimi,vlera_zbritjes,Statusi_Faturimit_id) values(20,'2022-01-07',300,'EFX23',20,20)
insert into Faturimi(Faturimi_id,data_krijimit,kostoja_fillestare,tax_sherbimi,vlera_zbritjes,Statusi_Faturimit_id) values(21,'2022-02-14',300,'EFX23',20,21)
insert into Faturimi(Faturimi_id,data_krijimit,kostoja_fillestare,tax_sherbimi,vlera_zbritjes,Statusi_Faturimit_id) values(22,'2022-03-19',300,'EFX23',20,22)
insert into Faturimi(Faturimi_id,data_krijimit,kostoja_fillestare,tax_sherbimi,vlera_zbritjes,Statusi_Faturimit_id) values(23,'2022-04-06',300,'EFX23',20,23)
insert into Faturimi(Faturimi_id,data_krijimit,kostoja_fillestare,tax_sherbimi,vlera_zbritjes,Statusi_Faturimit_id) values(24,'2022-03-06',300,'EFX23',20,24)
insert into Faturimi(Faturimi_id,data_krijimit,kostoja_fillestare,tax_sherbimi,vlera_zbritjes,Statusi_Faturimit_id) values(25,'2022-01-22',300,'EFX23',20,25)

select * from Faturimi



insert into Stafi(Stafi_id,Adresa_id,emri,mbiemri,email,telefoni,eshte_aktiv) values(1,1,'Jaydon','Roy','Jaydon@gmail.com','044-432-343','N')
insert into Stafi(Stafi_id,Adresa_id,emri,mbiemri,email,telefoni,eshte_aktiv) values(2,2,'Kaleigh','Beasley','Kaleigh@gmail.com','044-321-432','N')
insert into Stafi(Stafi_id,Adresa_id,emri,mbiemri,email,telefoni,eshte_aktiv) values(3,3,'Owen','Massey','Owen@gmail.com','044-342-1221','N')
insert into Stafi(Stafi_id,Adresa_id,emri,mbiemri,email,telefoni,eshte_aktiv) values(4,4,'Ksawery ','Wise','Ksawery@gmail.com','044-43-343','Y')
insert into Stafi(Stafi_id,Adresa_id,emri,mbiemri,email,telefoni,eshte_aktiv) values(5,5,'Kristian ','Kirkland','Kristian@gmail.com','044-432-343','Y')
insert into Stafi(Stafi_id,Adresa_id,emri,mbiemri,email,telefoni,eshte_aktiv) values(6,6,'Ailsa ','Kay','Ailsa@gmail.com','044-432-343','Y')
insert into Stafi(Stafi_id,Adresa_id,emri,mbiemri,email,telefoni,eshte_aktiv) values(7,7,'Amayah ','Sims','Amayah@gmail.com','044-543-432','N')
insert into Stafi(Stafi_id,Adresa_id,emri,mbiemri,email,telefoni,eshte_aktiv) values(8,8,'Paula ','Beck','Paula@gmail.com','044-432-654','Y')
insert into Stafi(Stafi_id,Adresa_id,emri,mbiemri,email,telefoni,eshte_aktiv) values(9,9,'Shanice','Gunn','Shanice@gmail.com','044-324-343','N')
insert into Stafi(Stafi_id,Adresa_id,emri,mbiemri,email,telefoni,eshte_aktiv) values(10,10,'Courteney ','Roy','Courteney@gmail.com','044-543-654','N')
insert into Stafi(Stafi_id,Adresa_id,emri,mbiemri,email,telefoni,eshte_aktiv) values(11,11,'Courteney ','Mcfarland','Courteney@gmail.com','044-762-343','N')
insert into Stafi(Stafi_id,Adresa_id,emri,mbiemri,email,telefoni,eshte_aktiv) values(12,12,'Kaylen ','Greenaway','Kaylen@gmail.com','044-432-343','Y')
insert into Stafi(Stafi_id,Adresa_id,emri,mbiemri,email,telefoni,eshte_aktiv) values(13,13,'Salim ','Albert','Salim@gmail.com','044-3234-54','N')
insert into Stafi(Stafi_id,Adresa_id,emri,mbiemri,email,telefoni,eshte_aktiv) values(14,14,'Jemma ','Whitaker','Jemma@gmail.com','044-654-755','Y')
insert into Stafi(Stafi_id,Adresa_id,emri,mbiemri,email,telefoni,eshte_aktiv) values(15,15,'Jak ','OReilly','Jak@gmail.com','044-543-876','N')
insert into Stafi(Stafi_id,Adresa_id,emri,mbiemri,email,telefoni,eshte_aktiv) values(16,16,'Shakil ','Chase','Shakil@gmail.com','044-876-987','N')
insert into Stafi(Stafi_id,Adresa_id,emri,mbiemri,email,telefoni,eshte_aktiv) values(17,17,'Felicia ','Booker','Felicia@gmail.com','044-097-346','Y')
insert into Stafi(Stafi_id,Adresa_id,emri,mbiemri,email,telefoni,eshte_aktiv) values(18,18,'Mohsin ','Richard','Mohsin@gmail.com','044-765-986','N')
insert into Stafi(Stafi_id,Adresa_id,emri,mbiemri,email,telefoni,eshte_aktiv) values(19,19,'Aleyna ','Dennis','Aleyna@gmail.com','044-345-755','Y')
insert into Stafi(Stafi_id,Adresa_id,emri,mbiemri,email,telefoni,eshte_aktiv) values(20,20,'Alana ','Dunne','Alana@gmail.com','044-864-987','N')
insert into Stafi(Stafi_id,Adresa_id,emri,mbiemri,email,telefoni,eshte_aktiv) values(21,21,'Zeeshan ','Fenton','Zeeshan@gmail.com','044-345-654','N')
insert into Stafi(Stafi_id,Adresa_id,emri,mbiemri,email,telefoni,eshte_aktiv) values(22,22,'Jonty ','Branch','Jonty@gmail.com','044-543-756','Y')
insert into Stafi(Stafi_id,Adresa_id,emri,mbiemri,email,telefoni,eshte_aktiv) values(23,23,'Etta ','Bouvet','Etta@gmail.com','044-324-654','N')
insert into Stafi(Stafi_id,Adresa_id,emri,mbiemri,email,telefoni,eshte_aktiv) values(24,24,'Ayva ','Hills','Ayva@gmail.com','044-432-23','Y')
insert into Stafi(Stafi_id,Adresa_id,emri,mbiemri,email,telefoni,eshte_aktiv) values(25,25,'Martine ','Martine ','Martine@gmail.com','044-865-343','N')


select * from Stafi

insert into Rezervimi(Rezervimi_id,planifikimi_dates_ligjerates,Kerkesa_id,Faturimi_id,Statusi_Rezervimit_id,Ligjerata_id,Sherbimi_id) values(1,'2022-02-07',1,1,1,1,1)
insert into Rezervimi(Rezervimi_id,planifikimi_dates_ligjerates,Kerkesa_id,Faturimi_id,Statusi_Rezervimit_id,Ligjerata_id,Sherbimi_id) values(2,'2022-02-10',2,2,2,2,2)
insert into Rezervimi(Rezervimi_id,planifikimi_dates_ligjerates,Kerkesa_id,Faturimi_id,Statusi_Rezervimit_id,Ligjerata_id,Sherbimi_id) values(3,'2022-03-18',3,3,3,3,3)
insert into Rezervimi(Rezervimi_id,planifikimi_dates_ligjerates,Kerkesa_id,Faturimi_id,Statusi_Rezervimit_id,Ligjerata_id,Sherbimi_id) values(4,'2022-01-15',4,4,4,4,4)
insert into Rezervimi(Rezervimi_id,planifikimi_dates_ligjerates,Kerkesa_id,Faturimi_id,Statusi_Rezervimit_id,Ligjerata_id,Sherbimi_id) values(5,'2022-03-18',5,5,5,5,5)
insert into Rezervimi(Rezervimi_id,planifikimi_dates_ligjerates,Kerkesa_id,Faturimi_id,Statusi_Rezervimit_id,Ligjerata_id,Sherbimi_id) values(6,'2022-03-16',6,6,6,6,6)
insert into Rezervimi(Rezervimi_id,planifikimi_dates_ligjerates,Kerkesa_id,Faturimi_id,Statusi_Rezervimit_id,Ligjerata_id,Sherbimi_id) values(7,'2022-02-17',7,7,7,7,7)
insert into Rezervimi(Rezervimi_id,planifikimi_dates_ligjerates,Kerkesa_id,Faturimi_id,Statusi_Rezervimit_id,Ligjerata_id,Sherbimi_id) values(8,'2022-03-24',8,8,8,8,8)
insert into Rezervimi(Rezervimi_id,planifikimi_dates_ligjerates,Kerkesa_id,Faturimi_id,Statusi_Rezervimit_id,Ligjerata_id,Sherbimi_id) values(9,'2022-03-15',9,9,9,9,9)
insert into Rezervimi(Rezervimi_id,planifikimi_dates_ligjerates,Kerkesa_id,Faturimi_id,Statusi_Rezervimit_id,Ligjerata_id,Sherbimi_id) values(10,'2022-02-13',10,10,10,10,10)
insert into Rezervimi(Rezervimi_id,planifikimi_dates_ligjerates,Kerkesa_id,Faturimi_id,Statusi_Rezervimit_id,Ligjerata_id,Sherbimi_id) values(11,'2022-03-10',11,11,11,11,11)
insert into Rezervimi(Rezervimi_id,planifikimi_dates_ligjerates,Kerkesa_id,Faturimi_id,Statusi_Rezervimit_id,Ligjerata_id,Sherbimi_id) values(12,'2022-03-06',12,12,12,12,12)
insert into Rezervimi(Rezervimi_id,planifikimi_dates_ligjerates,Kerkesa_id,Faturimi_id,Statusi_Rezervimit_id,Ligjerata_id,Sherbimi_id) values(13,'2022-03-16',13,13,13,13,13)
insert into Rezervimi(Rezervimi_id,planifikimi_dates_ligjerates,Kerkesa_id,Faturimi_id,Statusi_Rezervimit_id,Ligjerata_id,Sherbimi_id) values(14,'2022-02-16',14,14,14,14,14)
insert into Rezervimi(Rezervimi_id,planifikimi_dates_ligjerates,Kerkesa_id,Faturimi_id,Statusi_Rezervimit_id,Ligjerata_id,Sherbimi_id) values(15,'2022-01-05',15,15,15,15,15)
insert into Rezervimi(Rezervimi_id,planifikimi_dates_ligjerates,Kerkesa_id,Faturimi_id,Statusi_Rezervimit_id,Ligjerata_id,Sherbimi_id) values(16,'2022-02-21',16,16,16,16,16)
insert into Rezervimi(Rezervimi_id,planifikimi_dates_ligjerates,Kerkesa_id,Faturimi_id,Statusi_Rezervimit_id,Ligjerata_id,Sherbimi_id) values(17,'2022-03-01',17,17,17,17,17)
insert into Rezervimi(Rezervimi_id,planifikimi_dates_ligjerates,Kerkesa_id,Faturimi_id,Statusi_Rezervimit_id,Ligjerata_id,Sherbimi_id) values(18,'2022-04-05',18,18,18,18,18)
insert into Rezervimi(Rezervimi_id,planifikimi_dates_ligjerates,Kerkesa_id,Faturimi_id,Statusi_Rezervimit_id,Ligjerata_id,Sherbimi_id) values(19,'2022-02-19',19,19,19,19,19)
insert into Rezervimi(Rezervimi_id,planifikimi_dates_ligjerates,Kerkesa_id,Faturimi_id,Statusi_Rezervimit_id,Ligjerata_id,Sherbimi_id) values(20,'2022-01-07',20,20,20,20,20)
insert into Rezervimi(Rezervimi_id,planifikimi_dates_ligjerates,Kerkesa_id,Faturimi_id,Statusi_Rezervimit_id,Ligjerata_id,Sherbimi_id) values(21,'2022-02-14',21,21,21,21,21)
insert into Rezervimi(Rezervimi_id,planifikimi_dates_ligjerates,Kerkesa_id,Faturimi_id,Statusi_Rezervimit_id,Ligjerata_id,Sherbimi_id) values(22,'2022-03-19',22,22,22,22,22)
insert into Rezervimi(Rezervimi_id,planifikimi_dates_ligjerates,Kerkesa_id,Faturimi_id,Statusi_Rezervimit_id,Ligjerata_id,Sherbimi_id) values(23,'2022-04-06',23,23,23,23,23)
insert into Rezervimi(Rezervimi_id,planifikimi_dates_ligjerates,Kerkesa_id,Faturimi_id,Statusi_Rezervimit_id,Ligjerata_id,Sherbimi_id) values(24,'2022-03-06',24,24,24,24,24)
insert into Rezervimi(Rezervimi_id,planifikimi_dates_ligjerates,Kerkesa_id,Faturimi_id,Statusi_Rezervimit_id,Ligjerata_id,Sherbimi_id) values(25,'2022-01-22',25,25,25,25,25)

select * from Rezervimi


insert into Zenia_Stafit(Zenia_Stafit_id,Rezervimi_id,Stafi_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(1,1,1,'2022-04-07','2022-08-12','Y')
insert into Zenia_Stafit(Zenia_Stafit_id,Rezervimi_id,Stafi_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(2,2,2,'2022-04-07','2023-08-12','N')
insert into Zenia_Stafit(Zenia_Stafit_id,Rezervimi_id,Stafi_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(3,3,3,'2022-02-07','2022-08-12','Y')
insert into Zenia_Stafit(Zenia_Stafit_id,Rezervimi_id,Stafi_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(4,4,4,'2022-05-27','2022-08-12','Y')
insert into Zenia_Stafit(Zenia_Stafit_id,Rezervimi_id,Stafi_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(5,NULL,5,'2022-02-17','2022-08-12','N')
insert into Zenia_Stafit(Zenia_Stafit_id,Rezervimi_id,Stafi_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(6,6,6,'2022-04-07','2022-08-12','Y')
insert into Zenia_Stafit(Zenia_Stafit_id,Rezervimi_id,Stafi_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(7,7,7,'2022-04-07','2022-08-12','Y')
insert into Zenia_Stafit(Zenia_Stafit_id,Rezervimi_id,Stafi_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(8,NULL,8,'2022-04-07','2022-08-12','N')
insert into Zenia_Stafit(Zenia_Stafit_id,Rezervimi_id,Stafi_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(9,9,9,'2022-04-07','2022-08-12','N')
insert into Zenia_Stafit(Zenia_Stafit_id,Rezervimi_id,Stafi_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(10,NULL,10,'2022-04-07','2022-08-12','Y')
insert into Zenia_Stafit(Zenia_Stafit_id,Rezervimi_id,Stafi_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(11,11,11,'2022-04-07','2022-08-12','Y')
insert into Zenia_Stafit(Zenia_Stafit_id,Rezervimi_id,Stafi_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(12,NULL,12,'2022-04-07','2022-08-12','N')
insert into Zenia_Stafit(Zenia_Stafit_id,Rezervimi_id,Stafi_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(13,13,13,'2022-04-07','2022-08-12','N')
insert into Zenia_Stafit(Zenia_Stafit_id,Rezervimi_id,Stafi_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(14,NULL,14,'2022-04-07','2022-08-12','Y')
insert into Zenia_Stafit(Zenia_Stafit_id,Rezervimi_id,Stafi_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(15,15,15,'2022-04-07','2022-08-12','N')
insert into Zenia_Stafit(Zenia_Stafit_id,Rezervimi_id,Stafi_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(16,16,16,'2022-04-07','2022-08-12','Y')
insert into Zenia_Stafit(Zenia_Stafit_id,Rezervimi_id,Stafi_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(17,17,17,'2022-04-07','2022-08-12','N')
insert into Zenia_Stafit(Zenia_Stafit_id,Rezervimi_id,Stafi_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(18,18,18,'2022-04-07','2022-08-12','Y')
insert into Zenia_Stafit(Zenia_Stafit_id,Rezervimi_id,Stafi_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(19,19,19,'2022-04-07','2022-08-12','N')
insert into Zenia_Stafit(Zenia_Stafit_id,Rezervimi_id,Stafi_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(20,NULL,20,'2022-04-07','2022-08-12','N')
insert into Zenia_Stafit(Zenia_Stafit_id,Rezervimi_id,Stafi_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(21,21,21,'2022-04-07','2022-08-12','N')
insert into Zenia_Stafit(Zenia_Stafit_id,Rezervimi_id,Stafi_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(22,22,22,'2022-04-07','2022-08-12','Y')
insert into Zenia_Stafit(Zenia_Stafit_id,Rezervimi_id,Stafi_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(23,NULL,23,'2022-04-07','2022-08-12','N')
insert into Zenia_Stafit(Zenia_Stafit_id,Rezervimi_id,Stafi_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(24,24,24,'2022-04-07','2022-08-12','N')
insert into Zenia_Stafit(Zenia_Stafit_id,Rezervimi_id,Stafi_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(25,25,25,'2022-04-07','2022-08-12','Y')

select * from Zenia_Stafit

insert into Zenia_Automjetit(zenia_automjetit_id,Rezervimi_id,Automjeti_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(1,1,1,'2022-04-07','2022-08-12','Y')
insert into Zenia_Automjetit(zenia_automjetit_id,Rezervimi_id,Automjeti_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(2,2,2,'2022-04-07','2023-08-12','N')
insert into Zenia_Automjetit(zenia_automjetit_id,Rezervimi_id,Automjeti_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(3,3,3,'2022-02-07','2022-08-12','Y')
insert into Zenia_Automjetit(zenia_automjetit_id,Rezervimi_id,Automjeti_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(4,4,4,'2022-05-27','2022-08-12','Y')
insert into Zenia_Automjetit(zenia_automjetit_id,Rezervimi_id,Automjeti_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(5,NULL,5,'2022-02-17','2022-08-12','N')
insert into Zenia_Automjetit(zenia_automjetit_id,Rezervimi_id,Automjeti_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(6,6,6,'2022-04-07','2022-08-12','Y')
insert into Zenia_Automjetit(zenia_automjetit_id,Rezervimi_id,Automjeti_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(7,7,7,'2022-04-07','2022-08-12','Y')
insert into Zenia_Automjetit(zenia_automjetit_id,Rezervimi_id,Automjeti_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(8,NULL,8,'2022-04-07','2022-08-12','N')
insert into Zenia_Automjetit(zenia_automjetit_id,Rezervimi_id,Automjeti_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(9,9,9,'2022-04-07','2022-08-12','N')
insert into Zenia_Automjetit(zenia_automjetit_id,Rezervimi_id,Automjeti_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(10,NULL,10,'2022-04-07','2022-08-12','Y')
insert into Zenia_Automjetit(zenia_automjetit_id,Rezervimi_id,Automjeti_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(11,11,11,'2022-04-07','2022-08-12','Y')
insert into Zenia_Automjetit(zenia_automjetit_id,Rezervimi_id,Automjeti_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(12,NULL,12,'2022-04-07','2022-08-12','N')
insert into Zenia_Automjetit(zenia_automjetit_id,Rezervimi_id,Automjeti_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(14,NULL,14,'2022-04-07','2022-08-12','Y')
insert into Zenia_Automjetit(zenia_automjetit_id,Rezervimi_id,Automjeti_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(15,15,15,'2022-04-07','2022-08-12','N')
insert into Zenia_Automjetit(zenia_automjetit_id,Rezervimi_id,Automjeti_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(16,16,16,'2022-04-07','2022-08-12','Y')
insert into Zenia_Automjetit(zenia_automjetit_id,Rezervimi_id,Automjeti_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(17,17,17,'2022-04-07','2022-08-12','N')
insert into Zenia_Automjetit(zenia_automjetit_id,Rezervimi_id,Automjeti_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(18,18,18,'2022-04-07','2022-08-12','Y')
insert into Zenia_Automjetit(zenia_automjetit_id,Rezervimi_id,Automjeti_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(19,19,19,'2022-04-07','2022-08-12','N')
insert into Zenia_Automjetit(zenia_automjetit_id,Rezervimi_id,Automjeti_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(20,NULL,20,'2022-04-07','2022-08-12','N')
insert into Zenia_Automjetit(zenia_automjetit_id,Rezervimi_id,Automjeti_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(21,21,21,'2022-04-07','2022-08-12','N')
insert into Zenia_Automjetit(zenia_automjetit_id,Rezervimi_id,Automjeti_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(22,22,22,'2022-04-07','2022-08-12','Y')
insert into Zenia_Automjetit(zenia_automjetit_id,Rezervimi_id,Automjeti_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(23,NULL,23,'2022-04-07','2022-08-12','N')
insert into Zenia_Automjetit(zenia_automjetit_id,Rezervimi_id,Automjeti_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(24,24,24,'2022-04-07','2022-08-12','N')
insert into Zenia_Automjetit(zenia_automjetit_id,Rezervimi_id,Automjeti_id,dataFillimit_zenies,dataMbarimit_zenies,eshte_aktiv) values(25,25,25,'2022-04-07','2022-08-12','Y')

select * from Zenia_Automjetit



insert into Pagesa(Pagesa_id,lloji_pageses,Faturimi_id) values(1,'Keste',1)
insert into Pagesa(Pagesa_id,lloji_pageses,Faturimi_id) values(2,'Cash',2)
insert into Pagesa(Pagesa_id,lloji_pageses,Faturimi_id) values(3,'Cash',3)
insert into Pagesa(Pagesa_id,lloji_pageses,Faturimi_id) values(4,'Keste',4)
insert into Pagesa(Pagesa_id,lloji_pageses,Faturimi_id) values(5,'Cash',5)
insert into Pagesa(Pagesa_id,lloji_pageses,Faturimi_id) values(6,'Cash',6)
insert into Pagesa(Pagesa_id,lloji_pageses,Faturimi_id) values(7,'Keste',7)
insert into Pagesa(Pagesa_id,lloji_pageses,Faturimi_id) values(8,'Total',8)
insert into Pagesa(Pagesa_id,lloji_pageses,Faturimi_id) values(9,'Cash',9)
insert into Pagesa(Pagesa_id,lloji_pageses,Faturimi_id) values(10,'Keste',10)
insert into Pagesa(Pagesa_id,lloji_pageses,Faturimi_id) values(11,'Total',11)
insert into Pagesa(Pagesa_id,lloji_pageses,Faturimi_id) values(12,'Keste',12)
insert into Pagesa(Pagesa_id,lloji_pageses,Faturimi_id) values(13,'Keste',13)
insert into Pagesa(Pagesa_id,lloji_pageses,Faturimi_id) values(14,'Total',14)
insert into Pagesa(Pagesa_id,lloji_pageses,Faturimi_id) values(15,'Keste',15)
insert into Pagesa(Pagesa_id,lloji_pageses,Faturimi_id) values(16,'Total',16)
insert into Pagesa(Pagesa_id,lloji_pageses,Faturimi_id) values(17,'Me Kartele',17)
insert into Pagesa(Pagesa_id,lloji_pageses,Faturimi_id) values(18,'Keste',18)
insert into Pagesa(Pagesa_id,lloji_pageses,Faturimi_id) values(19,'Keste',19)
insert into Pagesa(Pagesa_id,lloji_pageses,Faturimi_id) values(20,'Total',20)
insert into Pagesa(Pagesa_id,lloji_pageses,Faturimi_id) values(21,'Keste',21)
insert into Pagesa(Pagesa_id,lloji_pageses,Faturimi_id) values(22,'Me Kartele',22)
insert into Pagesa(Pagesa_id,lloji_pageses,Faturimi_id) values(23,'Keste',23)
insert into Pagesa(Pagesa_id,lloji_pageses,Faturimi_id) values(24,'Total',24)
insert into Pagesa(Pagesa_id,lloji_pageses,Faturimi_id) values(25,'Keste',25)


select * from Pagesa


insert into Lloji_Sherbimit(Lloji_sherbimit,tax_lloji_sherbimit,Sherbimi_id) values(1,'AX08',1)
insert into Lloji_Sherbimit(Lloji_sherbimit,tax_lloji_sherbimit,Sherbimi_id) values(2,'AX08',2)
insert into Lloji_Sherbimit(Lloji_sherbimit,tax_lloji_sherbimit,Sherbimi_id) values(3,'AX08',3)
insert into Lloji_Sherbimit(Lloji_sherbimit,tax_lloji_sherbimit,Sherbimi_id) values(4,'AX08',4)
insert into Lloji_Sherbimit(Lloji_sherbimit,tax_lloji_sherbimit,Sherbimi_id) values(5,'AX08',5)
insert into Lloji_Sherbimit(Lloji_sherbimit,tax_lloji_sherbimit,Sherbimi_id) values(6,'AX08',6)
insert into Lloji_Sherbimit(Lloji_sherbimit,tax_lloji_sherbimit,Sherbimi_id) values(7,'AX08',7)
insert into Lloji_Sherbimit(Lloji_sherbimit,tax_lloji_sherbimit,Sherbimi_id) values(8,'AX08',8)
insert into Lloji_Sherbimit(Lloji_sherbimit,tax_lloji_sherbimit,Sherbimi_id) values(9,'AX08',9)
insert into Lloji_Sherbimit(Lloji_sherbimit,tax_lloji_sherbimit,Sherbimi_id) values(10,'AX08',10)
insert into Lloji_Sherbimit(Lloji_sherbimit,tax_lloji_sherbimit,Sherbimi_id) values(11,'AX08',11)
insert into Lloji_Sherbimit(Lloji_sherbimit,tax_lloji_sherbimit,Sherbimi_id) values(12,'AX08',12)
insert into Lloji_Sherbimit(Lloji_sherbimit,tax_lloji_sherbimit,Sherbimi_id) values(13,'AX08',13)
insert into Lloji_Sherbimit(Lloji_sherbimit,tax_lloji_sherbimit,Sherbimi_id) values(14,'AX08',14)
insert into Lloji_Sherbimit(Lloji_sherbimit,tax_lloji_sherbimit,Sherbimi_id) values(15,'AX08',15)
insert into Lloji_Sherbimit(Lloji_sherbimit,tax_lloji_sherbimit,Sherbimi_id) values(16,'AX08',16)
insert into Lloji_Sherbimit(Lloji_sherbimit,tax_lloji_sherbimit,Sherbimi_id) values(17,'AX08',17)
insert into Lloji_Sherbimit(Lloji_sherbimit,tax_lloji_sherbimit,Sherbimi_id) values(18,'AX08',18)
insert into Lloji_Sherbimit(Lloji_sherbimit,tax_lloji_sherbimit,Sherbimi_id) values(19,'AX08',19)
insert into Lloji_Sherbimit(Lloji_sherbimit,tax_lloji_sherbimit,Sherbimi_id) values(20,'AX08',20)
insert into Lloji_Sherbimit(Lloji_sherbimit,tax_lloji_sherbimit,Sherbimi_id) values(21,'AX08',21)
insert into Lloji_Sherbimit(Lloji_sherbimit,tax_lloji_sherbimit,Sherbimi_id) values(22,'AX08',22)
insert into Lloji_Sherbimit(Lloji_sherbimit,tax_lloji_sherbimit,Sherbimi_id) values(23,'AX08',23)
insert into Lloji_Sherbimit(Lloji_sherbimit,tax_lloji_sherbimit,Sherbimi_id) values(24,'AX08',24)
insert into Lloji_Sherbimit(Lloji_sherbimit,tax_lloji_sherbimit,Sherbimi_id) values(25,'AX08',25)


select * from Lloji_Sherbimit



insert into Job_Title(Job_title_id,Stafi_id,job_title_desc) values(1,1,'Instruktor')
insert into Job_Title(Job_title_id,Stafi_id,job_title_desc) values(2,2,'Administrator')
insert into Job_Title(Job_title_id,Stafi_id,job_title_desc) values(3,3,'Asistent')
insert into Job_Title(Job_title_id,Stafi_id,job_title_desc) values(4,4,'Instruktor')
insert into Job_Title(Job_title_id,Stafi_id,job_title_desc) values(5,5,'Instruktor')
insert into Job_Title(Job_title_id,Stafi_id,job_title_desc) values(6,6,'Instruktor')
insert into Job_Title(Job_title_id,Stafi_id,job_title_desc) values(7,7,'Asistent')
insert into Job_Title(Job_title_id,Stafi_id,job_title_desc) values(8,8,'Asistent')
insert into Job_Title(Job_title_id,Stafi_id,job_title_desc) values(9,9,'Asistent')
insert into Job_Title(Job_title_id,Stafi_id,job_title_desc) values(10,10,'Instruktor')
insert into Job_Title(Job_title_id,Stafi_id,job_title_desc) values(11,11,'Asistent')
insert into Job_Title(Job_title_id,Stafi_id,job_title_desc) values(12,12,'Instruktor')
insert into Job_Title(Job_title_id,Stafi_id,job_title_desc) values(13,13,'Asistent')
insert into Job_Title(Job_title_id,Stafi_id,job_title_desc) values(14,14,'Asistent')
insert into Job_Title(Job_title_id,Stafi_id,job_title_desc) values(15,15,'Instruktor')
insert into Job_Title(Job_title_id,Stafi_id,job_title_desc) values(16,16,'Asistent')
insert into Job_Title(Job_title_id,Stafi_id,job_title_desc) values(17,17,'Instruktor')
insert into Job_Title(Job_title_id,Stafi_id,job_title_desc) values(18,18,'Asistent')
insert into Job_Title(Job_title_id,Stafi_id,job_title_desc) values(19,19,'Instruktor')
insert into Job_Title(Job_title_id,Stafi_id,job_title_desc) values(20,20,'Asistent')
insert into Job_Title(Job_title_id,Stafi_id,job_title_desc) values(21,21,'Asistent')
insert into Job_Title(Job_title_id,Stafi_id,job_title_desc) values(22,22,'Instruktor')
insert into Job_Title(Job_title_id,Stafi_id,job_title_desc) values(23,23,'Asistent')
insert into Job_Title(Job_title_id,Stafi_id,job_title_desc) values(24,24,'Asistent')
insert into Job_Title(Job_title_id,Stafi_id,job_title_desc) values(25,25,'Instruktor')

select * from Job_Title



-- 	Përditësimin e 20 objekteve duke përdorur kushtet të caktuara.

--updates

Select* from Klienti

update Klienti 
set emri = 'Edonii'
from Klienti k
where k.Klienti_id=2

select * from Klienti


select * from Stafi
update Stafi 
set eshte_aktiv='P'
where eshte_aktiv='Y'


select * from Job_Title

update Job_Title 
set job_title_desc='Drejtor'
where Job_title_id < 5

select * from Zenia_Automjetit
update Zenia_Automjetit
set eshte_aktiv = 'N'
where dataFillimit_zenies='2022-04-07' and dataMbarimit_zenies='2022-08-12'

select * from Rezervimi
update Rezervimi
set data_krijuar = '2022-08-4'
where Rezervimi_id > 8


select * from Kerkesa

alter table Kerkesa alter column data_krijuar varchar(255) null
update Kerkesa
set data_krijuar = null
where Kerkesa_id <= 3

select * from Faturimi
update Faturimi 
set kostoja_fillestare = kostoja_fillestare+(kostoja_fillestare* 0.5)
from Faturimi f, Rezervimi r
where f.Faturimi_id = r.Rezervimi_id

select * from Pagesa
update Pagesa
set lloji_pageses = 'Total'
where lloji_pageses='Cash'


select * from Sherbimi
update Sherbimi 
set kostoja=kostoja + kostoja

select * from Automjeti
update Automjeti 
set modeli_automjetit = 'Model udhetues' 
where modeli_automjetit ='Bus'

select* from Automjeti 
update Automjeti set modeli_automjetit = 'Model transportues'
where modeli_automjetit= 'Kamion'


select * from License_type
update License_type 
set license_type_desc = 'Certifikate e lindjes'
where License_id >= 21

select * from Kerkesa 
update Kerkesa 
set data_krijuar = null
where Kerkesa_id > 15


select * from Zenia_Automjetit
update Zenia_Automjetit 
set eshte_aktiv = 'Y'
where zenia_automjetit_id = 21 or zenia_automjetit_id = 25


select * from Zenia_Stafit 
update Zenia_Stafit 
set eshte_aktiv = 'N'
where dataMbarimit_zenies ='2022-08-12'

select * from Ligjerata 
update Ligjerata set kostoja = kostoja + (kostoja * 0.2) 
where ligjerata_titulli = 'Praktika ne vozitje' 

select * from Ligjerata 
update Ligjerata set kohezgjatja = '120min'
where kostoja = 24


select * from Statusi_Faturimit 
update Statusi_Faturimit 
set statusi_fatures_desc = 'cancel'
 where Statusi_faturimit_id > 12 and Statusi_faturimit_id < 25


 select * from Statusi_Kerkesa
 update Statusi_Kerkesa 
 set statusi_kerkesa_desc = 'complete'
 where eshte_aktiv = 'Y'

 select * from Statusi_Rezervimit 
 update Statusi_Rezervimit 
 set statusi_rezervimit_desc= 'in-procces' 
 where eshte_aktiv = 'N'



--Fshierja e 10 objekteve




delete from Ligjerata where kostoja <24


delete from Adresa where shteti like 'Germany'

delete from Klienti where email = 'edon@gmail.com'

delete from Klienti where eshte_aktiv = 'N' and fix_nr is not null


delete from Stafi where Adresa_id > 5 and Adresa_id < 15

delete from Rezervimi where data_krijuar is null


delete from License_type where license_type_desc = 'Certifikate e lindjes'

delete from Kerkesa where Kerkesa_id = 12


delete from Sherbimi where kostoja < 60

delete from Zenia_Stafit where eshte_aktiv = 'N'



-- Te krijoni min 5 query te thjeshta, te rezliohen vetem me nje relacion tabele

select s.emri  from Stafi s where s.emri = 'Jaydon'

-- Te selektohet stafi i cili eshte aktiv
select s.emri, s.mbiemri  from Stafi s where eshte_aktiv = 'P'

select  a.prodhuesi_automjetit from Automjeti a where a.prodhuesi_automjetit = 'Mercedes'
group by a.prodhuesi_automjetit

select * from Sherbimi sh where sh.sherbimi_desc = ''

select AVG(l.kostoja)  from Ligjerata l 
 


 --	Të krijoni min. 5 query të thjeshta, të realizohen në minimum dy relacione (tabela) e më tepër. 