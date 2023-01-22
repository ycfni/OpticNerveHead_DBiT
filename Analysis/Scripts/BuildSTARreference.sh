#!/bin/bash
#SBATCH --partition=general
#SBATCH --job-name=stpipeline
#SBATCH --cpus-per-task=12
#SBATCH --mem=64G
#SBATCH --time=72:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=marcello.distasio@yale.edu

module load STAR


mdkir -p `pwd`/../../ReferenceFiles/hg38_STAR
OUTDIR=`pwd`/../../ReferenceFiles/hg38_STAR

GENOMEDIR="/gpfs/ycga/datasets/genomes/Homo_sapiens/NCBI/GRCh38/"

STAR --runThreadN 11 --runMode genomeGenerate --genomeDir $OUTDIR --genomeFastaFiles $GENOMEDIR/Sequence/WholeGenomeFasta/genome.fa --sjdbGTFfile $GENOMEDIR/Annotation/Genes/genes.gtf 

# Link the annotations to a local folder to simplify the st_pipeline submission script
ln -s /gpfs/ycga/datasets/genomes/Homo_sapiens/NCBI/GRCh38/Annotation/Genes/genes.gtf `pwd`/../../ReferenceFiles/genes.gtf
