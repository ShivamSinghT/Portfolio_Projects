/***************************************************************************
			 NAME   : CODE FOR SUPPLIERMASTER
			 AUTHOR :SHIVAM TOMAR
			 DATE	:OCT 22 ,2023

PURPOSE: THIS SCRIPT WILL CREATE DATABASE AND FEW TABLE IN IT TO STORE 
          INFO ABOUT PROCUREMENT .
		   

 *****************************************************************************/


USE SUPPLIER
GO

----CREATE SUPPLIERMASTER TABLE:
CREATE TABLE SUPPLIERMASTER
(
SID									INT								PRIMARY KEY IDENTITY(100,1),
NAME								VARCHAR(80)						NOT NULL,
CITY								VARCHAR(40)						NOT NULL,
GRADE								TINYINT							NOT NULL CHECK(GRADE >0 AND GRADE<=4)
)
GO


----CREATE PARTMASTER TABLE:
CREATE TABLE PARTMASTER
(
PID					                INT							  PRIMARY KEY IDENTITY(1000,1),
NAME							    VARCHAR(150)					NOT NULL,
PRICE								MONEY							NOT NULL,
CATEGORY							TINYINT							NOT NULL CHECK (CATEGORY IN(1,2,3)),
QTYONHAND							INT								NULL
)
GO


----CREATE SUPPLYDETAILS TABLE WITH RELEATIONSHIP:
CREATE TABLE SUPPLYDETAILS
(
PID									INT							NOT NULL FOREIGN KEY REFERENCES PARTMASTER(PID),
SID									INT                         NOT NULL FOREIGN KEY REFERENCES SUPPLIERMASTER(SID),
DATEOFSUPPLY					    DATE                        NOT NULL,
CITY							    VARCHAR(40)                 NOT NULL,
QTYSUPPLIED						    INT							NOT NULL
)
GO


