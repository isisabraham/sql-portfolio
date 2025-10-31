USE ContosoRetailDW;
GO

/* 
02 - Monthly Trends with Window Functions
Goal: Calculate rolling 3-month averages for revenue and quantity.
*/

WITH MonthlyData AS (
    SELECT
        d.CalendarYear,
        d.CalendarMonth,
        EOMONTH(d.FullDateAlternateKey) AS MonthEnd,
        SUM(fs.SalesQuantity) AS Qty,
        SUM(fs.SalesAmount) AS Revenue
    FROM FactOnlineSales fs
    JOIN DimDate d ON d.DateKey = fs.DateKey
    GROUP BY d.CalendarYear, d.CalendarMonth, EOMONTH(d.FullDateAlternateKey)
)
SELECT
    CalendarYear,
    CalendarMonth,
    MonthEnd,
    Revenue,
    AVG(Revenue) OVER (ORDER BY MonthEnd ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS Rolling3MonthRevenue,
    Qty,
    AVG(Qty) OVER (ORDER BY MonthEnd ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS Rolling3MonthQty
FROM MonthlyData
ORDER BY MonthEnd;

