#!/bin/sh
set title "Throughput"
set xlabel "CBR (Mbps)"
set xrange [1:7]
set xtics 1,1,7
set ylabel "Throughput (Mbps)"
set yrange [0:10]
set ytics    0,1,10
set key right
set grid
set terminal postscript eps "Helvetica" 20 color
set output "throughput.eps"
plot "th-V" using 1:2 lw 6 lt 1 lc rgb "orange" title "Throughput-Vegas" with line,"th-L" using 1:2 lw 6 lt 1 lc rgb "blue" title "Throughput-Linux" with line,"th-NR" using 1:2 lw 6 lt 1 lc rgb "red" title "Throughput-NewReno" with line,"th-T" using 1:2 lw 6 lt 1 lc rgb "green" title "Throughput-Tahoe" with line
set output
