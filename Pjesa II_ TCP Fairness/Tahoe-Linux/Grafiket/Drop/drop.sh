#!/bin/sh
set title "Droprate Tahoe-Linux"
set xlabel "BW (Mbps)"
set xrange [1:7]
set xtics 1,1,7
set ylabel "droprate (%)"
set yrange [0:10]
set ytics    0,0.5,10
set key right
set grid
set terminal postscript eps "Helvetica" 20 color
set output "Droprate Tahoe-Linux"
plot "Tahoe-LinuxDrop" using 1:2 lw 6 lt 1 lc rgb "blue" title "Tahoe 1-5" with line,"Tahoe-LinuxDrop" using 1:3 lw 6 lt 1 lc rgb "green" title "Linux 3-5" with line
set output
