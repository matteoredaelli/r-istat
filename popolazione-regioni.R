#!/usr/bin/env Rscript

## Copyright (C) 2010 ~ matteo DOT redaelli AT libero DOT it
##                      http://www.redaelli.org/matteo/
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

args <- commandArgs()

if (length(args) < 7) {
  usage <- "Numero parametri insufficiente!
Parametri: file_provincia.csv codice_comune [output_folder] [prefix]
  file_provincia.csv scaricato da http://demo.istat.it/pop2010/index3.html
  codice_comune: utilizza, per esempio, 108015 per Carate Brianza.
  prefix: utilizzato sia nel titolo sia nel nome file delle immagini 
"
  stop(usage)
}

source("sp-italia.R")

library(Hmisc)

spfile <-args[6]
file_regioni<- args[7]
outdir <- if (is.na(args[8])) "." else args[8]

regioni <- read.csv(file_regioni, skip=1)
regioni$Età <- as.numeric(regioni$Età)

width=500
height=500
bg="grey45"

reports <- list(
##                c("Coniugati", "Coniugate")
                c("Divorziati", "Divorziate")
##                c("Vedovi", "Vedove")
                )

mappa_popolazione_per_stato_civile_eta <- function(spfile, regioni, eta, fields, title, outdir=".") {
   reg <- subset(regioni, Età == as.numeric(eta))
   perc_values <- (reg[[fields[1]]] + reg[[fields[2]]]) / (reg[["Totale.Maschi"]] +reg[["Totale.Femmine"]]) * 100
   values <-paste(as.character( round(perc_values,1) ),"%", sep="")
   outfile <- paste(outdir, "/", fields[1], "-", sprintf("%03d", eta), ".png", sep="")
   newtitle <- paste(title, "di", eta, "anni (% sulla popolazione regionale)", sep=" ")
   spplot.italy(spfile, values=values, title=newtitle, filename=outfile)
}

mappa_popolazione_per_stato_civile <- function(spfile, regioni, fields, title, outdir=".") {
  lapply( seq(0,100), function(eta) mappa_popolazione_per_stato_civile_eta(spfile, regioni, eta, fields, title, outdir))
}


lapply(reports,
       function(fields) mappa_popolazione_per_stato_civile(spfile,
                                                           regioni,
                                                           fields,
                                                           fields[1],
                                                           outdir=outdir
                                                           )
       )
