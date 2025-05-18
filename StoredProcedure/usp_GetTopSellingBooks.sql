CREATE PROCEDURE usp_GetTopSellingBooks
    @TopNBooks INT
AS 
BEGIN
    SELECT TOP (@TopNBooks)
        b.Id,
        b.Title,
        b.Genre,
        SUM(oi.Quantity) AS [Copies Sold],
        SUM(oi.Quantity * oi.UnitPrice) AS [Total Revenue]
    FROM Orders AS o 
    INNER JOIN OrderItems AS oi ON o.Id = oi.OrderId
    INNER JOIN Books AS b ON oi.BookId = b.Id
    WHERE o.PaymentStatus = 'paid'
    GROUP BY b.Id, b.Title, b.Genre
    ORDER BY [Copies Sold] DESC;
END;
