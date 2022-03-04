#!/bin/sh
set title "Throughput"
set xlabel "Koha (s)"
set xrange [0:50]
set xtics 0,5,50
set ylabel "Throughput (Mbps)"
set yrange [1:5]
set ytics    1,0.4,5
set key right
set grid
set terminal postscript eps "Helvetica" 20 color
set output "throughput.eps"
plot "NR-DRR" using 1:2 lw 6 lt 1 lc rgb "red" title "NewReno DRR TCP" with line,"NR-DRR" using 1:3 lw 6 lt 1 lc rgb "blue" title "NewReno DRR CBR" with line, "NR-SFQ" using 1:2 lw 6 lt 1 lc rgb "green" title "NewReno SFQ TCP" with line,"NR-SFQ" using 1:3 lw 6 lt 1 lc rgb "yellow" title "NewReno SFQ CBR" with line
set output
