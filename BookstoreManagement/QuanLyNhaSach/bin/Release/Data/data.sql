USE [master]
GO
/****** Object:  Database [QuanLyNhaSach]    Script Date: 12/27/2020 11:05:29 PM ******/
CREATE DATABASE [QuanLyNhaSach]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuanLyNhaSach', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\QuanLyNhaSach.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QuanLyNhaSach_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\QuanLyNhaSach_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [QuanLyNhaSach] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuanLyNhaSach].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuanLyNhaSach] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [QuanLyNhaSach] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyNhaSach] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLyNhaSach] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QuanLyNhaSach] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLyNhaSach] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QuanLyNhaSach] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLyNhaSach] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLyNhaSach] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuanLyNhaSach] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuanLyNhaSach] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QuanLyNhaSach] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QuanLyNhaSach] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [QuanLyNhaSach] SET QUERY_STORE = OFF
GO
USE [QuanLyNhaSach]
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_MANXB]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Thêm Mã Nhà Xuất Bản
CREATE FUNCTION [dbo].[AUTO_MANXB]()
RETURNS VARCHAR(6)
AS
BEGIN
	DECLARE @ma VARCHAR(6)
	IF (SELECT COUNT(MaNXB) FROM NhaXuatBan) = 0
		SET @ma = '0'
	ELSE
		SELECT @ma = MAX(RIGHT(MaNXB, 3)) FROM NhaXuatBan
		SELECT @ma = CASE
			WHEN @ma >= 0 and @ma < 9 THEN 'NXB00' + CONVERT(VARCHAR, CONVERT(INT, @ma) + 1)
			WHEN @ma >= 9 THEN 'NXB0' + CONVERT(VARCHAR, CONVERT(INT, @ma) + 1)
		END
	RETURN @ma
END
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_MAPN]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Thêm Mã PN-Trong Bảng PhieuNhap
CREATE FUNCTION [dbo].[AUTO_MAPN]()
RETURNS VARCHAR(5)
AS
BEGIN
	DECLARE @ma VARCHAR(5)
	IF (SELECT COUNT(SoPN) FROM PhieuNhap) = 0
		SET @ma = '0'
	ELSE
		SELECT @ma = MAX(RIGHT(SoPN, 3)) FROM PhieuNhap
		SELECT @ma = CASE
			WHEN @ma >= 0 and @ma < 9 THEN 'PN00' + CONVERT(CHAR, CONVERT(INT, @ma) + 1)
			WHEN @ma >= 9 THEN 'PN0' + CONVERT(CHAR, CONVERT(INT, @ma) + 1)
		END
	RETURN @ma
END
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_MAPN_CTPN]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Thêm Mã PN--Trong Bảng ChiTietPhieuNhap
CREATE FUNCTION [dbo].[AUTO_MAPN_CTPN]()
RETURNS VARCHAR(5)
AS
BEGIN
	DECLARE @ma VARCHAR(5)
	IF (SELECT COUNT(SoPN) FROM ChiTietPhieuNhap) = 0
		SET @ma = '0'
	ELSE
		SELECT @ma = MAX(RIGHT(SoPN, 3)) FROM ChiTietPhieuNhap
		SELECT @ma = CASE
			WHEN @ma >= 0 and @ma < 9 THEN 'PN00' + CONVERT(CHAR, CONVERT(INT, @ma) + 1)
			WHEN @ma >= 9 THEN 'PN0' + CONVERT(CHAR, CONVERT(INT, @ma) + 1)
		END
	RETURN @ma
END
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_MASACH]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Thêm Mã Sách-Trong Bảng Sách
CREATE FUNCTION [dbo].[AUTO_MASACH]()
RETURNS VARCHAR(5)
AS
BEGIN
	DECLARE @ma VARCHAR(5)
	IF (SELECT COUNT(MaSach) FROM Sach) = 0
		SET @ma = '0'
	ELSE
		SELECT @ma = MAX(RIGHT(MaSach, 3)) FROM dbo.Sach
		SELECT @ma = CASE
			WHEN @ma >= 0 and @ma < 9 THEN 'S00' + CONVERT(VARCHAR, CONVERT(INT, @ma) + 1)
			WHEN @ma >= 9 THEN 'S0' + CONVERT(VARCHAR, CONVERT(INT, @ma) + 1)
		END
	RETURN @ma
END
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_MASACH_CTPN]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Thêm Mã Sách-- Trong Bảng ChiTietPhieuNhap
CREATE FUNCTION [dbo].[AUTO_MASACH_CTPN]()
RETURNS VARCHAR(5)
AS
BEGIN
	DECLARE @ma VARCHAR(5)
	IF (SELECT COUNT(MaSach) FROM ChiTietPhieuNhap) = 0
		SET @ma = '0'
	ELSE
		SELECT @ma = MAX(RIGHT(MaSach, 3)) FROM ChiTietPhieuNhap
		SELECT @ma = CASE
			WHEN @ma >= 0 and @ma < 9 THEN 'S00' + CONVERT(VARCHAR, CONVERT(INT, @ma) + 1)
			WHEN @ma >= 9 THEN 'S0' + CONVERT(VARCHAR, CONVERT(INT, @ma) + 1)
		END
	RETURN @ma
END
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_MATG]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Thêm Mã Tác Giả
CREATE FUNCTION [dbo].[AUTO_MATG]()
RETURNS VARCHAR(5)
AS
BEGIN
	DECLARE @ma VARCHAR(5)
	IF (SELECT COUNT(MaTG) FROM TacGia) = 0
		SET @ma = '0'
	ELSE
		SELECT @ma = MAX(RIGHT(MaTG, 3)) FROM TacGia
		SELECT @ma = CASE
			WHEN @ma >= 0 and @ma < 9 THEN 'TG00' + CONVERT(CHAR, CONVERT(INT, @ma) + 1)
			WHEN @ma >= 9 THEN 'TG0' + CONVERT(CHAR, CONVERT(INT, @ma) + 1)
		END
	RETURN @ma
END
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_MATL]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Thêm mã thể loại
CREATE FUNCTION [dbo].[AUTO_MATL]()
RETURNS VARCHAR(5)
AS
BEGIN
	DECLARE @ma VARCHAR(5)
	IF (SELECT COUNT(MaTL) FROM TheLoai) = 0
		SET @ma = '0'
	ELSE
		SELECT @ma = MAX(RIGHT(MaTL, 3)) FROM TheLoai
		SELECT @ma = CASE
			WHEN @ma >= 0 and @ma < 9 THEN 'TL00' + CONVERT(CHAR, CONVERT(INT, @ma) + 1)
			WHEN @ma >= 9 THEN 'TL0' + CONVERT(CHAR, CONVERT(INT, @ma) + 1)
		END
	RETURN @ma
END
GO
/****** Object:  Table [dbo].[ChiTietHoaDon]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietHoaDon](
	[MaSach] [char](4) NOT NULL,
	[SoHD] [char](5) NOT NULL,
	[SoLuongBan] [int] NOT NULL,
	[GiaBan] [int] NOT NULL,
	[ThanhTien] [int] NOT NULL,
 CONSTRAINT [pk_CTHD] PRIMARY KEY CLUSTERED 
(
	[MaSach] ASC,
	[SoHD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChiTietPhieuNhap]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietPhieuNhap](
	[MaSach] [char](4) NOT NULL,
	[SoPN] [char](5) NOT NULL,
	[SoLuongNhap] [int] NOT NULL,
	[GiaNhap] [int] NOT NULL,
 CONSTRAINT [pk_CTPN] PRIMARY KEY CLUSTERED 
(
	[MaSach] ASC,
	[SoPN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HoaDon]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDon](
	[SoHD] [char](5) NOT NULL,
	[NgayBan] [smalldatetime] NOT NULL,
	[TongTriGia] [int] NOT NULL,
	[TenNhanVien] [nvarchar](30) NOT NULL,
	[TenKhachHang] [nvarchar](30) NULL,
 CONSTRAINT [pk_HD] PRIMARY KEY CLUSTERED 
(
	[SoHD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhaXuatBan]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhaXuatBan](
	[MaNXB] [char](6) NOT NULL,
	[TenNXB] [nvarchar](100) NOT NULL,
	[DiaChiNXB] [nvarchar](100) NOT NULL,
	[DienThoai] [varchar](20) NOT NULL,
 CONSTRAINT [pk_NXB] PRIMARY KEY CLUSTERED 
(
	[MaNXB] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhieuNhap]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhieuNhap](
	[SoPN] [char](5) NOT NULL,
	[NgayNhap] [smalldatetime] NOT NULL,
	[MaNXB] [char](6) NOT NULL,
 CONSTRAINT [pk_PN] PRIMARY KEY CLUSTERED 
(
	[SoPN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sach]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sach](
	[MaSach] [char](4) NOT NULL,
	[TenSach] [nvarchar](60) NOT NULL,
	[SoLuongTon] [int] NOT NULL,
	[MaTL] [char](5) NOT NULL,
	[MaTG] [char](5) NOT NULL,
	[MaNXB] [char](6) NOT NULL,
	[GiaTien] [int] NOT NULL,
	[KinhDoanh] [nvarchar](15) NOT NULL,
 CONSTRAINT [pk_S] PRIMARY KEY CLUSTERED 
(
	[MaSach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TacGia]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TacGia](
	[MaTG] [char](5) NOT NULL,
	[TenTG] [nvarchar](40) NOT NULL,
	[LienLac] [nvarchar](40) NULL,
 CONSTRAINT [pk_TG] PRIMARY KEY CLUSTERED 
(
	[MaTG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiKhoan](
	[TenDN] [nvarchar](50) NOT NULL,
	[HoTen] [nvarchar](50) NOT NULL,
	[Loai] [int] NOT NULL,
	[MatKhau] [nvarchar](1000) NOT NULL,
	[NhapSach] [int] NOT NULL,
	[ThongKe] [int] NOT NULL,
	[KeSach] [int] NOT NULL,
	[ThemDuLieu] [int] NOT NULL,
	[BanSach] [int] NOT NULL,
	[TTTaiKhoan] [int] NOT NULL,
	[CaiDat] [int] NOT NULL,
	[Ma] [nvarchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TenDN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TheLoai]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TheLoai](
	[MaTL] [char](5) NOT NULL,
	[TenTL] [nvarchar](50) NOT NULL,
 CONSTRAINT [pk_TL] PRIMARY KEY CLUSTERED 
(
	[MaTL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[TaiKhoan] ([TenDN], [HoTen], [Loai], [MatKhau], [NhapSach], [ThongKe], [KeSach], [ThemDuLieu], [BanSach], [TTTaiKhoan], [CaiDat], [Ma]) VALUES (N'admin', N'Quản lý', 1, N'admin', 1, 1, 1, 1, 1, 1, 1, N'KVC2020')
GO
ALTER TABLE [dbo].[ChiTietPhieuNhap] ADD  CONSTRAINT [df_ID_SACH_CTPN]  DEFAULT ([DBO].[AUTO_MASACH_CTPN]()) FOR [MaSach]
GO
ALTER TABLE [dbo].[ChiTietPhieuNhap] ADD  CONSTRAINT [df_ID_PN_CTPN]  DEFAULT ([DBO].[AUTO_MAPN]()) FOR [SoPN]
GO
ALTER TABLE [dbo].[NhaXuatBan] ADD  CONSTRAINT [df_ID_NXB]  DEFAULT ([DBO].[AUTO_MANXB]()) FOR [MaNXB]
GO
ALTER TABLE [dbo].[PhieuNhap] ADD  CONSTRAINT [df_ID_PN]  DEFAULT ([DBO].[AUTO_MAPN]()) FOR [SoPN]
GO
ALTER TABLE [dbo].[Sach] ADD  CONSTRAINT [df_ID_SACH]  DEFAULT ([DBO].[AUTO_MASACH]()) FOR [MaSach]
GO
ALTER TABLE [dbo].[Sach] ADD  DEFAULT (N'Còn') FOR [KinhDoanh]
GO
ALTER TABLE [dbo].[TacGia] ADD  CONSTRAINT [df_ID_TG]  DEFAULT ([DBO].[AUTO_MATG]()) FOR [MaTG]
GO
ALTER TABLE [dbo].[TaiKhoan] ADD  DEFAULT ((0)) FOR [Loai]
GO
ALTER TABLE [dbo].[TaiKhoan] ADD  DEFAULT ((0)) FOR [CaiDat]
GO
ALTER TABLE [dbo].[TheLoai] ADD  CONSTRAINT [df_ID_TL]  DEFAULT ([DBO].[AUTO_MATL]()) FOR [MaTL]
GO
ALTER TABLE [dbo].[ChiTietHoaDon]  WITH CHECK ADD  CONSTRAINT [fk_CTHD_MaSach] FOREIGN KEY([MaSach])
REFERENCES [dbo].[Sach] ([MaSach])
GO
ALTER TABLE [dbo].[ChiTietHoaDon] CHECK CONSTRAINT [fk_CTHD_MaSach]
GO
ALTER TABLE [dbo].[ChiTietHoaDon]  WITH CHECK ADD  CONSTRAINT [fk_CTHD_SoHD] FOREIGN KEY([SoHD])
REFERENCES [dbo].[HoaDon] ([SoHD])
GO
ALTER TABLE [dbo].[ChiTietHoaDon] CHECK CONSTRAINT [fk_CTHD_SoHD]
GO
ALTER TABLE [dbo].[ChiTietPhieuNhap]  WITH CHECK ADD  CONSTRAINT [fk_CTPN_MaSach] FOREIGN KEY([MaSach])
REFERENCES [dbo].[Sach] ([MaSach])
GO
ALTER TABLE [dbo].[ChiTietPhieuNhap] CHECK CONSTRAINT [fk_CTPN_MaSach]
GO
ALTER TABLE [dbo].[ChiTietPhieuNhap]  WITH CHECK ADD  CONSTRAINT [fk_CTPN_SoPN] FOREIGN KEY([SoPN])
REFERENCES [dbo].[PhieuNhap] ([SoPN])
GO
ALTER TABLE [dbo].[ChiTietPhieuNhap] CHECK CONSTRAINT [fk_CTPN_SoPN]
GO
ALTER TABLE [dbo].[PhieuNhap]  WITH CHECK ADD  CONSTRAINT [fk_PN] FOREIGN KEY([MaNXB])
REFERENCES [dbo].[NhaXuatBan] ([MaNXB])
GO
ALTER TABLE [dbo].[PhieuNhap] CHECK CONSTRAINT [fk_PN]
GO
ALTER TABLE [dbo].[Sach]  WITH CHECK ADD  CONSTRAINT [fk_S_MaNXB] FOREIGN KEY([MaNXB])
REFERENCES [dbo].[NhaXuatBan] ([MaNXB])
GO
ALTER TABLE [dbo].[Sach] CHECK CONSTRAINT [fk_S_MaNXB]
GO
ALTER TABLE [dbo].[Sach]  WITH CHECK ADD  CONSTRAINT [fk_S_MaTG] FOREIGN KEY([MaTG])
REFERENCES [dbo].[TacGia] ([MaTG])
GO
ALTER TABLE [dbo].[Sach] CHECK CONSTRAINT [fk_S_MaTG]
GO
ALTER TABLE [dbo].[Sach]  WITH CHECK ADD  CONSTRAINT [fk_S_MaTL] FOREIGN KEY([MaTL])
REFERENCES [dbo].[TheLoai] ([MaTL])
GO
ALTER TABLE [dbo].[Sach] CHECK CONSTRAINT [fk_S_MaTL]
GO
/****** Object:  StoredProcedure [dbo].[USP_CapNhatMatKhau]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Cập nhật mật khẩu
CREATE PROC [dbo].[USP_CapNhatMatKhau]
@mkmoi NVARCHAR(50), @matk VARCHAR(5)
AS
BEGIN
	UPDATE TaiKhoan
	SET
	
		MatKhau = @mkmoi
		
	WHERE
		Ma = @matk
END
GO
/****** Object:  StoredProcedure [dbo].[USP_CapNhatTaiKhoan]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Cập nhật tài khoản
CREATE PROC [dbo].[USP_CapNhatTaiKhoan]
@tendn NVARCHAR(50), @tenht NVARCHAR(50), @nhapsach INT, @thongke INT, @kesach INT, @themdl INT, @bansach INT, @tttaikhoan INT, @mkmoi NVARCHAR(50)
AS
BEGIN
	UPDATE TaiKhoan
	SET
		HoTen = @tenht,
		MatKhau = @mkmoi,
		NhapSach = @nhapsach,
		ThongKe = @thongke,
		KeSach = @kesach,
		ThemDuLieu = @themdl,
		BanSach = @bansach,
		TTTaiKhoan = @tttaikhoan
	WHERE
		TenDN = @tenDN
END
GO
/****** Object:  StoredProcedure [dbo].[USP_CapNhatTenDNAdmin]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Cập nhật tài khoản admin
CREATE PROC [dbo].[USP_CapNhatTenDNAdmin]
@tendncu NVARCHAR(50), @tendnmoi NVARCHAR(50), @mk NVARCHAR(50)
AS
BEGIN
	UPDATE TaiKhoan
	SET
		TenDN = @tendnmoi
	WHERE
		TenDN = @tendncu AND MatKhau = @mk
END
GO
/****** Object:  StoredProcedure [dbo].[USP_DangNhap]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Đăng nhập
CREATE PROC [dbo].[USP_DangNhap]
@tenDN NVARCHAR(50), @matKhau NVARCHAR(50)
AS
BEGIN
	SELECT * FROM TaiKhoan WHERE TenDN = @tenDN AND MatKhau = @matKhau
END
GO
/****** Object:  StoredProcedure [dbo].[USP_HienThiHoaDon]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Hiển thị hóa đơn 
CREATE PROC [dbo].[USP_HienThiHoaDon]
  @NgayBan1 DATETIME, @NgayBan2 DATETIME
AS
BEGIN
SELECT
	hd.SoHD AS [Số Hóa Đơn],
	hd.NgayBan AS [Ngày Bán],
	hd.TongTriGia AS [Tổng trị giá],
	hd.TenKhachHang AS [Tên Khách Hàng],
	hd.TenNhanVien AS [Tên Nhân Viên]
FROM dbo.HoaDon hd
WHERE hd.NgayBan >= @NgayBan1 AND hd.NgayBan <= @NgayBan2
END
GO
/****** Object:  StoredProcedure [dbo].[USP_HienThiNhaXuatBan]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Hiển thị nhà sản xuất

CREATE PROC [dbo].[USP_HienThiNhaXuatBan]
AS
BEGIN
	SELECT
		nxb.MaNXB AS [Mã NXB],
		nxb.TenNXB AS [Tên NXB],
		nxb.DiaChiNXB AS [Địa chỉ NXB],
		nxb.DienThoai AS [Số Điện Thoại]
	FROM
		NhaXuatBan AS nxb
END
GO
/****** Object:  StoredProcedure [dbo].[USP_HienThiPhieuNhap]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Hiển thị phiếu nhập
CREATE PROC [dbo].[USP_HienThiPhieuNhap]
  @NgayDau DATETIME, @NgayCuoi DATETIME
AS
BEGIN
SELECT
	s.TenSach,
	ctpn.SoLuongNhap,
	s.GiaTien,
	s.GiaTien * ctpn.SoLuongNhap AS [ThanhTien],
	pn.NgayNhap,
	nxb.TenNXB
FROM dbo.PhieuNhap pn, dbo.Sach s, dbo.NhaXuatBan nxb, dbo.ChiTietPhieuNhap ctpn
WHERE pn.NgayNhap >= @NgayDau AND pn.NgayNhap <= @NgayCuoi AND ctpn.SoPN = pn.SoPN AND s.MaSach = ctpn.MaSach AND nxb.MaNXB = pn.MaNXB
END
GO
/****** Object:  StoredProcedure [dbo].[USP_HienThiSach]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Hiển thị sách
CREATE PROC [dbo].[USP_HienThiSach]
AS
BEGIN
	SELECT DISTINCT s.MaSach, s.TenSach, tg.TenTG,tl.TenTL, nxb.TenNXB,s.SoLuongTon,s.GiaTien
	FROM Sach s 
	INNER JOIN ChiTietPhieuNhap ct on s.MaSach=ct.MaSach
	INNER JOIN TacGia tg on s.MaTG=tg.MaTG
	INNER JOIN TheLoai tl on s.MaTL=tl.MaTL
	INNER JOIN NhaXuatBan nxb on s.MaNXB=nxb.MaNXB
	WHERE s.KinhDoanh = N'Còn'
END
GO
/****** Object:  StoredProcedure [dbo].[USP_HienThiSachTimKiem]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	
--Hiển thị sách tìm kiếm
CREATE PROC [dbo].[USP_HienThiSachTimKiem]
AS
BEGIN
	SELECT
	s.MaSach AS [ID],
	s.TenSach AS [Tên Sách],
	s.SoLuongTon AS [Số Lượng],
	s.GiaTien AS [Giá Tiền]
	FROM Sach s , ChiTietPhieuNhap ct, TacGia tg, TheLoai tl, NhaXuatBan nxb
	WHERE s.MaSach=ct.MaSach AND s.MaTG=tg.MaTG AND s.MaTL=tl.MaTL AND s.MaNXB=nxb.MaNXB AND s.KinhDoanh = N'Còn'
END
GO
/****** Object:  StoredProcedure [dbo].[USP_HienThiTacGia]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Hiển thị tác giả
CREATE PROC [dbo].[USP_HienThiTacGia]
AS
BEGIN
	SELECT
		tg.MaTG AS [Mã Tác Giả],
		tg.TenTG AS [Tên Tác Giả],
		tg.LienLac AS [Số Điện Thoại]
	FROM
		TacGia AS tg
END
GO
/****** Object:  StoredProcedure [dbo].[USP_HienThiTheLoai]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Hiển thị thể loại
CREATE PROC [dbo].[USP_HienThiTheLoai]
AS
BEGIN
	SELECT
		tl.MaTL AS [Mã Thể Loại],
		tl.TenTL AS [Tên Thể Loại]
	FROM
		TheLoai AS tl
END
GO
/****** Object:  StoredProcedure [dbo].[USP_LayTatCaSach]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Lấy tất cả sách
CREATE PROC [dbo].[USP_LayTatCaSach]
AS
BEGIN
	SELECT DISTINCT s.MaSach AS [ID], s.TenSach AS [Tên Sách], tg.TenTG AS [Tác Giả],tl.TenTL AS [Thể Loại], nxb.TenNXB AS [Nhà Sản Xuất] ,s.SoLuongTon AS [Số Lượng Tồn],s.GiaTien AS [Giá Tiền], s.KinhDoanh AS [Kinh Doanh]
	FROM Sach s 
	INNER JOIN ChiTietPhieuNhap ct on s.MaSach=ct.MaSach
	INNER JOIN TacGia tg on s.MaTG=tg.MaTG
	INNER JOIN TheLoai tl on s.MaTL=tl.MaTL
	INNER JOIN NhaXuatBan nxb on s.MaNXB=nxb.MaNXB
END
GO
/****** Object:  StoredProcedure [dbo].[USP_NgungKinhDoanhSach]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Trạng thái sách ngừng kinh doanh
CREATE PROC [dbo].[USP_NgungKinhDoanhSach]
@maSach CHAR(4)
AS
BEGIN
    UPDATE Sach
	SET KinhDoanh = N'Ngừng'
	WHERE MaSach = @maSach
END
GO
/****** Object:  StoredProcedure [dbo].[USP_QuenMatKhau]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Quên Mật Khẩu
CREATE PROC [dbo].[USP_QuenMatKhau]
@tendn NVARCHAR(50), @matkhaumoi NVARCHAR(50)
AS
BEGIN
    UPDATE QuanLyNhaSach.dbo.TaiKhoan
	SET
	MatKhau = @matkhaumoi
	WHERE
	TenDN = @tendn
END
GO
/****** Object:  StoredProcedure [dbo].[USP_SuaMaTaiKhoan]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Sửa mã tài khoản
CREATE PROC [dbo].[USP_SuaMaTaiKhoan]
@tenDN NVARCHAR(50), @ma NVARCHAR(50), @maMoi NVARCHAR(50)
AS
BEGIN
	DECLARE @isMaDung INT = 0
	
	SELECT @isMaDung = COUNT(*) FROM TaiKhoan WHERE @tenDN = TenDN AND @ma = Ma
	
	IF (@isMaDung = 1)
	BEGIN

		UPDATE TaiKhoan 
		SET
		Ma = @maMoi WHERE TenDN = @tenDN
	END
END
GO
/****** Object:  StoredProcedure [dbo].[USP_SuaNhaXuatBan]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Sửa nhà xuất bản
CREATE PROC [dbo].[USP_SuaNhaXuatBan]
@tennxb NVARCHAR(100), @sdt VARCHAR(20), @diachi NVARCHAR(100), @manxb CHAR(6)
AS
BEGIN
	UPDATE NhaXuatBan
	SET
	TenNXB = @tennxb,
	DienThoai = @sdt,
	DiaChiNXB = @diachi
	WHERE
	MaNXB = @manxb
END
GO
/****** Object:  StoredProcedure [dbo].[USP_SuaSach]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Sửa Sách
CREATE PROC [dbo].[USP_SuaSach]
@tensach NVARCHAR(50), @soluong INT, @giatien INT, @masach CHAR(4) 
AS
BEGIN
	UPDATE Sach
	SET
	TenSach = @tensach,
	SoLuongTon = @soluong,
	GiaTien = @giatien
	WHERE 
	MaSach = @masach
END
GO
/****** Object:  StoredProcedure [dbo].[USP_SuaTacGia]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Sửa tác giả
CREATE PROC [dbo].[USP_SuaTacGia]
@tentg NVARCHAR(50), @sdt NVARCHAR(20), @matg CHAR(5)
AS
BEGIN
	UPDATE TacGia
	SET
		TenTG = @tentg,
		LienLac =@sdt
		WHERE
		MaTG = @matg
END
GO
/****** Object:  StoredProcedure [dbo].[USP_SuaTaiKhoan]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Sửa tài khoản
CREATE PROC [dbo].[USP_SuaTaiKhoan]
@tenDN NVARCHAR(50), @tenHT NVARCHAR(50), @matKhau NVARCHAR(50), @matKhauMoi NVARCHAR(50)
AS
BEGIN
	DECLARE @isMKDung INT = 0
	
	SELECT @isMKDung = COUNT(*) FROM TaiKhoan WHERE @tenDN = TenDN AND @matKhau = MatKhau
	
	IF (@isMKDung = 1)
	BEGIN
		IF (@matKhauMoi = NULL OR @matKhauMoi = '')
		UPDATE TaiKhoan SET HoTen = @tenHT WHERE TenDN = @tenDN
		ELSE
		UPDATE TaiKhoan SET HoTen = @tenHT, MatKhau = @matKhauMoi WHERE TenDN = @tenDN
	END
END
GO
/****** Object:  StoredProcedure [dbo].[USP_SuaTheLoai]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Sửa thể loại
CREATE PROC [dbo].[USP_SuaTheLoai]
@tentl NVARCHAR(50), @matl CHAR(5)
AS
BEGIN
	UPDATE TheLoai
	SET
		TenTL = @tentl
		WHERE
		MaTL = @matl
END
GO
/****** Object:  StoredProcedure [dbo].[USP_ThanhToanSach]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Thanh toán sách

CREATE PROC [dbo].[USP_ThanhToanSach]
@maSach NVARCHAR(50) , @soLuong INT
AS
BEGIN
	UPDATE Sach
	SET
		SoLuongTon = SoLuongTon - @soLuong
	WHERE MaSach = @maSach
END
GO
/****** Object:  StoredProcedure [dbo].[USP_ThemChiTietHoaDon]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Thêm chi tiết hóa đơn 
CREATE PROC [dbo].[USP_ThemChiTietHoaDon] 
@maSach CHAR(4), @soHD CHAR(5), @soLuongBan INT, @giaBan INT
AS
BEGIN
    INSERT INTO ChiTietHoaDon
	(
		MaSach,
		SoHD,
		SoLuongBan,
		GiaBan,
		ThanhTien
	)
	VALUES
	(
		@maSach,
		@soHD,
		@soLuongBan,
		@giaBan,
		@giaBan * @soLuongBan
	)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_ThemHoaDon]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Thêm hóa đơn
CREATE PROC [dbo].[USP_ThemHoaDon]
@soHD CHAR(5), @ngay SMALLDATETIME, @tongTien INT, @tenkh NVARCHAR(30), @tennv NVARCHAR(30)
AS
BEGIN
    INSERT INTO HoaDon
	(
		SoHD,
		NgayBan,
		TongTriGia,
		TenKhachHang,
		TenNhanVien
	)
	VALUES
	(
		@soHD,
		@ngay,
		@tongTien,
		@tenkh,
		@tennv
	)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_ThemNhaXuatBan]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Thêm nhà xuất bản
CREATE PROC [dbo].[USP_ThemNhaXuatBan]
@tennxb NVARCHAR(50), @diachi NVARCHAR(100), @sdt NVARCHAR(50)
AS
BEGIN
	INSERT INTO NhaXuatBan
		(
			TenNXB,
			DiaChiNXB,
			DienThoai
		)
	VALUES
		(
			@tennxb,
			@diachi,
			@sdt
		)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_ThemSach]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Thêm sách
CREATE PROC [dbo].[USP_ThemSach]
@soPn CHAR(5),@maSach CHAR(4),@tenSach NVARCHAR(100), @soluong INT, @giatien INT, @matl CHAR(5), @matg CHAR(5), @manxb CHAR(6), @ngaynhap smalldatetime
AS
BEGIN
	SET DATEFORMAT DMY

	INSERT INTO Sach
	(
		MaSach,
		TenSach,
		SoLuongTon,
		GiaTien,
		MaTL,
		MaTG,
		MaNXB
	)
	VALUES
	(
		@maSach,
		@tenSach,
		@soluong,
		@giatien,
		@matl,
		@matg,
		@manxb
	)
	INSERT INTO PhieuNhap
	(
		SoPN,
		NgayNhap,
		MaNXB
	)
	VALUES
	(
		@soPn,
		@ngaynhap,
		@manxb
	)

	INSERT INTO ChiTietPhieuNhap
	(
		MaSach,
		SoPN,
		SoLuongNhap,
		GiaNhap
	)
	VALUES
	(
		@maSach,
		@soPn,
		@soluong,
		@giatien
	)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_ThemSLChoSach]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Thêm số lượng cho sách

CREATE PROC [dbo].[USP_ThemSLChoSach]
@soPn CHAR(5),@maSach CHAR(4), @soluong INT, @giatien INT, @ngaynhap SMALLDATETIME, @manxb CHAR(6)
AS
BEGIN
	INSERT INTO PhieuNhap
	(
		SoPN,
		NgayNhap,
		MaNXB
	)
	VALUES
	(
		@soPn,
		@ngaynhap,
		@manxb
	)
	INSERT INTO ChiTietPhieuNhap
	(
		MaSach,
		SoPN,
		SoLuongNhap,
		GiaNhap
	)
	VALUES
	(
		@maSach,
		@soPn,
		@soluong,
		@giatien
	)
	UPDATE Sach
	SET
		SoLuongTon = SoLuongTon + @soluong
	WHERE
		MaSach = @maSach
END
GO
/****** Object:  StoredProcedure [dbo].[USP_ThemTacGia]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Thêm tác giả
CREATE PROC [dbo].[USP_ThemTacGia]
@tentg NVARCHAR(50), @sdt NVARCHAR(40)
AS
BEGIN
	INSERT INTO TacGia
		(
			TenTG,
			LienLac
		)
	VALUES 
		(
			@tentg,
			@sdt
		)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_ThemTaiKhoan]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Thêm tài khoản
CREATE PROC [dbo].[USP_ThemTaiKhoan]
@tendn NVARCHAR(50),@matkhau NVARCHAR(50), @tenht NVARCHAR(50), @loai INT, @nhapsach INT, @thongke INT, @kesach INT, @themdl INT, @bansach INT, @tttaikhoan INT, @ma NVARCHAR(50)
AS
BEGIN
	INSERT INTO TaiKhoan
	(
		TenDN,
		HoTen,
		Loai,
		MatKhau,
		NhapSach,
		ThongKe,
		KeSach,
		ThemDuLieu,
		BanSach,
		TTTaiKhoan,
		Ma
	)
	VALUES
	(
		@tenDN,
		@tenHT,
		@loai,
		@matKhau,
		@nhapsach,
		@thongke,
		@kesach,
		@themdl,
		@bansach,
		@tttaikhoan,
		@ma
	)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_ThemTheLoai]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Thêm Thể Loại
CREATE PROC [dbo].[USP_ThemTheLoai]
@tentl NVARCHAR(50)
AS
BEGIN
	INSERT INTO TheLoai
		(
			TenTL
		)
	VALUES
		(
			@tentl
		)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_TimKiemSach_TacGia]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--Tìm kiếm sách qua tác giả
CREATE PROC [dbo].[USP_TimKiemSach_TacGia]
@tacGia NVARCHAR(50)
AS
BEGIN
	SELECT DISTINCT s.MaSach, s.TenSach, tg.TenTG,tl.TenTL, nxb.TenNXB,s.SoLuongTon,s.GiaTien,s.KinhDoanh
	FROM Sach s 
	INNER JOIN ChiTietPhieuNhap ct on s.MaSach=ct.MaSach
	INNER JOIN TacGia tg on s.MaTG=tg.MaTG
	INNER JOIN TheLoai tl on s.MaTL=tl.MaTL
	INNER JOIN NhaXuatBan nxb on s.MaNXB=nxb.MaNXB
	WHERE tg.TenTG LIKE CONCAT(@tacGia,'%') AND s.KinhDoanh = N'Còn'
END
GO
/****** Object:  StoredProcedure [dbo].[USP_TimKiemSach_TenSach]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Tìm kiếm sách qua tên sách

CREATE PROC [dbo].[USP_TimKiemSach_TenSach]
@tenSach NVARCHAR(50)
AS
BEGIN
	SELECT DISTINCT s.MaSach, s.TenSach, tg.TenTG,tl.TenTL, nxb.TenNXB,s.SoLuongTon,s.GiaTien,s.KinhDoanh
	FROM Sach s 
	INNER JOIN ChiTietPhieuNhap ct on s.MaSach=ct.MaSach
	INNER JOIN TacGia tg on s.MaTG=tg.MaTG
	INNER JOIN TheLoai tl on s.MaTL=tl.MaTL
	INNER JOIN NhaXuatBan nxb on s.MaNXB=nxb.MaNXB
	WHERE s.TenSach LIKE CONCAT(@tenSach,'%') AND s.KinhDoanh = N'Còn'
END
GO
/****** Object:  StoredProcedure [dbo].[USP_TimKiemSach_TheLoai]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--Tìm kiếm sách qua thể loại

CREATE PROC [dbo].[USP_TimKiemSach_TheLoai]
@theLoai NVARCHAR(50)
AS
BEGIN
	SELECT DISTINCT s.MaSach, s.TenSach, tg.TenTG,tl.TenTL, nxb.TenNXB,s.SoLuongTon,s.GiaTien,s.KinhDoanh
	FROM Sach s 
	INNER JOIN ChiTietPhieuNhap ct on s.MaSach=ct.MaSach
	INNER JOIN TacGia tg on s.MaTG=tg.MaTG
	INNER JOIN TheLoai tl on s.MaTL=tl.MaTL
	INNER JOIN NhaXuatBan nxb on s.MaNXB=nxb.MaNXB
	WHERE tl.TenTL LIKE CONCAT(@theLoai,'%') AND s.KinhDoanh = N'Còn'
END
GO
/****** Object:  StoredProcedure [dbo].[USP_TimSach_TacGia]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Tìm kiếm sách qua tên tác giả
CREATE PROC [dbo].[USP_TimSach_TacGia]
@tacGia NVARCHAR(50)
AS
BEGIN
	SELECT DISTINCT s.MaSach, s.TenSach, tg.TenTG,tl.TenTL, nxb.TenNXB,s.SoLuongTon,s.GiaTien
	FROM Sach s 
	INNER JOIN ChiTietPhieuNhap ct on s.MaSach=ct.MaSach
	INNER JOIN TacGia tg on s.MaTG=tg.MaTG
	INNER JOIN TheLoai tl on s.MaTL=tl.MaTL
	INNER JOIN NhaXuatBan nxb on s.MaNXB=nxb.MaNXB
	WHERE tg.TenTG LIKE CONCAT(@tacGia,'%') AND s.KinhDoanh = N'Còn'
END
GO
/****** Object:  StoredProcedure [dbo].[USP_TimSach_TacGia_TheLoai]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Tìm sách qua tác giả và thể loại
CREATE PROC [dbo].[USP_TimSach_TacGia_TheLoai]
@tacGia NVARCHAR(50) , @theLoai NVARCHAR(50)
AS
BEGIN
	SELECT DISTINCT s.MaSach, s.TenSach, tg.TenTG,tl.TenTL, nxb.TenNXB,s.SoLuongTon,s.GiaTien
	FROM Sach s 
	INNER JOIN ChiTietPhieuNhap ct on s.MaSach=ct.MaSach
	INNER JOIN TacGia tg on s.MaTG=tg.MaTG
	INNER JOIN TheLoai tl on s.MaTL=tl.MaTL
	INNER JOIN NhaXuatBan nxb on s.MaNXB=nxb.MaNXB
	WHERE tg.TenTG LIKE CONCAT(@tacGia,'%') AND tl.TenTL LIKE CONCAT(@theLoai,'%') AND s.KinhDoanh = N'Còn'
END
GO
/****** Object:  StoredProcedure [dbo].[USP_TimSach_TenSach]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Lọc sách qua tên

CREATE PROC [dbo].[USP_TimSach_TenSach]
@tenSach NVARCHAR(50)
AS
BEGIN
	SELECT DISTINCT s.MaSach, s.TenSach, tg.TenTG,tl.TenTL, nxb.TenNXB,s.SoLuongTon,s.GiaTien,s.KinhDoanh
	FROM Sach s 
	INNER JOIN ChiTietPhieuNhap ct on s.MaSach=ct.MaSach
	INNER JOIN TacGia tg on s.MaTG=tg.MaTG
	INNER JOIN TheLoai tl on s.MaTL=tl.MaTL
	INNER JOIN NhaXuatBan nxb on s.MaNXB=nxb.MaNXB
	WHERE s.TenSach LIKE CONCAT(@tenSach,'%') AND s.KinhDoanh = N'Còn'
END
GO
/****** Object:  StoredProcedure [dbo].[USP_TimSach_TenSach_TacGia]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Tìm kiếm sách qua tên sách và tác giả
CREATE PROC [dbo].[USP_TimSach_TenSach_TacGia]
@tenSach NVARCHAR(50), @tacGia NVARCHAR(50)
AS
BEGIN
	SELECT DISTINCT s.MaSach, s.TenSach, tg.TenTG,tl.TenTL, nxb.TenNXB,s.SoLuongTon,s.GiaTien
	FROM Sach s 
	INNER JOIN ChiTietPhieuNhap ct on s.MaSach=ct.MaSach
	INNER JOIN TacGia tg on s.MaTG=tg.MaTG
	INNER JOIN TheLoai tl on s.MaTL=tl.MaTL
	INNER JOIN NhaXuatBan nxb on s.MaNXB=nxb.MaNXB
	WHERE s.TenSach LIKE CONCAT(@tenSach,'%') AND tg.TenTG LIKE CONCAT(@tacGia,'%') AND s.KinhDoanh = N'Còn'
END
GO
/****** Object:  StoredProcedure [dbo].[USP_TimSach_TenSach_TacGia_TheLoai]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Tìm sách qua tên sách, tác giả, thể loại
CREATE PROC [dbo].[USP_TimSach_TenSach_TacGia_TheLoai]
@tenSach NVARCHAR(50) , @tacGia NVARCHAR(50) , @theLoai NVARCHAR(50)
AS
BEGIN
	SELECT DISTINCT s.MaSach, s.TenSach, tg.TenTG,tl.TenTL, nxb.TenNXB,s.SoLuongTon,s.GiaTien
	FROM Sach s 
	INNER JOIN ChiTietPhieuNhap ct on s.MaSach=ct.MaSach
	INNER JOIN TacGia tg on s.MaTG=tg.MaTG
	INNER JOIN TheLoai tl on s.MaTL=tl.MaTL
	INNER JOIN NhaXuatBan nxb on s.MaNXB=nxb.MaNXB
	WHERE s.TenSach LIKE CONCAT(@tenSach,'%') AND tg.TenTG LIKE CONCAT(@tacGia,'%') AND tl.TenTL LIKE CONCAT(@theLoai,'%') AND s.KinhDoanh = N'Còn'
END
GO
/****** Object:  StoredProcedure [dbo].[USP_TimSach_TenSach_TheLoai]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--Tìm kiếm sách qua tên sách và thể loại
CREATE PROC [dbo].[USP_TimSach_TenSach_TheLoai]
@tenSach NVARCHAR(50), @theLoai NVARCHAR(50)
AS
BEGIN
	SELECT DISTINCT s.MaSach, s.TenSach, tg.TenTG,tl.TenTL, nxb.TenNXB,s.SoLuongTon,s.GiaTien
	FROM Sach s 
	INNER JOIN ChiTietPhieuNhap ct on s.MaSach=ct.MaSach
	INNER JOIN TacGia tg on s.MaTG=tg.MaTG
	INNER JOIN TheLoai tl on s.MaTL=tl.MaTL
	INNER JOIN NhaXuatBan nxb on s.MaNXB=nxb.MaNXB
	WHERE tl.TenTL LIKE CONCAT(@theLoai,'%') AND s.TenSach LIKE CONCAT(@tenSach,'%') AND s.KinhDoanh = N'Còn'
END
GO
/****** Object:  StoredProcedure [dbo].[USP_TimSach_TheLoai]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Tìm kiếm sách qua thể loại
CREATE PROC [dbo].[USP_TimSach_TheLoai]
@theLoai NVARCHAR(50)
AS
BEGIN
	SELECT DISTINCT s.MaSach, s.TenSach, tg.TenTG,tl.TenTL, nxb.TenNXB,s.SoLuongTon,s.GiaTien
	FROM Sach s 
	INNER JOIN ChiTietPhieuNhap ct on s.MaSach=ct.MaSach
	INNER JOIN TacGia tg on s.MaTG=tg.MaTG
	INNER JOIN TheLoai tl on s.MaTL=tl.MaTL
	INNER JOIN NhaXuatBan nxb on s.MaNXB=nxb.MaNXB
	WHERE tl.TenTL LIKE CONCAT(@theLoai,'%') AND s.KinhDoanh = N'Còn'
END
GO
/****** Object:  StoredProcedure [dbo].[USP_TTKinhDoanhSach]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Trạng thái sách còn kinh doanh
CREATE PROC [dbo].[USP_TTKinhDoanhSach]
@maSach CHAR(4)
AS
BEGIN
    UPDATE Sach
	SET KinhDoanh = N'Còn'
	WHERE MaSach = @maSach
END
GO
/****** Object:  StoredProcedure [dbo].[USP_XacNhanTaiKhoanQuaMa]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Xác nhận tài khoản qua mã
CREATE PROC [dbo].[USP_XacNhanTaiKhoanQuaMa]
@tendn NVARCHAR(50), @ma NVARCHAR(50)
AS
BEGIN
	SELECT * FROM TaiKhoan WHERE TenDN = @tendn AND Ma = @ma
END
GO
/****** Object:  StoredProcedure [dbo].[USP_XacNhanTenTheLoai]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Xác nhận tên thể loại
CREATE PROC [dbo].[USP_XacNhanTenTheLoai]
@tentl NVARCHAR(50)
AS
BEGIN
	SELECT * FROM QuanLyNhaSach.dbo.TheLoai WHERE TenTL=@tentl
END
GO
/****** Object:  StoredProcedure [dbo].[USP_XemThongTinHD]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--Xem chi tiết hóa đơn

CREATE PROC [dbo].[USP_XemThongTinHD]
@mahd NVARCHAR(5)
AS
BEGIN
    SELECT s.TenSach, cthd.SoLuongBan, cthd.GiaBan, cthd.ThanhTien
	FROM dbo.ChiTietHoaDon cthd, dbo.Sach s
	WHERE cthd.SoHD = @mahd AND cthd.MaSach = s.MaSach 
END
GO
/****** Object:  StoredProcedure [dbo].[USP_XemTTPhieuNhap]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Xem thông tin phiếu nhập
CREATE PROC [dbo].[USP_XemTTPhieuNhap]
@soPN CHAR(5)
AS
BEGIN
    SELECT  s.TenSach , ctpn.SoLuongNhap, ctpn.GiaNhap, pn.NgayNhap
	FROM dbo.ChiTietPhieuNhap ctpn, dbo.PhieuNhap pn, Sach s
	WHERE pn.SoPN = @soPN AND ctpn.SoPN = pn.SoPN AND ctpn.MaSach = s.MaSach
END
GO
/****** Object:  StoredProcedure [dbo].[USP_XoaSach]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Xóa Sách
CREATE PROC [dbo].[USP_XoaSach]
@masach CHAR(5)
AS
BEGIN
	DELETE FROM ChiTietPhieuNhap
	WHERE 
	MaSach= @masach
	DELETE FROM Sach
	WHERE
	MaSach = @masach
END
GO
/****** Object:  StoredProcedure [dbo].[USP_XoaTaiKhoan]    Script Date: 12/27/2020 11:05:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Xóa tài khoản	
CREATE PROC [dbo].[USP_XoaTaiKhoan]
@tenDN NVARCHAR(50)
AS
BEGIN
	DELETE FROM TaiKhoan WHERE TenDN = @tenDN
END
GO
USE [master]
GO
ALTER DATABASE [QuanLyNhaSach] SET  READ_WRITE 
GO
