#!/bin/bash

# Run on one gpu node w/ a four hour timelimit

#SBATCH --job-name=vectoradd_par
#SBATCH --output=vectoradd_par.out
#SBATCH --error=vectoradd_par.err
#SBATCH --partition=gpu
#SBATCH -N 1
#SBATCH -t 04:00:00
#SBATCH --gres="gpu:1"

# Output the time taken for execution (stderr)
time ./vectoradd_par
