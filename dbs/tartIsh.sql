create database tartIsh
use tartIsh

create table ErrorLog(
Id int Identity(1,1) not null,
UserIp nvarchar(20) not null,
UserRole nvarchar(20) not null,
ErrorCode nvarchar(20) not null,
ErrorPage nvarchar(300) not null,
ErrorDate datetime not null,
ErrorCount int,
Constraint P_ErrorLog PRIMARY KEY(Id),
CONSTRAINT U_ErrorLog UNIQUE (UserIp),
)


create table Hobby(
Id int Identity(1,1) not null,
HobbyName nvarchar(50) not null,
HobbyDescription nvarchar(150),
HobbyImg nvarchar(250),
Constraint P_Hobby PRIMARY KEY(Id),
)

insert into Hobby(HobbyName,HobbyDescription,HobbyImg) values('Kitap Okumak','Kitap okuyan kişilerin hobisi.','www.google.com/images/book')
insert into Hobby(HobbyName,HobbyDescription) values('Kod yazmak','kodAçıklama')
insert into Hobby(HobbyName) values('Balık tutmak')
insert into Hobby(HobbyName) values('Oyun oynamak')
insert into Hobby(HobbyName) values('Yemek yapmak')
insert into Hobby(HobbyName) values('Zeka soruları çözmek')

create table Rosette(
Id int Identity(1,1) not null,
RosetteName nvarchar(50) not null,
RosetteImg nvarchar(250) not null,
Constraint P_Rosette PRIMARY KEY(Id),
)

insert into Rosette(RosetteName,RosetteImg) values('İlk 100 Üye','eklenecek')
insert into Rosette(RosetteName,RosetteImg) values('İlk Zafer Alan','eklenecek')
insert into Rosette(RosetteName,RosetteImg) values('100 zafer alan','eklenecek')

create table Ban(
Id int Identity(1,1) not null,
Reason nvarchar(300) not null,
BanDuration int not null,
LastDate datetime not null,
IsSelectable bit not null,
BanPriority int,
Constraint P_Ban PRIMARY KEY(Id),
)


create table Category(
Id int Identity(1,1) not null,
CategoryName nvarchar(50) not null,
CategoryDescription nvarchar(200),
Constraint P_Category PRIMARY KEY(Id),
)

insert into Category(CategoryName) values('Bilim')
insert into Category(CategoryName) values('İnanç')
insert into Category(CategoryName) values('Siyaset')
insert into Category(CategoryName) values('Oyun')
insert into Category(CategoryName) values('Eğlence')
insert into Category(CategoryName) values('Sanat')
insert into Category(CategoryName) values('Harici')

create table UserType(
Id int Identity(1,1) not null,
TypeName nvarchar(50) not null,
Constraint P_UserType PRIMARY KEY(Id),
CONSTRAINT U_UserType UNIQUE (TypeName),
)

insert into UserType(TypeName) values('Admin')
insert into UserType(TypeName) values('Premium')
insert into UserType(TypeName) values('User')

create table TartIshStatus(
Id int Identity(1,1) not null,
StatusName nvarchar(50) not null,
Constraint P_TartIshStatus PRIMARY KEY(Id),
)

insert into TartIshStatus(StatusName) values ('Tartışıyor')
insert into TartIshStatus(StatusName) values ('Tartışma İzliyor')
insert into TartIshStatus(StatusName) values ('Sayfada geziniyor')

create table TartIshSection(
Id int Identity(1,1) not null,
SectionName nvarchar(50) not null,
Title nvarchar(100) not null,
ViewerTypeId int not null,
Content nvarchar(max),
Constraint P_Section PRIMARY KEY(Id),
CONSTRAINT F_Section FOREIGN KEY(ViewerTypeId) REFERENCES UserType(Id),
)

create table TartIshUser(
Id int Identity(1,1) not null,
FirstName nvarchar(50) not null,
LastName nvarchar(50) not null,
UserName nvarchar(50) not null,
Email nvarchar(60) not null,
BirthDate date not null,
Sex bit not null,
UserPassword nvarchar(200) not null,
UserTypeId int not null,
TotalActiveteMinutes int not null,
IsPassive bit not null,
IsDelete bit not null,
IsBanned bit not null,
LastLogIn datetime,
RegisterDate datetime,
PassiveDate datetime,
DeleteDate datetime,
Constraint P_TartIshUser PRIMARY KEY(Id),
CONSTRAINT F_TartIshUser FOREIGN KEY(UserTypeId) REFERENCES UserType(Id),
CONSTRAINT U_TartIshUser UNIQUE (Email),
CONSTRAINT U_TartIshUser2 UNIQUE (UserName)
)

insert into TartIshUser(FirstName,LastName,UserName,Email,BirthDate,Sex,
UserPassword,UserTypeId,TotalActiveteMinutes,IsPassive,IsDelete,IsBanned) 
values('Server','ÇETİN','admin','merhaba@servercetin.com','1993/01/07',1,'123',1,0,0,0,0)


create table AdminTask(
Id int Identity(1,1) not null,
Task nvarchar(250) not null,
EmployeeId int,
LastDate datetime,
Progress int,
Constraint P_AdminTask PRIMARY KEY(Id),
CONSTRAINT F_AdminTask FOREIGN KEY(EmployeeId) REFERENCES TartIshUser(Id),
)

insert into AdminTask(Task,EmployeeId,LastDate,Progress) values ('Logların temizlenmesi',1,2020/01/06,0)
insert into AdminTask(Task,LastDate,Progress) values ('Logların temizlenmesi',2020/01/06,0)
insert into AdminTask(Task,Progress) values ('Logların temizlenmesi',0)

create table UserMessage(
Id int Identity(1,1) not null,
SenderId int not null,
ReceiverId int not null,
MessageText nvarchar(400) not null,
SentDate datetime not null,
IsDelete bit,
Constraint P_UserMessage PRIMARY KEY(Id),
CONSTRAINT F_UserMessage FOREIGN KEY(SenderId) REFERENCES TartIshUser(Id),
CONSTRAINT F_UserMessage2 FOREIGN KEY(ReceiverId) REFERENCES TartIshUser(Id),
)

create table DeletedMessages(
Id int Identity(1,1) not null,
SenderId int not null,
ReceiverId int not null,
MessageText nvarchar(400) not null,
SentDate datetime not null,
DeletedDate datetime,
Constraint P_DeletedMessages PRIMARY KEY(Id),
CONSTRAINT F_DeletedMessages FOREIGN KEY(SenderId) REFERENCES TartIshUser(Id),
CONSTRAINT F_DeletedMessages2 FOREIGN KEY(ReceiverId) REFERENCES TartIshUser(Id),
)


create table Mastery(
Id int Identity(1,1) not null,
UserId int not null,
CategoryWins int not null,
CategoryMatchingCount int not null,
LastMatch datetime,
LastOwnedDate datetime,
Rates float not null,
IsPassive bit,
IsDelete bit,
CategoryId int not null,
Constraint P_Mastery PRIMARY KEY(Id),
CONSTRAINT F_Mastery FOREIGN KEY(CategoryId) REFERENCES Category(Id),
CONSTRAINT F_Mastery2 FOREIGN KEY(UserId) REFERENCES TartIshUser(Id),
)


create table UserHobies(
Id int Identity(1,1) not null,
UserId int not null,
HobbyId int not null,
Constraint P_UserHobies PRIMARY KEY(Id),
CONSTRAINT F_UserHobies FOREIGN KEY(HobbyId) REFERENCES Hobby(Id),
CONSTRAINT F_UserHobies2 FOREIGN KEY(UserId) REFERENCES TartIshUser(Id),
)


create table Chat(
Id int Identity(1,1) not null,
ModeratorId int not null,
Constraint P_Chat PRIMARY KEY(Id),
CONSTRAINT F_Chat FOREIGN KEY(ModeratorId) REFERENCES TartIshUser(Id),
)


create table UserSubscriber(
Id int Identity(1,1) not null,
SubscriberId int not null,
SubscribedId int not null,
SubscriptionDate datetime not null,
Constraint P_UserSubscriber PRIMARY KEY(Id),
CONSTRAINT F_UserSubscriber FOREIGN KEY(SubscriberId) REFERENCES TartIshUser(Id),
)


create table UserProfileImage(
Id int Identity(1,1) not null,
ImageUrl nvarchar(250) not null,
UploadedDate datetime not null,
UserId int not null,
IsPassive bit,
Constraint P_UserProfileImage PRIMARY KEY(Id),
CONSTRAINT F_UserProfileImage FOREIGN KEY(UserId) REFERENCES TartIshUser(Id),
)

create table NotificationUser(
Id int Identity(1,1) not null,
Title nvarchar(50) not null,
Content nvarchar(300),
SentDate datetime not null,
UserId int not null,
Constraint P_NotificationUser PRIMARY KEY(Id),
CONSTRAINT F_NotificationUser FOREIGN KEY(UserId) REFERENCES TartIshUser(Id),
)


create table ChatMessage(
Id int Identity(1,1) not null,
SenderId int not null,
ChatId int not null,
IsDeleted bit not null,
SentDate datetime not null,
DeletedDate datetime,
Constraint P_ChatMessage PRIMARY KEY(Id),
CONSTRAINT F_ChatMessage FOREIGN KEY(SenderId) REFERENCES TartIshUser(Id),
CONSTRAINT F_ChatMessage3 FOREIGN KEY(ChatId) REFERENCES Chat(Id),
)

create table TartIshRoom(
Id int Identity(1,1) not null,
Title nvarchar(50) not null,
RoomDescription nvarchar(200) not null,
CategoryId int not null,
ViewersCount int not null,
RoomCreatorId int not null,
RivalId int,
RoomImageUrl nvarchar(250) not null,
ChatId int,
RoomStartDate datetime not null,
RoomFinishDate datetime,
WinnerId int,
IsRoomPrivate bit not null,
IsRunAway bit,
IsPassive bit,
IsFinished bit,
RunawayId int,
Constraint P_TartIshRoom PRIMARY KEY(Id),
CONSTRAINT F_TartIshRoom FOREIGN KEY(CategoryId) REFERENCES Category(Id),
CONSTRAINT F_TartIshRoom2 FOREIGN KEY(ChatId) REFERENCES Chat(Id),
CONSTRAINT F_TartIshRoom3 FOREIGN KEY(RoomCreatorId) REFERENCES TartIshUser(Id),
CONSTRAINT F_TartIshRoom4 FOREIGN KEY(RivalId) REFERENCES TartIshUser(Id),
CONSTRAINT F_TartIshRoom5 FOREIGN KEY(WinnerId) REFERENCES TartIshUser(Id),
CONSTRAINT F_TartIshRoom6 FOREIGN KEY(RunawayId) REFERENCES TartIshUser(Id),
)

create table UserWatchedRoom(
Id int Identity(1,1) not null,
UserId int not null,
TartIshRoomId int not null,
WatchedDuration int not null,
Constraint P_UserWatchedRoom PRIMARY KEY(Id),
CONSTRAINT F_UserWatchedRoom FOREIGN KEY(UserId) REFERENCES TartIshUser(Id),
CONSTRAINT F_UserWatchedRoo2m FOREIGN KEY(TartIshRoomId) REFERENCES TartIshRoom(Id),
)


create table UserStatus(
Id int Identity(1,1) not null,
TartIshStatusId int not null,
TartIshRoomId int,
StatusStartDate datetime not null,
Constraint P_UserStatus PRIMARY KEY(Id),
CONSTRAINT F_UserStatus FOREIGN KEY(TartIshStatusId) REFERENCES TartIshStatus(Id),
CONSTRAINT F_UserStatus2 FOREIGN KEY(TartIshRoomId) REFERENCES TartIshRoom(Id),
)

create table RoomVotes(
Id int Identity(1,1) not null,
RoomId int not null,
RoomOwnerVotesCount int not null,
RivalVotesCount int not null,
Constraint P_RoomVotes PRIMARY KEY(Id),
CONSTRAINT F_RoomVotes FOREIGN KEY(RoomId) REFERENCES TartIshRoom(Id),
)

create table RoomVote(
Id int Identity(1,1) not null,
RoomVotesId int not null,
SenderId int not null,
VotedId int not null,
Constraint P_RoomVote PRIMARY KEY(Id),
CONSTRAINT F_RoomVote FOREIGN KEY(RoomVotesId) REFERENCES RoomVotes(Id),
CONSTRAINT F_RoomVote2 FOREIGN KEY(SenderId) REFERENCES TartIshUser(Id),
CONSTRAINT F_RoomVote3 FOREIGN KEY(VotedId) REFERENCES TartIshUser(Id),
)


create table RoomComplaint(
Id int Identity(1,1) not null,
Reason nvarchar(200) not null,
SenderId int not null,
TartIshRoomId int not null,
Constraint P_RoomComplaint PRIMARY KEY(Id),
CONSTRAINT F_RoomComplaint FOREIGN KEY(TartIshRoomId) REFERENCES TartIshRoom(Id),
)


create table Rating(
Id int Identity(1,1) not null,
CategoryId int not null,
SenderId int not null,
ReceiverId int not null,
RatingValue float not null,
Reason nvarchar(400) not null,
IsPassive bit not null, 
Constraint P_Rating PRIMARY KEY(Id),
CONSTRAINT F_Rating FOREIGN KEY(SenderId) REFERENCES TartIshUser(Id),
CONSTRAINT F_Rating2 FOREIGN KEY(SenderId) REFERENCES TartIshUser(Id),
CONSTRAINT F_Rating3 FOREIGN KEY(ReceiverId) REFERENCES TartIshUser(Id),
CONSTRAINT F_Rating4 FOREIGN KEY(ReceiverId) REFERENCES TartIshUser(Id),
)

Create table UserRosette(
Id int Identity(1,1) not null,
UserId int not null,
RosetteId int not null,
OwnedDate datetime not null,
IsPassive bit not null,
IsDelete bit not null,
Constraint P_UserRosette PRIMARY KEY(Id),
CONSTRAINT F_UserRosette FOREIGN KEY(UserId) REFERENCES TartIshUser(Id),
CONSTRAINT F_UserRosette2 FOREIGN KEY(UserId) REFERENCES TartIshUser(Id),
CONSTRAINT F_UserRosette3 FOREIGN KEY(RosetteId) REFERENCES Rosette(Id),
)


create table Suggestion(
Id int Identity(1,1) not null,
SenderId int not null,
Title nvarchar(200),
SuggestionText nvarchar(400) not null,
Constraint P_Suggestion PRIMARY KEY(Id),
CONSTRAINT F_Suggestion FOREIGN KEY(SenderId) REFERENCES TartIshUser(Id),
)


create table UserBan(
Id int Identity(1,1) not null,
UserId int not null,
BanId int not null,
Constraint P_UserBan PRIMARY KEY(Id),
CONSTRAINT F_UserBan FOREIGN KEY(UserId) REFERENCES TartIshUser(Id),
CONSTRAINT F_UserBan2 FOREIGN KEY(BanId) REFERENCES Ban(Id),
)

create table Premium(
Id int Identity(1,1) not null,
UserId int not null,
PremiumDate datetime not null,
PremiumEndDate datetime not null,
Constraint P_Premium PRIMARY KEY(Id),
CONSTRAINT F_Premium FOREIGN KEY(UserId) REFERENCES TartIshUser(Id),
)

create table PremiumUser(
Id int Identity(1,1) not null,
UserId int not null,
FirstPremiumDate datetime not null,
LastUpdatedPremiumDate datetime not null,
OwnedPremiumCount int not null,
PremiumStreak int,
Constraint P_PremiumUser PRIMARY KEY(Id),
CONSTRAINT F_PremiumUser FOREIGN KEY(UserId) REFERENCES TartIshUser(Id),
)


create table PersonComplaint(
Id int Identity(1,1) not null,
SenderId int not null,
ComplaintedId int not null,
Reason nvarchar(200) not null,
Constraint P_PersonComplaint PRIMARY KEY(Id),
CONSTRAINT F_PersonComplaint FOREIGN KEY(SenderId) REFERENCES TartIshUser(Id),
CONSTRAINT F_PersonComplaint2 FOREIGN KEY(ComplaintedId) REFERENCES TartIshUser(Id),
)

insert into PersonComplaint(SenderId,ComplaintedId,Reason) values(1,1,'Deneme')

create table Poll(
Id int Identity(1,1) not null,
TartIshRoomId int not null,
PollQuestion nvarchar(200) not null,
PollWinnerPollId int not null,
Constraint P_Poll PRIMARY KEY(Id),
CONSTRAINT F_Poll FOREIGN KEY(TartIshRoomId) REFERENCES TartIshRoom(Id),
)

create table PollOption(
Id int Identity(1,1) not null,
PoolTitle nvarchar(50) not null,
PoolId int not null,
VoteCount int not null,
Constraint P_PollOption PRIMARY KEY(Id),
CONSTRAINT F_PollOption FOREIGN KEY(PoolId) REFERENCES Poll(Id),
)


create table UserSelectedPoll(
Id int Identity(1,1) not null,
UserId int not null,
PoolOptionId int not null,
Constraint P_UserSelectedPoll PRIMARY KEY(Id),
CONSTRAINT F_UserSelectedPoll FOREIGN KEY(UserId) REFERENCES TartIshUser(Id),
CONSTRAINT F_UserSelectedPoll2 FOREIGN KEY(PoolOptionId) REFERENCES PollOption(Id),
)

create table Document(
Id int Identity(1,1) not null,
SenderId int not null,
SentDate datetime not null,
DocumentUrl nvarchar(250) not null,
DocumentType nvarchar(20) not null,
TartIshRoomId int not null,
Constraint P_Document PRIMARY KEY(Id),
CONSTRAINT F_Document FOREIGN KEY(TartIshRoomId) REFERENCES TartIshRoom(Id),
)


select * from UserType
select * from UserSubscriber
select * from UserStatus
select * from TartIshStatus
select * from UserSelectedPoll
select * from UserRosette
select * from UserProfileImage
select * from UserMessage
select * from UserHobies
select * from UserBan
select * from TartIshUser
select * from TartIshRoom
select * from tartIshSection
select * from Suggestion
select * from Rosette
select * from RoomVotes
select * from RoomVote
select * from RoomComplaint
select * from Rating
select * from PremiumUser
select * from Premium
select * from PollOption
select * from Poll
select * from PersonComplaint
select * from NotificationUser
select * from Mastery
select * from Hobby
select * from ErrorLog
select * from Document
select * from DeletedMessages
select * from ChatMessage
select * from Chat
select * from Category
select * from Ban
select * from AdminTask
select * from UserWatchedRoom

use master
drop database tartIshDB