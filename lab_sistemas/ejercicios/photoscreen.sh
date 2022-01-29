#!/bin/sh

usage(){
	echo "usage: $0 dir" 1>&2
	exit 1
}

if [ $# -ne 1 ] || ! [ -d "$1" ]; then
	usage
fi

dirname=$1/$(date +%d%b%Y)

if [ -d "$dirname" ] ; then
	echo "error: dir $dirname alreadyexists" 1>&2
	exit 1
fi
mkdir $dirname

if ! [ -d "$dirname" ]; then
	echo "error: dir $dirname could not be created " 1>&2
	exit 1
fi

isimage(){
	file --mime-type "$1" | sed 's/.*://g' | awk  '{print $1 }' |\
	egrep '^image/'> /dev/null 2>&1 # el sed quita todo lo que hay antes de los 2 puntos
}

for i in "$1/"*; do
	if isimage "$i " ; then
		cp "$i" "$dirname"
	fi
done

nfile=$(ls $dirname/| wc -l ) # cuenta el numero de ficheros

for i in $(seq -w 1 $nfile ) ; do
	fichname=$(ls $dirname/ | sed "$i"q | tail -1) #va sacando los nombres de los ficheros de uno en uno
	ext=$(echo "$fichname" | sed -E 's/.*(\.[ˆ.]+)/\1/')
	mv $dirname/$fichname $dirname/$i$ext
done
