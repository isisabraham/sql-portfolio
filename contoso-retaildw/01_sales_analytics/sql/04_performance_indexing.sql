USE ContosoRetailDW;
GO
/*
04 - Performance: baseline vs. indexed
Goal: Show improvement in logical reads/time using a targeted nonclustered index.
*/

-- 4.1 Baseline (meça IO/tempo)
SET STATISTICS IO ON; 
SET STATISTICS TIME ON;

SELECT TOP (5000)
  fs.CustomerKey,
  SUM(fs.SalesAmount) AS Revenue
FROM FactOnlineSales fs
JOIN DimDate d ON d.DateKey = fs.DateKey
WHERE d.CalendarYear BETWEEN 2007 AND 2008
GROUP BY fs.CustomerKey
ORDER BY Revenue DESC;

SET STATISTICS IO OFF; 
SET STATISTICS TIME OFF;
GO

-- 4.2 Criar índice para acelerar por Data + agregação por Cliente
IF NOT EXISTS (
  SELECT 1 
  FROM sys.indexes 
  WHERE name = 'IX_FactOnlineSales_Date_Customer' 
    AND object_id = OBJECT_ID('FactOnlineSales')
)
BEGIN
  CREATE NONCLUSTERED INDEX IX_FactOnlineSales_Date_Customer
  ON dbo.FactOnlineSales(DateKey, CustomerKey)
  INCLUDE (SalesAmount, SalesQuantity);
END
GO

-- 4.3 Rodar novamente para comparar (cole no README os números antes/depois)
SET STATISTICS IO ON; 
SET STATISTICS TIME ON;

SELECT TOP (5000)
  fs.CustomerKey,
  SUM(fs.SalesAmount) AS Revenue
FROM FactOnlineSales fs
JOIN DimDate d ON d.DateKey = fs.DateKey
WHERE d.CalendarYear BETWEEN 2007 AND 2008
GROUP BY fs.CustomerKey
ORDER BY Revenue DESC;

SET STATISTICS IO OFF; 
SET STATISTICS TIME OFF;
GO
