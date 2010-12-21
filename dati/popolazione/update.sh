#!/usr/bin/env bash

anno=$1
for ambito in province regioni ripartizioni Milano Monza_e_della_Brianza
do
    zipfile=${ambito}.zip
    rm ${zipfile}
    
    wget http://demo.istat.it/pop${anno}/dati/${zipfile}
    unzip -u ${zipfile}
done