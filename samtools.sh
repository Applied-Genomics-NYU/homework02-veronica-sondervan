#!/bin/sh
#
#SBATCH --verbose
#SBATCH --job-name=sam2bam
#SBATCH --output=sam2bam.slurm_%j.out
#SBATCH --error=sam2bam.slurm_%j.err
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --mem=4GB

module load samtools/intel/1.9

for FILE in *.sam; do
samtools view -bS $FILE > ${FILE::-3}bam;
done
