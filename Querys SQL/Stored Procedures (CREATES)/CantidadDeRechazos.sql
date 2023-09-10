USE [Challenge]
GO

/****** Object:  StoredProcedure [dbo].[CantidadDeRechazos]    Script Date: 10/9/2023 05:55:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[CantidadDeRechazos]
    @UserID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @CurrentDate date;
    SET @CurrentDate = getdate();
    
    -- Realizar el conteo de rechazos para el usuario y la fecha actual
    SELECT COUNT(*) AS CantidadRechazos
    FROM [Challenge].[dbo].[Pagos]
    WHERE idUsuario = @UserID
    AND CAST(fecha AS DATE) = @CurrentDate AND estado = 0;
END
GO


