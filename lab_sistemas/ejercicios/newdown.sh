#!/bin/sh
if [ -z $1 ]               #si no hay parametro se considera 1
then
  fd=1
else
  fd=$1
fi
if [ $# -gt 1 ]          #da error si hay mas de un parametro
then
  echo 'usage: findbig N [USER]' 1>&2
  exit 1
fi
user=$(whoami)
deadline=$(date -d "$fd days ago" +"%y%m%d")        #fecha limite en la que mirar los archivos
for i in $(seq 1 3);do
  date=$(ls -lct "/home/$user/Descargas"|sed -E '1d'|           #mira la fecha de los primeros archivos
  awk '{print $6,$7}'|sed -E -n "${i}p"|sed -E 's/abr/apr/')
  d=$(date -d "$date" +"%y%m%d")
  if [ $deadline -lt $d ];then                                  #y los compara con la fecha limite para saber
      ls -lct "/home/$user/Descargas"|sed -E '1d'|awk '{print $9}'|   #si estan dentro de ella. si lo están,
      sed -E -n "${i}p"|sed -E "s#^#/home/$user/Descargas/#"          #imprime el fichero.
  fi
done
exit 0
