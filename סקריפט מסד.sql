Create database [port]
go
USE [port]
GO
/****** Object:  Table [dbo].[boats]    Script Date: 18/03/2024 13:24:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[boats](
	[boatId] [int] IDENTITY(100,1) NOT NULL,
	[boatName] [varchar](45) NULL,
	[cargoId] [int] NOT NULL,
	[content] [int] NOT NULL,
 CONSTRAINT [pk_boats] PRIMARY KEY CLUSTERED 
(
	[boatId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cargos]    Script Date: 18/03/2024 13:24:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cargos](
	[cargoId] [int] IDENTITY(200,1) NOT NULL,
	[cargoName] [varchar](15) NOT NULL,
	[importance] [int] NOT NULL,
 CONSTRAINT [pk_cargos] PRIMARY KEY CLUSTERED 
(
	[cargoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[definitions]    Script Date: 18/03/2024 13:24:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[definitions](
	[contentPort] [bigint] NOT NULL,
	[contentPass] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[entrys]    Script Date: 18/03/2024 13:24:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[entrys](
	[boatId] [int] NOT NULL,
	[dateTimeEntry] [datetime] NOT NULL,
	[dateTimePass] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[exits]    Script Date: 18/03/2024 13:24:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[exits](
	[boatId] [int] NOT NULL,
	[dateTimeExit] [datetime] NULL,
	[dateTimePass] [datetime] NULL,
	[finishUnloading] [smallint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tools]    Script Date: 18/03/2024 13:24:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tools](
	[toolId] [int] IDENTITY(1,1) NOT NULL,
	[toolName] [varchar](15) NOT NULL,
	[amount] [int] NOT NULL,
	[amountAvaliable] [int] NOT NULL,
 CONSTRAINT [pk_tools] PRIMARY KEY CLUSTERED 
(
	[toolId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[unLoadingTools]    Script Date: 18/03/2024 13:24:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[unLoadingTools](
	[toolId] [int] NOT NULL,
	[cargoId] [int] NOT NULL,
	[amount] [int] NOT NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[boats] ON 
GO
INSERT [dbo].[boats] ([boatId], [boatName], [cargoId], [content]) VALUES (100, N'המלכה מרי', 207, 350)
GO
INSERT [dbo].[boats] ([boatId], [boatName], [cargoId], [content]) VALUES (102, N'USS Enterprise', 205, 750)
GO
INSERT [dbo].[boats] ([boatId], [boatName], [cargoId], [content]) VALUES (103, N'HMS Victory', 211, 400)
GO
INSERT [dbo].[boats] ([boatId], [boatName], [cargoId], [content]) VALUES (106, N'Maersk Triple-E Class ', 210, 750)
GO
INSERT [dbo].[boats] ([boatId], [boatName], [cargoId], [content]) VALUES (107, N'SS Great Britain', 206, 1550)
GO
INSERT [dbo].[boats] ([boatId], [boatName], [cargoId], [content]) VALUES (108, N'HMS Bounty', 209, 1000)
GO
INSERT [dbo].[boats] ([boatId], [boatName], [cargoId], [content]) VALUES (110, N'קוסטה קונקורדיה', 202, 650)
GO
INSERT [dbo].[boats] ([boatId], [boatName], [cargoId], [content]) VALUES (111, N'הינד הזהב', 204, 685)
GO
INSERT [dbo].[boats] ([boatId], [boatName], [cargoId], [content]) VALUES (112, N'M?rsk Mc-Kinney Mller', 208, 2850)
GO
INSERT [dbo].[boats] ([boatId], [boatName], [cargoId], [content]) VALUES (115, N'A.Q.W 55', 201, 1000)
GO
INSERT [dbo].[boats] ([boatId], [boatName], [cargoId], [content]) VALUES (116, N'BBC ', 203, 679)
GO
INSERT [dbo].[boats] ([boatId], [boatName], [cargoId], [content]) VALUES (117, N'MRCK-1221-', 209, 1700)
GO
SET IDENTITY_INSERT [dbo].[boats] OFF
GO
SET IDENTITY_INSERT [dbo].[cargos] ON 
GO
INSERT [dbo].[cargos] ([cargoId], [cargoName], [importance]) VALUES (201, N'ציוד רפואי', 1)
GO
INSERT [dbo].[cargos] ([cargoId], [cargoName], [importance]) VALUES (202, N'מזון', 1)
GO
INSERT [dbo].[cargos] ([cargoId], [cargoName], [importance]) VALUES (203, N'הלבשה', 2)
GO
INSERT [dbo].[cargos] ([cargoId], [cargoName], [importance]) VALUES (204, N'צעצועים', 5)
GO
INSERT [dbo].[cargos] ([cargoId], [cargoName], [importance]) VALUES (205, N'רכבים', 4)
GO
INSERT [dbo].[cargos] ([cargoId], [cargoName], [importance]) VALUES (206, N'מכשור כבד', 3)
GO
INSERT [dbo].[cargos] ([cargoId], [cargoName], [importance]) VALUES (207, N'רהיטים', 4)
GO
INSERT [dbo].[cargos] ([cargoId], [cargoName], [importance]) VALUES (208, N'צבאי', 2)
GO
INSERT [dbo].[cargos] ([cargoId], [cargoName], [importance]) VALUES (209, N'חומרים בתפזורת', 5)
GO
INSERT [dbo].[cargos] ([cargoId], [cargoName], [importance]) VALUES (210, N'חיוני', 0)
GO
INSERT [dbo].[cargos] ([cargoId], [cargoName], [importance]) VALUES (211, N'קרור', 1)
GO
SET IDENTITY_INSERT [dbo].[cargos] OFF
GO
INSERT [dbo].[definitions] ([contentPort], [contentPass]) VALUES (1000000000, 50000000)
GO
INSERT [dbo].[entrys] ([boatId], [dateTimeEntry], [dateTimePass]) VALUES (100, CAST(N'2024-03-18T10:16:37.700' AS DateTime), CAST(N'2024-03-18T12:18:03.553' AS DateTime))
GO
INSERT [dbo].[entrys] ([boatId], [dateTimeEntry], [dateTimePass]) VALUES (102, CAST(N'2024-03-18T10:16:37.717' AS DateTime), CAST(N'2024-03-18T12:25:05.457' AS DateTime))
GO
INSERT [dbo].[entrys] ([boatId], [dateTimeEntry], [dateTimePass]) VALUES (103, CAST(N'2024-03-18T10:16:37.717' AS DateTime), CAST(N'2024-03-18T10:48:56.353' AS DateTime))
GO
INSERT [dbo].[entrys] ([boatId], [dateTimeEntry], [dateTimePass]) VALUES (106, CAST(N'2024-03-18T10:16:37.717' AS DateTime), CAST(N'2024-03-18T10:24:04.813' AS DateTime))
GO
INSERT [dbo].[entrys] ([boatId], [dateTimeEntry], [dateTimePass]) VALUES (107, CAST(N'2024-03-18T10:16:37.717' AS DateTime), CAST(N'2024-03-18T11:15:08.570' AS DateTime))
GO
INSERT [dbo].[entrys] ([boatId], [dateTimeEntry], [dateTimePass]) VALUES (108, CAST(N'2024-03-18T10:16:37.717' AS DateTime), CAST(N'2024-03-18T12:34:09.077' AS DateTime))
GO
INSERT [dbo].[entrys] ([boatId], [dateTimeEntry], [dateTimePass]) VALUES (110, CAST(N'2024-03-18T10:16:37.720' AS DateTime), CAST(N'2024-03-18T10:59:35.673' AS DateTime))
GO
INSERT [dbo].[entrys] ([boatId], [dateTimeEntry], [dateTimePass]) VALUES (111, CAST(N'2024-03-18T10:16:37.720' AS DateTime), CAST(N'2024-03-18T11:08:05.040' AS DateTime))
GO
INSERT [dbo].[entrys] ([boatId], [dateTimeEntry], [dateTimePass]) VALUES (112, CAST(N'2024-03-18T10:16:37.720' AS DateTime), CAST(N'2024-03-18T12:33:51.727' AS DateTime))
GO
INSERT [dbo].[entrys] ([boatId], [dateTimeEntry], [dateTimePass]) VALUES (115, CAST(N'2024-03-18T10:16:37.720' AS DateTime), CAST(N'2024-03-18T11:01:06.033' AS DateTime))
GO
INSERT [dbo].[entrys] ([boatId], [dateTimeEntry], [dateTimePass]) VALUES (116, CAST(N'2024-03-18T10:16:37.720' AS DateTime), CAST(N'2024-03-18T10:17:53.733' AS DateTime))
GO
INSERT [dbo].[entrys] ([boatId], [dateTimeEntry], [dateTimePass]) VALUES (117, CAST(N'2024-03-18T10:16:37.720' AS DateTime), CAST(N'2024-03-18T11:03:22.720' AS DateTime))
GO
INSERT [dbo].[entrys] ([boatId], [dateTimeEntry], [dateTimePass]) VALUES (100, CAST(N'2024-03-18T12:36:57.417' AS DateTime), CAST(N'2024-03-18T12:48:21.317' AS DateTime))
GO
INSERT [dbo].[entrys] ([boatId], [dateTimeEntry], [dateTimePass]) VALUES (102, CAST(N'2024-03-18T12:36:57.430' AS DateTime), CAST(N'2024-03-18T12:55:06.813' AS DateTime))
GO
INSERT [dbo].[entrys] ([boatId], [dateTimeEntry], [dateTimePass]) VALUES (103, CAST(N'2024-03-18T12:36:57.430' AS DateTime), CAST(N'2024-03-18T12:37:48.270' AS DateTime))
GO
INSERT [dbo].[entrys] ([boatId], [dateTimeEntry], [dateTimePass]) VALUES (106, CAST(N'2024-03-18T12:36:57.430' AS DateTime), CAST(N'2024-03-18T12:37:17.747' AS DateTime))
GO
INSERT [dbo].[entrys] ([boatId], [dateTimeEntry], [dateTimePass]) VALUES (107, CAST(N'2024-03-18T12:36:57.430' AS DateTime), CAST(N'2024-03-18T12:55:28.873' AS DateTime))
GO
INSERT [dbo].[entrys] ([boatId], [dateTimeEntry], [dateTimePass]) VALUES (108, CAST(N'2024-03-18T12:36:57.433' AS DateTime), CAST(N'2024-03-18T12:55:42.000' AS DateTime))
GO
INSERT [dbo].[entrys] ([boatId], [dateTimeEntry], [dateTimePass]) VALUES (110, CAST(N'2024-03-18T12:36:57.433' AS DateTime), CAST(N'2024-03-18T12:39:01.023' AS DateTime))
GO
INSERT [dbo].[entrys] ([boatId], [dateTimeEntry], [dateTimePass]) VALUES (111, CAST(N'2024-03-18T12:36:57.433' AS DateTime), CAST(N'2024-03-18T12:55:02.360' AS DateTime))
GO
INSERT [dbo].[entrys] ([boatId], [dateTimeEntry], [dateTimePass]) VALUES (112, CAST(N'2024-03-18T12:36:57.433' AS DateTime), CAST(N'2024-03-18T12:48:09.450' AS DateTime))
GO
INSERT [dbo].[entrys] ([boatId], [dateTimeEntry], [dateTimePass]) VALUES (115, CAST(N'2024-03-18T12:36:57.433' AS DateTime), CAST(N'2024-03-18T12:39:34.200' AS DateTime))
GO
INSERT [dbo].[entrys] ([boatId], [dateTimeEntry], [dateTimePass]) VALUES (116, CAST(N'2024-03-18T12:36:57.433' AS DateTime), CAST(N'2024-03-18T12:55:53.460' AS DateTime))
GO
INSERT [dbo].[entrys] ([boatId], [dateTimeEntry], [dateTimePass]) VALUES (117, CAST(N'2024-03-18T12:36:57.433' AS DateTime), CAST(N'2024-03-18T12:56:04.713' AS DateTime))
GO
INSERT [dbo].[exits] ([boatId], [dateTimeExit], [dateTimePass], [finishUnloading]) VALUES (116, CAST(N'2024-03-20T10:17:53.740' AS DateTime), CAST(N'2024-03-18T12:18:03.500' AS DateTime), 1)
GO
INSERT [dbo].[exits] ([boatId], [dateTimeExit], [dateTimePass], [finishUnloading]) VALUES (106, CAST(N'2024-03-20T10:24:04.820' AS DateTime), CAST(N'2024-03-18T10:38:12.857' AS DateTime), 1)
GO
INSERT [dbo].[exits] ([boatId], [dateTimeExit], [dateTimePass], [finishUnloading]) VALUES (103, CAST(N'2024-03-20T10:48:56.360' AS DateTime), CAST(N'2024-03-18T10:49:44.860' AS DateTime), 1)
GO
INSERT [dbo].[exits] ([boatId], [dateTimeExit], [dateTimePass], [finishUnloading]) VALUES (110, CAST(N'2024-03-20T10:59:35.680' AS DateTime), CAST(N'2024-03-18T10:59:50.540' AS DateTime), 1)
GO
INSERT [dbo].[exits] ([boatId], [dateTimeExit], [dateTimePass], [finishUnloading]) VALUES (115, CAST(N'2024-03-20T11:01:06.040' AS DateTime), CAST(N'2024-03-18T11:01:17.873' AS DateTime), 1)
GO
INSERT [dbo].[exits] ([boatId], [dateTimeExit], [dateTimePass], [finishUnloading]) VALUES (117, CAST(N'2024-03-20T11:03:22.723' AS DateTime), CAST(N'2024-03-18T11:03:46.247' AS DateTime), 1)
GO
INSERT [dbo].[exits] ([boatId], [dateTimeExit], [dateTimePass], [finishUnloading]) VALUES (115, CAST(N'2024-03-20T11:05:01.907' AS DateTime), CAST(N'2024-03-18T11:06:20.450' AS DateTime), 1)
GO
INSERT [dbo].[exits] ([boatId], [dateTimeExit], [dateTimePass], [finishUnloading]) VALUES (111, CAST(N'2024-03-20T11:08:05.047' AS DateTime), CAST(N'2024-03-18T11:08:14.713' AS DateTime), 1)
GO
INSERT [dbo].[exits] ([boatId], [dateTimeExit], [dateTimePass], [finishUnloading]) VALUES (107, CAST(N'2024-03-20T11:15:08.577' AS DateTime), CAST(N'2024-03-18T11:15:37.537' AS DateTime), 1)
GO
INSERT [dbo].[exits] ([boatId], [dateTimeExit], [dateTimePass], [finishUnloading]) VALUES (100, CAST(N'2024-03-20T12:18:03.557' AS DateTime), CAST(N'2024-03-18T12:21:15.977' AS DateTime), 1)
GO
INSERT [dbo].[exits] ([boatId], [dateTimeExit], [dateTimePass], [finishUnloading]) VALUES (100, CAST(N'2024-03-20T12:21:16.050' AS DateTime), CAST(N'2024-03-18T12:22:43.443' AS DateTime), 1)
GO
INSERT [dbo].[exits] ([boatId], [dateTimeExit], [dateTimePass], [finishUnloading]) VALUES (102, CAST(N'2024-03-20T12:25:05.460' AS DateTime), CAST(N'2024-03-18T12:25:21.940' AS DateTime), 1)
GO
INSERT [dbo].[exits] ([boatId], [dateTimeExit], [dateTimePass], [finishUnloading]) VALUES (112, CAST(N'2024-03-20T12:33:51.730' AS DateTime), CAST(N'2024-03-18T12:34:09.067' AS DateTime), 1)
GO
INSERT [dbo].[exits] ([boatId], [dateTimeExit], [dateTimePass], [finishUnloading]) VALUES (108, CAST(N'2024-03-20T12:34:09.077' AS DateTime), CAST(N'2024-03-18T12:34:59.743' AS DateTime), 1)
GO
INSERT [dbo].[exits] ([boatId], [dateTimeExit], [dateTimePass], [finishUnloading]) VALUES (106, CAST(N'2024-03-20T12:37:17.753' AS DateTime), CAST(N'2024-03-18T12:37:48.260' AS DateTime), 1)
GO
INSERT [dbo].[exits] ([boatId], [dateTimeExit], [dateTimePass], [finishUnloading]) VALUES (103, CAST(N'2024-03-20T12:37:48.270' AS DateTime), CAST(N'2024-03-18T12:39:00.737' AS DateTime), 1)
GO
INSERT [dbo].[exits] ([boatId], [dateTimeExit], [dateTimePass], [finishUnloading]) VALUES (110, CAST(N'2024-03-20T12:39:01.043' AS DateTime), CAST(N'2024-03-18T12:39:34.197' AS DateTime), 1)
GO
INSERT [dbo].[exits] ([boatId], [dateTimeExit], [dateTimePass], [finishUnloading]) VALUES (115, CAST(N'2024-03-20T12:39:34.200' AS DateTime), CAST(N'2024-03-18T12:39:54.460' AS DateTime), 1)
GO
INSERT [dbo].[exits] ([boatId], [dateTimeExit], [dateTimePass], [finishUnloading]) VALUES (112, CAST(N'2024-03-20T12:48:09.460' AS DateTime), CAST(N'2024-03-18T12:48:21.313' AS DateTime), 1)
GO
INSERT [dbo].[exits] ([boatId], [dateTimeExit], [dateTimePass], [finishUnloading]) VALUES (100, CAST(N'2024-03-20T12:48:21.320' AS DateTime), NULL, 0)
GO
INSERT [dbo].[exits] ([boatId], [dateTimeExit], [dateTimePass], [finishUnloading]) VALUES (111, CAST(N'2024-03-20T12:55:02.363' AS DateTime), CAST(N'2024-03-18T12:55:06.813' AS DateTime), 1)
GO
INSERT [dbo].[exits] ([boatId], [dateTimeExit], [dateTimePass], [finishUnloading]) VALUES (102, CAST(N'2024-03-20T12:55:06.817' AS DateTime), CAST(N'2024-03-18T12:55:28.870' AS DateTime), 1)
GO
INSERT [dbo].[exits] ([boatId], [dateTimeExit], [dateTimePass], [finishUnloading]) VALUES (107, CAST(N'2024-03-20T12:55:28.877' AS DateTime), CAST(N'2024-03-18T12:55:41.997' AS DateTime), 1)
GO
INSERT [dbo].[exits] ([boatId], [dateTimeExit], [dateTimePass], [finishUnloading]) VALUES (108, CAST(N'2024-03-20T12:55:42.000' AS DateTime), CAST(N'2024-03-18T12:55:53.453' AS DateTime), 1)
GO
INSERT [dbo].[exits] ([boatId], [dateTimeExit], [dateTimePass], [finishUnloading]) VALUES (116, CAST(N'2024-03-20T12:55:53.463' AS DateTime), CAST(N'2024-03-18T12:56:04.710' AS DateTime), 1)
GO
INSERT [dbo].[exits] ([boatId], [dateTimeExit], [dateTimePass], [finishUnloading]) VALUES (117, CAST(N'2024-03-20T12:56:04.713' AS DateTime), CAST(N'2024-03-18T12:56:15.303' AS DateTime), 1)
GO
SET IDENTITY_INSERT [dbo].[tools] ON 
GO
INSERT [dbo].[tools] ([toolId], [toolName], [amount], [amountAvaliable]) VALUES (1, N'עגורן', 2, 2)
GO
INSERT [dbo].[tools] ([toolId], [toolName], [amount], [amountAvaliable]) VALUES (2, N'מנופי מכולות', 8, 7)
GO
INSERT [dbo].[tools] ([toolId], [toolName], [amount], [amountAvaliable]) VALUES (4, N'משאית', 15, 13)
GO
INSERT [dbo].[tools] ([toolId], [toolName], [amount], [amountAvaliable]) VALUES (6, N'מלגזות', 40, 36)
GO
INSERT [dbo].[tools] ([toolId], [toolName], [amount], [amountAvaliable]) VALUES (7, N'רצועות מסוע', 15, 15)
GO
INSERT [dbo].[tools] ([toolId], [toolName], [amount], [amountAvaliable]) VALUES (8, N'תופסים והופרים', 8, 8)
GO
INSERT [dbo].[tools] ([toolId], [toolName], [amount], [amountAvaliable]) VALUES (9, N'ציוד לתפזורת', 1, 1)
GO
INSERT [dbo].[tools] ([toolId], [toolName], [amount], [amountAvaliable]) VALUES (10, N'רמפות רו רו', 4, 4)
GO
INSERT [dbo].[tools] ([toolId], [toolName], [amount], [amountAvaliable]) VALUES (11, N'משאיות רכב', 4, 4)
GO
INSERT [dbo].[tools] ([toolId], [toolName], [amount], [amountAvaliable]) VALUES (12, N'משיות קרור', 4, 4)
GO
SET IDENTITY_INSERT [dbo].[tools] OFF
GO
INSERT [dbo].[unLoadingTools] ([toolId], [cargoId], [amount]) VALUES (2, 201, 1)
GO
INSERT [dbo].[unLoadingTools] ([toolId], [cargoId], [amount]) VALUES (4, 201, 2)
GO
INSERT [dbo].[unLoadingTools] ([toolId], [cargoId], [amount]) VALUES (6, 201, 4)
GO
INSERT [dbo].[unLoadingTools] ([toolId], [cargoId], [amount]) VALUES (2, 202, 1)
GO
INSERT [dbo].[unLoadingTools] ([toolId], [cargoId], [amount]) VALUES (4, 202, 2)
GO
INSERT [dbo].[unLoadingTools] ([toolId], [cargoId], [amount]) VALUES (6, 202, 4)
GO
INSERT [dbo].[unLoadingTools] ([toolId], [cargoId], [amount]) VALUES (2, 203, 1)
GO
INSERT [dbo].[unLoadingTools] ([toolId], [cargoId], [amount]) VALUES (4, 203, 2)
GO
INSERT [dbo].[unLoadingTools] ([toolId], [cargoId], [amount]) VALUES (6, 203, 4)
GO
INSERT [dbo].[unLoadingTools] ([toolId], [cargoId], [amount]) VALUES (2, 204, 1)
GO
INSERT [dbo].[unLoadingTools] ([toolId], [cargoId], [amount]) VALUES (4, 204, 2)
GO
INSERT [dbo].[unLoadingTools] ([toolId], [cargoId], [amount]) VALUES (6, 201, 4)
GO
INSERT [dbo].[unLoadingTools] ([toolId], [cargoId], [amount]) VALUES (10, 205, 4)
GO
INSERT [dbo].[unLoadingTools] ([toolId], [cargoId], [amount]) VALUES (11, 205, 4)
GO
INSERT [dbo].[unLoadingTools] ([toolId], [cargoId], [amount]) VALUES (6, 204, 4)
GO
INSERT [dbo].[unLoadingTools] ([toolId], [cargoId], [amount]) VALUES (1, 206, 1)
GO
INSERT [dbo].[unLoadingTools] ([toolId], [cargoId], [amount]) VALUES (10, 206, 1)
GO
INSERT [dbo].[unLoadingTools] ([toolId], [cargoId], [amount]) VALUES (2, 207, 1)
GO
INSERT [dbo].[unLoadingTools] ([toolId], [cargoId], [amount]) VALUES (4, 207, 2)
GO
INSERT [dbo].[unLoadingTools] ([toolId], [cargoId], [amount]) VALUES (6, 207, 4)
GO
INSERT [dbo].[unLoadingTools] ([toolId], [cargoId], [amount]) VALUES (9, 209, 1)
GO
INSERT [dbo].[unLoadingTools] ([toolId], [cargoId], [amount]) VALUES (7, 211, 4)
GO
INSERT [dbo].[unLoadingTools] ([toolId], [cargoId], [amount]) VALUES (2, 211, 2)
GO
INSERT [dbo].[unLoadingTools] ([toolId], [cargoId], [amount]) VALUES (6, 211, 4)
GO
INSERT [dbo].[unLoadingTools] ([toolId], [cargoId], [amount]) VALUES (12, 211, 4)
GO
INSERT [dbo].[unLoadingTools] ([toolId], [cargoId], [amount]) VALUES (1, 210, 1)
GO
INSERT [dbo].[unLoadingTools] ([toolId], [cargoId], [amount]) VALUES (2, 210, 1)
GO
INSERT [dbo].[unLoadingTools] ([toolId], [cargoId], [amount]) VALUES (4, 210, 2)
GO
INSERT [dbo].[unLoadingTools] ([toolId], [cargoId], [amount]) VALUES (7, 210, 1)
GO
INSERT [dbo].[unLoadingTools] ([toolId], [cargoId], [amount]) VALUES (6, 210, 4)
GO
INSERT [dbo].[unLoadingTools] ([toolId], [cargoId], [amount]) VALUES (9, 210, 1)
GO
INSERT [dbo].[unLoadingTools] ([toolId], [cargoId], [amount]) VALUES (11, 210, 4)
GO
ALTER TABLE [dbo].[exits] ADD  DEFAULT ((0)) FOR [finishUnloading]
GO
ALTER TABLE [dbo].[boats]  WITH CHECK ADD  CONSTRAINT [fk_boats_cargos] FOREIGN KEY([cargoId])
REFERENCES [dbo].[cargos] ([cargoId])
GO
ALTER TABLE [dbo].[boats] CHECK CONSTRAINT [fk_boats_cargos]
GO
ALTER TABLE [dbo].[entrys]  WITH CHECK ADD  CONSTRAINT [fk_entrys_boats] FOREIGN KEY([boatId])
REFERENCES [dbo].[boats] ([boatId])
GO
ALTER TABLE [dbo].[entrys] CHECK CONSTRAINT [fk_entrys_boats]
GO
ALTER TABLE [dbo].[exits]  WITH CHECK ADD  CONSTRAINT [fk_exits_boats] FOREIGN KEY([boatId])
REFERENCES [dbo].[boats] ([boatId])
GO
ALTER TABLE [dbo].[exits] CHECK CONSTRAINT [fk_exits_boats]
GO
ALTER TABLE [dbo].[unLoadingTools]  WITH CHECK ADD  CONSTRAINT [fk_unLoadingTools_cargos] FOREIGN KEY([cargoId])
REFERENCES [dbo].[cargos] ([cargoId])
GO
ALTER TABLE [dbo].[unLoadingTools] CHECK CONSTRAINT [fk_unLoadingTools_cargos]
GO
ALTER TABLE [dbo].[unLoadingTools]  WITH CHECK ADD  CONSTRAINT [fk_unLoadingTools_tools] FOREIGN KEY([toolId])
REFERENCES [dbo].[tools] ([toolId])
GO
ALTER TABLE [dbo].[unLoadingTools] CHECK CONSTRAINT [fk_unLoadingTools_tools]
GO
