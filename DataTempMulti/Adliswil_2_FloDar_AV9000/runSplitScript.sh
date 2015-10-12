#!/bin/bash

for i in rawData/*.tsv
do
    Rscript splitscript.r "./$i"
    echo "splited $i"
done
