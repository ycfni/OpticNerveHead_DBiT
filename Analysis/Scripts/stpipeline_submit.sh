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
FW=`pwd`/../../data/Undetermined_S0_L002_R1_001_filtered.fastq.gz
RV=`pwd`/../../data/Undetermined_S0_L002_R2_001_filtered.fastq.gz

# References for mapping, annotation and nonRNA-filtering
MAP=`pwd`/../../ReferenceFiles/hg38_STAR/
ANN=`pwd`/../../ReferenceFiles/genes.gtf

# Barcodes settings
ID=`pwd`/../spatial_barcodes_index.txt 

# Output folder and experiment name
PATH_TO_OUTPUT=`pwd`/../Results/
OUTPUT=$PATH_TO_OUTPUT/st_pipeline_out/
mkdir -p $OUTPUT

PATH_TO_TEMP=`pwd`/../tmp/
TMP=$PATH_TO_TEMP/st_pipeline_tmp/
mkdir -p $TMP


# EXP is the experiment name Do not add / or \ to the experiment name
EXP=ONH_001

# Running the pipeline
st_pipeline/scripts/st_pipeline_run.py \
  --output-folder $OUTPUT \
  --ids $ID \
  --ref-map $MAP \
  --ref-annotation $ANN \
  --expName $EXP \
  --htseq-no-ambiguous \
  --verbose \
  --log-file $OUTPUT/${EXP}_log.txt \
  --temp-folder $TMP \
  --no-clean-up \
  --umi-start-position 16 \
  --umi-end-position 26 \
  --min-length-qual-trimming 10 \
  $FW $RV
