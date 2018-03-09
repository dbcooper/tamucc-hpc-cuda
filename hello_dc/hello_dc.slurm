#!/bin/bash

# Run on one gpu node w/ a four hour timelimit

#SBATCH --job-name=hellodc
#SBATCH --output=hellodc.out
#SBATCH --error=hellodc.err
#SBATCH --partition=gpu
#SBATCH -N 1
#SBATCH -t 04:00:00
#SBATCH --gres="gpu:1"

# I assume you've already compiled with nvcc
./hello_dc
