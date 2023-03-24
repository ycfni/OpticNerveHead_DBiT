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
RV=`pwd`/../../data/A22-1834_slide3/raw/usftp21.novogene.com/01.RawData/A221834_ON2/A221834_ON2_CKDL230007519-1A_H3NY2DSX7_L2_1.fq.gz
FW=`pwd`/../../data/A22-1834_slide3/raw/usftp21.novogene.com/01.RawData/A221834_ON2/A221834_ON2_CKDL230007519-1A_H3NY2DSX7_L2_2_processed.fastq.gz

# References for mapping, annotation and nonRNA-filtering
MAP=`pwd`/../../ReferenceFiles/hg38_STAR/
ANN=`pwd`/../../ReferenceFiles/genes.gtf

# Barcodes settings
ID=`pwd`/../Library/spatial_barcodes_index_51_100.txt 

# Output folder and experiment name
PATH_TO_OUTPUT=`pwd`/../../data/A22-1834_slide3/processed/
OUTPUT=$PATH_TO_OUTPUT/st_pipeline_out/
mkdir -p $OUTPUT

PATH_TO_TEMP=`pwd`/../../data/tmp/
TMP=$PATH_TO_TEMP/st_pipeline_tmp/
mkdir -p $TMP

# EXP is the experiment name Do not add / or \ to the experiment name
EXP=ONH_A22-1834_S3

# Running the pipeline
st_pipeline_run.py \
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
