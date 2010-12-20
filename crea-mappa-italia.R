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

source("sp-italia.R")

args <- commandArgs()

if (length(args) < 8) {
  usage <- "Numero parametri insufficiente!i 
"
  stop(usage)
}

spfile <- args[6]
title <- args[7]
values.string <- args[8] 
outdir <- if (is.na(args[9])) "." else args[9]
outfile <- paste(outdir, "/", title, ".png", sep="")
values.vector <- unlist(strsplit(values.string, ","))

spplot.italy(spfile, values=values.vector, title=title, filename=outfile)
