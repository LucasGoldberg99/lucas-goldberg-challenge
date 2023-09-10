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
    
	-- Obtener la fecha de creación para el usuario específico.
    SELECT @FechaCreacion = fechaCreacion
    FROM dbo.Usuarios
    WHERE id = @UserID;

	-- Verificar si se encontró la fecha de creación.
    IF @FechaCreacion IS NOT NULL
    BEGIN
        -- Calcular la diferencia en días entre la fecha actual y la fecha de creación.
        SET @DiasPasados = datediff(day, @FechaCreacion, @FechaActual);

        -- Devolver la cantidad de días pasados.
        SELECT @DiasPasados AS DiasPasados;
    END
    ELSE
    BEGIN
        -- Si no se encuentra la fecha de creación, devolver un valor de error.
        SELECT -1 AS DiasPasados;
    END
END
GO


