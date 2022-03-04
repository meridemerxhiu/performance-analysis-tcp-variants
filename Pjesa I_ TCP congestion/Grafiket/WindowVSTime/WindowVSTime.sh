#!/bin/sh
set title "WindowVSTime"
set xlabel "Koha"
set xrange [0:60]
set xtics 0,10,60
set ylabel "Dritarja"
set yrange [0:50]
set ytics    0,25,20
set key right
set grid
set terminal postscript eps "Helvetica" 20 color
set output "Window.eps"
plot "WindowVsTime_Vegas" using 1:2 lw 6 lt 1 lc rgb "orange" title "Vegas" with line,"WindowVsTime_Linux" using 1:2 lw 6 lt 1 lc rgb "blue" title "Linux" with line,"WindowVsTime_NewReno" using 1:2 lw 6 lt 1 lc rgb "red" title "NewReno" with line,"WindowVsTime_Tahoe" using 1:2 lw 6 lt 1 lc rgb "green" title "Tahoe" with line
set output
