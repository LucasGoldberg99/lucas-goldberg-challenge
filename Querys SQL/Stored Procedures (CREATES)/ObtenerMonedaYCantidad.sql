USE [Challenge]
GO

/****** Object:  StoredProcedure [dbo].[ObtenerMonedaYCantidad]    Script Date: 10/9/2023 05:57:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ObtenerMonedaYCantidad]
    @PagoID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Hace un select que devuelve la moneda local y el total en dicha moneda.
    SELECT monedaLocal, totalMonedaLocal
    FROM [Challenge].[dbo].[Pagos]
    WHERE id = @PagoID
END
GO


