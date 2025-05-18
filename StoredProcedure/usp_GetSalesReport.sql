CREATE PROCEDURE dbo.usp_GetSalesReport
    @ReportType NVARCHAR(10) -- ['Daily', 'Weekly', 'Monthly', 'Yearly']
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        IF @ReportType NOT IN ('Daily', 'Weekly', 'Monthly', 'Yearly')
        BEGIN
            THROW 50001, 'Invalid Report Type. Use Daily, Weekly, Monthly, or Yearly.', 1;
        END

        SELECT 
            CASE 
                WHEN @ReportType = 'Daily' THEN FORMAT(o.OrderDate, 'ddd dd MMM yyyy')
                WHEN @ReportType = 'Weekly' THEN CONCAT(YEAR(o.OrderDate), ' week ', DATEPART(WK, o.OrderDate))
                WHEN @ReportType = 'Monthly' THEN FORMAT(o.OrderDate, 'MMM yyyy')
                WHEN @ReportType = 'Yearly' THEN FORMAT(o.OrderDate, 'yyyy')
            END AS PeriodLabel,
            COUNT(o.Id) AS [TotalOrders],
            SUM(oi.Quantity) AS [TotalBooksSold],
            SUM(o.TotalPrice) AS [TotalRevenue]
        FROM Orders AS o
        JOIN OrderItems AS oi ON o.Id = oi.OrderId
        WHERE o.PaymentStatus = 'Paid'
        GROUP BY 
            CASE 
                WHEN @ReportType = 'Daily' THEN FORMAT(o.OrderDate, 'ddd dd MMM yyyy')
                WHEN @ReportType = 'Weekly' THEN CONCAT(YEAR(o.OrderDate), ' week ', DATEPART(WK, o.OrderDate))
                WHEN @ReportType = 'Monthly' THEN FORMAT(o.OrderDate, 'MMM yyyy')
                WHEN @ReportType = 'Yearly' THEN FORMAT(o.OrderDate, 'yyyy')
            END
        ORDER BY MIN(o.OrderDate);
        
    END TRY
    BEGIN CATCH
        SELECT ERROR_NUMBER() AS ErrorNumber, ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;
