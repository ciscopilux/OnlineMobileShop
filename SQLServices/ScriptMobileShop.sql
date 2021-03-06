USE [master]
GO
/****** Object:  Database [MobileShop]    Script Date: 11/10/2021 11:00:12 AM ******/
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
/****** Object:  UserDefinedFunction [dbo].[CheckLoginCustomer]    Script Date: 11/10/2021 11:00:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CheckLoginCustomer](@username varchar(16), @password varchar(32))  
RETURNS int   
AS   
-- Returns the stock level for the product.  
BEGIN  
    DECLARE @ret int = 0;  
    IF exists(select 1 from Customer where username = @username and password = @password and is_active = 1)   
        SET @ret = 1;  
    RETURN @ret;  
END; 
GO
/****** Object:  UserDefinedFunction [dbo].[CheckLoginStaff]    Script Date: 11/10/2021 11:00:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CheckLoginStaff](@username varchar(16), @password varchar(32))  
RETURNS int   
AS   
-- Returns the stock level for the product.  
BEGIN  
    DECLARE @ret int = 0;  
    IF exists(select 1 from Staff where username = @username and password = @password and is_deleted = 0)   
        SET @ret = 1;  
    RETURN @ret;  
END; 
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 11/10/2021 11:00:12 AM ******/
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
	[is_active] [int] NOT NULL CONSTRAINT [DF_Customer_is_active]  DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CustomerOrder]    Script Date: 11/10/2021 11:00:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CustomerOrder](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[created_date] [datetime] NOT NULL CONSTRAINT [DF__CustomerO__creat__267ABA7A]  DEFAULT (getdate()),
	[customer_id] [varchar](16) NULL,
	[address] [nvarchar](128) NOT NULL,
	[staff_id] [varchar](16) NULL,
	[status_id] [int] NULL,
	[note] [nvarchar](255) NULL,
 CONSTRAINT [PK__Customer__3213E83F5E0E1AD2] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CustomerOrderDetail]    Script Date: 11/10/2021 11:00:12 AM ******/
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
/****** Object:  Table [dbo].[Person]    Script Date: 11/10/2021 11:00:12 AM ******/
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
	[email] [varchar](64) NULL,
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
/****** Object:  Table [dbo].[Phone]    Script Date: 11/10/2021 11:00:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Phone](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[phone_name] [nvarchar](64) NULL,
	[phone_type] [int] NULL,
	[phone_descrip] [nvarchar](256) NULL,
	[quantity] [int] NULL,
	[img] [varchar](32) NULL,
	[color] [int] NULL,
	[price] [money] NULL,
 CONSTRAINT [PK__Phone__3213E83F5A43ACBF] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PhoneColor]    Script Date: 11/10/2021 11:00:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhoneColor](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[color] [nvarchar](32) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PhoneType]    Script Date: 11/10/2021 11:00:12 AM ******/
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
/****** Object:  Table [dbo].[RoleStaff]    Script Date: 11/10/2021 11:00:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleStaff](
	[role_id] [int] IDENTITY(1,1) NOT NULL,
	[role_name] [nvarchar](16) NOT NULL,
 CONSTRAINT [PK__RoleStaf__760965CC209C31B3] PRIMARY KEY CLUSTERED 
(
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ShopOrder]    Script Date: 11/10/2021 11:00:12 AM ******/
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
/****** Object:  Table [dbo].[ShopOrderDetail]    Script Date: 11/10/2021 11:00:12 AM ******/
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
/****** Object:  Table [dbo].[Staff]    Script Date: 11/10/2021 11:00:12 AM ******/
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
/****** Object:  Table [dbo].[StatusOrder]    Script Date: 11/10/2021 11:00:12 AM ******/
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
/****** Object:  Table [dbo].[Supplier]    Script Date: 11/10/2021 11:00:12 AM ******/
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
/****** Object:  UserDefinedFunction [dbo].[GetListAllOrder]    Script Date: 11/10/2021 11:00:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetListAllOrder] (
	@from_date date,
	@to_date date
)
RETURNS TABLE
AS
RETURN
    SELECT
		co.id, co.created_date, CONCAT(pr.last_name, ' ', pr.first_name) as name, co.address, co.note, co.status_id, so.status_name, cod.phone_id, p.phone_name, p.img, cod.quantity, cod.price
	FROM
		CustomerOrder co
	LEFT JOIN
	    CustomerOrderDetail cod
	ON
		co.id = cod.order_id
	LEFT JOIN
		StatusOrder so
	ON
		co.status_id = so.id
	LEFT JOIN
		Phone p
	ON
		cod.phone_id = p.id
	LEFT JOIN
		Person pr
	ON
		co.customer_id = pr.id
	WHERE
		CONVERT(date, co.created_date) >= @from_date and CONVERT(date, co.created_date) <= @to_date


GO
/****** Object:  UserDefinedFunction [dbo].[GetListCustomer]    Script Date: 11/10/2021 11:00:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetListCustomer] (
)
RETURNS TABLE
AS
RETURN
    SELECT
		p.id, p.last_name, p.first_name, p.gender, p.identity_card, p.email, p.phone_num, p.day_of_birth, p.address,
		c.username, c.password, c.is_active
	FROM
		Customer c
	LEFT JOIN 
		Person p
	ON
		c.customer_id = p.id
GO
/****** Object:  UserDefinedFunction [dbo].[GetListHistoryCustomerOrder]    Script Date: 11/10/2021 11:00:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetListHistoryCustomerOrder] (
	@customer_id varchar(16)
)
RETURNS TABLE
AS
RETURN
    SELECT
		co.id, co.created_date, CONCAT(pr.last_name, ' ', pr.first_name) as name, co.address, co.note, co.status_id, so.status_name, cod.phone_id, p.phone_name, p.img, cod.quantity, cod.price
	FROM
		CustomerOrder co
	LEFT JOIN
	    CustomerOrderDetail cod
	ON
		co.id = cod.order_id
	LEFT JOIN
		StatusOrder so
	ON
		co.status_id = so.id
	LEFT JOIN
		Phone p
	ON
		cod.phone_id = p.id
	LEFT JOIN
		Person pr
	ON
		co.customer_id = pr.id
	WHERE
		co.customer_id = @customer_id
GO
/****** Object:  UserDefinedFunction [dbo].[GetListPhone]    Script Date: 11/10/2021 11:00:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetListPhone] (
)
RETURNS TABLE
AS
RETURN
    SELECT
		p.id, p.phone_name, p.phone_type, pt.type_phone_name, p.phone_descrip, p.quantity, p.img,
		pc.id as id_color, pc.color, p.price
	FROM
		Phone p
	LEFT JOIN 
		PhoneType pt
	ON
		pt.id = p.phone_type
	LEFT JOIN
		PhoneColor pc
	ON
		pc.id = p.color
GO
/****** Object:  UserDefinedFunction [dbo].[GetListPhoneColor]    Script Date: 11/10/2021 11:00:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetListPhoneColor] (
)
RETURNS TABLE
AS
RETURN
    SELECT
		pc.id, pc.color
	FROM
		PhoneColor pc
GO
/****** Object:  UserDefinedFunction [dbo].[GetListPhoneType]    Script Date: 11/10/2021 11:00:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetListPhoneType] (
)
RETURNS TABLE
AS
RETURN
    SELECT
		pt.id, pt.type_phone_name
	FROM
		PhoneType pt
GO
/****** Object:  UserDefinedFunction [dbo].[GetListRole]    Script Date: 11/10/2021 11:00:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetListRole] (
)
RETURNS TABLE
AS
RETURN
    SELECT
		role_id, role_name
	FROM
		RoleStaff
GO
/****** Object:  UserDefinedFunction [dbo].[GetListStaff]    Script Date: 11/10/2021 11:00:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetListStaff] (
)
RETURNS TABLE
AS
RETURN
    SELECT
		p.id, p.last_name, p.first_name, p.gender, p.identity_card, p.email, p.phone_num, p.day_of_birth, p.address,
		s.username, s.password, s.role_id, r.role_name, s.salary, s.is_deleted
	FROM
		Staff s
	LEFT JOIN 
		Person p
	ON
		s.staff_id = p.id
	LEFT JOIN
		RoleStaff r
	ON
		r.role_id = s.role_id

		
GO
/****** Object:  UserDefinedFunction [dbo].[GetListStatusOrder]    Script Date: 11/10/2021 11:00:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetListStatusOrder] (
)
RETURNS TABLE
AS
RETURN
    SELECT
		s.id, s.status_name
	FROM
		StatusOrder s;
GO
/****** Object:  UserDefinedFunction [dbo].[GetListSupplier]    Script Date: 11/10/2021 11:00:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetListSupplier] (
)
RETURNS TABLE
AS
RETURN
    SELECT
		s.id, s.name, s.address, s.phone_num
	FROM
		Supplier s;
GO
INSERT [dbo].[Customer] ([customer_id], [username], [password], [is_active]) VALUES (N'CUSTOMER_1', N'mumumu', N'abc1', 0)
INSERT [dbo].[Customer] ([customer_id], [username], [password], [is_active]) VALUES (N'CUSTOMER_2', N'mcmumu', N'1', 1)
INSERT [dbo].[Customer] ([customer_id], [username], [password], [is_active]) VALUES (N'CUSTOMER_3', N'mpmumu', N'vllong', 1)
INSERT [dbo].[Customer] ([customer_id], [username], [password], [is_active]) VALUES (N'CUSTOMER_4', N'loiloi', N'vlloi', 1)
INSERT [dbo].[Customer] ([customer_id], [username], [password], [is_active]) VALUES (N'CUSTOMER_5', N'baobao', N'baobao', 1)
INSERT [dbo].[Customer] ([customer_id], [username], [password], [is_active]) VALUES (N'CUSTOMER_6', N'lienlien111', N'123', 1)
INSERT [dbo].[Customer] ([customer_id], [username], [password], [is_active]) VALUES (N'CUSTOMER_7', N'ngocngoc', N'be2925748ff82b68b95aa4ee94f01f06', 1)
INSERT [dbo].[Customer] ([customer_id], [username], [password], [is_active]) VALUES (N'CUSTOMER_8', N'cisco', N'6f956d70a7227bffb405c6507c7110a5', 1)
SET IDENTITY_INSERT [dbo].[CustomerOrder] ON 

INSERT [dbo].[CustomerOrder] ([id], [created_date], [customer_id], [address], [staff_id], [status_id], [note]) VALUES (4, CAST(N'2021-10-03 13:18:49.670' AS DateTime), N'CUSTOMER_1', N'Qu?n 8', NULL, 1, N'Giao cho bảo vệ, gọi số 09129382130')
INSERT [dbo].[CustomerOrder] ([id], [created_date], [customer_id], [address], [staff_id], [status_id], [note]) VALUES (7, CAST(N'2021-10-18 22:13:00.670' AS DateTime), N'CUSTOMER_2', N'Quận 8', NULL, 1, N'Gọi số 0949618237')
INSERT [dbo].[CustomerOrder] ([id], [created_date], [customer_id], [address], [staff_id], [status_id], [note]) VALUES (8, CAST(N'2021-10-18 22:13:47.307' AS DateTime), N'CUSTOMER_1', N'Quận 10', NULL, 1, N'Gọi số 0949333203')
INSERT [dbo].[CustomerOrder] ([id], [created_date], [customer_id], [address], [staff_id], [status_id], [note]) VALUES (10, CAST(N'2021-10-18 22:21:00.697' AS DateTime), N'CUSTOMER_2', N'Quận 8', NULL, 1, N'Gọi số 0949333987')
INSERT [dbo].[CustomerOrder] ([id], [created_date], [customer_id], [address], [staff_id], [status_id], [note]) VALUES (11, CAST(N'2021-10-18 22:22:01.487' AS DateTime), N'CUSTOMER_3', N'Quận Thủ Đức', NULL, 1, N'Gọi số 0949333111')
SET IDENTITY_INSERT [dbo].[CustomerOrder] OFF
INSERT [dbo].[CustomerOrderDetail] ([order_id], [phone_id], [quantity], [price]) VALUES (4, 2, 1, 4000000.0000)
INSERT [dbo].[CustomerOrderDetail] ([order_id], [phone_id], [quantity], [price]) VALUES (4, 5, 2, 12000000.0000)
INSERT [dbo].[CustomerOrderDetail] ([order_id], [phone_id], [quantity], [price]) VALUES (4, 6, 1, 7000000.0000)
INSERT [dbo].[CustomerOrderDetail] ([order_id], [phone_id], [quantity], [price]) VALUES (7, 6, 1, 6000000.0000)
INSERT [dbo].[CustomerOrderDetail] ([order_id], [phone_id], [quantity], [price]) VALUES (8, 5, 2, 15000000.0000)
INSERT [dbo].[CustomerOrderDetail] ([order_id], [phone_id], [quantity], [price]) VALUES (10, 2, 1, 5500000.0000)
INSERT [dbo].[CustomerOrderDetail] ([order_id], [phone_id], [quantity], [price]) VALUES (11, 2, 1, 5700000.0000)
INSERT [dbo].[CustomerOrderDetail] ([order_id], [phone_id], [quantity], [price]) VALUES (11, 6, 1, 11000000.0000)
INSERT [dbo].[Person] ([id], [first_name], [last_name], [gender], [identity_card], [email], [phone_num], [day_of_birth], [address]) VALUES (N'CUSTOMER_1', N'Thắng', N'Nguyễn Quốc', N'Nam', N'1988202111', N'draculathang@gmail.com', N'0911920391', CAST(N'2000-07-01' AS Date), N'Nha Trang')
INSERT [dbo].[Person] ([id], [first_name], [last_name], [gender], [identity_card], [email], [phone_num], [day_of_birth], [address]) VALUES (N'CUSTOMER_2', N'Hiền', N'Nguyễn Thanh', N'Nam', N'1988202112', N'draculahien@gmail.com', N'0911920392', CAST(N'2000-09-22' AS Date), N'Bình Thuận')
INSERT [dbo].[Person] ([id], [first_name], [last_name], [gender], [identity_card], [email], [phone_num], [day_of_birth], [address]) VALUES (N'CUSTOMER_3', N'Long', N'Nguyễn Văn', N'Nam', N'1988202113', N'draculalong@gmail.com', N'0911920393', CAST(N'2000-08-16' AS Date), N'Bình Thuận')
INSERT [dbo].[Person] ([id], [first_name], [last_name], [gender], [identity_card], [email], [phone_num], [day_of_birth], [address]) VALUES (N'CUSTOMER_4', N'Lợi', N'Cao Thành', N'Nam', N'1988202115', N'draculaloi@gmail.com', N'0911920395', CAST(N'2000-01-01' AS Date), N'Bình Chánh')
INSERT [dbo].[Person] ([id], [first_name], [last_name], [gender], [identity_card], [email], [phone_num], [day_of_birth], [address]) VALUES (N'CUSTOMER_5', N'Bảo', N'Trần Quốc', N'Nam', N'1988202119', N'baobao@gmail.com', N'0911920399', CAST(N'2000-06-30' AS Date), N'Quảng Trị')
INSERT [dbo].[Person] ([id], [first_name], [last_name], [gender], [identity_card], [email], [phone_num], [day_of_birth], [address]) VALUES (N'CUSTOMER_6', N'Liên', N'Trần Bích', N'Nam', N'123456789', N'lienlien111@gmail.com', N'0111111111', CAST(N'2004-04-09' AS Date), N'Thái Bình')
INSERT [dbo].[Person] ([id], [first_name], [last_name], [gender], [identity_card], [email], [phone_num], [day_of_birth], [address]) VALUES (N'CUSTOMER_7', N'Ngọc', N'Phạm Thị Bích', N'Nữ', N'123827389', N'ngocngungoc@gmail.com', N'0922132221', CAST(N'2003-04-09' AS Date), N'Thái Bình')
INSERT [dbo].[Person] ([id], [first_name], [last_name], [gender], [identity_card], [email], [phone_num], [day_of_birth], [address]) VALUES (N'CUSTOMER_8', N'Bảo', N'Trần Quốc', N'Nam', N'197427389', N'tranquocb306@gmail.com', N'0949618234', CAST(N'2000-06-30' AS Date), N'Quảng Trị')
INSERT [dbo].[Person] ([id], [first_name], [last_name], [gender], [identity_card], [email], [phone_num], [day_of_birth], [address]) VALUES (N'STAFF_1', N'Hoài', N'Nguyễn Thị', N'Nữ', N'134567890', N'hoaiskt@gmail.com', N'0123456789', CAST(N'1996-05-15' AS Date), N'Quảng Nam')
INSERT [dbo].[Person] ([id], [first_name], [last_name], [gender], [identity_card], [email], [phone_num], [day_of_birth], [address]) VALUES (N'STAFF_2', N'Trâm', N'Thái Thị Bích', N'Nữ', NULL, N'tramskt@gmail.com', N'0123456788', CAST(N'1996-05-15' AS Date), N'Quảng Nam')
INSERT [dbo].[Person] ([id], [first_name], [last_name], [gender], [identity_card], [email], [phone_num], [day_of_birth], [address]) VALUES (N'STAFF_3', N'Trung', N'Nguyễn Đình', N'Nam', N'1010101010', N'trungnd224@gmail.com', N'0123456888', CAST(N'1980-03-21' AS Date), N'Hà Tây')
INSERT [dbo].[Person] ([id], [first_name], [last_name], [gender], [identity_card], [email], [phone_num], [day_of_birth], [address]) VALUES (N'STAFF_4', N'Nga', N'Hoàng Thị Ái', N'Nữ', N'192367890', N'ngahta@gmail.com', N'0123456721', CAST(N'1975-07-11' AS Date), N'Quảng Trị')
SET IDENTITY_INSERT [dbo].[Phone] ON 

INSERT [dbo].[Phone] ([id], [phone_name], [phone_type], [phone_descrip], [quantity], [img], [color], [price]) VALUES (2, N'Iphone 11', 1, N'Xinh ', 17, N'a', 1, 30000000.0000)
INSERT [dbo].[Phone] ([id], [phone_name], [phone_type], [phone_descrip], [quantity], [img], [color], [price]) VALUES (3, N'Samsung Galaxy', 2, N'ádssđa', 50, N'image Samsung Galaxy', 2, 15000000.0000)
INSERT [dbo].[Phone] ([id], [phone_name], [phone_type], [phone_descrip], [quantity], [img], [color], [price]) VALUES (5, N'Samsung Note 5', 2, NULL, 96, N'image Samsung Note 5', 3, 7900000.0000)
INSERT [dbo].[Phone] ([id], [phone_name], [phone_type], [phone_descrip], [quantity], [img], [color], [price]) VALUES (6, N'IPhone 10', 1, NULL, 27, N'image IPhone', 2, 1800000.0000)
SET IDENTITY_INSERT [dbo].[Phone] OFF
SET IDENTITY_INSERT [dbo].[PhoneColor] ON 

INSERT [dbo].[PhoneColor] ([id], [color]) VALUES (1, N'Đỏ')
INSERT [dbo].[PhoneColor] ([id], [color]) VALUES (2, N'Trắng')
INSERT [dbo].[PhoneColor] ([id], [color]) VALUES (3, N'Đen')
INSERT [dbo].[PhoneColor] ([id], [color]) VALUES (4, N'Xanh')
INSERT [dbo].[PhoneColor] ([id], [color]) VALUES (5, N'Xanh đen')
INSERT [dbo].[PhoneColor] ([id], [color]) VALUES (6, N'Hồng')
INSERT [dbo].[PhoneColor] ([id], [color]) VALUES (7, N'Vàng')
INSERT [dbo].[PhoneColor] ([id], [color]) VALUES (8, N'Bạc')
INSERT [dbo].[PhoneColor] ([id], [color]) VALUES (9, N'Aura Glow')
SET IDENTITY_INSERT [dbo].[PhoneColor] OFF
SET IDENTITY_INSERT [dbo].[PhoneType] ON 

INSERT [dbo].[PhoneType] ([id], [type_phone_name]) VALUES (1, N'IPhone')
INSERT [dbo].[PhoneType] ([id], [type_phone_name]) VALUES (2, N'Samsung')
INSERT [dbo].[PhoneType] ([id], [type_phone_name]) VALUES (3, N'Huawei')
INSERT [dbo].[PhoneType] ([id], [type_phone_name]) VALUES (4, N'Lenovo')
INSERT [dbo].[PhoneType] ([id], [type_phone_name]) VALUES (5, N'Redmi')
INSERT [dbo].[PhoneType] ([id], [type_phone_name]) VALUES (6, N'Oppo')
SET IDENTITY_INSERT [dbo].[PhoneType] OFF
SET IDENTITY_INSERT [dbo].[RoleStaff] ON 

INSERT [dbo].[RoleStaff] ([role_id], [role_name]) VALUES (1, N'Quản lý')
INSERT [dbo].[RoleStaff] ([role_id], [role_name]) VALUES (2, N'Thu ngân')
INSERT [dbo].[RoleStaff] ([role_id], [role_name]) VALUES (3, N'Giao hàng')
INSERT [dbo].[RoleStaff] ([role_id], [role_name]) VALUES (4, N'Bảo vệ')
SET IDENTITY_INSERT [dbo].[RoleStaff] OFF
INSERT [dbo].[Staff] ([staff_id], [username], [password], [salary], [role_id], [is_deleted]) VALUES (N'STAFF_1', N'hoaihoai1', N'eaa0e52fb4bb487cc4af4bac30ea7149', 200000.0000, 1, 0)
INSERT [dbo].[Staff] ([staff_id], [username], [password], [salary], [role_id], [is_deleted]) VALUES (N'STAFF_2', N'tramskt1', N'acb0294a83d43a76ba33c8733d4a605c', 3500000.0000, 4, 0)
INSERT [dbo].[Staff] ([staff_id], [username], [password], [salary], [role_id], [is_deleted]) VALUES (N'STAFF_3', N'trungnd224', N'117b22aec862cba114e964a5577f5d09', 2500000.0000, 3, 0)
INSERT [dbo].[Staff] ([staff_id], [username], [password], [salary], [role_id], [is_deleted]) VALUES (N'STAFF_4', N'ngahoang1975', N'9b7c034f42c5f4cdb848ff84c0b26cfc', 3500000.0000, 1, 0)
SET IDENTITY_INSERT [dbo].[StatusOrder] ON 

INSERT [dbo].[StatusOrder] ([id], [status_name]) VALUES (1, N'Đơn mới')
INSERT [dbo].[StatusOrder] ([id], [status_name]) VALUES (2, N'Đang giao')
INSERT [dbo].[StatusOrder] ([id], [status_name]) VALUES (3, N'Ðã giao')
INSERT [dbo].[StatusOrder] ([id], [status_name]) VALUES (4, N'Hủy đơn')
SET IDENTITY_INSERT [dbo].[StatusOrder] OFF
SET IDENTITY_INSERT [dbo].[Supplier] ON 

INSERT [dbo].[Supplier] ([id], [name], [phone_num], [address]) VALUES (1, N'Công ty STVG', N'0188111982', N'110 Bùi Tá Hán, thành phố Thủ Đức')
INSERT [dbo].[Supplier] ([id], [name], [phone_num], [address]) VALUES (2, N'Học viện Công nghệ Bưu Chính Viễn Thông TPHCM', N'0987228173', N'97 Man Thiện')
SET IDENTITY_INSERT [dbo].[Supplier] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Customer__F3DBC572B1871016]    Script Date: 11/10/2021 11:00:12 AM ******/
ALTER TABLE [dbo].[Customer] ADD UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Person__4943C3B48D8242DF]    Script Date: 11/10/2021 11:00:12 AM ******/
ALTER TABLE [dbo].[Person] ADD  CONSTRAINT [UQ__Person__4943C3B48D8242DF] UNIQUE NONCLUSTERED 
(
	[identity_card] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Person__AB6E61646CDF8F70]    Script Date: 11/10/2021 11:00:12 AM ******/
ALTER TABLE [dbo].[Person] ADD  CONSTRAINT [UQ__Person__AB6E61646CDF8F70] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Person__E592CEB3A1102599]    Script Date: 11/10/2021 11:00:12 AM ******/
ALTER TABLE [dbo].[Person] ADD  CONSTRAINT [UQ__Person__E592CEB3A1102599] UNIQUE NONCLUSTERED 
(
	[phone_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Staff__F3DBC5727E433AFF]    Script Date: 11/10/2021 11:00:12 AM ******/
ALTER TABLE [dbo].[Staff] ADD UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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
ALTER TABLE [dbo].[Phone]  WITH CHECK ADD  CONSTRAINT [FK_PhoneColor] FOREIGN KEY([color])
REFERENCES [dbo].[PhoneColor] ([id])
GO
ALTER TABLE [dbo].[Phone] CHECK CONSTRAINT [FK_PhoneColor]
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
ALTER TABLE [dbo].[Phone]  WITH CHECK ADD  CONSTRAINT [positive_price] CHECK  (([price]>=(0)))
GO
ALTER TABLE [dbo].[Phone] CHECK CONSTRAINT [positive_price]
GO
ALTER TABLE [dbo].[Phone]  WITH CHECK ADD  CONSTRAINT [positive_quantity] CHECK  (([quantity]>=(0)))
GO
ALTER TABLE [dbo].[Phone] CHECK CONSTRAINT [positive_quantity]
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD CHECK  (([is_deleted]=(1) OR [is_deleted]=(0)))
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD  CONSTRAINT [positive_salary] CHECK  (([salary]>=(0)))
GO
ALTER TABLE [dbo].[Staff] CHECK CONSTRAINT [positive_salary]
GO
/****** Object:  StoredProcedure [dbo].[ActiveCustomer]    Script Date: 11/10/2021 11:00:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActiveCustomer] (@email varchar(64))
AS 
BEGIN
				declare @customer_id varchar(16) = '';
				select @customer_id = id from Person where email = @email;
				print(@customer_id)
				update Customer set is_active = 1 where customer_id = @customer_id;
	 
END;
GO
/****** Object:  StoredProcedure [dbo].[ChangeInfoPerson]    Script Date: 11/10/2021 11:00:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ChangeInfoPerson] (@f_name nvarchar(16), @l_name nvarchar(32), @gen nvarchar(3), @id_card varchar(16), @mail varchar(64),
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
			  DECLARE @ErrorMessage VARCHAR(2000)
			  SELECT @ErrorMessage = 'Error: ' + ERROR_MESSAGE()
			  RAISERROR(@ErrorMessage, 16, 1)
       END CATCH
	 
END;
GO
/****** Object:  StoredProcedure [dbo].[ChangePasswordCustomer]    Script Date: 11/10/2021 11:00:12 AM ******/
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
/****** Object:  StoredProcedure [dbo].[ChangePasswordStaff]    Script Date: 11/10/2021 11:00:12 AM ******/
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
/****** Object:  StoredProcedure [dbo].[CheckExistedCustomerUser]    Script Date: 11/10/2021 11:00:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CheckExistedCustomerUser] (@user varchar(16))
AS 
BEGIN
	select count(*) from Customer where username = @user
	 
END;
GO
/****** Object:  StoredProcedure [dbo].[CheckExistedStaffUser]    Script Date: 11/10/2021 11:00:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CheckExistedStaffUser] (@user varchar(16))
AS 
BEGIN
	select count(*) from Staff where username = @user
	 
END;
GO
/****** Object:  StoredProcedure [dbo].[DeleteStaff]    Script Date: 11/10/2021 11:00:12 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetCustomerEmailByUsername]    Script Date: 11/10/2021 11:00:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetCustomerEmailByUsername] (@user varchar(16))
AS 
BEGIN
	declare @id_person varchar(16) = '';
	select @id_person = customer_id from Customer where username = @user;

	select email from Person where id = @id_person;
	 
END;
GO
/****** Object:  StoredProcedure [dbo].[GetPasswordCustomer]    Script Date: 11/10/2021 11:00:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPasswordCustomer] (@user varchar(16))
AS 
BEGIN
	select password from Customer where username = @user
	 
END;
GO
/****** Object:  StoredProcedure [dbo].[GetPasswordStaff]    Script Date: 11/10/2021 11:00:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPasswordStaff] (@user varchar(16))
AS 
BEGIN
	select password from Staff where username = @user
	 
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertCustomer]    Script Date: 11/10/2021 11:00:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertCustomer] (@f_name nvarchar(16), @l_name nvarchar(32), @gen nvarchar(3), @id_card varchar(16), @mail varchar(64),
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

				 INSERT INTO Customer values(@new_id, @user, @pass, 0)
				
				COMMIT TRANSACTION
				END TRY
       BEGIN CATCH
              -- if error, roll back any chanegs done by any of the sql statements
              ROLLBACK TRANSACTION
			  DECLARE @ErrorMessage VARCHAR(2000)
			  SELECT @ErrorMessage = 'Error: ' + ERROR_MESSAGE()
			  RAISERROR(@ErrorMessage, 16, 1)
       END CATCH
	 
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertCustomerOrder]    Script Date: 11/10/2021 11:00:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertCustomerOrder] (@customer_id varchar(16), @address nvarchar(128), @staff_id varchar(16), @note nvarchar(256))
AS 
BEGIN
		insert into CustomerOrder(customer_id, created_date, address, staff_id, status_id, note)
		output inserted.id
		values(@customer_id, getdate(), @address, @staff_id, 1, @note);
	 
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertCustomerOrderDetail]    Script Date: 11/10/2021 11:00:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertCustomerOrderDetail] (@order_id bigint, @phone_id int, @quantity int, @price money)
AS 
BEGIN
	BEGIN TRAN
              BEGIN TRY
				insert into CustomerOrderDetail(order_id, phone_id, quantity, price)
				values(@order_id, @phone_id, @quantity, @price);

				update Phone set quantity = quantity - @quantity
				where id = @phone_id;
				
				COMMIT TRANSACTION
				END TRY
       BEGIN CATCH
              -- if error, roll back any chanegs done by any of the sql statements
              ROLLBACK TRANSACTION
			  DECLARE @ErrorMessage VARCHAR(2000)
			  SELECT @ErrorMessage = 'Error: ' + ERROR_MESSAGE()
			  RAISERROR(@ErrorMessage, 16, 1)
       END CATCH
	 
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertPhone]    Script Date: 11/10/2021 11:00:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertPhone] (@phone_name nvarchar(64), @phone_type int, @phone_descrip nvarchar(256),
										@quantity int, @img varchar(32), @color int, @price money)
AS 
BEGIN
	BEGIN TRAN
              BEGIN TRY
				insert into Phone values(@phone_name, @phone_type, @phone_descrip, @quantity, @img, @color, @price);
				
				COMMIT TRANSACTION
				END TRY
       BEGIN CATCH
              -- if error, roll back any chanegs done by any of the sql statements
              ROLLBACK TRANSACTION
			  DECLARE @ErrorMessage VARCHAR(2000)
			  SELECT @ErrorMessage = 'Error: ' + ERROR_MESSAGE()
			  RAISERROR(@ErrorMessage, 16, 1)
       END CATCH
	 
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertPhoneColor]    Script Date: 11/10/2021 11:00:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertPhoneColor] (@color nvarchar(64))
AS 
BEGIN
	BEGIN TRAN
              BEGIN TRY
				insert into PhoneColor values(@color);
				
				COMMIT TRANSACTION
				END TRY
       BEGIN CATCH
              -- if error, roll back any chanegs done by any of the sql statements
              ROLLBACK TRANSACTION
			  DECLARE @ErrorMessage VARCHAR(2000)
			  SELECT @ErrorMessage = 'Error: ' + ERROR_MESSAGE()
			  RAISERROR(@ErrorMessage, 16, 1)
       END CATCH
	 
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertPhoneType]    Script Date: 11/10/2021 11:00:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertPhoneType] (@type_phone_name nvarchar(64))
AS 
BEGIN
	BEGIN TRAN
              BEGIN TRY
				insert into PhoneType values(@type_phone_name);
				
				COMMIT TRANSACTION
				END TRY
       BEGIN CATCH
              -- if error, roll back any chanegs done by any of the sql statements
              ROLLBACK TRANSACTION
			  DECLARE @ErrorMessage VARCHAR(2000)
			  SELECT @ErrorMessage = 'Error: ' + ERROR_MESSAGE()
			  RAISERROR(@ErrorMessage, 16, 1)
       END CATCH
	 
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertRole]    Script Date: 11/10/2021 11:00:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[InsertRole] @role_name nvarchar(16)
as
begin
	insert into RoleStaff values(@role_name)
end
 
GO
/****** Object:  StoredProcedure [dbo].[InsertStaff]    Script Date: 11/10/2021 11:00:12 AM ******/
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
			  DECLARE @ErrorMessage VARCHAR(2000)
			  SELECT @ErrorMessage = 'Error: ' + ERROR_MESSAGE()
			  RAISERROR(@ErrorMessage, 16, 1)
       END CATCH
	 
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertSupplier]    Script Date: 11/10/2021 11:00:12 AM ******/
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
/****** Object:  StoredProcedure [dbo].[TestInsertCustomer]    Script Date: 11/10/2021 11:00:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TestInsertCustomer] (@f_name nvarchar(16), @l_name nvarchar(32), @gen nvarchar(3), @id_card varchar(16), @mail varchar(32),
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
			  DECLARE @ErrorMessage VARCHAR(2000)
			  SELECT @ErrorMessage = 'Error: ' + ERROR_MESSAGE()
			  RAISERROR(@ErrorMessage, 16, 1)
       END CATCH
	 
END;

GO
/****** Object:  StoredProcedure [dbo].[UpdateCustomerOrder]    Script Date: 11/10/2021 11:00:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateCustomerOrder] (@order_id bigint, @staff_id varchar(16), @status_id int)
AS 
BEGIN
	BEGIN TRAN
              BEGIN TRY
				update CustomerOrder set staff_id = @staff_id, status_id = @status_id where id = @order_id;
				if(@status_id = 4)
				begin
					update Phone set quantity = Phone.quantity + CustomerOrderDetail.quantity
					from CustomerOrderDetail where order_id = @order_id and Phone.id = CustomerOrderDetail.phone_id
				end
				COMMIT TRANSACTION
				END TRY
       BEGIN CATCH
              -- if error, roll back any chanegs done by any of the sql statements
              ROLLBACK TRANSACTION
			  DECLARE @ErrorMessage VARCHAR(2000)
			  SELECT @ErrorMessage = 'Error: ' + ERROR_MESSAGE()
			  RAISERROR(@ErrorMessage, 16, 1)
       END CATCH
	 
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdatePhone]    Script Date: 11/10/2021 11:00:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdatePhone] (@phone_name nvarchar(64), @phone_type int, @phone_descrip nvarchar(256),
									 @quantity int, @img varchar(32), @color int, @price money, @id int)
AS 
BEGIN
	BEGIN TRAN
              BEGIN TRY
				update Phone set phone_name = @phone_name, phone_type = @phone_type, phone_descrip = @phone_descrip,
									quantity = @quantity, img = @img, color = @color, price = @price
									where id = @id;
				
				COMMIT TRANSACTION
				END TRY
       BEGIN CATCH
              -- if error, roll back any chanegs done by any of the sql statements
              ROLLBACK TRANSACTION
			  DECLARE @ErrorMessage VARCHAR(2000)
			  SELECT @ErrorMessage = 'Error: ' + ERROR_MESSAGE()
			  RAISERROR(@ErrorMessage, 16, 1)
       END CATCH
	 
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateStaff]    Script Date: 11/10/2021 11:00:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateStaff] (@role_id int, @salary money, @staff_id varchar(16))
AS 
BEGIN
	BEGIN TRAN
              BEGIN TRY
				update Staff set role_id = @role_id, salary = @salary
				where staff_id = @staff_id;
				
				COMMIT TRANSACTION
				END TRY
       BEGIN CATCH
              -- if error, roll back any chanegs done by any of the sql statements
              ROLLBACK TRANSACTION
			  DECLARE @ErrorMessage VARCHAR(2000)
			  SELECT @ErrorMessage = 'Error: ' + ERROR_MESSAGE()
			  RAISERROR(@ErrorMessage, 16, 1)
       END CATCH
	 
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateSupplier]    Script Date: 11/10/2021 11:00:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateSupplier] (@id int, @name nvarchar(128), @phone varchar(16), @address nvarchar(128))
AS 
BEGIN
	BEGIN TRAN
              BEGIN TRY
				update Supplier set name = @name, phone_num = @phone, address = @address
				where id = @id;
				
				COMMIT TRANSACTION
				END TRY
       BEGIN CATCH
              -- if error, roll back any chanegs done by any of the sql statements
              ROLLBACK TRANSACTION
			  DECLARE @ErrorMessage VARCHAR(2000)
			  SELECT @ErrorMessage = 'Error: ' + ERROR_MESSAGE()
			  RAISERROR(@ErrorMessage, 16, 1)
       END CATCH
	 
END;
GO
USE [master]
GO
ALTER DATABASE [MobileShop] SET  READ_WRITE 
GO
