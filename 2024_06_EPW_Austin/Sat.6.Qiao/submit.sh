#!/bin/bash
#SBATCH --job-name=ex1
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --hint=nomultithread
#SBATCH --output=slurm.out
#SBATCH --error=slurm.err
## only on TACC machine
#SBATCH -A DMR23030
#SBATCH -p small
#SBATCH --reservation=DMR23030_June_15

module use /work2/05193/sabyadk/stampede3/EPWSchool2024/autowan/modulefiles
module load autowan

# for TACC machine, use ibrun instead of mpirun, e.g.
ibrun pw.x -inp graphene.scf.in > graphene.scf.out
ibrun wannier90.x silicon.win
