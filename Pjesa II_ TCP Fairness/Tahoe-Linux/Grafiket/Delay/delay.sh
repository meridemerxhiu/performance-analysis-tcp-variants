#!/bin/sh
set title "Delay Tahoe-Linux"
set xlabel "BW (Mbps)"
set xrange [1:7]
set xtics 1,1,7
set ylabel "delay (ms)"
set yrange [11.3:11.5]
set ytics    11.3,0.05,11.5
set key right
set grid
set terminal postscript eps "Helvetica" 20 color
set output "Delay Tahoe-Linux"
plot "Tahoe-LinuxDelay" using 1:2 lw 6 lt 1 lc rgb "blue" title "Tahoe 1-5" with line,"Tahoe-LinuxDelay" using 1:3 lw 6 lt 1 lc rgb "green" title "Linux 3-5" with line
set output
