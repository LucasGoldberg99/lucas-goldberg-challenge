from fastapi import FastAPI
import uvicorn
import pyodbc as pyodbc
import requests

# Configuración de la conexión a SQL Server.
connection_string = "Driver={SQL Server};Server=PC-LUCAS\SQLEXPRESS;Database=Challenge;Trusted_Connection=yes;"
conn = pyodbc.connect(connection_string)
cursor = conn.cursor()

# Declaración de constantes.
APP = FastAPI()
DIAS_NUEVO_USUARIO = 7
VERDADERO = 1
USD_CURRENCY = "USD"

#Metodo que devuelve "true" si el usuario es nuevo y "false" si no lo es (para que sea nuevo deben haber pasado menos de 7 dias del registro).
def es_usuario_nuevo(id_usuario):
    try:    
        # Llamada al stored procedure en SQL Server que con el parámetro ID Usuario devuelve la cantidad de días desde la creacion del usuario.
        cursor.execute("EXEC DiasDesdeLaCreacion @UserID = ?", id_usuario)
        row = cursor.fetchone()
        es_nuevo = bool

        if (row[0]<DIAS_NUEVO_USUARIO):
            es_nuevo = True
        else:
            es_nuevo = False

        return es_nuevo
    
    except Exception as e:
        print(e)
        return {"error": str(e)}

#Metodo que devuelve la cantidad de compras rechazadas al usuario en el ultimo día.
def cantidad_de_rechazos_ultimo_dia(id_usuario):
    try:
        # Llamada al stored procedure en SQL Server que con el parámetro ID Usuario devuelve la cantidad de rechazos.
        cursor.execute("EXEC CantidadDeRechazos @UserID = ?", id_usuario)
        row = cursor.fetchone()

        if row:
            return row[0]
        else:
            return {"error": "No se encontraron datos"}

    except Exception as e:
        print(e)
        return {"error": str(e)}

#Metodo que devuelve el total en dólares de la ultima semana.
def total_en_dolares(id_usuario):

    url = "https://api.apilayer.com/exchangerates_data/latest"

    headers = {
        "apikey": "0WdsI8NFZMpzOWMf83Y1he7ZyZIBHn83"
    }

    sumador = 0

    try:
        # Llamada al stored procedure en SQL Server que con el parametro ID trae todos los ID de las compras efectuadas la ultima semana por dicho Usuario.
        cursor.execute("EXEC ObtenerIDsCompraUltimaSemana @UserID = ?", id_usuario)
        array_de_ids = cursor.fetchall()

        print(array_de_ids)

        # FOR que va a iterar dentro del array de IDs de compra.
        for id_pago in array_de_ids:

            # Llamada al stored procedure que para cada ID de compra va a traer la moneda local y el total de la compra en dicha moneda.
            cursor.execute("EXEC ObtenerMonedaYCantidad @PagoID = ?", id_pago)
            raw = cursor.fetchall()

            tipo_moneda = raw[0][0]
            total_en_moneda_local = raw[0][1]

            print(f"Tipo de moneda: {tipo_moneda}")
            print(f"Total en moneda local: {total_en_moneda_local}")

            if tipo_moneda != USD_CURRENCY:
                params = {
                    "base": str(tipo_moneda),  # Moneda de origen.
                    "symbols": "USD"  # Moneda de destino: dólares estadounidenses.
                }

                # Solicitud a la API de Exchange Rates API.
                response = requests.get(url, params=params, headers=headers)

                # IF que verifica si la solicitud fue exitosa.
                if response.status_code == 200:
                    data = response.json()

                    # Obtiene la tasa de conversión y la cantidad convertida.
                    tasa_de_conversion = data["rates"]["USD"]
                    total_en_USD = total_en_moneda_local * tasa_de_conversion

                    # Imprime la tasa de conversión y la cantidad convertida.
                    print(f"Tasa de conversión {tipo_moneda} a USD: {tasa_de_conversion}")
                    print(f"Cantidad convertida: {total_en_USD} USD")

                    # Se hace la suma del total actual de compras en dólares.
                    sumador = sumador + total_en_USD

                else:
                    print("Error en la solicitud a la API: Exchange Rates Data API")

            else:
                # Se hace la suma del total actual de compras en dólares.
                sumador = sumador + total_en_moneda_local
                print(f"Compra originalmente en USD: {total_en_moneda_local} USD")

        print(f"El total en doalres es: {sumador} USD")
        return (sumador)

    except Exception as e:
        print(e)
        return {"error": str(e)}

# Ruta para obtener los datos de usuario.
@APP.get('/get_data/{id}')
def get_data(id: int):

    # Llamada al stored procedure que para cada ID de compra va a traer la moneda local y el total de la compra en dicha moneda.
    cursor.execute("EXEC ExisteID @UserID = ?", id)
    raw = cursor.fetchall()

    print(raw[0][0])
    
    if(raw[0][0]==VERDADERO):
        is_new_user = es_usuario_nuevo(id)
        qty_rejected_1d = cantidad_de_rechazos_ultimo_dia(id)
        total_amt_7d = total_en_dolares(id)
        try:
            # Creación del JSON
            data = {
                "is_new_user": is_new_user,
                "qty_rejected_1d": qty_rejected_1d,
                "total_amt_7d": total_amt_7d
            }

        except Exception as e:
            return {"error": str(e)}
    else:
        data = {
                "error": f"No existe el usuario: {id}"
            }
    
    return data

if __name__ == "__main__":
    uvicorn.run("main:APP", port=8000, reload=True)