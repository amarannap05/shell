# Aitor Maraña Pérez
# 25/03/2026

import os
import shutil as s

def CarList(archivo="rutas.txt"):
    ficheros = []
    directorio = []

    if not os.path.exists(archivo):
        print(f"Error: Archivo {archivo} no existe")
        return ficheros, directorio

    with open(archivo, "r") as f:
        for line in f:
            ruta = line.strip()
            if not ruta:
                continue

            if os.path.exists(ruta):
                ficheros.append(ruta)
            elif os.path.isdir(ruta):
                directorio.append(ruta)
            else:
                print(f"Error: Archivo {archivo} no es valido")
    return ficheros, directorio

def DelFich():
    nombre = input("Ingrese nombre del fichero: ").strip()
    if os.path.isfile(nombre):
        os.remove(nombre)
        print("Archivo eliminado")
    else:
        print(f"Error: Archivo {nombre} no existe")

def infoFich():
    nombre = input("Ingrese nombre del fichero: ").strip()
    if os.path.isfile(nombre):
        print("Ruta absoluta: ", os.path.abspath(nombre))
        print("contenido:")
        for item in os.listdir(nombre):
            print(item)
    else:
        print(f"Error: Archivo {nombre} no existe")

def CopFich():
    origen = input("Ingrese origen del fichero: ").strip()
    destino = input("Ingrese destino del fichero: ").strip()

    if not os.path.isfile(origen):
        print(f"Error: Archivo {origen} no existe")
        return
    if not os.path.isdir(destino):
        print(f"Error: Archivo {destino} no existe")
        return

    s.copyfile(origen, destino)
    print("Archivo copiado")

def MostFich(ficheros, directorios):
    cual = input("Que lista quieres usar (F=Ficheros o D=Directorios): ").strip()
    if cual == "F":
        print("Lista de ficheros")
        for r in ficheros:
            print(r)
    elif cual == "D":
        print("Lista de directorios")
        for r in directorios:
            print(r)
    else:
        print("Opccion Invalida")

while True:
    print("1 Eliminar fichero")
    print("2 Mostrar informacion del directorio")
    print("3 Copiar fichero")
    print("4 Mostrar lista")
    print("5 Salir")
    opc = int(input("Que opcion deseada: "))

    match opc:
        case "1":
            infoFich()
        case "2":
            DelFich()
        case "3":
            CopFich()
        case "4":
            CarList()
        case "5":
            break

