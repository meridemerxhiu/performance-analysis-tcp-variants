#!/bin/sh
set title "Vonesa"
set xlabel "CBR (Mbps)"
set xrange [0:7]
set xtics 0,1,7
set ylabel "Vonesa (ms)"
set yrange [11:12]
set ytics    11,0.1,12
set key right
set grid
set terminal postscript eps "Helvetica" 20 color
set output "Delay.eps"
plot "v-Tahoe" using 1:2 lw 6 lt 1 lc rgb "blue" title "VonesaTahoe" with line,"v-Linux" using 1:2 lw 6 lt 1 lc rgb "green" title "VonesaLinux" with line,"v-NReno" using 1:2 lw 6 lt 1 lc rgb "red" title "VonesaNewReno" with line,"v-Vegas" using 1:2 lw 6 lt 1 lc rgb "yellow" title "Vonesa-Vegas" with line
set output

