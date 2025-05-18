CREATE FUNCTION dbo.fn_GetBooksByGenre
(
    @Genre VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        id,
        title,
        author,
        stock
    FROM Books 
    WHERE genre = @Genre
);
