#!/bin/sh
set title "Droprate NewReno-Vegas"
set xlabel "BW (Mbps)"
set xrange [1:7]
set xtics 1,1,7
set ylabel "droprate (%)"
set yrange [0:4]
set ytics    0,0.2,4
set key right
set grid
set terminal postscript eps "Helvetica" 20 color
set output "Droprate NewReno-Vegas"
plot "NewReno-VegasDrop" using 1:2 lw 6 lt 1 lc rgb "blue" title "NewReno 1-5" with line,"NewReno-VegasDrop" using 1:3 lw 6 lt 1 lc rgb "green" title "Vegas 3-5" with line
set output
