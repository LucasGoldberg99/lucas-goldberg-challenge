USE [Challenge]
GO

/****** Object:  StoredProcedure [dbo].[ExisteID]    Script Date: 10/9/2023 05:58:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ExisteID]
    @UserID INT
AS
BEGIN
	
	DECLARE @Existe TINYINT;
	
    SET NOCOUNT ON;
	SET @Existe = 0;

    -- Verifica si el ID existe en la tabla.
    IF EXISTS (SELECT 1 FROM [dbo].[Usuarios] WHERE ID = @UserID)
    BEGIN
        -- Si el ID existe, establece @Existe en verdadero.
        SET @Existe = 1;
    END

    -- Devuelve el valor de @Existe.
    SELECT @Existe AS Existe;
END
GO


