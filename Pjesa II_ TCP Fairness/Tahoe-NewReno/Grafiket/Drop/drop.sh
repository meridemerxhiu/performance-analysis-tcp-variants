#!/bin/sh
set title "Droprate Tahoe-NewReno"
set xlabel "BW (Mbps)"
set xrange [1:7]
set xtics 1,1,7
set ylabel "droprate (%)"
set yrange [0:5.5]
set ytics    0,0.5,5.5
set key right
set grid
set terminal postscript eps "Helvetica" 20 color
set output "Droprate Tahoe-NewReno"
plot "Tahoe-NewRenoDrop" using 1:2 lw 6 lt 1 lc rgb "red" title "Tahoe 1-5" with line,"Tahoe-NewRenoDrop" using 1:3 lw 6 lt 1 lc rgb "blue" title "NewReno 3-5" with line
set output
