#!/bin/sh
set title "Throughput"
set xlabel "Time (s)"
set xrange [0:50]
set xtics 0,5,50
set ylabel "Throughput (Mbps)"
set yrange [1:5]
set ytics    1,0.2,5
set key right
set grid
set terminal postscript eps "Helvetica" 20 color
set output "compALgorAndQueue.eps"
plot "TcpData" using 1:2 lw 6 lt 1 lc rgb "red" title "Linux DRR" with line,"TcpData" using 1:3 lw 6 lt 1 lc rgb "blue" title "Linux SFQ" with line, "TcpData" using 1:4 lw 6 lt 1 lc rgb "green" title "NewReno DRR" with line,"TcpData" using 1:5 lw 6 lt 1 lc rgb "yellow" title "NewReno SFQ" with line
set output
