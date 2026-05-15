#!/usr/bin/env bash
#SBATCH --job-name=micov_coverage
#SBATCH --output=../output_files/micov_%j.out
#SBATCH --error=../output_files/micov_%j.err
#SBATCH --time=02:00:00
#SBATCH --mem=120G
#SBATCH -N 1
#SBATCH -c 8

# Calculate genome coverage summaries for Qiita shotgun metagenomic coverage archives.
#
# Usage:
#   sbatch scripts/1_calculating_coverages_micov.sh
#
# Before running, update the variables below for your compute environment.

set -euo pipefail

# Conda environment containing micov.
CONDA_ENV="micov3.12"

# Path to WoL genome length map.
LENGTH_MAP="/path/to/wol2/genomes/length.map"

# Output directory for micov coverage files.
OUTPUT_DIR="../output_files"
mkdir -p "${OUTPUT_DIR}"

# Qiita coverage archives used in this analysis.
QIITA_COVERAGES=(
  "/path/to/qiita_data/BIOM/227469/coverages.tgz"
  "/path/to/qiita_data/BIOM/227485/coverages.tgz"
  "/path/to/qiita_data/BIOM/227486/coverages.tgz"
  "/path/to/qiita_data/BIOM/227494/coverages.tgz"
)

# Activate conda environment. This assumes conda is initialized on the cluster.
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "${CONDA_ENV}"

micov_args=(
  qiita-coverage
  --lengths "${LENGTH_MAP}"
  --output "${OUTPUT_DIR}"
)

for coverage_archive in "${QIITA_COVERAGES[@]}"; do
  micov_args+=(--qiita-coverages "${coverage_archive}")
done

micov "${micov_args[@]}"
