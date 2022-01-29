#!/bin/sh

usage(){
        echo usage: $0 string fich.mup [fich.mup...] 2>&1
        exit 1
}

if [ -z $1 ] || [ $# -lt 2 ] ;then
        usage
fi

text=$1
shift

for i in $@;do
        if ! [ -f $1 ] | [ $(echo $i| egrep -E ".*\.mup$") ];then
                echo somithing is not a file or doesnt end in .mup 2>&1
                exit 1
        fi
	fichsalida=$(echo $i|sed -E 's/.mup$/.txt/')
	cat $i|egrep -E "^--$text TXT|^--$text COMMENT"|sed -E "s/^--$text TXT//g"|sed -E "s/^--$text COMMENT/#/g"|sed -E 's/^#.*$/&#/g' > $fichsalida
done
exit 0
