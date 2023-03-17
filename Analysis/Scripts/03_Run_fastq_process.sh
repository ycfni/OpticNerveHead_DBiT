#!/bin/bash
#SBATCH --partition=general
#SBATCH --job-name=stpipeline
#SBATCH --cpus-per-task=12
#SBATCH --mem=64G
#SBATCH --time=72:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=marcello.distasio@yale.edu

# Set up enviroment such that st_pipeline_run.py is in $PATH

# NOTE: Load miniconda module if you need the job to have access to a particular conda environment
# (uncomment if needed)
module load miniconda
conda init

conda activate stpipeline

# NEED TO RUN OpticNerveHead_DBiT/Analysis/Python/fastq_process.py on *_[Read|R|]*2.fastq first
# FASTQ reads

FW_orig=`/../../data/raw/Undetermined_S0_L002_R2.fq.gz"

python ../Python/fastq_process.py $FW_orig
