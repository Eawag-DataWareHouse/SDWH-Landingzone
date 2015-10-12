#!/bin/bash

for i in rawData/*.txt
do
    Rscript AV90002Standard.r "./$i"
    echo "converted $i"
done
