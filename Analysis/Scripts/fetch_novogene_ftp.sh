#!/bin/bash
#SBATCH --job-name=NovogeneFetch
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=24:00:00
#SBATCH --mail-type=ALL
#SBATCH -o slurm-%j.out

HOST="ftp://usftp21.novogene.com"
USER="X202SC23012940-Z01-F002"
PASSWORD="1ewpf7j3"

wget -r --user=$USER --password=$PASSWORD $HOST

