CREATE FUNCTION dbo.fn_GetCustomerOrderHistory
(
    @UserId VARCHAR(100)
)
RETURNS @OrderDetailsTable TABLE 
(
    OrderId INT,
    OrderStatus VARCHAR(10),
    BookTitle VARCHAR(255),
    UnitPrice DECIMAL(10,2),
    Quantity INT,
    Subtotal DECIMAL(10, 2)
)
AS 
BEGIN 
    INSERT INTO @OrderDetailsTable
    SELECT
        o.Id,
        o.[Status],
        b.Title,
        oi.UnitPrice,
        oi.Quantity,
        (oi.Quantity * oi.UnitPrice) AS Subtotal
    FROM Orders AS o  
    JOIN OrderItems AS oi ON o.Id = oi.OrderId
    JOIN Books AS b ON oi.BookId = b.Id
    WHERE o.UserId = @UserId;

    RETURN;
END;
