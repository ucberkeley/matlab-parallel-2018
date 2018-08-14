#!/bin/bash
# Job name:
#SBATCH --job-name=test
#
# Account:
#SBATCH --account=fc_paciorek
#
# Partition:
#SBATCH --partition=savio
#
# Number of tasks (e.g., number of MATLAB workers, here 2 nodes worth)
#SBATCH --ntasks=40
#
# MATLAB licenses
#SBATCH --licenses=mdcs:40
#
# Wall clock limit (30 minutes here):
#SBATCH --time=00:30:00
#
## Command(s) to run:
module load matlab
export MDCE_OVERRIDE_EXTERNAL_HOSTNAME=$(/bin/hostname -f)
matlab -nodisplay -nosplash -nodesktop < helloworld_parallel.m
