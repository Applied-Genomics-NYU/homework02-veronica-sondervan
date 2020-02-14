#!/bin/bash
#
#SBATCH --verbose
#SBATCH --job-name=HiSAT2
#SBATCH --output=HiSAT2.slurm_%j.out
#SBATCH --error=HiSAT2.slurm_%j.err
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=4GB

module load hisat2/intel/2.0.5

##hisat2-build /scratch/work/jupyterhub/2020-SP-BIOL-GA.1130-001/class_share/homework02/Arabidopsis.fa At_index
for FILE in /scratch/work/jupyterhub/2020-SP-BIOL-GA.1130-001/class_share/homework02/*1.fastq; do
FILE2=`echo $FILE | sed 's/subset_1/subset_2/'`;
ID=`echo $FILE | grep -o "SRR[0-9]*"`;
echo $FILE2; echo $ID;
hisat2 -p 8 -x At_index -1 ${FILE} -2 ${FILE2} -S ${ID}.sam
done
