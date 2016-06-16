#PBS -o out.txt
#PBS -e err.txt
#PBS -lnodes=1:ppn=16:gpu,walltime=72:00:00

cd $PBS_O_WORKDIR
cp /dev/null err.txt
cp /dev/null out.txt
make -j 2
