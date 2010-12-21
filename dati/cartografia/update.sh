#!/usr/bin/env bash

for file in regioni2010.zip province2010.zip comuni.zip
do
	rm $file
	wget http://www.istat.it/ambiente/cartografia/$file
	unzip $file
done

for file in ripartizioni_regioni_province.csv elenco_comuni_italiani_30_giugno_2010.csv
do
	rm $file
	wget http://www.istat.it/strumenti/definizioni/comuni/$file
done

