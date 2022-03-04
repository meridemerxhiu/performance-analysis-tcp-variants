#!/bin/sh
set title "Droprate"
set xlabel "CBR (Mbps)"
set xrange [1:7]
set xtics 1,1,7
set ylabel "Drop-Rate (%)"
set yrange [0:30]
set ytics    0,2,30
set key right
set grid
set terminal postscript eps "Helvetica" 20 color
set output "drop.eps"
plot "droprate-Tahoe" using 1:2 lw 6 lt 1 lc rgb "pink" title "DropTahoe" with line,"droprate-NReno" using 1:2 lw 6 lt 1 lc rgb "orange" title "DropNewReno" with line,"droprate-Linux" using 1:2 lw 6 lt 1 lc rgb "purple" title "DropLinux" with line,"droprate-Vegas" using 1:2 lw 6 lt 1 lc rgb "black" title "DropVegas" with line
set output
