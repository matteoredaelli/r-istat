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


library(sp)
library(lattice)
library(maptools)

spplot.italy <- function(
                         spfile,
                         values,
                         title,
                         filename="italy.png",
                         width=600, height=600,
                         bg="gray15"
                         ) {
  nc <- readShapePoly(spfile)

  nc$values <- as.factor(values)
  col = rev(heat.colors(length(levels(nc$values))))

  par.set <- list(axis.line=list(col="transparent"),
                  clip=list(panel="off"),
                  par.main.text=list(col="white"),
                  axis.text=list(col="white"),
                  fontsize=list(text=18))
  png(filename, width=height, height=height, bg=bg, units="px")
  img <- spplot(nc, "values", col.regions=col, col=bg, main=list(label=title), res=88, par.settings=par.set)

  print(img)
    dev.off()
}

# stampa i nomi dele regioni
#
#spplot(nc,zcol=1,panel=function(...){ 
#sp.polygons(gnc) 
#sp.text(coordinates(nc),regionnames,cex=0.6) 
#},colorkey=F) 
