CREATE FUNCTION dbo.fn_CalculateDiscountedPrice
(
    @OriginalPrice DECIMAL(10, 2),
    @DiscountPercent DECIMAL(5, 2)
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @DiscountedPrice DECIMAL(10, 2)
    SET @DiscountedPrice = @OriginalPrice - (@OriginalPrice * @DiscountedPrice / 100)
    RETURN @DiscountedPrice
END;
