#!/bin/bash
#SBATCH --chdir=/home/lakhatib/ADRC_plasma/clean_scripts/scripts
#SBATCH --output=/home/lakhatib/ADRC_plasma/clean_scripts/output_files/micov.out
#SBATCH --time 2:00:00
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user="lakhatib@ucsd.edu"
#SBATCH --mem 120G
#SBATCH -N 1
#SBATCH -c 8

source activate micov3.12

micov qiita-coverage \
    --lengths /projects/wol/qiyun/wol2/genomes/length.map \
    --output ../output_files/ \
    --qiita-coverages /qmounts/qiita_data/BIOM/227469/coverages.tgz \
    --qiita-coverages /qmounts/qiita_data/BIOM/227485/coverages.tgz \
    --qiita-coverages /qmounts/qiita_data/BIOM/227486/coverages.tgz \
    --qiita-coverages /qmounts/qiita_data/BIOM/227494/coverages.tgz \
    







