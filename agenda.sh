#!/bin/bash
# variables= op=opcion d=data ch=choice dn=DNI n=nombre a=apellido c=ciudad
# Aitor Maraña Pérez
# Fecha 29/01/2026

# Asegurarse de que el archivo existe
touch agenda.txt

while true; do

read -p $'Elige una de las siguientes opciones:\n
a) Añade una entrada\n
b) Busca por dni\n
c) Ver la agenda completa\n
d) Eliminar todas las entradas de la agenda\n
e) Finalizar\n
Opción: ' op

case $op in

	a)
		read -p "Introduce el DNI: " dn
		if grep -q "^$dn:" agenda.txt; then
			echo "La persona ya está dada de alta en la agenda"
		else
			read -p "Introduce el nombre: " n
			read -p "Introduce los apellidos: " a
			read -p "Introduce la ciudad: " c
			echo "$dn:$n:$a:$c" >> agenda.txt
			echo "Entrada añadida correctamente"
		fi
		sleep 2
		;;

	b)
		read -p "Introduce el DNI que desea buscar: " dn
		if [ ${$dn} == "9" ]; then	
			d=$(grep "^$dn:" agenda.txt)
			if [ -z "$d" ]; then
				echo "No existe ninguna persona con ese DNI"
			else
				IFS=":" read -r dn n a c <<< "$d"
				echo "La persona con DNI número $dn es: $n $a, y vive en $c"
			fi
		else
			echo "El DNI tiene un formato invalido"
		fi
		sleep 2
		;;

	c)
		if [ ! -s agenda.txt ]; then
			echo "Agenda vacía"
		else
			cat agenda.txt | tr ":" " "
		fi
		sleep 2
		;;

	d)
		read -p "Seguro que quiere eliminar todas las entradas (Si o No): " ch
		if [ "$ch" == "Si" ]; then
			> agenda.txt
			echo "Agenda eliminada correctamente"
		else
			echo "Anulando opción"
		fi
		sleep 2
		;;

	e)
		echo "El programa se cerrará..."
		sleep 2
		break
		;;

	*)
		echo "Parámetro equivocado"
		sleep 1
		;;
esac

done



