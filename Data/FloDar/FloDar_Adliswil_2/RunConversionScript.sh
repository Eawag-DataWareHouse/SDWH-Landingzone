#!/bin/bash

for i in rawData/*.txt
do
    Rscript FloDar2Standard.r "./$i"
    echo "converted $i"
done
