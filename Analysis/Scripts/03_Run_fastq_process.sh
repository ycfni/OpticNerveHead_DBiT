#!/bin/bash
#SBATCH --partition=general
#SBATCH --job-name=fastq_process
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

FW_orig=`pwd`/../../data/A22-1834_slide3/raw/usftp21.novogene.com/01.RawData/A221834_ON2/A221834_ON2_CKDL230007519-1A_H3NY2DSX7_L2_2.fq.gz

python ../Python/fastq_process.py -i $FW_orig
