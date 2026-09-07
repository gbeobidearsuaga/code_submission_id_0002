#! /bin/bash
#
#
#SBATCH --job-name=hw_exceed
#SBATCH --partition=compute
#SBATCH --time=8:00:00
#SBATCH --output=comment_hw_exceed_%j.log
#SBATCH --error=error_hw_exceed_%j.log
#SBATCH --mail-type=FAIL
#SBATCH --account=uo1075

module load cdo

r_start=1 #1 #start run
r_end=16 #16 #end run

for r_id in $(seq ${r_start} ${r_end}); do echo "select run: $r_id"
	pwd_in=/work/uo1075/decadal_system_mpi-esm-lr_enkf/mpiesm-1.2.01p5/experiments/asSEIKERAf_r${r_id}i8p4-LR/outdata/mpiom/
	file_in=asSEIKERAf_r${r_id}i8p4-LR_mpiom_data_2d_mm_*.nc

	pwd_out=/work/uo1075/u241308/ML_infilling/sst/
	file_out=asseikeraf_sst_r${r_id}i8p4_360x180.nc

	cdo mergetime ${pwd_in}${file_in} ${pwd_out}temp1.nc
	cdo -remapbil,r360x180 -selvar,tos ${pwd_out}temp1.nc ${pwd_out}${file_out}
	
	rm ${pwd_out}temp1.nc
done
cdo merge ${pwd_out}asseikeraf_sst_r*i8p4_360x180.nc ${pwd_out}asseikeraf_sst_r${r_start}-${r_end}i8p4_360x180.nc
