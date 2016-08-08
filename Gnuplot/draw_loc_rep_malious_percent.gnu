#!/usr/bin/gnuplot

set title "pourcentage d'exclusion suivant le pourcentage de noeuds malicieux"
set xlabel "Pourcentage de noeuds malicieux"
set ylabel "Pourcentage de messages malicieux exclus"
set autoscale
set grid
set terminal postscript enhanced color
set output 'LocaleRePPourcentageExclusion.ps'

plot 'locale_rep_ssrv.dat' with linespoints title 'donnees brutes' smooth unique
