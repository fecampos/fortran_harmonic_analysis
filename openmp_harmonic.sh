#!/bin/sh 
#SBATCH --job-name=harmonic

#SBATCH --partition=mpi_long2

#SBATCH --ntasks=20 

#SBATCH --cpus-per-task=1

export OMP_NUM_THREADS=20

date
./jobcomp
date
