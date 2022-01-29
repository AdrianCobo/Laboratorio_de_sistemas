#!/bin/sh


usage(){
	echo "usage: $0 [-d] dirs..." 1>&2
	exit 1
}

printonly=''
if [ $# -ge 1 ] && [ $1 = '-d' ]; then
	shift
	printonly='print'
fi

if [ $# = 0 ]; then
	usage
fi

dirs=''
for i in "$@";
do
	#para evitar /tmp/..
	cldir=$(realpath "$i")
	if [ "$cldir" = '/' ] ; then
		echo "error $0 : /is not a valid argument " 1>&2
		exit 1
	fi
	if ! [ -d "$cldir" ]; then #si no existe el directorio
		echo "error $cldir is not a dir" 1>&2
		exit 1
	fi
	dirs="$cldir $dirs"
done

cd /

listpids=$(lsof +D $dirs | awk '$4  ~ /^cwd$/ {print $2}') #muestra los procesos de los directorios pasados a lsof

if [ "$listpids" = '' ]; then
	exit 0
fi

cmd=$(echo $listpids | sed 's/^/ kill −KILL /g') # añade kill -Kill al principion de la linea para que se vea el comando que habria que poner

if [ "$printonly" = 'print' ]; then
	echo $cmd
else
	$cmd
fi
