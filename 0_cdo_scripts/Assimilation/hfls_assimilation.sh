#! /bin/bash
#
#
#SBATCH --job-name=hfls
#SBATCH --partition=compute
#SBATCH --time=8:00:00
#SBATCH --output=comment_hfls_%j.log
#SBATCH --error=error_hfls_%j.log
#SBATCH --mail-type=FAIL
#SBATCH --account=uo1075

module load cdo

r_start=1 #1 #start run
r_end=16 #16 #end run

for r_id in $(seq ${r_start} ${r_end}); do echo "select run: $r_id"
	pwd_in=/work/uo1075/decadal_system_mpi-esm-lr_enkf/data/MPI-ESM1-2-LR/asSEIKERAf/Amon/ahfl/r${r_id}i8p4/
	file_in=ahfl_Amon_MPI-ESM-LR_asSEIKERAf_r${r_id}i8p4_195801-202010.nc

	pwd_out=/work/uo1075/u241308/ML_infilling/hfls/
	file_out=asseikeraf_hfls_r${r_id}i8p4_360x180.nc

	cdo -remapbil,r360x180 ${pwd_in}${file_in} ${pwd_out}${file_out}

done
cdo merge ${pwd_out}asseikeraf_hfls_r*i8p4_360x180.nc ${pwd_out}asseikeraf_hfls_r${r_start}-${r_end}i8p4_360x180.nc
