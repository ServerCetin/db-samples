create database DiyetinGuvende
use  DiyetinGuvende

Create Table KullaniciTur(
Id int AUTO_INCREMENT PRIMARY KEY,
TurAd varchar(15) not null
) 

insert into KullaniciTur(TurAd) values ('Diyetisyen');
insert into KullaniciTur(TurAd) values ('Spor Hocası');
insert into KullaniciTur(TurAd) values ('Kullanıcı');

Create Table Cinsiyet (
Id int AUTO_INCREMENT PRIMARY KEY,
CinsiyetAd varchar(10) not null
)

insert into Cinsiyet(CinsiyetAd) values ('Kadın');
insert into Cinsiyet(CinsiyetAd) values ('Erkek');

Create Table ProgramSaat (
Id int AUTO_INCREMENT PRIMARY KEY,
Saat float not null
)

Create Table ProgramGun (
Id int AUTO_INCREMENT PRIMARY KEY,
Gun varchar(9) not null)

Create Table ProgramGunSaat (
Id int AUTO_INCREMENT PRIMARY KEY,
ProgramSaatId int not null,
ProgramGunId int null,
CONSTRAINT FK_ProgramGunSaat FOREIGN KEY (ProgramSaatId) REFERENCES ProgramSaat(Id),
CONSTRAINT FK_ProgramGunSaat2 FOREIGN KEY (ProgramGunId) REFERENCES ProgramGun(Id)
)

insert into ProgramGun(Gun) values ('Pazartesi');
insert into ProgramGun(Gun) values ('Salı');
insert into ProgramGun(Gun) values ('Çarşamba');
insert into ProgramGun(Gun) values ('Perşembe');
insert into ProgramGun(Gun) values ('Cuma');
insert into ProgramGun(Gun) values ('Cumartesi');
insert into ProgramGun(Gun) values ('Pazar');

Create Table YiyecekTuru(
Id int AUTO_INCREMENT PRIMARY KEY,
Ad varchar(20) not null
)

Create Table SporTuru(
Id int AUTO_INCREMENT PRIMARY KEY,
Ad varchar(20) not null,
Aciklama varchar(100)
)

insert into SporTuru(Ad,Aciklama) values ('Şınav','Şınav ellerin omuz hizasında tutulduğu yerde aşağı yukarı kalkma hareketidir.')

Create Table YiyecekMiktar(
Id int AUTO_INCREMENT PRIMARY KEY,
Ad varchar(20) not null
)

insert into YiyecekMiktar(Ad) values ('Gram');
insert into YiyecekMiktar(Ad) values ('Kilo');
insert into YiyecekMiktar(Ad) values ('Tabak');
insert into YiyecekMiktar(Ad) values ('Kaşık');

Create Table Yiyecek(
Id int AUTO_INCREMENT PRIMARY KEY,
Ad varchar(50) not null,
TurId int not null,
Kalori int not null,
Protein float not null, 
CONSTRAINT FK_Yiyecek FOREIGN KEY (TurId) REFERENCES YiyecekTuru(Id)
) 

Create Table Kullanici(
Id int AUTO_INCREMENT PRIMARY KEY,
CinsiyetId int not null,
Ad varchar(30) not null,
Soyad varchar(30) not null,
DogumTarih date not null,
KullaniciAdi varchar(15) not null,
Email varchar(50) not null,
TelefonNo varchar(15) not null,
Sifre varchar(150) not null,
KullaniciTurId int not null,
CONSTRAINT U_Kullanici UNIQUE (TelefonNo),
CONSTRAINT U_Kullanici2 UNIQUE (KullaniciAdi),
CONSTRAINT FK_Kullanici FOREIGN KEY (CinsiyetId) REFERENCES Cinsiyet(Id),
CONSTRAINT FK_Kullanici2 FOREIGN KEY (KullaniciTurId) REFERENCES KullaniciTur(Id)
)

Create Table HastaDiyet(
Id int AUTO_INCREMENT PRIMARY KEY,
HastaId int not null,
DiyetisyenId int not null,
DiyetisyenNot varchar(500) not null,
DiyetBaslangic datetime not null,
CONSTRAINT FK_HastaDiyet FOREIGN KEY (HastaId) REFERENCES Kullanici(Id),
CONSTRAINT FK_HastaDiyet2 FOREIGN KEY (DiyetisyenId) REFERENCES Kullanici(Id)
)

Create Table HastaSpor(
Id int AUTO_INCREMENT PRIMARY KEY,
HastaId int not null,
HocaId int not null,
HocaNot varchar(500) not null,
ProgramBaslangic datetime not null,
CONSTRAINT FK_HastaSpor FOREIGN KEY (HastaId) REFERENCES Kullanici(Id),
CONSTRAINT FK_HastaSpor2 FOREIGN KEY (HocaId) REFERENCES Kullanici(Id)
)

Create Table DiyetYemek( 
Id int AUTO_INCREMENT PRIMARY KEY,
YiyecekId int not null,
YiyecekMiktarId int, 
HastaId int not null, 
DiyetisyenId int not null,
CONSTRAINT FK_DiyetYemek FOREIGN KEY (YiyecekId) REFERENCES Yiyecek(Id),
CONSTRAINT FK_DiyetYemek2 FOREIGN KEY (YiyecekMiktarId) REFERENCES YiyecekMiktar(Id),
CONSTRAINT FK_DiyetYemek3 FOREIGN KEY (HastaId) REFERENCES Kullanici(Id),
CONSTRAINT FK_DiyetYemek4 FOREIGN KEY (DiyetisyenId) REFERENCES Kullanici(Id)
)

Create Table SporHareket(
Id int AUTO_INCREMENT PRIMARY KEY,
HastaId int not null, 
SporTuruId int not null,
DiyetisyenId int not null,
CONSTRAINT FK_SporHareket FOREIGN KEY (SporTuruId) REFERENCES SporTuru(Id),
CONSTRAINT FK_SporHareket2 FOREIGN KEY (HastaId) REFERENCES Kullanici(Id),
CONSTRAINT FK_SporHareket3 FOREIGN KEY (DiyetisyenId) REFERENCES Kullanici(Id)
)

Create Table DiyetYemekSaat(
Id int AUTO_INCREMENT PRIMARY KEY,
DiyetYemekId int not null,
ProgramGunSaatId int not null, 
HastaDiyetId int not null,
CONSTRAINT FK_DiyetYemekSaat FOREIGN KEY(DiyetYemekId) REFERENCES DiyetYemek(Id),
CONSTRAINT FK_DiyetYemekSaat2 FOREIGN KEY(ProgramGunSaatId) REFERENCES ProgramGunSaat(Id),
CONSTRAINT FK_DiyetYemekSaat3 FOREIGN KEY(HastaDiyetId) REFERENCES HastaDiyet(Id)
)

Create Table SporHareketSaat(
Id int AUTO_INCREMENT PRIMARY KEY,
SporHareketId int not null,
ProgramGunSaatId int not null, 
HastaSporId int not null,
CONSTRAINT FK_SporHareketSaat FOREIGN KEY(SporHareketId) REFERENCES SporHareket(Id),
CONSTRAINT FK_SporHareketSaat2 FOREIGN KEY(ProgramGunSaatId) REFERENCES ProgramGunSaat(Id),
CONSTRAINT FK_SporHareketSaat3 FOREIGN KEY(HastaSporId) REFERENCES HastaSpor(Id)
)

Create Table HastaBilgi( 
Id int,
KullaniciId int,
Boy int not null, 
Kilo float not null,
YagOrani float, 
DiyetisyenId int not null,
KocId int not null,
CONSTRAINT FK_HastaBilgi FOREIGN KEY (KullaniciId) REFERENCES Cinsiyet(Id),
CONSTRAINT FK_HastaBilgi2 FOREIGN KEY (DiyetisyenId) REFERENCES Kullanici(Id), 
CONSTRAINT FK_HastaBilgi3 FOREIGN KEY (KocId) REFERENCES Kullanici(Id) 
)


Create Table DestekKategori(
Id int AUTO_INCREMENT PRIMARY KEY,
Ad varchar(30) not null,
Aciklama varchar(100)
)

insert into DestekKategori(Ad,Aciklama) values ('Teknik Sorunlar','Sitede gördüğünüz açık veya sorunlarda bu seçeneği seçmelisiniz.')

Create Table Destek(
Id int AUTO_INCREMENT PRIMARY KEY,
GonderenId int not null,
Sorun varchar(250) not null,
SorunKategoriId int not null,
CONSTRAINT FK_Destek FOREIGN KEY (GonderenId) REFERENCES Cinsiyet(Id),
CONSTRAINT FK_Destek2 FOREIGN KEY (SorunKategoriId) REFERENCES DestekKategori(Id)
)

create table KullaniciMesaj(
Id int AUTO_INCREMENT PRIMARY KEY not null,
GonderenId int not null,
AlanId int not null,
Mesaj varchar(400) not null,
GonderilmeTarihi datetime not null,
CONSTRAINT F_UserMessage FOREIGN KEY(GonderenId) REFERENCES Kullanici(Id),
CONSTRAINT F_UserMessage2 FOREIGN KEY(AlanId) REFERENCES Kullanici(Id)
)


