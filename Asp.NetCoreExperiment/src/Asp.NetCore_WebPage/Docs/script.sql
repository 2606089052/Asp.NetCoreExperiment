--权限数据库脚本
USE [master]
GO
/****** Object:  Database [ExperimentPageDb]    Script Date: 2017/3/11 8:36:03 ******/
CREATE DATABASE [ExperimentPageDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ExperimentPageDb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\ExperimentPageDb.mdf' , SIZE = 4160KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ExperimentPageDb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\ExperimentPageDb_log.ldf' , SIZE = 1040KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ExperimentPageDb] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ExperimentPageDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ExperimentPageDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ExperimentPageDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ExperimentPageDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ExperimentPageDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ExperimentPageDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [ExperimentPageDb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ExperimentPageDb] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [ExperimentPageDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ExperimentPageDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ExperimentPageDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ExperimentPageDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ExperimentPageDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ExperimentPageDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ExperimentPageDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ExperimentPageDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ExperimentPageDb] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ExperimentPageDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ExperimentPageDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ExperimentPageDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ExperimentPageDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ExperimentPageDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ExperimentPageDb] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [ExperimentPageDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ExperimentPageDb] SET RECOVERY FULL 
GO
ALTER DATABASE [ExperimentPageDb] SET  MULTI_USER 
GO
ALTER DATABASE [ExperimentPageDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ExperimentPageDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ExperimentPageDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ExperimentPageDb] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ExperimentPageDb', N'ON'
GO
USE [ExperimentPageDb]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 2017/3/11 8:36:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Permissions]    Script Date: 2017/3/11 8:36:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permissions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ActionName] [nvarchar](max) NULL,
	[PermissionName] [nvarchar](max) NULL,
 CONSTRAINT [PK_Permissions] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RolePermissions]    Script Date: 2017/3/11 8:36:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RolePermissions](
	[PermissionID] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
 CONSTRAINT [PK_RolePermissions] PRIMARY KEY CLUSTERED 
(
	[PermissionID] ASC,
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Roles]    Script Date: 2017/3/11 8:36:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](max) NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 2017/3/11 8:36:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[UserID] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
 CONSTRAINT [PK_UserRoles] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 2017/3/11 8:36:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Password] [nvarchar](max) NULL,
	[UserName] [nvarchar](max) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20170305124853_ExperimentPageMigration', N'1.1.0-rtm-22752')
SET IDENTITY_INSERT [dbo].[Permissions] ON 

INSERT [dbo].[Permissions] ([ID], [ActionName], [PermissionName]) VALUES (1, N'/adduser', N'添加用户')
INSERT [dbo].[Permissions] ([ID], [ActionName], [PermissionName]) VALUES (2, N'/users', N'用户列表')
INSERT [dbo].[Permissions] ([ID], [ActionName], [PermissionName]) VALUES (3, N'/', N'主页')
SET IDENTITY_INSERT [dbo].[Permissions] OFF
INSERT [dbo].[RolePermissions] ([PermissionID], [RoleID]) VALUES (1, 1)
INSERT [dbo].[RolePermissions] ([PermissionID], [RoleID]) VALUES (3, 1)
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([ID], [RoleName]) VALUES (1, N'管理员')
SET IDENTITY_INSERT [dbo].[Roles] OFF
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (1, 1)
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([ID], [Password], [UserName]) VALUES (1, N'111111', N'gsw')
SET IDENTITY_INSERT [dbo].[Users] OFF
/****** Object:  Index [IX_RolePermissions_RoleID]    Script Date: 2017/3/11 8:36:03 ******/
CREATE NONCLUSTERED INDEX [IX_RolePermissions_RoleID] ON [dbo].[RolePermissions]
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserRoles_RoleID]    Script Date: 2017/3/11 8:36:03 ******/
CREATE NONCLUSTERED INDEX [IX_UserRoles_RoleID] ON [dbo].[UserRoles]
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RolePermissions]  WITH CHECK ADD  CONSTRAINT [FK_RolePermissions_Permissions_PermissionID] FOREIGN KEY([PermissionID])
REFERENCES [dbo].[Permissions] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RolePermissions] CHECK CONSTRAINT [FK_RolePermissions_Permissions_PermissionID]
GO
ALTER TABLE [dbo].[RolePermissions]  WITH CHECK ADD  CONSTRAINT [FK_RolePermissions_Roles_RoleID] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RolePermissions] CHECK CONSTRAINT [FK_RolePermissions_Roles_RoleID]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserRoles_Roles_RoleID] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserRoles_Roles_RoleID]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserRoles_Users_UserID] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserRoles_Users_UserID]
GO
USE [master]
GO
ALTER DATABASE [ExperimentPageDb] SET  READ_WRITE 
GO
