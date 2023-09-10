import pyodbc as pyodbc

connection_string = "Driver={SQL Server};Server=PC-LUCAS\SQLEXPRESS;Database=Challenge;Trusted_Connection=yes;"
conn = pyodbc.connect(connection_string)
cursor = conn.cursor()

id = 1

try:
    # Llamada al stored procedure en SQL Server con el parámetro ID
    cursor.execute("EXEC CantidadDeRechazos @UserID = ?", id)
    row = cursor.fetchone()
    print(row)
    if row:
        print(row[0]) 
    else:
        print ("No se encontraron datos")

except Exception as e:
    print(e)