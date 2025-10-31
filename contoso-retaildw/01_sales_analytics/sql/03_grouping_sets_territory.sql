USE ContosoRetailDW;
GO
/*
03 - Territory rollup with GROUPING SETS
Goal: Multi-level geography report (Continent, Country, City) with totals.
*/

SELECT
  g.ContinentName,
  g.RegionCountryName,
  g.CityName,
  SUM(fs.SalesAmount) AS Revenue,
  SUM(fs.SalesQuantity) AS Qty
FROM FactOnlineSales fs
JOIN DimCustomer c   ON c.CustomerKey  = fs.CustomerKey
JOIN DimGeography g  ON g.GeographyKey = c.GeographyKey
GROUP BY GROUPING SETS (
  (g.ContinentName, g.RegionCountryName, g.CityName), -- nível cidade
  (g.ContinentName, g.RegionCountryName),             -- subtotal por país
  (g.ContinentName),                                   -- subtotal por continente
  ( )                                                  -- total geral
)
ORDER BY
  g.ContinentName,
  g.RegionCountryName,
  g.CityName;
