#!/bin/bash
#
#SBATCH --verbose
#SBATCH --job-name=salmon
#SBATCH --output=salmon.slurm_%j.out
#SBATCH --error=salmon.slurm_%j.err
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=4GB

module load salmon/1.0.0

salmon index -t /scratch/work/jupyterhub/2020-SP-BIOL-GA.1130-001/class_share/homework02/athal.fa.gz -i athal_index
for FILE in /scratch/work/jupyterhub/2020-SP-BIOL-GA.1130-001/class_share/homework02/*1.fastq; do
FILE2=`echo $FILE | sed 's/subset_1/subset_2/'`;
ID=`echo $FILE | grep -o "SRR[0-9]*"`;
echo $FILE2; echo $ID;
salmon quant -i athal_index -l A -1 ${FILE} -2 ${FILE2} -p 8 --validateMappings -o quants/${ID}
done
