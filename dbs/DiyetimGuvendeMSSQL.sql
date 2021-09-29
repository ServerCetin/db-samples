create database DiyetinGuvende
use  DiyetinGuvende

Create Table KullaniciTur(
Id int Identity(1,1),
TurAd nvarchar(15) not null,
CONSTRAINT PK_HocaTur PRIMARY KEY (Id)
) --Kullanıcılarda normalizasyon sıkıntısı oluyor birden fazla olunca, dolayısıyla bir tane kullanıcı açıp türId üzerinden kullanıcı tipine erişeceğiz

insert into KullaniciTur(TurAd) values ('Diyetisyen')
insert into KullaniciTur(TurAd) values ('Spor Hocası')
insert into KullaniciTur(TurAd) values ('Kullanıcı')

Create Table Cinsiyet (
Id int IDENTITY(1,1),
CinsiyetAd nvarchar(10) not null
CONSTRAINT PK_Cinsiyet PRIMARY KEY (Id)
)

Create Table ProgramSaat (
Id int IDENTITY(1,1),
Saat float not null --diyetisyen saat girebilir demiştik, verileri çekince sıralama yapabilmek adına float yaptım.
CONSTRAINT PK_ProgramSaat PRIMARY KEY (Id)
)

Create Table ProgramGun (
Id int IDENTITY(1,1),
Gun nvarchar(9) not null --gunleri ayrı bir tabloya çekmemin sebebi belki hoca boş bir gün bırakabilir ve de iki tabloda gün olayı var normalize edilmiş hali tablo gerektiriyor
CONSTRAINT PK_ProgramGun PRIMARY KEY (Id)
)

Create Table ProgramGunSaat (--bu tablo diyet programının hangi gün ve saatte olacağını temsil ediyor, konuştuğumuzda böyle denildiği için bu tabloları yapıyorum. Fazla gözükebilir ama gerekiyor
Id int IDENTITY(1,1),
ProgramSaatId int not null,
ProgramGunId int null,
CONSTRAINT PK_ProgramGunSaat PRIMARY KEY (Id),
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
Id int IDENTITY(1,1),
Ad nvarchar(20) not null,
CONSTRAINT PK_YiyecekTuru PRIMARY KEY (Id)
)--Sürekli Türü girmek de normalizasyona uymuyor. Belki panel yaparsak select falan yaptırabiliriz. Veya insert into yerine kodla indexe bir yere eklenir bu tarz ekleme olayı. Dbye Eklendikten sonra silinir veya sqlden yapılır hangisi daha kolay oluyorsa

Create Table SporTuru(
Id int IDENTITY(1,1),
Ad nvarchar(20) not null,
Aciklama nvarchar(100), 
CONSTRAINT PK_SporTuru PRIMARY KEY (Id)
)

insert into SporTuru(Ad,Aciklama) values ('Şınav','Şınav ellerin omuz hizasında tutulduğu yerde aşağı yukarı kalkma hareketidir.')

Create Table YiyecekMiktar(
Id int IDENTITY(1,1),
Ad nvarchar(20) not null,
CONSTRAINT PK_YiyecekMiktar PRIMARY KEY (Id),
)-- bu da aynı şekilde yiyeceğin belirleyicisi, sürekli girilmemesi ve seçilmesi adına yapılmış. Gereksiz diyorsanız bu tablo silinip diyetyemek tablosuna bu varlık eklenebilir

insert into YiyecekMiktar(Ad) values ('Gram')
insert into YiyecekMiktar(Ad) values ('Kilo')
insert into YiyecekMiktar(Ad) values ('Tabak')
insert into YiyecekMiktar(Ad) values ('Kaşık')

Create Table Yiyecek(
Id int IDENTITY(1,1),
Ad nvarchar(50) not null,
TurId int not null,
Kalori int not null,
Protein float not null,  --nette gezindiğimde virgüllü değer alabiliyordu bu ondan float
CONSTRAINT PK_Yiyecek PRIMARY KEY(Id),
CONSTRAINT FK_Yiyecek FOREIGN KEY (TurId) REFERENCES YiyecekTuru(Id)
) -- Bir yiyecekte ne özellikler isteniyorsa eklenebilir

Create Table Kullanici(
Id int Identity(1,1),
CinsiyetId int not null,
Ad nvarchar(30) not null,
Soyad nvarchar(30) not null,
DogumTarih date not null,
KullaniciAdi nvarchar(15) not null,
Email nvarchar(50) not null,
TelefonNo nvarchar(15) not null,
Sifre nvarchar(150) not null,
KullaniciTurId int not null,
CONSTRAINT PK_Kullanici PRIMARY KEY (Id),
CONSTRAINT U_Kullanici UNIQUE (TelefonNo),
CONSTRAINT U_Kullanici2 UNIQUE (KullaniciAdi),
CONSTRAINT FK_Kullanici FOREIGN KEY (CinsiyetId) REFERENCES Cinsiyet(Id),
CONSTRAINT FK_Kullanici2 FOREIGN KEY (KullaniciTurId) REFERENCES KullaniciTur(Id)
)

Create Table HastaDiyet(
Id int IDENTITY(1,1),
HastaId int not null,
DiyetisyenId int not null,
DiyetisyenNot nvarchar(max) not null, --max yapmak biraz sıkıntılı ama şimdilik böyle kalabilir sanırım
DiyetBaslangic datetime not null,
CONSTRAINT PK_HastaDiyet PRIMARY KEY (Id),
CONSTRAINT FK_HastaDiyet FOREIGN KEY (HastaId) REFERENCES Kullanici(Id),
CONSTRAINT FK_HastaDiyet2 FOREIGN KEY (DiyetisyenId) REFERENCES Kullanici(Id)
)

Create Table HastaSpor(
Id int IDENTITY(1,1),
HastaId int not null,
HocaId int not null,
HocaNot nvarchar(max) not null, --max yapmak biraz sıkıntılı ama şimdilik böyle kalabilir sanırım
ProgramBaslangic datetime not null,
CONSTRAINT PK_HastaSpor PRIMARY KEY (Id),
CONSTRAINT FK_HastaSpor FOREIGN KEY (HastaId) REFERENCES Kullanici(Id),
CONSTRAINT FK_HastaSpor2 FOREIGN KEY (HocaId) REFERENCES Kullanici(Id)
)

Create Table DiyetYemek( --bu tablo diyetisyenin kullanıcıya vereceği yemeği temsil ediyor
Id int IDENTITY(1,1),
YiyecekId int not null,
YiyecekMiktarId int, --belki miktarı belirtmek istemeyebilir o yüzden nullable yaptım
HastaId int not null, --bu ve altındaki gelecekte ayrıntılı bilgi çekersek lazım olacak
DiyetisyenId int not null,
CONSTRAINT PK_DiyetYemek PRIMARY KEY(Id),
CONSTRAINT FK_DiyetYemek FOREIGN KEY (YiyecekId) REFERENCES Yiyecek(Id),
CONSTRAINT FK_DiyetYemek2 FOREIGN KEY (YiyecekMiktarId) REFERENCES YiyecekMiktar(Id),
CONSTRAINT FK_DiyetYemek3 FOREIGN KEY (HastaId) REFERENCES Kullanici(Id),
CONSTRAINT FK_DiyetYemek4 FOREIGN KEY (DiyetisyenId) REFERENCES Kullanici(Id)
)

Create Table SporHareket( --bu tablo spor hocasının kullanıcıya vereceği hareketleri temsil ediyor
Id int IDENTITY(1,1),
HastaId int not null, --bu ve altındaki gelecekte ayrıntılı bilgi çekersek lazım olacak
SporTuruId int not null,
DiyetisyenId int not null,
CONSTRAINT PK_SporHareket PRIMARY KEY(Id),
CONSTRAINT FK_SporHareket FOREIGN KEY (SporTuruId) REFERENCES SporTuru(Id),
CONSTRAINT FK_SporHareket2 FOREIGN KEY (HastaId) REFERENCES Kullanici(Id),
CONSTRAINT FK_SporHareket3 FOREIGN KEY (DiyetisyenId) REFERENCES Kullanici(Id)
)

Create Table DiyetYemekSaat(
Id int IDENTITY(1,1),
DiyetYemekId int not null,
ProgramGunSaatId int not null, 
HastaDiyetId int not null,
CONSTRAINT PK_DiyetYemekSaat PRIMARY KEY (Id),
CONSTRAINT FK_DiyetYemekSaat FOREIGN KEY(DiyetYemekId) REFERENCES DiyetYemek(Id),
CONSTRAINT FK_DiyetYemekSaat2 FOREIGN KEY(ProgramGunSaatId) REFERENCES ProgramGunSaat(Id),
CONSTRAINT FK_DiyetYemekSaat3 FOREIGN KEY(HastaDiyetId) REFERENCES HastaDiyet(Id)
)

Create Table SporHareketSaat(
Id int IDENTITY(1,1),
SporHareketId int not null,
ProgramGunSaatId int not null, 
HastaSporId int not null,
CONSTRAINT PK_SporHareketSaat PRIMARY KEY (Id),
CONSTRAINT FK_SporHareketSaat FOREIGN KEY(SporHareketId) REFERENCES SporHareket(Id),
CONSTRAINT FK_SporHareketSaat2 FOREIGN KEY(ProgramGunSaatId) REFERENCES ProgramGunSaat(Id),
CONSTRAINT FK_SporHareketSaat3 FOREIGN KEY(HastaSporId) REFERENCES HastaSpor(Id)
)

Create Table HastaBilgi( --hastadan rozeti sildim, zaten kod pzt için yeteri kadar komplex olacak. eğer derseniz ki ekleyelim 1 tablo bir de çağırıcıyla hallolur
Id int,
KullaniciId int,
Boy int not null, --boy cm cinsinden olacak
Kilo float not null,
YagOrani float, --nullable yaptım, bence herkes hesaplayamaz bunu ama isterseniz null yapılabilir
DiyetisyenId int not null,
KocId int not null,
CONSTRAINT PK_HastaBilgi PRIMARY KEY (Id),
CONSTRAINT FK_HastaBilgi FOREIGN KEY (KullaniciId) REFERENCES Cinsiyet(Id),
CONSTRAINT FK_HastaBilgi2 FOREIGN KEY (DiyetisyenId) REFERENCES Kullanici(Id), -- şu anda zaten validasyon falan yaptırmayacak hoca
CONSTRAINT FK_HastaBilgi3 FOREIGN KEY (KocId) REFERENCES Kullanici(Id) -- o yüzden o şunundur falan kodda yazılmayacak sadece veri tabanı bağlantısı ve elle girdi yetiyor herhalde
)-- güncel tabloları barındıran id yerleri de açacaktım ama zaten en son tarihe ait olanı çekince güncel olan olacak


Create Table DestekKategori(
Id int IDENTITY(1,1),
Ad nvarchar(30) not null,
Aciklama nvarchar(100), -- belki neden bunu seçmesiyle alakalı bilgilendirme koyulabilir o yüzden ekledim, nullable
CONSTRAINT PK_DestekKategori PRIMARY KEY (Id)
)

insert into DestekKategori(Ad,Aciklama) values ('Teknik Sorunlar','Sitede gördüğünüz açık veya sorunlarda bu seçeneği seçmelisiniz.')

Create Table Destek(
Id int IDENTITY(1,1),
GonderenId int not null,
Sorun nvarchar(250) not null, -- max'ı kullanmak biraz riskli çok fazla spam olabilir o yüzden az tutmak en iyisi
SorunKategoriId int not null,
CONSTRAINT PK_Destek PRIMARY KEY (Id),
CONSTRAINT FK_Destek FOREIGN KEY (GonderenId) REFERENCES Cinsiyet(Id),
CONSTRAINT FK_Destek2 FOREIGN KEY (SorunKategoriId) REFERENCES DestekKategori(Id)
)

create table KullaniciMesaj(
Id int Identity(1,1) not null,
GonderenId int not null,
AlanId int not null,
Mesaj nvarchar(400) not null,
GonderilmeTarihi datetime not null,
Constraint P_UserMessage PRIMARY KEY(Id),
CONSTRAINT F_UserMessage FOREIGN KEY(GonderenId) REFERENCES Kullanici(Id),
CONSTRAINT F_UserMessage2 FOREIGN KEY(AlanId) REFERENCES Kullanici(Id)
)


