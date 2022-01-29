#!/bin/sh  

usage(){
	echo "usage: $0 [-r] " 1>&2
	exit 1
}
nofiles(){
	echo "error: no files" 1>&2
	exit 1

}

listfiles(){
	ls -la |egrep '^-'|awk '{print $5, $9}' #imprimir tamaño en bites y nombre del fichero
}

cmd=listfiles
if [ $# = 1 ] && [ $1 = '-r' ]; then
	shift
	cmd='du -ba .' #busqueda recursiva de ficheros y su tamaño
fi

if [ $# != 0 ]; then
	usage
fi

if [ $(ls -la| wc -l) -le 3 ]; then #numero de ficheros del directorio (cuenta . y ..)
        nofiles
fi

files=$($cmd |sort -nr | awk '{print $2}')
biggest=''
for i in $files;
do 
	if [ -f "$i" ]; then #esta condicion es verdadero si el fichero existe y es un fichero regular
		biggest=$(realpath "$i") #realpath pone el directorio absoluto
		break
	fi
done

if [ -f "$biggest" ]; then
	echo $biggest| sed -E 's/(^[^ \t]+)/mv \1 \1.old/g'
else
	 nofiles
fi
