-- Se crea la tabla Usuarios
CREATE TABLE [Challenge].[dbo].[Usuarios] (
    id int identity(1,1) primary key,
    fechaCreacion date NOT NULL
);


-- Se crea la tabla Pagos
CREATE TABLE [Challenge].[dbo].[Pagos] (
    id int identity(1,1) primary key,
    idUsuario int NOT NULL,
    pais varchar(25) NOT NULL,
    monedaLocal varchar(25) NOT NULL,
    totalMonedaLocal float NOT NULL,
    fecha date NOT NULL,
    estado tinyint NOT NULL
);


-- Se agregan registros a la tabla de Usuarios
INSERT INTO [Challenge].[dbo].[Usuarios] (fechaCreacion) VALUES ('2021-08-22')
INSERT INTO [Challenge].[dbo].[Usuarios] (fechaCreacion) VALUES ('2022-12-31')
INSERT INTO [Challenge].[dbo].[Usuarios] (fechaCreacion) VALUES ('2023-09-03')
INSERT INTO [Challenge].[dbo].[Usuarios] (fechaCreacion) VALUES (getdate())
INSERT INTO [Challenge].[dbo].[Usuarios] (fechaCreacion) VALUES ('2023-09-09')
INSERT INTO [Challenge].[dbo].[Usuarios] (fechaCreacion) VALUES ('2019-10-17')
INSERT INTO [Challenge].[dbo].[Usuarios] (fechaCreacion) VALUES ('2023-09-08')
INSERT INTO [Challenge].[dbo].[Usuarios] (fechaCreacion) VALUES (getdate())

-- Se agregan registros a la tabla de Pagos
-- Usuario 1
INSERT INTO [Challenge].[dbo].[Pagos] (idUsuario, pais, monedaLocal, totalMonedaLocal, fecha, estado) VALUES (1, 'Argentina', 'ARS', 150000, getDate(), 1)
INSERT INTO [Challenge].[dbo].[Pagos] (idUsuario, pais, monedaLocal, totalMonedaLocal, fecha, estado) VALUES (1, 'Argentina', 'ARS', 100000.20, getDate(), 1)
INSERT INTO [Challenge].[dbo].[Pagos] (idUsuario, pais, monedaLocal, totalMonedaLocal, fecha, estado) VALUES (1, 'Argentina', 'ARS', 350000, getDate(), 0)
INSERT INTO [Challenge].[dbo].[Pagos] (idUsuario, pais, monedaLocal, totalMonedaLocal, fecha, estado) VALUES (1, 'Argentina', 'ARS', 540, getDate(), 1)
INSERT INTO [Challenge].[dbo].[Pagos] (idUsuario, pais, monedaLocal, totalMonedaLocal, fecha, estado) VALUES (1, 'Argentina', 'ARS', 9800, '2022-09-15', 1)

-- Usuario 2
INSERT INTO [Challenge].[dbo].[Pagos] (idUsuario, pais, monedaLocal, totalMonedaLocal, fecha, estado) VALUES (2, 'Uruguay', 'UYU', 10000, getDate(), 0)
INSERT INTO [Challenge].[dbo].[Pagos] (idUsuario, pais, monedaLocal, totalMonedaLocal, fecha, estado) VALUES (2, 'Uruguay', 'UYU', 9750.56, getDate(), 1)
INSERT INTO [Challenge].[dbo].[Pagos] (idUsuario, pais, monedaLocal, totalMonedaLocal, fecha, estado) VALUES (2, 'Uruguay', 'UYU', 2990, getDate(), 0)
INSERT INTO [Challenge].[dbo].[Pagos] (idUsuario, pais, monedaLocal, totalMonedaLocal, fecha, estado) VALUES (2, 'Uruguay', 'UYU', 150.20, getDate(), 1)
INSERT INTO [Challenge].[dbo].[Pagos] (idUsuario, pais, monedaLocal, totalMonedaLocal, fecha, estado) VALUES (2, 'Uruguay', 'UYU', 9800, '2023-09-02', 1)
INSERT INTO [Challenge].[dbo].[Pagos] (idUsuario, pais, monedaLocal, totalMonedaLocal, fecha, estado) VALUES (2, 'Uruguay', 'UYU', 7600, '2023-09-07', 0)

-- Usuario 3
INSERT INTO [Challenge].[dbo].[Pagos] (idUsuario, pais, monedaLocal, totalMonedaLocal, fecha, estado) VALUES (3, 'Brasil', 'BRL', 250, getDate(), 1)
INSERT INTO [Challenge].[dbo].[Pagos] (idUsuario, pais, monedaLocal, totalMonedaLocal, fecha, estado) VALUES (3, 'Brasil', 'BRL', 1000, getDate(), 1)
INSERT INTO [Challenge].[dbo].[Pagos] (idUsuario, pais, monedaLocal, totalMonedaLocal, fecha, estado) VALUES (3, 'Brasil', 'BRL', 800, getDate(), 1)
INSERT INTO [Challenge].[dbo].[Pagos] (idUsuario, pais, monedaLocal, totalMonedaLocal, fecha, estado) VALUES (3, 'Brasil', 'BRL', 386, getDate(), 1)

-- Usuario 4
INSERT INTO [Challenge].[dbo].[Pagos] (idUsuario, pais, monedaLocal, totalMonedaLocal, fecha, estado) VALUES (4, 'Argentina', 'ARS', 150000, getDate(), 0)
INSERT INTO [Challenge].[dbo].[Pagos] (idUsuario, pais, monedaLocal, totalMonedaLocal, fecha, estado) VALUES (4, 'Argentina', 'ARS', 200000, getDate(), 0)
INSERT INTO [Challenge].[dbo].[Pagos] (idUsuario, pais, monedaLocal, totalMonedaLocal, fecha, estado) VALUES (4, 'Argentina', 'ARS', 25, getDate(), 0)
INSERT INTO [Challenge].[dbo].[Pagos] (idUsuario, pais, monedaLocal, totalMonedaLocal, fecha, estado) VALUES (4, 'Argentina', 'ARS', 984, getDate(), 0)

-- Usuario 5
INSERT INTO [Challenge].[dbo].[Pagos] (idUsuario, pais, monedaLocal, totalMonedaLocal, fecha, estado) VALUES (5, 'Argentina', 'ARS', 150000, getDate(), 1)
INSERT INTO [Challenge].[dbo].[Pagos] (idUsuario, pais, monedaLocal, totalMonedaLocal, fecha, estado) VALUES (5, 'Argentina', 'ARS', 200000, getDate(), 1)

-- Usuario 6
INSERT INTO [Challenge].[dbo].[Pagos] (idUsuario, pais, monedaLocal, totalMonedaLocal, fecha, estado) VALUES (6, 'Brasil', 'BRL', 150000, getDate(), 0)

-- Usuario 7
INSERT INTO [Challenge].[dbo].[Pagos] (idUsuario, pais, monedaLocal, totalMonedaLocal, fecha, estado) VALUES (7, 'Argentina', 'ARS', 250000, getDate(), 0)
INSERT INTO [Challenge].[dbo].[Pagos] (idUsuario, pais, monedaLocal, totalMonedaLocal, fecha, estado) VALUES (7, 'Brasil', 'BRL', 150000, getDate(), 0)
INSERT INTO [Challenge].[dbo].[Pagos] (idUsuario, pais, monedaLocal, totalMonedaLocal, fecha, estado) VALUES (7, 'Estados Unidos', 'USD', 2000, getDate(), 0)