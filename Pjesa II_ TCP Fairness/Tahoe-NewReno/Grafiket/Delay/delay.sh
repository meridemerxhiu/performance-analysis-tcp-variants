#!/bin/sh
set title "Delay Tahoe-NewReno"
set xlabel "BW (Mbps)"
set xrange [1:7]
set xtics 1,1,7
set ylabel "delay (ms)"
set yrange [11.37:11.45]
set ytics    11.37,0.01,11.45
set key right
set grid
set terminal postscript eps "Helvetica" 20 color
set output "Delay Tahoe-NewReno"
plot "Tahoe-NewRenoDelay" using 1:2 lw 6 lt 1 lc rgb "blue" title "Tahoe 1-5" with line,"Tahoe-NewRenoDelay" using 1:3 lw 6 lt 1 lc rgb "green" title "NewReno 3-5" with line
set output
