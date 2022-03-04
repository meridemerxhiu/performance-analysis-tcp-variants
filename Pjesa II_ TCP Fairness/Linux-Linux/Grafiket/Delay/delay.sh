#!/bin/sh
set title "Delay Linux-Linux"
set xlabel "BW (Mbps)"
set xrange [1:7]
set xtics 1,1,7
set ylabel "delay (ms)"
set yrange [11.35:11.45]
set ytics    11.35,0.01,11.45
set key right
set grid
set terminal postscript eps "Helvetica" 20 color
set output "Delay Linux-Linux"
plot "delayLinux" using 1:2 lw 6 lt 1 lc rgb "blue" title "Linux 1-5" with line,"delayLinux" using 1:3 lw 6 lt 1 lc rgb "green" title "Linux 3-5" with line,
