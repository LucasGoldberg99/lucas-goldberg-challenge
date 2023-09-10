USE [Challenge]
GO

/****** Object:  StoredProcedure [dbo].[DiasDesdeLaCreacion]    Script Date: 10/9/2023 05:53:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[DiasDesdeLaCreacion]
    @UserID INT
AS
BEGIN
	DECLARE @FechaCreacion date;
    DECLARE @FechaActual date = getdate();
    DECLARE @DiasPasados int;
    SET NOCOUNT ON;
    
	-- Obtener la fecha de creaci�n para el usuario espec�fico.
    SELECT @FechaCreacion = fechaCreacion
    FROM dbo.Usuarios
    WHERE id = @UserID;

	-- Verificar si se encontr� la fecha de creaci�n.
    IF @FechaCreacion IS NOT NULL
    BEGIN
        -- Calcular la diferencia en d�as entre la fecha actual y la fecha de creaci�n.
        SET @DiasPasados = datediff(day, @FechaCreacion, @FechaActual);

        -- Devolver la cantidad de d�as pasados.
        SELECT @DiasPasados AS DiasPasados;
    END
    ELSE
    BEGIN
        -- Si no se encuentra la fecha de creaci�n, devolver un valor de error.
        SELECT -1 AS DiasPasados;
    END
END
GO


