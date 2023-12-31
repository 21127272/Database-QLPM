﻿--VĂN NGỌC NGUYÊN HẠO
--21127272
--21CLC03

USE MASTER
GO
IF DB_ID('QLPM') IS NOT NULL
	DROP DATABASE COMPUTER

CREATE DATABASE QLPM
GO
USE QLPM
GO
CREATE TABLE PHONGMAY
(
	MAPHONG CHAR(5),
	TENPHONG NVARCHAR(50),
	MAYCHU CHAR(5),
	MANVQL CHAR(5)
	PRIMARY KEY (MAPHONG)
)
GO
CREATE TABLE MAYTINH
(
	MAMT CHAR(5),
	MAPM CHAR(5),
	TENMT NVARCHAR(50),
	TINHTRANG BIT,
	MAYGATEWAY CHAR(5)
	PRIMARY KEY (MAMT, MAPM)
)
GO
CREATE TABLE NHANVIEN
(
	MANV CHAR(5),
	TENNV NVARCHAR(50),
	MANVQL CHAR(5),
	PHAI NCHAR(5)
	PRIMARY KEY(MANV)
)
GO
ALTER TABLE PHONGMAY ADD FOREIGN KEY (MAYCHU, MAPHONG) REFERENCES MAYTINH(MAMT, MAPM)
ALTER TABLE MAYTINH ADD FOREIGN KEY (MAYGATEWAY, MAPM) REFERENCES MAYTINH(MAMT, MAPM)
ALTER TABLE MAYTINH ADD FOREIGN KEY (MAPM) REFERENCES PHONGMAY(MAPHONG)
ALTER TABLE PHONGMAY ADD FOREIGN KEY (MANVQL) REFERENCES NHANVIEN(MANV)
ALTER TABLE NHANVIEN ADD FOREIGN KEY (MANVQL) references NHANVIEN(MANV)
GO
INSERT INTO NHANVIEN VALUES ('NV01', N'Nguyên Hạo', NULL, N'Nam')
INSERT INTO NHANVIEN VALUES ('NV02', N'Bảo Lân', NULL, N'Nam')
INSERT INTO NHANVIEN VALUES ('NV03', N'Huy Trí', 'NV03', N'Nam')
INSERT INTO NHANVIEN VALUES ('NV04', N'Kim Hưng', 'NV03', N'Nữ')
UPDATE NHANVIEN SET MANVQL = 'NV03' WHERE MANV = 'NV01'
UPDATE NHANVIEN SET MANVQL = 'NV03' WHERE MANV = 'NV02'
GO
INSERT INTO PHONGMAY VALUES ('PM01', N'Phòng 1', NULL, 'NV01')
INSERT INTO PHONGMAY VALUES ('PM02', N'Phòng 2', NULL, 'NV02')
INSERT INTO PHONGMAY VALUES ('PM03', N'Phòng 3', NULL, 'NV03')
INSERT INTO PHONGMAY VALUES ('PM04', N'Phòng 4', NULL, 'NV04')
GO
INSERT INTO MAYTINH VALUES ('MT01', 'PM01', N'Máy 1', 1, 'MT01')
INSERT INTO MAYTINH VALUES ('MT02', 'PM02', N'Máy 2', 0, 'MT02')
INSERT INTO MAYTINH VALUES ('MT03', 'PM03', N'Máy 3', 0, 'MT03')
INSERT INTO MAYTINH VALUES ('MT04', 'PM04', N'Máy 4', 1, 'MT04')
UPDATE PHONGMAY SET MAYCHU = 'MT01' WHERE MAPHONG = 'PM01'
UPDATE PHONGMAY SET MAYCHU = 'MT02' WHERE MAPHONG = 'PM02'
UPDATE PHONGMAY SET MAYCHU = 'MT03' WHERE MAPHONG = 'PM03'
UPDATE PHONGMAY SET MAYCHU = 'MT04' WHERE MAPHONG = 'PM04'

GO
SELECT MANV, TENNV
FROM NHANVIEN NV, PHONGMAY PM, MAYTINH MT
WHERE NV.MANV = PM.MANVQL
	AND MT.TINHTRANG = 0
	AND MT.MAPM = PM.MAPHONG

GO
SELECT MAMT, MAPM
FROM MAYTINH MT, PHONGMAY PM
WHERE PM.TENPHONG = 'I53'
	AND MT.MAYGATEWAY = MT.MAMT
	AND MT.MAPM = PM.MAPHONG