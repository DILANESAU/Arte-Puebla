# -*- coding: utf-8 -*-
"""OCR-V3-DBRG.ipynb

Automatically generated by Colab.

Original file is located at
    https://colab.research.google.com/drive/1Las1nm8IL-wucUwKFZ0nSLQsTRqJqqi0
"""
# Conectar con Google Drive
from google.colab import drive
drive.mount('/content/drive')

# --------------------------------------------------------------------------------
# |                               OCR Simple Process                             |
# --------------------------------------------------------------------------------
# |                                                                             |
# |  +-----------------+            +------------------------+                  |
# |  |   Image Input    | ----->    |   OCR Extraction       |                  |
# |  +-----------------+            +------------------------+                  |
# |                                         |                                   |
# |                                         v                                   |
# |                              +------------------------+                     |
# |                              |   Text Processing      |                     |
# |                              +------------------------+                     |
# |                                         |                                   |
# |                                         v                                   |
# |                        +-------------------------------------+              |
# |                        |   Data Mapping (Dates, Location,    |              |
# |                        |    Time, etc.)                      |              |
# |                        +-------------------------------------+              |
# |                                         |                                   |
# |                                         v                                   |
# |                              +------------------------+                     |
# |                              |   Save Data in CSV     |                     |
# |                              +------------------------+                     |
# |                                                                             |
# --------------------------------------------------------------------------------
# Este proceso se encarga de tomar la imagen, extraer texto con OCR y organizarlo
# en campos específicos como fecha, hora y lugar, para luego almacenarlo en un CSV.
# --------------------------------------------------------------------------------

#Instalar librerías necesarias
#!pip install easyocr pyspellchecker pandas

import easyocr

# Iniciar el lector OCR con soporte para español
reader = easyocr.Reader(['es'])

# Función para realizar OCR y obtener texto con detalles de posición y tamaño
def extraer_ocr_con_detalles(ruta_imagen):
    resultados = reader.readtext(ruta_imagen, detail=1)  # Detalle activado para obtener coordenadas y tamaños
    return resultados

# Procesar una imagen (la ruta se cambia para cada imagen que se procese)
ruta_imagen = '/content/drive/MyDrive/ML-DBRG/prueba4.jpg'  # RUTA DE MI IMAGEN
resultados_ocr = extraer_ocr_con_detalles(ruta_imagen)

# Mostrar los resultados del OCR
for res in resultados_ocr:
    texto, coordenadas, confianza = res[1], res[0], res[2]
    print(f"Texto: {texto} | Coordenadas: {coordenadas} | Confianza: {confianza}")

# Extraer todo el texto en un solo bloque para el procesamiento posterior
texto_extraido = " ".join([res[1] for res in resultados_ocr])
print(f"\nTexto extraído:\n{texto_extraido}")

# Función para identificar el nombre del evento basado en el tamaño del texto
def extraer_nombre_evento(resultados_ocr):
    nombre_evento = ''
    max_altura = 0

    # Recorrer resultados para encontrar el texto más grande (probable título)
    for res in resultados_ocr:
        coordenadas, texto, confianza = res

        # Cada coordenada tiene 4 puntos: topleft, topright, bottomright, bottomleft
        topleft, topright, bottomright, bottomleft = coordenadas

        # Calcular la altura del texto
        altura_texto = bottomright[1] - topright[1]

        # Si este texto es más grande que los anteriores, lo consideramos como posible título
        if altura_texto > max_altura:
            max_altura = altura_texto
            nombre_evento = texto

    return nombre_evento

# Detectar el nombre del evento usando el OCR
nombre_evento = extraer_nombre_evento(resultados_ocr)
print(f"Nombre del evento detectado: {nombre_evento}")

import re

# Función para extraer fechas en varios formatos
def extraer_fechas(texto):
    patron_fechas = r'(\d{1,2} de \w+ de \d{4})'
    fechas_encontradas = re.findall(patron_fechas, texto, re.IGNORECASE)

    if fechas_encontradas:
        if len(fechas_encontradas) == 1:
            return fechas_encontradas[0], None
        elif len(fechas_encontradas) >= 2:
            return fechas_encontradas[0], fechas_encontradas[1]

    return None, None

# Función para extraer horas en varios formatos
def extraer_horas(texto):
    patron_horas = r'(\d{1,2}:\d{2}\s?(?:am|pm)?)\s?(?:a|-|hasta)\s?(\d{1,2}:\d{2}\s?(?:am|pm)?)'
    horas_encontradas = re.findall(patron_horas, texto, re.IGNORECASE)

    if horas_encontradas:
        return horas_encontradas[0]  # Devolvemos la primera coincidencia
    return None, None

# Extraer fechas y horas dinámicamente del texto
fecha_inicio, fecha_fin = extraer_fechas(texto_extraido)
hora_inicio, hora_fin = extraer_horas(texto_extraido)

print(f"Fecha de inicio: {fecha_inicio}, Fecha de fin: {fecha_fin}")
print(f"Hora de inicio: {hora_inicio}, Hora de fin: {hora_fin}")

# Función para detectar palabras clave de dirección y lugar
def extraer_lugar_y_direccion(texto):
    palabras_clave_direccion = ['calle', 'avenida', 'av.', 'centro', 'museo', 'plaza']
    lugar = ''
    direccion = ''

    # Buscar las palabras clave en el texto extraído
    lineas = texto.split("\n")
    for linea in lineas:
        for palabra_clave in palabras_clave_direccion:
            if palabra_clave in linea.lower():
                direccion = linea
                if lineas.index(linea) > 0:
                    lugar = lineas[lineas.index(linea) - 1]  # Asumimos que el lugar está en la línea superior
                break

    return lugar, direccion

# Uso con el texto extraído
lugar, direccion = extraer_lugar_y_direccion(texto_extraido)
print(f"Lugar detectado: {lugar}")
print(f"Dirección detectada: {direccion}")

import os
import pandas as pd

# Función para organizar los datos y guardarlos en un CSV
def guardar_datos_csv(id_evento, nombre_evento, tipo_evento, fecha_inicio, fecha_fin, hora_inicio, hora_fin, direccion, lugar, costo, tipo_publico, descripcion, ruta_csv):
    # Verificar si la carpeta existe; si no, crearla
    ruta_directorio = os.path.dirname(ruta_csv)
    if not os.path.exists(ruta_directorio):
        os.makedirs(ruta_directorio)  # Crear el directorio si no existe

    # Organizar los datos en un diccionario
    datos_evento = {
        'ID': id_evento,
        'NOMBRE_EVENTO': nombre_evento,
        'TIPO_EVENTO': tipo_evento,
        'FECHA_INICIO': fecha_inicio,
        'FECHA_FIN': fecha_fin,
        'HORA_INICIO': hora_inicio,
        'HORA_FIN': hora_fin,
        'DIRECCION': direccion,
        'LUGAR': lugar,
        'COSTO': costo,
        'TIPO_PUBLICO': tipo_publico,
        'DESCRIPCION': descripcion
    }

    # Convertir a DataFrame
    df = pd.DataFrame([datos_evento])

    # Verificar si el archivo ya existe para evitar error al leerlo
    if os.path.exists(ruta_csv):
        df.to_csv(ruta_csv, mode='a', header=False, index=False)  # Append al archivo existente
    else:
        df.to_csv(ruta_csv, mode='w', header=True, index=False)  # Crear archivo con header

    print(f"Datos guardados en: {ruta_csv}")

# Ejemplo de uso para guardar los datos únicos de cada imagen
guardar_datos_csv(
    id_evento=1,
    nombre_evento=nombre_evento,
    tipo_evento='Taller',  # Esto también podría detectarse dinámicamente
    fecha_inicio=fecha_inicio,
    fecha_fin=fecha_fin,
    hora_inicio=hora_inicio,
    hora_fin=hora_fin,
    direccion=direccion,
    lugar=lugar,
    costo='Entrada libre',  # Esto también podría detectarse
    tipo_publico='General',  # También podría cambiar
    descripcion=texto_extraido,
    ruta_csv='/content/drive/MyDrive/ML-DBRG/csv/pruebas/eventos.csv'
)