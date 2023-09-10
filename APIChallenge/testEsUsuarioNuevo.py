import pyodbc as pyodbc

connection_string = "Driver={SQL Server};Server=PC-LUCAS\SQLEXPRESS;Database=Challenge;Trusted_Connection=yes;"
conn = pyodbc.connect(connection_string)
cursor = conn.cursor()

DIAS_NUEVO_USUARIO = 7

id = 1

try:    
    cursor.execute("EXEC DiasDesdeLaCreacion @UserID = ?", id)
    row = cursor.fetchone()
    es_nuevo = bool

    if (row[0]<DIAS_NUEVO_USUARIO):
        es_nuevo = True
    else:
        es_nuevo = False

    print(es_nuevo)
    
except Exception as e:
    print(e)