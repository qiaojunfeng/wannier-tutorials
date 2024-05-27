#!/usr/bin/env -S gnuplot -p
set terminal pdf enhanced color dashed lw 1 size 6in,6in
set output "silicon_bandsdiff_val.pdf"
set size ratio 1
fermi = 6.7332
# set style data dots
set key
set xrange [0: 5.22358]
set yrange [ (-6.69831 - fermi) : (17.5 - fermi)]
set arrow from  1.16407,  (-6.69831 - fermi) to  1.16407,  (17.5 - fermi) nohead
set arrow from  1.57563,  (-6.69831 - fermi) to  1.57563,  (17.5 - fermi) nohead
set arrow from  2.81031,  (-6.69831 - fermi) to  2.81031,  (17.5 - fermi) nohead
set arrow from  3.81842,  (-6.69831 - fermi) to  3.81842,  (17.5 - fermi) nohead
set arrow from  4.64154,  (-6.69831 - fermi) to  4.64154,  (17.5 - fermi) nohead
set xtics ("G"  0.00000,  "X"  1.16407,  "U|K"  1.57563,  "G"  2.81031, \
           "L"  3.81842,  "W"  4.64154,  "X"  5.22358)
# scale QE x-axis to be consistent with w90
plot "silicon_band.dat" u 1:($2 - fermi) w l title "W90 valcond", \
     "val/silicon_band.dat" u 1:($2 - fermi) w l title "W90 val"
