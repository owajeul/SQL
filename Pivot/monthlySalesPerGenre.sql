SELECT
    b.Genre,
    FORMAT(o.OrderDate, 'MMM yyyy') AS SaleMonth,
    SUM(o.TotalPrice) AS TotalRevenue
FROM Orders AS o
JOIN OrderItems AS oi ON o.Id = oi.OrderId
JOIN Books as b ON oi.BookId = b.Id
GROUP BY b.Genre, FORMAT(o.OrderDate, 'MMM yyyy');

SELECT *
FROM (
    SELECT
        b.Genre,
        FORMAT(o.OrderDate, 'MMM yyyy') AS SaleMonth,
        SUM(o.TotalPrice) AS TotalRevenue
    FROM Orders AS o
    JOIN OrderItems AS oi ON o.Id = oi.OrderId
    JOIN Books as b ON oi.BookId = b.Id
    GROUP BY b.Genre, FORMAT(o.OrderDate, 'MMM yyyy')
) AS SalesData 
PIVOT (
    SUM(TotalRevenue)
    FOR SaleMonth IN ([Jan 2025], [Feb 2025], [Mar 2025], [Apr 2025], [May 2025])
) AS PivotTable 
