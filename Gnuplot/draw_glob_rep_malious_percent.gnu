#!/usr/bin/gnuplot

set title "pourcentage d'exclusion suivant le pourcentage de noeuds malicieux"
set xlabel "Pourcentage de noeuds malicieux"
set ylabel "Pourcentage de messages malicieux exclus"
set autoscale
set grid
set terminal postscript enhanced color
set output 'GlobRepPourcentageExclusion.ps'

f(x) = a*x + b
fit f(x) 'globale_rep_ssrv.dat' via a, b
plot f(x) with lines title 'regression lineaire',\
 'globale_rep_ssrv.dat' with points title 'donnees brutes'
show v
