USE master
GO

-- Drop the database if it already exists
IF EXISTS ( SELECT name
                FROM sys.databases
                WHERE name = N'QuanLyChungCu' )
    DROP DATABASE QuanLyChungCu
GO

CREATE DATABASE QuanLyChungCu
GO

USE QuanLyChungCu
/*





*/
---------- Tables ----------

-- Account Table --
CREATE TABLE TAIKHOAN
    (
      TenTaiKhoan VARCHAR(25) CONSTRAINT pk_TAIKHOAN PRIMARY KEY ,
      MatKhau VARCHAR(16) NOT NULL ,
      VaiTro BIT NOT NULL
                 DEFAULT 0
    )
GO

-- Area Apartment Table
CREATE TABLE KHUCANHO
    (
      MaKhu CHAR(2) CONSTRAINT pk_KHUCANHO PRIMARY KEY ,
      TenKhu NVARCHAR(50) NOT NULL ,
      SoTang INT NOT NULL
                 DEFAULT 1 ,
      SoCanTT INT NOT NULL
                  DEFAULT 1 ,
      DiaChi NVARCHAR(100) NOT NULL,
	)

-- Resident Table --
CREATE TABLE CUDAN
    (
      MaCuDan CHAR(6) CONSTRAINT pk_CUDAN PRIMARY KEY ,
      TenCuDan NVARCHAR(50) NOT NULL ,
      NgaySinh DATE NOT NULL
                    DEFAULT GETDATE() ,
      GioiTinh BIT NOT NULL
                   DEFAULT 0 ,
      SoDT CHAR(10) NOT NULL ,
      SoCMT CHAR(12) NOT NULL ,
      QueQuan NVARCHAR(100) NOT NULL
    )
GO

-- Apartment Table --
CREATE TABLE CANHO
    (
      MaCanHo CHAR(6) CONSTRAINT pk_CANHO PRIMARY KEY ,
      DienTich FLOAT NOT NULL
                     DEFAULT 50 ,
      Gia BIGINT NOT NULL ,
      TrangThai BIT NOT NULL
                    DEFAULT 0 ,
      SoPhong INT NOT NULL
                  DEFAULT 5 ,
      MaCuDan CHAR(6)
        CONSTRAINT fk1_CANHO FOREIGN KEY REFERENCES dbo.CUDAN ( MaCuDan ) ,
      MaKhu CHAR(2)
        NOT NULL
        DEFAULT 'AA'
        CONSTRAINT fk2_CANHO
        FOREIGN KEY REFERENCES dbo.KHUCANHO ( MaKhu ) ON DELETE CASCADE
        ON UPDATE CASCADE --  (AA -> ZZ)
    )
GO

-- Contract Table --
CREATE TABLE HOPDONG
    (
      MaHopDong CHAR(12) NOT NULL
                         CONSTRAINT pk_HOPDONG PRIMARY KEY , -- HD0000000001
      NgayGiaoDich DATE NOT NULL
                        DEFAULT GETDATE() ,
      DiaChiKH NVARCHAR(100) NOT NULL ,
      MaCuDan CHAR(6)
        NOT NULL
        CONSTRAINT fk1_HOPDONG FOREIGN KEY REFERENCES dbo.CUDAN ( MaCuDan ) ,
      MaCanHo CHAR(6)
        NOT NULL
        CONSTRAINT fk2_HOPDONG
        FOREIGN KEY REFERENCES dbo.CANHO ( MaCanHo ) ON DELETE CASCADE
        ON UPDATE CASCADE,
    )
GO

-------- TaiKhoan ----------
INSERT [dbo].[TAIKHOAN] ([TenTaiKhoan], [MatKhau], [VaiTro]) VALUES (N'Long', N'123', 1)
INSERT [dbo].[TAIKHOAN] ([TenTaiKhoan], [MatKhau], [VaiTro]) VALUES (N'Van', N'123', 0)
GO

---------- KhuCanHo ----------
INSERT [dbo].[KHUCANHO] ([MaKhu], [TenKhu], [SoTang], [SoCanTT], [DiaChi]) VALUES (N'AA', N'An Phú', 25, 20, N'Hà Đông')
INSERT [dbo].[KHUCANHO] ([MaKhu], [TenKhu], [SoTang], [SoCanTT], [DiaChi]) VALUES (N'CE', N'Hi Land', 30, 25, N'Cầu Giấy')
INSERT [dbo].[KHUCANHO] ([MaKhu], [TenKhu], [SoTang], [SoCanTT], [DiaChi]) VALUES (N'TS', N'The Spark', 25, 20, N'Hà Đông')
GO

---------- CuDan ----------
INSERT [dbo].[CUDAN] ([MaCuDan], [TenCuDan], [NgaySinh], [GioiTinh], [SoDT], [SoCMT], [QueQuan]) VALUES (N'111111', N'Trần Văn Nam', CAST(N'1998-05-21' AS Date), 1, N'0123456789', N'012345678985', N'Yên Bái')
INSERT [dbo].[CUDAN] ([MaCuDan], [TenCuDan], [NgaySinh], [GioiTinh], [SoDT], [SoCMT], [QueQuan]) VALUES (N'111112', N'Nguyễn Văn An', CAST(N'1997-02-25' AS Date), 1, N'0123456789', N'012365897456', N'Nam Định')
INSERT [dbo].[CUDAN] ([MaCuDan], [TenCuDan], [NgaySinh], [GioiTinh], [SoDT], [SoCMT], [QueQuan]) VALUES (N'111113', N'Phạm Thị Nguyên Hồng', CAST(N'1991-02-28' AS Date), 1, N'0123658974', N'000256398745', N'Hà Nội')
GO

--------- CanHo ----------
INSERT [dbo].[CANHO] ([MaCanHo], [DienTich], [Gia], [TrangThai], [SoPhong], [MaCuDan], [MaKhu]) VALUES (N'AA1203', 46, 1400000000, 0, 4, NULL, N'AA')
INSERT [dbo].[CANHO] ([MaCanHo], [DienTich], [Gia], [TrangThai], [SoPhong], [MaCuDan], [MaKhu]) VALUES (N'CE2102', 65.2, 1500000000, 0, 6, NULL, N'CE')
INSERT [dbo].[CANHO] ([MaCanHo], [DienTich], [Gia], [TrangThai], [SoPhong], [MaCuDan], [MaKhu]) VALUES (N'TS0103', 50, 1200000000, 1, 5, N'111111', N'TS')
INSERT [dbo].[CANHO] ([MaCanHo], [DienTich], [Gia], [TrangThai], [SoPhong], [MaCuDan], [MaKhu]) VALUES (N'TS2301', 50, 2000000000, 0, 4, NULL, N'TS')
INSERT [dbo].[CANHO] ([MaCanHo], [DienTich], [Gia], [TrangThai], [SoPhong], [MaCuDan], [MaKhu]) VALUES (N'TS2502', 50, 2000000000, 0, 5, NULL, N'TS')
GO

---------- HopDong ----------
INSERT [dbo].[HOPDONG] ([MaHopDong], [NgayGiaoDich], [DiaChiKH], [MaCuDan], [MaCanHo]) VALUES (N'HD0000000001', CAST(N'2019-03-30' AS Date), N'Số 20, Phạm Văn Đồng, Bắc Từ Liêm', N'111111', N'TS0103')
INSERT [dbo].[HOPDONG] ([MaHopDong], [NgayGiaoDich], [DiaChiKH], [MaCuDan], [MaCanHo]) VALUES (N'HD0000000002', CAST(N'2019-03-30' AS Date), N'Số 50, Trần Duy Hưng, Cầu Giấy', N'111112', N'TS2502')
INSERT [dbo].[HOPDONG] ([MaHopDong], [NgayGiaoDich], [DiaChiKH], [MaCuDan], [MaCanHo]) VALUES (N'HD0000000003', CAST(N'2019-03-30' AS Date), N'Văn Trì, Từ Liêm, Hà Nội', N'111113', N'TS2301')
GO

---------- Views ----------

---------- Storage Procedure ----------

  USE QuanLyChungCu
  GO
  CREATE PROC [dbo].[searchApartmentWithCriterias]
    @trangthai BIT ,
    @tugia BIGINT ,
    @dengia BIGINT ,
    @tudt FLOAT ,
    @dendt FLOAT
  AS
    BEGIN
  -----
        IF ( @dendt = 0 AND @dengia = 0 ) -- dt > 50, gia > 2000000000
            SELECT c.MaCanHo, c.DienTich, c.Gia, c.TrangThai, c.SoPhong,
                    c.MaCuDan, k.TenKhu
                FROM [QuanLyChungCu].[dbo].[CANHO] c
                    JOIN [QuanLyChungCu].[dbo].KHUCANHO k
                    ON k.MaKhu = c.MaKhu
                WHERE TrangThai = @trangthai AND Gia > @tugia AND DienTich > @tudt
        ELSE -- dt > 50, 0 <gia <= 2000000000
            IF ( @dendt = 0 AND ( ( @tugia = 0 AND @dengia = 1000000000 ) OR ( @tugia = 1000000000 AND @dengia = 2000000000 ) ) )
                SELECT c.MaCanHo, c.DienTich, c.Gia, c.TrangThai, c.SoPhong,
                        c.MaCuDan, k.TenKhu
                    FROM [QuanLyChungCu].[dbo].[CANHO] c
                        JOIN [QuanLyChungCu].[dbo].KHUCANHO k
                        ON k.MaKhu = c.MaKhu
                    WHERE TrangThai = @trangthai AND Gia BETWEEN @tugia AND @dengia AND DienTich > @tudt
            ELSE -- 30 <= dt <= 50, gia > 2000000000
                IF ( @dengia = 0 AND ( ( @tudt = 30 AND @dendt = 40 ) OR ( @tudt = 40 AND @dendt = 50 ) ) )
                    SELECT c.MaCanHo, c.DienTich, c.Gia, c.TrangThai,
                            c.SoPhong, c.MaCuDan, k.TenKhu
                        FROM [QuanLyChungCu].[dbo].[CANHO] c
                            JOIN [QuanLyChungCu].[dbo].KHUCANHO k
                            ON k.MaKhu = c.MaKhu
                        WHERE TrangThai = @trangthai AND Gia > @tugia AND DienTich BETWEEN @tudt AND @dendt
                ELSE --  30 <= dt <= 50 , 0 < gia <= 2000000000
                    SELECT c.MaCanHo, c.DienTich, c.Gia, c.TrangThai,
                            c.SoPhong, c.MaCuDan, k.TenKhu
                        FROM [QuanLyChungCu].[dbo].[CANHO] c
                            JOIN [QuanLyChungCu].[dbo].KHUCANHO k
                            ON k.MaKhu = c.MaKhu
                        WHERE TrangThai = @trangthai AND Gia BETWEEN @tugia AND @dengia AND DienTich BETWEEN @tudt AND @dendt
  -----
    END

GO
SELECT * FROM  dbo.CANHO
EXEC dbo.searchApartmentWithCriterias 0,2000000000,0,40,50 -- 
GO 
CREATE PROC [dbo].[searchApartments]
    @tugia BIGINT ,
    @dengia BIGINT ,
    @tudt FLOAT ,
    @dendt FLOAT,
	@sophong INT
  AS
    BEGIN
  -----
        IF ( @dendt = 0 AND @dengia = 0 ) -- dt > 50, gia > 2000000000
            SELECT c.MaCanHo, c.DienTich, c.Gia, c.SoPhong, k.TenKhu
                FROM [QuanLyChungCu].[dbo].[CANHO] c
                    JOIN [QuanLyChungCu].[dbo].KHUCANHO k
                    ON k.MaKhu = c.MaKhu
                WHERE TrangThai = 0 AND Gia > @tugia AND DienTich > @tudt AND SoPhong=@sophong
        ELSE -- dt > 50, 0 <gia <= 2000000000
            IF ( @dendt = 0 AND ( ( @tugia = 0 AND @dengia = 1000000000 ) OR ( @tugia = 1000000000 AND @dengia = 2000000000 ) ) )
                SELECT c.MaCanHo, c.DienTich, c.Gia, c.SoPhong, k.TenKhu
                    FROM [QuanLyChungCu].[dbo].[CANHO] c
                        JOIN [QuanLyChungCu].[dbo].KHUCANHO k
                        ON k.MaKhu = c.MaKhu
                    WHERE Gia BETWEEN @tugia AND @dengia AND DienTich > @tudt AND SoPhong=@sophong
            ELSE -- 30 <= dt <= 50, gia > 2000000000
                IF ( @dengia = 0 AND ( ( @tudt = 30 AND @dendt = 40 ) OR ( @tudt = 40 AND @dendt = 50 ) ) )
                    SELECT c.MaCanHo, c.DienTich, c.Gia, c.SoPhong, k.TenKhu
                        FROM [QuanLyChungCu].[dbo].[CANHO] c
                            JOIN [QuanLyChungCu].[dbo].KHUCANHO k
                            ON k.MaKhu = c.MaKhu
                        WHERE Gia > @tugia AND DienTich BETWEEN @tudt AND @dendt AND SoPhong=@sophong
                ELSE --  30 <= dt <= 50 , 0 < gia <= 2000000000
                    SELECT c.MaCanHo, c.DienTich, c.Gia, c.SoPhong, k.TenKhu
                        FROM [QuanLyChungCu].[dbo].[CANHO] c
                            JOIN [QuanLyChungCu].[dbo].KHUCANHO k
                            ON k.MaKhu = c.MaKhu
                        WHERE  Gia BETWEEN @tugia AND @dengia AND DienTich BETWEEN @tudt AND @dendt AND SoPhong=@sophong
  -----
    END
GO
EXEC [dbo].[searchApartments] 1000000000,2000000000,40,50,4
GO
---------- Funtions ----------

---------- Triggers ----------

---------- Write Select, Insert, Update, Delete Alter below!  -----------
