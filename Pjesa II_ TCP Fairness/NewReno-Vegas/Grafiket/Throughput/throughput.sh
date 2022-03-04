#!/bin/sh
set title "Throughput"
set xlabel "BW (Mbps)"
set xrange [1:7]
set xtics 1,1,7
set ylabel "throughput (kbps)"
set yrange [0:18000]
set ytics    0,1000,18000
set key right
set grid
set terminal postscript eps "Helvetica" 20 color
set output "Throughput NewReno-Vegas"
plot "NewReno-VegasThroughput" using 1:2 lw 6 lt 1 lc rgb "blue" title "Newreno 1-5" with line,"NewReno-VegasThroughput" using 1:3 lw 6 lt 1 lc rgb "green" title "Vegas 3-5" with line
set output
