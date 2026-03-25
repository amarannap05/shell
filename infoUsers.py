# Aitor Maraña Pérez
# 25/03/2026

import os
import platform

def ValRoot():
    if os.geteuid() != 0:
        print("Error: Usted no es root")
        raise SystemExit(1)

def SysInfo():
    print("Información del sistema")
    print("Sistema: ", platform.system())
    print("Version: ", platform.release())

    print("\n Informacíon de la CPU")
    print("CPU: ", platform.processor())
    print("Arquitectura: ", platform.architecture())

def ValUser():
    User = input("Ingrese su usuario: ").strip()

    if os.system(f"sudo passwd {User} > /dev/null") == 0:
        os.system(f"sudo passwd {User}")
    else:
        print("No existe usuario, creando usuario")
        os.system(f"sudo useradd -m {User}")
        os.system(f"sudo passwd {User}")

def ValPath():
    Path = input("Ingrese la direccion de la path: ")

    if os.path.exists(Path) == True:
        print("Directorio existe")
    else:
        os.makedirs(Path)
        print("Directorio creado")
while True:
    ValRoot()
    print("1.-Mostrar información del SO")
    print("2.-Creación de usuario")
    print("3.-Creacion de path")
    print("4.-Salir")
    opt = input("Introduzca su opción: ")
    match opt:
     case "1":
         SysInfo()
     case "2":
         ValUser()
     case "3":
         ValPath()
     case "4":
         break

