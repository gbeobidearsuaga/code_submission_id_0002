#! /bin/bash
#
#
#SBATCH --job-name=sst_benchmark
#SBATCH --partition=compute
#SBATCH --time=8:00:00
#SBATCH --output=comment_sst_benchmark_%j.log
#SBATCH --error=error_sst_benchmark_%j.log
#SBATCH --mail-type=FAIL
#SBATCH --account=uo1075

module load cdo

r_start=1 #1 #start run
r_end=16 #16 #end run

y_start=1960 #1958 #start yeat
y_end=2021 #end year
sel_lead_years=3 #number of selected lead years

for y_id in $(seq ${y_start} ${y_end}); do echo "selected year: $y_id"
	y_lead=$((y_id + sel_lead_years))
        for r_id in $(seq ${r_start} ${r_end}); do echo "select run: $r_id"
		pwd_original=/work/uo1075/decadal_system_mpi-esm-lr_enkf/mpiesm-1.2.01p7-levante/experiments/dkfen4${y_id}_r${r_id}i2p2-LR/outdata/mpiom/
		file_original1=dkfen4${y_id}_r${r_id}i2p2-LR_mpiom_data_2d_mm_${y_id}1101_${y_id}1231.nc
                file_original2=dkfen4${y_id}_r${r_id}i2p2-LR_mpiom_data_2d_mm_$((y_id + 1))0101_$((y_id + 1))1231.nc
                file_original3=dkfen4${y_id}_r${r_id}i2p2-LR_mpiom_data_2d_mm_$((y_id + 2))0101_$((y_id + 2))1231.nc

		pwd_out=/work/uo1075/u241308/data_python_PostDoc/ML_assimilation/sst_benchmark/processed/
		file_out=sst_${y_id}_r${r_id}i2p2-LR_${sel_lead_years}_years_360x180.nc

		cdo mergetime ${pwd_original}${file_original1} ${pwd_original}${file_original2} ${pwd_original}${file_original3} ${pwd_out}temp1.nc
		cdo -remapbil,r360x180 -selvar,tos ${pwd_out}temp1.nc ${pwd_out}${file_out}
		rm ${pwd_out}temp1.nc
	done
	cdo merge ${pwd_out}sst_${y_id}_r*i2p2-LR_${sel_lead_years}_years_360x180.nc ${pwd_out}sst_${y_id}_r${r_start}-${r_end}i2p2-LR_${sel_lead_years}_years_360x180.nc
done
