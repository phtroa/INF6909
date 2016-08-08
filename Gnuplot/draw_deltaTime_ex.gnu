#!/usr/bin/gnuplot

set title "Influence du pas de temps"
set xlabel "pas de temps"
set ylabel "Pourcentage de messages malicieux refusés"
set autoscale
set grid
set terminal postscript enhanced color
set output 'ListeRepPourcentageExclusionRand.ps'

plot 'rssvr_msd.dat' using 1:3 with linespoints title 'moyenne',\
         'rssvr_msd.dat' using 1:2 with linespoints ,\
         'rssvr_msd.dat' using 1:4 with linespoints 
