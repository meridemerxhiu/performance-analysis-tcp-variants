#!/bin/sh
set title "Droprate Linux-Linux"
set xlabel "BW (Mbps)"
set xrange [1:7]
set xtics 1,1,7
set ylabel "droprate (%)"
set yrange [0:16]
set ytics 0,1,16
set key right
set grid
set terminal postscript eps "Helvetica" 20 color
set output "DropRate Linux-Linux"
plot "dropLinux" using 1:2 lw 6 lt 1 lc rgb "blue" title "Linux 1-5" with line,"dropLinux" using 1:3 lw 6 lt 1 lc rgb "green" title "Linux 3-5" with line,
