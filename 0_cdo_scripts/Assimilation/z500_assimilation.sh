#! /bin/bash
#
#
#SBATCH --job-name=tas
#SBATCH --partition=compute
#SBATCH --time=8:00:00
#SBATCH --output=comment_tas_%j.log
#SBATCH --error=error_tas_%j.log
#SBATCH --mail-type=FAIL
#SBATCH --account=uo1075

module load cdo

r_start=1 #1 #start run
r_end=16 #16 #end run

for r_id in $(seq ${r_start} ${r_end}); do echo "select run: $r_id"
	pwd_in=/work/uo1075/decadal_system_mpi-esm-lr_enkf/data/MPI-ESM1-2-LR/asSEIKERAf/Amon/zg/r${r_id}i8p4/
	file_in=zg_Amon_MPI-ESM-LR_asSEIKERAf_r${r_id}i8p4_195801-202010.nc

	pwd_out=/work/uo1075/u241308/ML_infilling/z500/
	file_out=asseikeraf_z500_r${r_id}i8p4_360x180.nc

	cdo -remapbil,r360x180 -sellevel,50000 ${pwd_in}${file_in} ${pwd_out}${file_out}

done
cdo merge ${pwd_out}asseikeraf_z500_r*i8p4_360x180.nc ${pwd_out}asseikeraf_z500_r${r_start}-${r_end}i8p4_360x180.nc
