#!/bin/sh

if test $# -eq 0 || test $# -gt 2 ; then
        echo usage error";" usage example: findbig N [USER] 1>&2
        exit 1

elif test $# -eq 1; then
	 find . -type f -ls | tr -s ' '| cut -d ' ' -f 8,12 |sort -nrk 1| awk '{print $2}' | sed 's/^..//g' | head -n $1

elif test $# -eq 2; then
	find . -type f -user $2 -ls | tr -s ' '| cut -d ' ' -f 8,12 |sort -nrk 1| awk '{print $2}' | sed 's/^..//g' | head -n $1

fi
exit 0
