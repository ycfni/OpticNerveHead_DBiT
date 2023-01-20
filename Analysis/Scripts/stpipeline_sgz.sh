#!/bin/bash

# Set up enviroment such that st_pipeline_run.py is in $PATH
# module load Python/3.8.6-GCCcore-10.2.0 # This includes Cython


# NEED TO RUN OpticNerveHead_DBiT/Analysis/Python/fastq_process.py on *_[Read|R|]*2.fastq first
# FASTQ reads
FW=`pwd`/../data/__SAMPLENAME__pass1.fastq.gz
RV=`pwd`/../data/__SAMPLENAME__pass2.fastq.gz
#FW=PATH_TO_PROCESSED_R2/sample_R2_processed.fastq.gz
#RV=PATH_TO_R1/R1.fastq.gz
#FW=$HOME/scratch60/mmdstp/DBiT_seq_FFPE_example/data/fastq/SRR12515582_pass_2_processed.fastq.gz
#RV=$HOME/scratch60/mmdstp/DBiT_seq_FFPE_example/data/fastq/SRR12515582_pass_1.fastq.gz
#FW=$HOME/yard/mmdstp/data_sgz/tinygex_S1_L002_R2_001.fastq.gz
#RV=$HOME/yard/mmdstp/data_sgz/tinygex_S1_L002_R1_001.fastq.gz
#FW=$HOME/Workspace/DBiT-seq_FFPE/data/fastq/SRR12515582_pass_2_processed.fastq.gz
#RV=$HOME/Workspace/DBiT-seq_FFPE/data/fastq/SRR12515582_pass_1.fastq.gz


#####################  SGZ: NEED TO POINT TO HUMAN REF (i.e. GRCh38-3.0.0_premrna)


# References for mapping, annotation and nonRNA-filtering
#MAP=PATH_TO_ALIGNMENT_REF/Dropseq_Alignment_References/mm10/
#MAP=$HOME/yard/mmdstp/data_sgz/reference_genomes/mm10/index_star_chr6
MAP=$HOME/scratch60/mmdstp/DBiT_seq_FFPE_example/data/reference_genomes/mm10
#MAP=$HOME/Workspace/DBiT-seq_FFPE/data/reference_genomes/mm10
#ANN=PATH_TO_ALIGNMENT_REF_GTF/Dropseq_Alignment_References/mm10/mm10.gtf
#ANN=$HOME/yard/mmdstp/data_sgz/reference_genomes/mm10/genes.gtf
ANN=/gpfs/ycga/datasets/genomes/Mus_musculus/UCSC/mm10/Annotation/Genes/genes.gtf
#CONT=/gpfs/ycga/project/fan/yd279/Spatial_omics_references/mouse/GRCm38_86/ncRNA/StarIndex/


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
