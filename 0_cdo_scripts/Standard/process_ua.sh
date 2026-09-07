#! /bin/bash
#
#
#SBATCH --job-name=ua_process
#SBATCH --partition=compute
#SBATCH --time=8:00:00
#SBATCH --output=comment_ua_process_%j.log
#SBATCH --error=error_ua_process_%j.log
#SBATCH --mail-type=FAIL
#SBATCH --account=uo1075

module load cdo

r_start=1 #1 #start run
r_end=16 #16 #end run

y_start=1960 #1958 #start yeat
y_end=2020 #end year
sel_lead_years=3 #number of selected lead years
var=ua

for y_id in $(seq ${y_start} ${y_end}); do echo "selected year: $y_id"
        for r_id in $(seq ${r_start} ${r_end}); do echo "select run: $r_id"
                pwd_original=/work/uo1075/decadal_system_mpi-esm-lr_enkf/mpiesm-1.2.01p7-levante/experiments/dkfen4${y_id}_r${r_id}i2p2-LR/outdata/echam6/
		file_original1=dkfen4${y_id}_r${r_id}i2p2-LR_echam6_100yr_mm_${y_id}.nc
                file_original2=dkfen4${y_id}_r${r_id}i2p2-LR_echam6_100yr_mm_$((y_id + 1)).nc
                file_original3=dkfen4${y_id}_r${r_id}i2p2-LR_echam6_100yr_mm_$((y_id + 2)).nc

		pwd_out=/work/uo1075/u241308/data_python_PostDoc/ML_assimilation/${var}_benchmark/processed/
		file_out=${var}_${y_id}_r${r_id}i2p2-LR_${sel_lead_years}_years_360x180.nc

		cdo mergetime ${pwd_original}${file_original1} ${pwd_original}${file_original2} ${pwd_original}${file_original3} ${pwd_out}temp1.nc
		cdo remapbil,r360x180 -sellevel,85000,70000 -selvar,${var} ${pwd_out}temp1.nc ${pwd_out}${file_out}
		rm ${pwd_out}temp1.nc
	done
	cdo merge ${pwd_out}${var}_${y_id}_r*i2p2-LR_${sel_lead_years}_years_360x180.nc ${pwd_out}${var}_${y_id}_r${r_start}-${r_end}i2p2-LR_${sel_lead_years}_years_360x180.nc
done
