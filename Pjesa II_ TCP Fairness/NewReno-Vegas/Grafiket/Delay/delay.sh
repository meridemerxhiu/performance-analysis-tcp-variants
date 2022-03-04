#!/bin/sh
set title "Delay NewReno-Vegas"
set xlabel "BW (Mbps)"
set xrange [1:7]
set xtics 1,1,7
set ylabel "delay (ms)"
set yrange [11.37:11.45]
set ytics    11.37,0.02,11.45
set key right
set grid
set terminal postscript eps "Helvetica" 20 color
set output "Delay NewReno-Vegas"
plot "NewReno-VegasDelay" using 1:2 lw 6 lt 1 lc rgb "blue" title "NewReno 1-5" with line,"NewReno-VegasDelay" using 1:3 lw 6 lt 1 lc rgb "green" title "Vegas 3-5" with line
set output
