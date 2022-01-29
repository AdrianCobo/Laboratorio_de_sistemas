#!/bin/sh

ficheros=$(ls . |sort -n| egrep -E "2[3-5].*")
echo $ficheros
gzip  $(echo $ficheros) > ficheroscomprimidos.gz
