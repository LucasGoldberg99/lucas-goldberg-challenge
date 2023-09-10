import requests
import pyodbc as pyodbc

USD_CURRENCY = "USD"

connection_string = "Driver={SQL Server};Server=PC-LUCAS\SQLEXPRESS;Database=Challenge;Trusted_Connection=yes;"
conn = pyodbc.connect(connection_string)
cursor = conn.cursor()

url = "https://api.apilayer.com/exchangerates_data/latest"

headers = {
    "apikey": "0WdsI8NFZMpzOWMf83Y1he7ZyZIBHn83"
}

sumador = 0

id_usuario = 2

# Llamada al stored procedure en SQL Server que con el parametro ID trae todos los ID de las compras efectuadas la ultima semana por dicho Usuario.
cursor.execute("EXEC ObtenerIDsCompraUltimaSemana @UserID = ?", id_usuario)
array_de_ids = cursor.fetchall()

print(array_de_ids)

# FOR que va a iterar dentro del array de IDs de compra.
for id_pago in array_de_ids:

    # Llamada al stored procedure que para cada ID de compra va a traer la "moneda local" y el total de la compra en dicha moneda.
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