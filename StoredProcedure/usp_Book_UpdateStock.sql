CREATE PROCEDURE usp_Book_UpdateStock 
    @BookId INT,
    @QuantityToDeduct INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION 
            UPDATE Books
            SET stock = stock - @QuantityToDeduct
            WHERE id = @BookId
            AND stock >= @QuantityToDeduct;
        IF @@ROWCOUNT = 0
        BEGIN
            THROW 50001, 'Book stock update failed', 1;
        END

        COMMIT TRANSACTION
        PRINT 'Book stock updated successfully.';
    END TRY 
    BEGIN CATCH 
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        SELECT 
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH;
END;

-- EXEC usp_Book_UpdateStock @BookId = 6, @QuantityToDeduct = 5;
