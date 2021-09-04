USE [master]
GO
/****** Object:  Database [MobileShop]    Script Date: 9/4/2021 4:31:10 PM ******/
CREATE DATABASE [MobileShop]
GO
ALTER DATABASE [MobileShop] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MobileShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MobileShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MobileShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MobileShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MobileShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MobileShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [MobileShop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MobileShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MobileShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MobileShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MobileShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MobileShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MobileShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MobileShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MobileShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MobileShop] SET  ENABLE_BROKER 
GO
ALTER DATABASE [MobileShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MobileShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MobileShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MobileShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MobileShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MobileShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MobileShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MobileShop] SET RECOVERY FULL 
GO
ALTER DATABASE [MobileShop] SET  MULTI_USER 
GO
ALTER DATABASE [MobileShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MobileShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MobileShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MobileShop] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [MobileShop] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'MobileShop', N'ON'
GO
USE [MobileShop]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 9/4/2021 4:31:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Customer](
	[customer_id] [varchar](16) NOT NULL,
	[username] [varchar](16) NULL,
	[password] [varchar](32) NULL,
PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CustomerOrder]    Script Date: 9/4/2021 4:31:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CustomerOrder](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[created_date] [datetime] NOT NULL,
	[customer_id] [varchar](16) NULL,
	[staff_id] [varchar](16) NULL,
	[status_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CustomerOrderDetail]    Script Date: 9/4/2021 4:31:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerOrderDetail](
	[order_id] [bigint] NOT NULL,
	[phone_id] [int] NOT NULL,
	[quantity] [int] NULL,
	[price] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[order_id] ASC,
	[phone_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Person]    Script Date: 9/4/2021 4:31:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Person](
	[id] [varchar](16) NOT NULL,
	[first_name] [nvarchar](16) NOT NULL,
	[last_name] [nvarchar](32) NULL,
	[gender] [nvarchar](3) NOT NULL,
	[identity_card] [varchar](16) NULL,
	[email] [varchar](32) NULL,
	[phone_num] [varchar](16) NOT NULL,
	[day_of_birth] [date] NULL,
	[address] [nvarchar](128) NULL,
 CONSTRAINT [PK__Person__3213E83F8E4FE2C0] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Phone]    Script Date: 9/4/2021 4:31:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Phone](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[phone_name] [varchar](64) NULL,
	[phone_type] [int] NULL,
	[phone_descrip] [varchar](256) NULL,
	[quantity] [int] NULL,
	[img] [varchar](32) NULL,
	[color] [varchar](16) NULL,
	[price] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PhoneType]    Script Date: 9/4/2021 4:31:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhoneType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[type_phone_name] [nvarchar](64) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RoleStaff]    Script Date: 9/4/2021 4:31:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RoleStaff](
	[role_id] [int] IDENTITY(1,1) NOT NULL,
	[role_name] [varchar](16) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ShopOrder]    Script Date: 9/4/2021 4:31:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ShopOrder](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[created_date] [datetime] NULL,
	[supplier_id] [int] NULL,
	[staff_id] [varchar](16) NULL,
	[status_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ShopOrderDetail]    Script Date: 9/4/2021 4:31:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShopOrderDetail](
	[order_id] [bigint] NOT NULL,
	[phone_id] [int] NOT NULL,
	[quantity] [int] NULL,
	[price] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[order_id] ASC,
	[phone_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Staff]    Script Date: 9/4/2021 4:31:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Staff](
	[staff_id] [varchar](16) NOT NULL,
	[username] [varchar](16) NULL,
	[password] [varchar](32) NULL,
	[salary] [money] NULL,
	[role_id] [int] NULL,
	[is_deleted] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[staff_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StatusOrder]    Script Date: 9/4/2021 4:31:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatusOrder](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[status_name] [nvarchar](16) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Supplier]    Script Date: 9/4/2021 4:31:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Supplier](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](128) NULL,
	[phone_num] [varchar](16) NULL,
	[address] [nvarchar](128) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Customer] ([customer_id], [username], [password]) VALUES (N'CUSTOMER_1', N'mumumu', N'12233')
INSERT [dbo].[Customer] ([customer_id], [username], [password]) VALUES (N'CUSTOMER_2', N'mcmumu', N'1')
INSERT [dbo].[Customer] ([customer_id], [username], [password]) VALUES (N'CUSTOMER_3', N'mpmumu', N'vllong')
INSERT [dbo].[Customer] ([customer_id], [username], [password]) VALUES (N'CUSTOMER_4', N'loiloi', N'vlloi')
INSERT [dbo].[Customer] ([customer_id], [username], [password]) VALUES (N'CUSTOMER_5', N'baobao', N'baobao')
INSERT [dbo].[Person] ([id], [first_name], [last_name], [gender], [identity_card], [email], [phone_num], [day_of_birth], [address]) VALUES (N'CUSTOMER_1', N'Thắng', N'Nguyễn Quốc', N'Nam', N'1988202111', N'draculathang@gmail.com', N'0911920391', CAST(N'2000-07-01' AS Date), N'Nha Trang')
INSERT [dbo].[Person] ([id], [first_name], [last_name], [gender], [identity_card], [email], [phone_num], [day_of_birth], [address]) VALUES (N'CUSTOMER_2', N'Hiền', N'Nguyễn Thanh', N'Nam', N'1988202112', N'draculahien@gmail.com', N'0911920392', CAST(N'2000-09-22' AS Date), N'Bình Thuận')
INSERT [dbo].[Person] ([id], [first_name], [last_name], [gender], [identity_card], [email], [phone_num], [day_of_birth], [address]) VALUES (N'CUSTOMER_3', N'Long', N'Nguyễn Văn', N'Nam', N'1988202113', N'draculalong@gmail.com', N'0911920393', CAST(N'2000-08-16' AS Date), N'Bình Thuận')
INSERT [dbo].[Person] ([id], [first_name], [last_name], [gender], [identity_card], [email], [phone_num], [day_of_birth], [address]) VALUES (N'CUSTOMER_4', N'Lợi', N'Cao Thành', N'Nam', N'1988202115', N'draculaloi@gmail.com', N'0911920395', CAST(N'2000-01-01' AS Date), N'Bình Chánh')
INSERT [dbo].[Person] ([id], [first_name], [last_name], [gender], [identity_card], [email], [phone_num], [day_of_birth], [address]) VALUES (N'CUSTOMER_5', N'Bảo', N'Trần Quốc', N'Nam', N'1988202119', N'baobao@gmail.com', N'0911920399', CAST(N'2000-06-30' AS Date), N'Quảng Trị')
SET IDENTITY_INSERT [dbo].[RoleStaff] ON 

INSERT [dbo].[RoleStaff] ([role_id], [role_name]) VALUES (1, N'Qu?n lý')
INSERT [dbo].[RoleStaff] ([role_id], [role_name]) VALUES (2, N'Thu ngân')
INSERT [dbo].[RoleStaff] ([role_id], [role_name]) VALUES (3, N'Giao hàng')
SET IDENTITY_INSERT [dbo].[RoleStaff] OFF
SET IDENTITY_INSERT [dbo].[StatusOrder] ON 

INSERT [dbo].[StatusOrder] ([id], [status_name]) VALUES (1, N'Chưa giao')
INSERT [dbo].[StatusOrder] ([id], [status_name]) VALUES (2, N'Đã giao')
INSERT [dbo].[StatusOrder] ([id], [status_name]) VALUES (3, N'Hủy đơn')
SET IDENTITY_INSERT [dbo].[StatusOrder] OFF
SET IDENTITY_INSERT [dbo].[Supplier] ON 

INSERT [dbo].[Supplier] ([id], [name], [phone_num], [address]) VALUES (1, N'Công ty STVG', N'0188111982', N'110 Bùi Tá Hán, thành phố Thủ Đức')
SET IDENTITY_INSERT [dbo].[Supplier] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Customer__F3DBC572B1871016]    Script Date: 9/4/2021 4:31:10 PM ******/
ALTER TABLE [dbo].[Customer] ADD UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Person__4943C3B48D8242DF]    Script Date: 9/4/2021 4:31:10 PM ******/
ALTER TABLE [dbo].[Person] ADD  CONSTRAINT [UQ__Person__4943C3B48D8242DF] UNIQUE NONCLUSTERED 
(
	[identity_card] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Person__AB6E61646CDF8F70]    Script Date: 9/4/2021 4:31:10 PM ******/
ALTER TABLE [dbo].[Person] ADD  CONSTRAINT [UQ__Person__AB6E61646CDF8F70] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Person__E592CEB3A1102599]    Script Date: 9/4/2021 4:31:10 PM ******/
ALTER TABLE [dbo].[Person] ADD  CONSTRAINT [UQ__Person__E592CEB3A1102599] UNIQUE NONCLUSTERED 
(
	[phone_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Staff__F3DBC5727E433AFF]    Script Date: 9/4/2021 4:31:10 PM ******/
ALTER TABLE [dbo].[Staff] ADD UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CustomerOrder] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[ShopOrder] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Info] FOREIGN KEY([customer_id])
REFERENCES [dbo].[Person] ([id])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_Info]
GO
ALTER TABLE [dbo].[CustomerOrder]  WITH CHECK ADD  CONSTRAINT [FK_Info_Customer_Order] FOREIGN KEY([customer_id])
REFERENCES [dbo].[Person] ([id])
GO
ALTER TABLE [dbo].[CustomerOrder] CHECK CONSTRAINT [FK_Info_Customer_Order]
GO
ALTER TABLE [dbo].[CustomerOrder]  WITH CHECK ADD  CONSTRAINT [FK_Info_Staff_Order] FOREIGN KEY([staff_id])
REFERENCES [dbo].[Staff] ([staff_id])
GO
ALTER TABLE [dbo].[CustomerOrder] CHECK CONSTRAINT [FK_Info_Staff_Order]
GO
ALTER TABLE [dbo].[CustomerOrder]  WITH CHECK ADD  CONSTRAINT [FK_Status_Customer_Order] FOREIGN KEY([status_id])
REFERENCES [dbo].[StatusOrder] ([id])
GO
ALTER TABLE [dbo].[CustomerOrder] CHECK CONSTRAINT [FK_Status_Customer_Order]
GO
ALTER TABLE [dbo].[CustomerOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_Order_Detail_ID] FOREIGN KEY([order_id])
REFERENCES [dbo].[CustomerOrder] ([id])
GO
ALTER TABLE [dbo].[CustomerOrderDetail] CHECK CONSTRAINT [FK_Order_Detail_ID]
GO
ALTER TABLE [dbo].[CustomerOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_Order_Phone_ID] FOREIGN KEY([phone_id])
REFERENCES [dbo].[Phone] ([id])
GO
ALTER TABLE [dbo].[CustomerOrderDetail] CHECK CONSTRAINT [FK_Order_Phone_ID]
GO
ALTER TABLE [dbo].[Phone]  WITH CHECK ADD  CONSTRAINT [FK_Phone_Type] FOREIGN KEY([phone_type])
REFERENCES [dbo].[PhoneType] ([id])
GO
ALTER TABLE [dbo].[Phone] CHECK CONSTRAINT [FK_Phone_Type]
GO
ALTER TABLE [dbo].[ShopOrder]  WITH CHECK ADD  CONSTRAINT [FK_Staff_Shop_Order] FOREIGN KEY([staff_id])
REFERENCES [dbo].[Staff] ([staff_id])
GO
ALTER TABLE [dbo].[ShopOrder] CHECK CONSTRAINT [FK_Staff_Shop_Order]
GO
ALTER TABLE [dbo].[ShopOrder]  WITH CHECK ADD  CONSTRAINT [FK_Status_Shop_Order] FOREIGN KEY([status_id])
REFERENCES [dbo].[StatusOrder] ([id])
GO
ALTER TABLE [dbo].[ShopOrder] CHECK CONSTRAINT [FK_Status_Shop_Order]
GO
ALTER TABLE [dbo].[ShopOrder]  WITH CHECK ADD  CONSTRAINT [FK_Supplier_Shop_Order] FOREIGN KEY([supplier_id])
REFERENCES [dbo].[Supplier] ([id])
GO
ALTER TABLE [dbo].[ShopOrder] CHECK CONSTRAINT [FK_Supplier_Shop_Order]
GO
ALTER TABLE [dbo].[ShopOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_Order_ShopOrderDetail] FOREIGN KEY([order_id])
REFERENCES [dbo].[ShopOrder] ([id])
GO
ALTER TABLE [dbo].[ShopOrderDetail] CHECK CONSTRAINT [FK_Order_ShopOrderDetail]
GO
ALTER TABLE [dbo].[ShopOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_Phone_ShopOrderDetail] FOREIGN KEY([phone_id])
REFERENCES [dbo].[Phone] ([id])
GO
ALTER TABLE [dbo].[ShopOrderDetail] CHECK CONSTRAINT [FK_Phone_ShopOrderDetail]
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD  CONSTRAINT [FK_ROLE] FOREIGN KEY([role_id])
REFERENCES [dbo].[RoleStaff] ([role_id])
GO
ALTER TABLE [dbo].[Staff] CHECK CONSTRAINT [FK_ROLE]
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD  CONSTRAINT [FK_Staff_Info] FOREIGN KEY([staff_id])
REFERENCES [dbo].[Person] ([id])
GO
ALTER TABLE [dbo].[Staff] CHECK CONSTRAINT [FK_Staff_Info]
GO
ALTER TABLE [dbo].[Person]  WITH CHECK ADD  CONSTRAINT [Check_gender] CHECK  (([gender]=N'Nữ' OR [gender]=N'Nam'))
GO
ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [Check_gender]
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD CHECK  (([is_deleted]=(1) OR [is_deleted]=(0)))
GO
/****** Object:  StoredProcedure [dbo].[ChangeInfoPerson]    Script Date: 9/4/2021 4:31:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ChangeInfoPerson] (@f_name nvarchar(16), @l_name nvarchar(32), @gen nvarchar(3), @id_card varchar(16), @mail varchar(32),
@phonenum varchar(16), @dob date, @addres nvarchar(128), @id varchar(16))
AS 
BEGIN
	BEGIN TRAN
              BEGIN TRY
				update Person set first_name = @f_name, last_name = @l_name, gender = @gen,
								identity_card = @id_card, email = @mail, phone_num = @phonenum,
								day_of_birth = @dob, address = @addres where id = @id;
				
				COMMIT TRANSACTION
				END TRY
       BEGIN CATCH
              -- if error, roll back any chanegs done by any of the sql statements
              ROLLBACK TRANSACTION
       END CATCH
	 
END;


GO
/****** Object:  StoredProcedure [dbo].[ChangePasswordCustomer]    Script Date: 9/4/2021 4:31:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ChangePasswordCustomer] (@user varchar(16), @pass varchar(32))
AS 
BEGIN
	BEGIN TRAN
              BEGIN TRY

				update Customer set password = @pass where username = @user;
				
				COMMIT TRANSACTION
				END TRY
       BEGIN CATCH
              -- if error, roll back any chanegs done by any of the sql statements
              ROLLBACK TRANSACTION
       END CATCH
	 
END;


GO
/****** Object:  StoredProcedure [dbo].[ChangePasswordStaff]    Script Date: 9/4/2021 4:31:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ChangePasswordStaff] (@user varchar(16), @pass varchar(32))
AS 
BEGIN
	BEGIN TRAN
              BEGIN TRY

				update Staff set password = @pass where username = @user;
				
				COMMIT TRANSACTION
				END TRY
       BEGIN CATCH
              -- if error, roll back any chanegs done by any of the sql statements
              ROLLBACK TRANSACTION
       END CATCH
	 
END;


GO
/****** Object:  StoredProcedure [dbo].[DeleteStaff]    Script Date: 9/4/2021 4:31:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteStaff] (@id varchar(16))
AS 
BEGIN
	BEGIN TRAN
              BEGIN TRY
				update Staff set is_deleted = 1 where staff_id = @id;
				
				COMMIT TRANSACTION
				END TRY
       BEGIN CATCH
              -- if error, roll back any chanegs done by any of the sql statements
              ROLLBACK TRANSACTION
       END CATCH
	 
END;


GO
/****** Object:  StoredProcedure [dbo].[InsertCustomer]    Script Date: 9/4/2021 4:31:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertCustomer] (@f_name nvarchar(16), @l_name nvarchar(32), @gen nvarchar(3), @id_card varchar(16), @mail varchar(32),
@phonenum varchar(16), @dob date, @addres nvarchar(128), @user varchar(16), @pass varchar(32))
AS 
BEGIN
	BEGIN TRAN
              BEGIN TRY
				DECLARE @last_index int = 1;

				 IF EXISTS(SELECT * FROM Customer)
				 BEGIN
					SELECT @last_index = convert(INT, substring(customer_id, CHARINDEX('_', customer_id) + 1, len(customer_id))) 
					from Customer
					order by convert(INT, substring(customer_id, CHARINDEX('_', customer_id) + 1, len(customer_id)))
					SET @last_index = @last_index + 1
				 END
	 

				 DECLARE @new_id varchar(16) = concat('CUSTOMER', '_', convert(varchar(7), @last_index))
				 print(@new_id)

				 INSERT INTO Person values(@new_id, @f_name, @l_name, @gen, @id_card, @mail, @phonenum, @dob, @addres)

				 INSERT INTO Customer values(@new_id, @user, @pass)
				
				COMMIT TRANSACTION
				END TRY
       BEGIN CATCH
              -- if error, roll back any chanegs done by any of the sql statements
              ROLLBACK TRANSACTION
       END CATCH
	 
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertStaff]    Script Date: 9/4/2021 4:31:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertStaff] (@f_name nvarchar(16), @l_name nvarchar(32), @gen nvarchar(3), @id_card varchar(16), @mail varchar(32),
@phonenum varchar(16), @dob date, @addres nvarchar(128), @user varchar(16), @pass varchar(32), @sal money, @role int)
AS 
BEGIN
	BEGIN TRAN
              BEGIN TRY
				DECLARE @last_index int = 1;

				 IF EXISTS(SELECT * FROM Staff)
				 BEGIN
					SELECT @last_index = convert(INT, substring(staff_id, CHARINDEX('_', staff_id) + 1, len(staff_id))) 
					from Staff
					order by convert(INT, substring(staff_id, CHARINDEX('_', staff_id) + 1, len(staff_id)))
					SET @last_index = @last_index + 1
				 END
	 

				 DECLARE @new_id varchar(16) = concat('STAFF', '_', convert(varchar(9), @last_index))

				 INSERT INTO Person values(@new_id, @f_name, @l_name, @gen, @id_card, @mail, @phonenum, @dob, @addres)

				 INSERT INTO Staff values(@new_id, @user, @pass, @sal, @role, 0)
				
				COMMIT TRANSACTION
				END TRY
       BEGIN CATCH
              -- if error, roll back any chanegs done by any of the sql statements
              ROLLBACK TRANSACTION
       END CATCH
	 
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertSupplier]    Script Date: 9/4/2021 4:31:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertSupplier] (@name nvarchar(128), @phone varchar(16), @addres nvarchar(128))
AS 
BEGIN
	BEGIN TRAN
              BEGIN TRY
				insert into Supplier values(@name, @phone, @addres)
				
				COMMIT TRANSACTION
				END TRY
       BEGIN CATCH
              -- if error, roll back any chanegs done by any of the sql statements
              ROLLBACK TRANSACTION
       END CATCH
	 
END;


GO
USE [master]
GO
ALTER DATABASE [MobileShop] SET  READ_WRITE 
GO
