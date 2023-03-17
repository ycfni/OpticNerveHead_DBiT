#Output of st_pipeline:
tsv_E=`pwd`/../../data/MY_SAMPLE/processed/st_pipeline_out/___stdata.tsv

path_to_annotation_file=/gpfs/ycga/datasets/genomes/Mus_musculus/UCSC/mm10/Annotation/Genes/genes.gtf 

convertEnsemblToNames.py $tsv_E --annotation $path_to_annotation_file --output `pwd`/../../data/MY_SAMPLE/processed/st_pipeline_out/___stdata_renamed.tsv

