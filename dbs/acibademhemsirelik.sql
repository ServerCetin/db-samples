create database AcibademHemsirelik
use AcibademHemsirelik

create table ErrorLog(
Id int Identity(1,1) not null,
UserIp nvarchar(20) not null,
UserRole nvarchar(20) not null,
ErrorCode nvarchar(20) not null,
ErrorPage nvarchar(300) not null,
ErrorDate datetime not null,
ErrorCount int,
Constraint P_ErrorLog PRIMARY KEY(Id)
)

create table SiteVersion(
Id int Identity(1,1) not null,
ReleaseNumber int not null,
ReleaseDate nvarchar(20) not null,
VersionDescription nvarchar(150),
Constraint P_SiteVersion PRIMARY KEY(Id)
)

insert into SiteVersion(ReleaseNumber,ReleaseDate) values(122,'2019 Temmuz')

create table UserTypes(
Id int Identity(1,1) not null,
TypeName nvarchar(15) not null,
Constraint P_KullaniciTipi PRIMARY KEY(Id),
)

insert into UserTypes(TypeName) values('Admin')
insert into UserTypes(TypeName) values('Editor')

create table Categories(
Id int Identity(1,1) not null,
CategoryName nvarchar(30) not null,
CategoryDescription nvarchar(250) ,
Constraint P_Categories PRIMARY KEY(Id),
)

insert into Categories(CategoryName) values('MAKALELER')
insert into Categories(CategoryName) values('VİDEOLAR')
insert into Categories(CategoryName) values('İÇİMİZDEN BİRİ')
insert into Categories(CategoryName) values('KLİNİKTEN HİKAYELERİMİZ')
insert into Categories(CategoryName) values('UYGULAMALARIMIZI GELİŞTİRELİM')
insert into Categories(CategoryName) values('HABERLER')
insert into Categories(CategoryName) values('KONGRE TAKVİMİ')
insert into Categories(CategoryName) values('BİLİMSEL ÇALIŞMALAR')
insert into Categories(CategoryName) values('BUNLARI BİLİYOR MUYUZ?')
insert into Categories(CategoryName) values('HARİCİ')



create table Menus(
Id int Identity(1,1) not null,
MenuName nvarchar(30) not null,
MenuUrl nvarchar(200) not null,
MenuTarget bit not null,
UserTypesViewId int, 
Constraint P_Menu PRIMARY KEY(Id),
CONSTRAINT F_Menu FOREIGN KEY(UserTypesViewId) REFERENCES UserTypes(Id),
)


create table Users(
Id int Identity(1,1) not null,
FirstName nvarchar(30) not null,
Surname nvarchar(30) not null,
UserName nvarchar(20) not null,
UserPassword nvarchar(80) not null,
Mail nvarchar(80) not null,
UserTypeId int not null,
IsPassive bit,
IsDelete bit,
CreatedTime datetime not null,
UpdatedTime datetime,
PassivedDate datetime,
DeletedDate datetime,
Constraint P_Kullanici PRIMARY KEY(Id),
Constraint F_Kullanici FOREIGN KEY(UserTypeId) REFERENCES UserTypes(Id),
)

insert into Users(FirstName,Surname,UserName,UserPassword,Mail,UserTypeId,CreatedTime) values('Server','ÇETİN','admin','202cb962ac59075b964b07152d234b70','mail@mail.com',1,'2012-06-18 10:34:09.000 AM') --default kullanıcı

create table Pages(
Id int Identity(1,1) not null,
Title nvarchar(300) not null,
PageContent nvarchar(max),
AuthorId int not null,
PageUrl nvarchar(300) not null UNIQUE,
Summary nvarchar(300) ,
PagePriority tinyint,
UserTypeEditId int not null,
CategoryId int not null,
SiteVersionId int,
AddedDate smalldatetime not null,
EditedDate date,
IsApprove bit not null,
IsPassive bit,
IsDelete bit,
PassivedDate datetime,
DeletedDate datetime,
PageImage nvarchar(200) not null,
ViewCount int,
Constraint P_Sayfa PRIMARY KEY(Id),
Constraint F_Sayfa FOREIGN KEY(AuthorId) REFERENCES Users(Id),
Constraint F_Sayfa2 FOREIGN KEY(UserTypeEditId) REFERENCES UserTypes(Id),
Constraint F_Sayfa3 FOREIGN KEY(CategoryId) REFERENCES Categories(Id),
Constraint F_Sayfa4 FOREIGN KEY(SiteVersionId) REFERENCES SiteVersion(Id)
)

create table Complaint(
Id int Identity(1,1) not null,
Title nvarchar(100),
About nvarchar(max),
PageUrl nvarchar(300),
UserId int not null,
IsSolve bit not null,
AddedDate smalldatetime not null,
UpdatedDate smalldatetime,
Constraint P_Complaint PRIMARY KEY(Id),
Constraint F_Complaint FOREIGN KEY(UserId) REFERENCES Users(Id),
)

select * from UserTypes
select * from Categories
select * from Menus
select * from Users
select * from Pages
select * from SiteVersion

use master
drop database AcibademHemsirelik
