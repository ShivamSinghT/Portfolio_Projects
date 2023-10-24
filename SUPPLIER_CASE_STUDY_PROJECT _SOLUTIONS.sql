---SELECT DATABASE
USE SUPPLIER
GO


SELECT * FROM SUPPLYDETAILS AS ST INNER JOIN SUPPLIERMASTER AS MT
ON MT.SID =ST.SID
INNER JOIN PARTMASTER AS RT
ON RT.PID =ST.PID
GO
/*********************************************************************
1.List the month-wise average supply of parts supplied for all parts. 
  Provide the information only if the average is higher than 473.
**********************************************************************/

SELECT * FROM SUPPLYDETAILS
GO

SELECT DATENAME(MM,DATEOFSUPPLY) AS MONTH_WISE ,AVG(QTYSUPPLIED) AS AVERAGE_SUPPLY_OF_PART FROM SUPPLYDETAILS
GROUP BY DATENAME(MM,DATEOFSUPPLY)
HAVING AVG(QTYSUPPLIED) >=473
GO

/*********************************************************************
2. List the names of the Suppliers who do not supply part with PID ‘1001’.
**********************************************************************/


SELECT ST.PID, MT.NAME FROM SUPPLYDETAILS AS ST JOIN SUPPLIERMASTER AS MT
ON MT.SID =ST.SID
WHERE PID <>1001
GO---ANSWER

/*******************************************************************
3.List the part id, name, price and difference between price and 
  average price of all parts.
********************************************************************/


SELECT PID,NAME,PRICE,PRICE -(SELECT AVG(PRICE)FROM PARTMASTER)  AS _DIFFERENCE_
FROM PARTMASTER
GO


/******************************************************************************
4. List the names of the suppliers who have supplied at least one part 
    where the quantity supplied is lower than 100.
*******************************************************************************/
SELECT MT.NAME ,ST.QTYSUPPLIED FROM SUPPLYDETAILS AS ST INNER JOIN SUPPLIERMASTER AS MT
ON MT.SID =ST.SID
WHERE QTYSUPPLIED < 100
GO


/*******************************************************************************
5.List the names of the suppliers who live in a city where no supply 
has been made.
**********************************************************************************/
SELECT MT.NAME ,ST.CITY,ST.QTYSUPPLIED FROM SUPPLYDETAILS AS ST INNER JOIN SUPPLIERMASTER AS MT
ON MT.SID =ST.SID
WHERE QTYSUPPLIED<1
GO


/**********************************************************************************
6. List the names of the parts which have not been supplied in the 
    month of May 2023.
************************************************************************************/
SELECT DATENAME(MM,DATEOFSUPPLY) AS _MONTH_,DATEPART(YYYY,DATEOFSUPPLY) AS _YEAR_ ,
MT.NAME AS NAME_OF_THE_PART
FROM SUPPLYDETAILS AS ST INNER JOIN PARTMASTER AS MT
ON MT.PID =ST.PID
WHERE DATENAME (MM,DATEOFSUPPLY) <>'MAY' OR DATEPART(YYYY,DATEOFSUPPLY) <>2023
GO


/************************************************************************************
7. List name and Price  for all parts. Price category has to be 
displayed as “Cheap” if price is less than 5000, “Medium” if the price 
is greater than or equal to 5000 and less than 21000, and “Costly” if the 
price is greater than or equal to 21000.
************************************************************************************/
SELECT NAME AS PRODUCT_NAME ,PRICE,
                             CASE
							 WHEN PRICE <5000 THEN 'CHEAP'
							 WHEN PRICE >=5000 AND PRICE <21000 THEN 'MEDIUM'
							 ELSE 'COSTALY' 
							 END AS PRICE_CATAGORY
FROM PARTMASTER
GO


/*****************************************************************************
8. List the most recent supply details with information on Product 
name, price and no. of days elapsed since the latest supply.
******************************************************************************/
???????????????????
???????????????????

SELECT * FROM PARTMASTER
GO
/******************************************************************************
9. List the names of the suppliers who have supplied exactly 100 units 
   of part P1.
*******************************************************************************/
SELECT ST.NAME,RT.NAME ,MT.QTYSUPPLIED FROM SUPPLIERMASTER AS ST INNER JOIN SUPPLYDETAILS AS MT
ON MT.SID =ST.SID
INNER JOIN PARTMASTER AS RT
ON RT.PID =MT.PID
WHERE RT.NAME ='P1' AND QTYSUPPLIED =100
GO

/***********************************************************************************
10. List the names of the parts supplied by more than one supplier.
************************************************************************************/
???????????????????
???????????????????

/**********************************************************************************
11. List the names of the parts whose price is less than or '=' the average 
     price of parts.
************************************************************************************/
SELECT NAME FROM PARTMASTER 
WHERE PRICE <=(SELECT AVG(PRICE) FROM PARTMASTER)
GO


/************************************************************************************
12. List the category-wise number of parts; exclude those where the sum 
    is > 100 and less than 600. List in the descending order of sum.
************************************************************************************/

SELECT CATEGORY ,COUNT(NAME) AS NO_OF_PARTS FROM PARTMASTER 
GROUP BY CATEGORY
ORDER BY 2 DESC
GO

/*************************************************************************************
13. List the supplier name, part name and supplied quantity for all 
    supplies made between 1st and 15th of June 2023.
*************************************************************************************/
SELECT RT.NAME, ST.QTYSUPPLIED,MT.NAME,CONVERT(VARCHAR ,DATEOFSUPPLY,107) AS _DATE_
FROM SUPPLYDETAILS AS ST INNER JOIN PARTMASTER AS MT
ON MT.PID =ST.PID
INNER JOIN SUPPLIERMASTER AS RT
ON RT.SID =ST.SID
WHERE DATEOFSUPPLY BETWEEN '2023-06-01' AND '2023-06-15'
GO

/**************************************************************************************
14. For all products supplied by Supplier S1, List the part name and 
    total quantity.
**************************************************************************************/

SELECT MT.NAME,RT.NAME,COUNT(RT.NAME) AS TOTAL_QUANTITY 
	FROM SUPPLYDETAILS AS ST 
	INNER JOIN SUPPLIERMASTER AS MT
	ON MT.SID =ST.SID
	INNER JOIN PARTMASTER AS RT
	ON RT.PID =ST.PID
	WHERE MT.NAME ='S1'
	GROUP BY MT.NAME,RT.NAME
	GO

/**************************************************************************************
15. For the part with the minimum price, List the latest supply details 
    (Supplier Name, Part id, Date of supply, Quantity Supplied).***************************************************************************************/SELECT MT.NAME ,RT.PID,ST.DATEOFSUPPLY ,ST.QTYSUPPLIED FROM SUPPLYDETAILS AS ST INNER JOIN SUPPLIERMASTER AS MTON MT.SID =ST.SIDINNER JOIN PARTMASTER AS RT ON RT.PID =ST.PIDWHERE PRICE = (SELECT MIN(PRICE) FROM PARTMASTER)GO