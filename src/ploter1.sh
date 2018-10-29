#! /bin/bash

cd ./outputs/snapshots/
rm -f *.txt
rm -f *.png
m=$(ls|wc -l)
for i in `seq 1 $m`;
do
	cat $i >> all_data.txt
done

gnuplot << eof
set palette rgb 33,13,10
set pm3d map
set terminal postscript color
set autoscale x
set yrange[-89:89]
set output "TempratureProfile.eps"
set font "Times Roman,60"
set title 'Space Time diagram of earthlike planet'
set xlabel 'Time (Years)'
set ylabel 'Latitude'
splot "all_data.txt" u 1:2:3 notitle
set ou
eof

mv TempratureProfile.eps ../results/

cd ..
