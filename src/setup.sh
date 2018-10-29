compiler="gfortran"
flags="-O3 -frecord-marker=4 -fdefault-real-8"
rm -f *.o *.mod climate_simulation.run *.mod
${compiler} ${flags} -c systemparams.f90
${compiler} ${flags} -c *.f90
${compiler} ${flags} -o climate_simulation.run *.o

