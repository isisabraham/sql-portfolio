USE ContosoRetailDW;
GO


IF OBJECT_ID('dbo.vw_DailyKPI') IS NOT NULL
  DROP VIEW dbo.vw_DailyKPI;
GO
CREATE VIEW dbo.vw_DailyKPI AS
SELECT
    d.FullDateAlternateKey AS [Date],
    SUM(fs.SalesQuantity) AS Qty,
    SUM(fs.SalesAmount)   AS Revenue,
    CASE 
      WHEN SUM(fs.SalesQuantity) = 0 THEN 0
      ELSE SUM(fs.SalesAmount) * 1.0 / SUM(fs.SalesQuantity)
    END AS AvgOrderValue
FROM FactOnlineSales fs
JOIN DimDate d ON d.DateKey = fs.DateKey
GROUP BY d.FullDateAlternateKey;
GO

IF OBJECT_ID('dbo.vw_MonthlyKPI') IS NOT NULL
  DROP VIEW dbo.vw_MonthlyKPI;
GO
CREATE VIEW dbo.vw_MonthlyKPI AS
SELECT
    d.CalendarYear,
    d.CalendarMonth,
    EOMONTH(d.FullDateAlternateKey) AS MonthEnd,
    SUM(fs.SalesQuantity) AS Qty,
    SUM(fs.SalesAmount)   AS Revenue,
    CASE 
      WHEN SUM(fs.SalesQuantity) = 0 THEN 0
      ELSE SUM(fs.SalesAmount) * 1.0 / SUM(fs.SalesQuantity)
    END AS AvgOrderValue
FROM FactOnlineSales fs
JOIN DimDate d ON d.DateKey = fs.DateKey
GROUP BY d.CalendarYear, d.CalendarMonth, EOMONTH(d.FullDateAlternateKey);
GO

