#!/bin/bash

# -------------------------------------------
# Create Symbol links to mac270 forcings
# -------------------------------------------
ln -sf /nobackup/cbertin/ED-SBS_LR/darwin3_v69a/builds/build_v3.0/mitgcmuv .
ln -sf /nobackup/hzhang1/forcing/era_xx .
ln -sf /nobackup/cbertin/ED-SBS_LR/forcings/river_runoff/Freshwater/r46/AGRO_interan .
ln -sf /nobackup/cbertin/ED-SBS_LR/forcings/river_runoff/Temperature/Tokuda_ED-SBS .

ln -sf /nobackup/cbertin/ED-SBS_LR/forcings/river_runoff/Nutrients/Bertin_etal_21/Interannual/r46/cdom/L50_R48_C2/tDOCl .
ln -sf /nobackup/cbertin/ED-SBS_LR/forcings/river_runoff/Nutrients/Bertin_etal_21/Interannual/r46/cdom/L50_R48_C2/tDOCr .
ln -sf /nobackup/cbertin/ED-SBS_LR/forcings/river_runoff/Nutrients/Bertin_etal_21/Interannual/r46/cdom/L50_R48_C2/tDOCc .
#ln -sf /nobackup/cbertin/ED-SBS_LR/forcings/river_runoff/Nutrients/Bertin_etal_21/Interannual/r46/L50_R50/tDOCc .
ln -sf /nobackup/cbertin/ED-SBS_LR/forcings/river_runoff/Nutrients/AGRO_Alk/AlkC/Interannual/r46/tAlk .
ln -sf /nobackup/cbertin/ED-SBS_LR/forcings/river_runoff/Nutrients/Tank_etal_12/Interannual/r46/tDIC .
ln -sf /nobackup/cbertin/ED-SBS_LR/forcings/river_runoff/Nutrients/AGRO_NutClim/r46/tDON .
ln -sf /nobackup/cbertin/ED-SBS_LR/forcings/river_runoff/Nutrients/AGRO_NutClim/r46/tDOP .
ln -sf /nobackup/cbertin/ED-SBS_LR/forcings/river_runoff/Nutrients/AGRO_NutClim/r46/tDSi .

# -------------------------------------------
# link to run_template files
# -------------------------------------------
ln -sf /nobackup/cbertin/ED-SBS_LR/forcings/run_template/ED-SBSv3/* .
ln -sf /nobackup/cbertin/ED-SBS_LR/forcings/run_template/ED-SBSv3/eta_adjust/OBWu_Mac_46x68.bal_ROFF OBWu_Mac_46x68.balance
# -------------------------------------------
# copy data files
# -------------------------------------------
cp /nobackup/cbertin/ED-SBS_LR/configs/setup_files_v3.0/input/* .
cp /nobackup/cbertin/ED-SBS_LR/configs/job_mac270_bro .
# -------------------------------------------
# Make diags directory
# -------------------------------------------
mkdir diags diags/daily