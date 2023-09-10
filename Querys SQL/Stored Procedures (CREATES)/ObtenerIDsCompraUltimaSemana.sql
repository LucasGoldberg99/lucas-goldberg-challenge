USE [Challenge]
GO

/****** Object:  StoredProcedure [dbo].[ObtenerIDsCompraUltimaSemana]    Script Date: 10/9/2023 05:56:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ObtenerIDsCompraUltimaSemana]
    @UserID INT
AS
BEGIN
	DECLARE @FechaInicioSemana date;
    DECLARE @FechaActual date;

	-- Calcular la fecha de inicio de la última semana.
    SET @FechaInicioSemana = dateadd(day, -7, getdate());
    -- Calcular la fecha de fin de la última semana.
    SET @FechaActual = getdate();

    SET NOCOUNT ON;
    
    -- Hace un select que devuelve todos los ID de compras de la ultima semana del ID Usuario pasado por parametro.
    SELECT id
    FROM [Challenge].[dbo].[Pagos]
    WHERE idUsuario = @UserID and fecha >= @FechaInicioSemana and fecha <= @FechaActual;
END
GO


