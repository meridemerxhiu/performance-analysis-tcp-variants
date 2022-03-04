#!/bin/sh
set title "Throughput"
set xlabel "Koha (s)"
set xrange [0:50]
set xtics 0,5,50
set ylabel "Throughput (Mbps)"
set yrange [1:4.2]
set ytics 1,0.4,4.2
set key right
set grid
set terminal postscript eps "Helvetica" 20 color
set output "throughput.eps"
plot "L-DRR" using 1:2 lw 6 lt 1 lc rgb "red" title "Linux DRR TCP" with line,"L-DRR" using 1:3 lw 6 lt 1 lc rgb "blue" title "Linux DRR CBR" with line, "L-SFQ" using 1:2 lw 6 lt 1 lc rgb "green" title "Linux SFQ TCP" with line,"L-SFQ" using 1:3 lw 6 lt 1 lc rgb "yellow" title "Linux SFQ CBR" with line
set output
