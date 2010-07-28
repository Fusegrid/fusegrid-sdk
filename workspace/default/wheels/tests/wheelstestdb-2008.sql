USE [wheelstestdb]
go

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND type in (N'U'))
DROP TABLE [dbo].[Users]
go
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PhotoGalleries]') AND type in (N'U'))
DROP TABLE [dbo].[PhotoGalleries]
go
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PhotoGalleryPhotos]') AND type in (N'U'))
DROP TABLE [dbo].[PhotoGalleryPhotos]
go
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Posts]') AND type in (N'U'))
DROP TABLE [dbo].[Posts]
go
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Authors]') AND type in (N'U'))
DROP TABLE [dbo].[Authors]
go
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Classifications]') AND type in (N'U'))
DROP TABLE [dbo].[Classifications]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Comments]') AND type in (N'U'))
DROP TABLE [dbo].[Comments]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Profiles]') AND type in (N'U'))
DROP TABLE [dbo].[Profiles]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tags]') AND type in (N'U'))
DROP TABLE [dbo].[Tags]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Cities]') AND type in (N'U'))
DROP TABLE [dbo].[Cities]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Shops]') AND type in (N'U'))
DROP TABLE [dbo].[Shops]
GO

/***********************************************
		building tables
***********************************************/
--Users
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[Address] [varchar](100) NULL,
	[City] [varchar](50) NULL,
	[State] [char](2) NULL,
	[ZipCode] [varchar](50) NULL,
	[Phone] [varchar](20) NULL,
	[Fax] [varchar](20) NULL,
	[BirthDay] [datetime] NULL,
	[BirthDayMonth] [int] NULL,
	[BirthDayYear] [int] NULL,
	[BirthTime] [time] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
go

ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_BirthTime]  DEFAULT ('18:26:08.6900000') FOR [BirthTime]
GO

-- PhotoGalleries
CREATE TABLE [dbo].[PhotoGalleries](
	[photogalleryid] [int] IDENTITY(1,1) NOT NULL,
	[userid] [int] NOT NULL,
	[title] [varchar](255) NOT NULL,
	[description] [text] NOT NULL,
 CONSTRAINT [PK_PhotoGalleries] PRIMARY KEY CLUSTERED 
(
	[photogalleryid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
go

-- PhotoGalleryPhotos
CREATE TABLE [dbo].[PhotoGalleryPhotos](
	[photogalleryphotoid] [int] IDENTITY(1,1) NOT NULL,
	[photogalleryid] [int] NOT NULL,
	[filename] [varchar](255) NOT NULL,
	[description] [varchar](255) NOT NULL,
	[filedata] [image] NULL,
 CONSTRAINT [PK_photogalleryphotos] PRIMARY KEY CLUSTERED 
(
	[photogalleryphotoid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
go

-- Posts
CREATE TABLE [dbo].[Posts](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[authorid] [int] NULL,
	[title] [varchar](250) NOT NULL,
	[body] [text] NOT NULL,
	[createdat] [datetime] NOT NULL,
	[updatedat] [datetime] NOT NULL,
	[deletedat] [datetime] NULL,
	[views] [int] NOT NULL CONSTRAINT [DF_Posts_views]  DEFAULT ((0)),
	[averagerating] [float] NULL,
 CONSTRAINT [PK_Posts] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
go

-- Authors
CREATE TABLE [dbo].[Authors](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[firstname] [varchar](100) NOT NULL,
	[lastname] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Authors] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
go

-- Classifications
CREATE TABLE [dbo].[Classifications](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[postid] [int] NOT NULL,
	[tagid] [int] NOT NULL,
 CONSTRAINT [PK_Classifications] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
go

-- Comments
CREATE TABLE [dbo].[Comments](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[postid] [int] NOT NULL,
	[body] [text] NOT NULL,
	[name] [varchar](100) NOT NULL,
	[url] [varchar](100) NULL,
	[email] [varchar](100) NULL,
	[createdat] [datetime] NOT NULL,
 CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
go

-- Profiles
CREATE TABLE [dbo].[Profiles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[authorid] [int] NULL,
	[dateofbirth] [datetime] NOT NULL,
	[bio] [text] NULL,
 CONSTRAINT [PK_profiles] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
go

-- Tags
CREATE TABLE [dbo].[Tags](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[description] [varchar](50) NULL,
 CONSTRAINT [PK_Tags] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
go

-- Cities
CREATE TABLE [dbo].[Cities](
	[CountyId] [char](4) NOT NULL,
	[CityCode] [tinyint] NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Cities] PRIMARY KEY CLUSTERED 
(
	[CountyId] ASC,
	[CityCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
go

-- Shops
CREATE TABLE [dbo].[Shops](
	[ShopId] [char](9) NOT NULL,
	[CityCode] [tinyint] NULL,
	[Name] [varchar](80) NOT NULL,
 CONSTRAINT [PK_Shops] PRIMARY KEY NONCLUSTERED 
(
	[ShopId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[userphotos]') AND type in (N'V'))
DROP VIEW [dbo].[userphotos]
go

create view userphotos
as
select
	u.id as userid
	,u.username as username
	,u.firstname as firstname
	,u.lastname as lastname
	,pg.title as title
	,pg.photogalleryid as photogalleryid
from
	users u
	inner join photogalleries pg
		on u.id = pg.userid
go