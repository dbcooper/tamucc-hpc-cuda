#!/bin/bash

# Run on one gpu node w/ a four hour timelimit

#SBATCH --job-name=vectoradd_gpu
#SBATCH --output=vectoradd.out
#SBATCH --error=vectoradd.err
#SBATCH --partition=gpu
#SBATCH -N 1
#SBATCH -t 04:00:00
#SBATCH --gres="gpu:1"

# I assume you already compiled vectoradd.cu with nvcc
./vectoradd
