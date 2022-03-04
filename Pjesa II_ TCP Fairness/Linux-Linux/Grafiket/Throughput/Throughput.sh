#!/bin/sh
set title "Throughput"
set xlabel "BW (Mbps)"
set xrange [1:7]
set xtics 1,1,7
set ylabel "throughput (kbps)"
set yrange [0:15350]
set ytics    0,1000,15350
set key right
set grid
set terminal postscript eps "Helvetica" 20 color
set output "Throughput Linux-Linux"
plot "throughputLinux" using 1:2 lw 6 lt 1 lc rgb "blue" title "Linux 1-5" with line,"throughputLinux" using 1:3 lw 6 lt 1 lc rgb "green" title "Linux 3-5" with line,
