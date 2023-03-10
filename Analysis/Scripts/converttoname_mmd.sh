tsv_E=$HOME/Workspace/DBiT-seq_FFPE/data/output/st_pipeline_new/FFPE-2_stdata.tsv

path_to_annotation_file=/gpfs/ycga/datasets/genomes/Mus_musculus/UCSC/mm10/Annotation/Genes/genes.gtf 

convertEnsemblToNames.py $tsv_E --annotation $path_to_annotation_file --output $HOME/Workspace/DBiT-seq_FFPE/data/output/st_pipeline_new/3t3_exp_matrix.tsv

