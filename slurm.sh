#!/bin/bash
#SBATCH -o out.txt
#SBATCH -J myjob
#SBATCH -t 24:00:00
#SBATCH --gres=gpu:1
make -j 2
