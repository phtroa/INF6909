#!/usr/bin/gnuplot
set terminal svg enhanced size 300 300
set output 'comparaison.svg'
set key inside left top vertical Right noreverse enhanced \
    autotitles box linetype -1 linewidth 1.000
set samples 50, 50
plot [0:1] 60*x, 100*(1 + (1 - x))
#plot [0:1] 60*x, 100*(1 + (1 - x)), 100*(1 + x)
