#!/bin/sh

for archivo in $(ls)
do
if test $archivo != renword.sh ;then
	if file --mime-type $archivo | awk -F: '{print $2 }' | egrep image >/dev/null 2>&1 ;then
		mv $archivo foto_$archivo
	fi

	if ( cat $archivo | egrep -w $1 && file --mime-type $archivo | awk -F: '{print $2 }' | egrep text ) >/dev/null 2>&1 ;then
		mv $archivo $archivo.$1
	fi
fi
done
