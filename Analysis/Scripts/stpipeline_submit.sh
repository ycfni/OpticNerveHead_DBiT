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
MAP=`pwd`/../../ReferenceFiles/
ANN=`pwd`/../../ReferenceFiles/

############################## SGZ: COPY FILES INTO HIS REPO and fix these paths for Rawdata_processing (copy in this OpticNerveHead_DBiT repo)

#converttoname_mmd.
#converttoname_mmd.
#converttoname.sh  
#fastq_process.py  
#PATH_TO_OUTPUT    
#PATH_TO_TEMP      
#spatial_barcodes_i
#stpipeline_mmd.sh 
#stpipeline.sh     
#stpipeline.sh.orig




# Barcodes settings
#PATH_TO_BARCODE_INDEX=$HOME/Workspace/DBiT-seq_FFPE/Rawdata_processing
PATH_TO_BARCODE_INDEX=$HOME/scratch60/mmdstp/DBiT_seq_FFPE_example/Rawdata_processing
ID=`pwd`/../spatial_barcodes_index.txt 
#ID=spatial_barcodes_index.txt


# 

# Output folder and experiment name
#PATH_TO_OUTPUT=$HOME/Workspace/DBiT-seq_FFPE/data/output
PATH_TO_OUTPUT=$HOME/scratch60/mmdstp/DBiT_seq_FFPE_example/data/output
#PATH_TO_OUTPUT=$HOME/yard/mmdstp/data_sgz/output
OUTPUT=$PATH_TO_OUTPUT/st_pipeline_new/
mkdir -p $OUTPUT

#PATH_TO_TEMP=$HOME/Workspace/DBiT-seq_FFPE/data/tmp
#PATH_TO_TEMP=$HOME/yard/mmdstp/data_sgz/tmp
PATH_TO_TEMP=$HOME/scratch60/mmdstp/DBiT_seq_FFPE_example/data/tmp
TMP=$PATH_TO_TEMP/st_pipeline_new/tmp
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
