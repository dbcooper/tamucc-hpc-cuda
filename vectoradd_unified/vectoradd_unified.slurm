#!/bin/bash

# Run on one gpu node w/ a four hour timelimit

#SBATCH --job-name=va_unified
#SBATCH --output=vectoradd_unified.out
#SBATCH --error=vectoradd_unified.err
#SBATCH --partition=gpu
#SBATCH -N 1
#SBATCH -t 04:00:00
#SBATCH --gres="gpu:1"

# Output the time taken for execution (stderr)
time ./vectoradd_unified
