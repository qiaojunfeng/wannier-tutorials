#!/bin/bash
#SBATCH --job-name=ex1
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --partition=skx
#SBATCH --hint=nomultithread
#SBATCH --output=slurm.out
#SBATCH --error=slurm.err

module use ~/modulefiles
module load autowan

# for TACC machine, use ibrun instead of mpirun, e.g.
ibrun pw.x -inp graphene.scf.in > graphene.scf.out
ibrun wannier90.x silicon.win
