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

simulation=mpiesm-1.2.01p7-levante
physics=3
r_start=1 #1 #start run
r_end=16 #16 #end run

y_start=1958 #1958 #start yeat
y_end=2020 #end year

for y_id in $(seq ${y_start} ${y_end}); do echo "selected year: $y_id"
        for r_id in $(seq ${r_start} ${r_end}); do echo "select run: $r_id"
		pwd_original=/work/uo1075/u241308/${simulation}/experiments/dmlen4${y_id}_r${r_id}i2p${physics}-LR/outdata/mpiom/
                file_original=dmlen4${y_id}_r${r_id}i2p${physics}-LR_mpiom_data_2d_mm_*.nc

		pwd_out=/work/uo1075/u241308/${simulation}/proccessed_output/sst/
		file_out=sst_${y_id}_r${r_id}i2p${physics}-LR_26_months_360x180.nc

		cdo mergetime ${pwd_original}${file_original} ${pwd_out}temp1.nc
		cdo remapbil,r360x180 -selvar,tos ${pwd_out}temp1.nc ${pwd_out}${file_out}
		rm ${pwd_out}temp1.nc
	done
	cdo merge ${pwd_out}sst_${y_id}_r*i2p${physics}-LR_26_months_360x180.nc ${pwd_out}sst_${y_id}_r${r_start}-${r_end}i2p${physics}-LR_26_months_360x180.nc
done
