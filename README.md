Scripts for “Uncovering hidden seasonal predictive skill under sparse observational constraints”

by Goratz Beobide-Arsuaga (goratz.beobide.arsuaga@uni-hamburg.de)

Download data from:

    ERA5 => Copernicus Climate Data Store (https://cds.climate.copernicus.eu/).
    EN4 => Met Office website (https://www.metoffice.gov.uk/hadobs/en4/download.html)
    Standard hindcast => World Data Centre for Climate, on the following website (https://hdl.handle.net/21.14106/098c6104e3d89943248aa61ff69db972adb3baf6).
    Hybrid-ML hindcast => World Data Centre for Climate, on the following website (https://hdl.handle.net/21.14106/61a65555786bc8b1ff065214ad9485e20e0fe35f).

Data processing with CDO (scripts in 0_cdo_files).

    Files are merged over the time dimension and linearly regridded to 1° spatial resolution.

Computing anomalies (1_compute_anomalies).

    We compute anomalies relative to 1985-2014 reference period. For Hybrid-ML and Standard, the climatology is computed using the assimilation output. 

Scripts for the analysis and figures (2_analysis_and_figures)
