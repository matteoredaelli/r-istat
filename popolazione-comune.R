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

file_provincia <- args[6]
codice_comune <- args[7]
outdir <- if (is.na(args[8])) "." else args[8]
prefix  <- if (is.na(args[9])) codice_comune else args[9]


prov <- read.csv(file_provincia, skip=2)

colors=c("cyan", "violet")
width=800
height=400
lwd=3
bg="grey45"

comune <- subset(prov, Codice.Comune == codice_comune & Età != 999, select = -1)
comune$Età <- as.numeric(comune$Età)

compare_male_female <- function(male.data, female.data, title=title, prefix=prefix, outdir=".", col=colors, bg=bg, width=800, height=400, lwd=3) { 
  maxvalue <- max( c(male.data, female.data), na.rm = TRUE) + 10
  png(paste(outdir, "/", prefix, ".png", sep=""), units="px", width=width, height=height, bg=bg)
  plot(male.data, type="l", col=col[1], ylim=c(0,maxvalue), xlab="Età", ylab="numerosità", lwd=lwd)
  legend(0,maxvalue, c("Maschi", "Femmine"), col=col, title="Legenda", lwd=lwd)
  lines( female.data, col=col[2], lwd=lwd)
  title( title)
  dev.off()
}

reports <- list(
            c("totale", "Totale.Maschi", "Totale.Femmine"),
                c("non_coniugati", "Celibi", "Nubili"),
                 c("coniugati", "Coniugati", "Coniugate"),
                 c("divorziati", "Divorziati", "Divorziate"),
                 c("vedovi", "Vedovi", "Vedove")
            )

lapply(reports,
       function(report) compare_male_female(comune[[report[2]]],
                                            comune[[report[3]]],
                                            title=paste(prefix, ": popolazione ", report[1], sep=""),
                                            prefix=paste(prefix, "popolazione",  report[1], sep="_"),
                                            outdir=outdir,
                                            col=colors,
                                            bg=bg,
                                            width=width,
                                            height=height,
                                            lwd=lwd
                                            )
       )
