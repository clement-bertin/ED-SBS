#!/bin/bash

# -------------------------------------------
# Create Symbol links to mac270 forcings
# -------------------------------------------
ln -sf /nobackup/cbertin/ED-SBS_LR/darwin3/darwin3_v69a/builds/build_v4.0/mitgcmuv .
ln -sf /nobackup/hzhang1/forcing/era_xx .
ln -sf /nobackup/cbertin/ED-SBS_LR/forcings/river_runoff/freshwater/AGRO_interan .
ln -sf /nobackup/cbertin/ED-SBS_LR/forcings/river_runoff/freshwater/Tokuda_ED-SBS .

ln -sf /nobackup/cbertin/ED-SBS_LR/forcings/river_runoff/nutrients/mmol_m2/Bertin_DOC/L50_R48_C2/tDOCl .
ln -sf /nobackup/cbertin/ED-SBS_LR/forcings/river_runoff/nutrients/mmol_m2/Bertin_DOC/L50_R48_C2/tDOCr .
ln -sf /nobackup/cbertin/ED-SBS_LR/forcings/river_runoff/nutrients/mmol_m2/Bertin_DOC/L50_R48_C2/tDOCc .
ln -sf /nobackup/cbertin/ED-SBS_LR/forcings/river_runoff/nutrients/mmol_m2/Tank_DIC/tAlk .
ln -sf /nobackup/cbertin/ED-SBS_LR/forcings/river_runoff/nutrients/mmol_m2/Tank_DIC/tDIC .
ln -sf /nobackup/cbertin/ED-SBS_LR/forcings/river_runoff/nutrients/mmol_m2/AGRO_nutclim/tDON .
ln -sf /nobackup/cbertin/ED-SBS_LR/forcings/river_runoff/nutrients/mmol_m2/AGRO_nutclim/tDOP .
ln -sf /nobackup/cbertin/ED-SBS_LR/forcings/river_runoff/nutrients/mmol_m2/AGRO_nutclim/tDSi .

# -------------------------------------------
# link to run_template files
# -------------------------------------------
ln -sf /nobackup/cbertin/ED-SBS_LR/forcings/run_template/ED-SBSv4/* .
ln -sf /nobackup/cbertin/ED-SBS_LR/forcings/run_template/ED-SBSv4/eta_adjust/OBWu_Mac_46x68.bal_ROFF OBWu_Mac_46x68.balance
# -------------------------------------------
# copy data files
# -------------------------------------------
cp /nobackup/cbertin/ED-SBS_LR/configs/setup_files_v4.0/input/* .
cp /nobackup/cbertin/ED-SBS_LR/configs/job_mac270_bro .
# -------------------------------------------
# Make diags directory
# -------------------------------------------
mkdir diags diags/monthly
