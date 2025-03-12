# Running instructions for ED-SBS v3.1

WARNING: An Earthdata account is required to download forcing files. Create it at: https://urs.earthdata.nasa.gov/users/new

## 1. Clone darwin environmemt 
Note: ED-SBS v3.1 runs on darwin checkpoint v69a (commit b537eb4)

```
git clone https://github.com/darwinproject/darwin3.git
git checkout b537eb4
```


## 2. Build executable
Note: Message Passing Interface (MPI) needs to be installed to lauch parrallel computing.
More informations can be fin at https://darwin3.readthedocs.io/en/latest/getting_started/getting_started.html#building-with-mpi

```
cd darwin3
mkdir build run
cd build
export MPI_INC_DIR=path_toward_MPI_files
../tools/genmake2 -mpi -mo '../../setup_files_v3.1/code_darwin ../../setup_files_v3.1/code'
make depend
make -j 16
```

## 3. Download the forcing files
Note: You need your WebDAV password accessible at: https://ecco.jpl.nasa.gov/drive
```
wget -r --no-parent --user=USERNAME --ask-password https://ecco.jpl.nasa.gov/drive/files/Version5/Alpha/era_xx
wget -r --no-parent --user=USERNAME --ask-password https://ecco.jpl.nasa.gov/drive/files/ECCO2/LLC270/Mac_Delta/run_template/33_Tracers_Nr46
wget -r --no-parent --user=USERNAME --ask-password https://ecco.jpl.nasa.gov/drive/files/ECCO2/LLC270/Mac_Delta/river_runoff
```

## 4. Prepare the simulation
Note: You need to download the forcing files on ECCO data portal 

```
cd ../run
mkdir diags diags/daily diags/budget
-- Link to the executable --
ln -sf ../build/mitgcmuv .
-- Link to atmospheric forcing --
ln -sf ../../Forcing/era_xx .
-- Link to Freswater runnoff --
ln -sf /../../Forcing/river_runoff/Freswater/AGRO_interan .
ln -sf /../../Forcing/river_runoff/Temperature/Tokuda_Mac270modif .
-- Link to Biogeochemical runoff --
ln -sf /../../Forcing/river_runoff/Nutrients/Bertin_etal_21/Interannual/L50_R48_C2/tDOCl .
ln -sf /../../Forcing/river_runoff/Nutrients/Bertin_etal_21/Interannual/L50_R48_C2/tDOCr .
ln -sf /../../Forcing/river_runoff/Nutrients/Bertin_etal_21/Interannual/L50_R48_C2/tDOCc .
ln -sf /../../Forcing/river_runoff/Nutrients/Tank_etal_12/Interannual/tAlk .
ln -sf /../../Forcing/river_runoff/Nutrients/Tank_etal_12/Interannual/tDIC .
ln -sf /../../Forcing/river_runoff/Nutrients/GNW2_NutCim/tDON .
ln -sf /../../Forcing/river_runoff/Nutrients/GNW2_NutCim/tDOP .
ln -sf /../../Forcing/river_runoff/Nutrients/GNW2_NutCim/tDSi .
-- Link to Initial and Boundary conditions -- 
ln -sf /../../Forcing/run_template/* .
ln -sf /../../Forcing/run_template/eta_adjust/OBWu_Mac_46x68.bal_ROFF OBWu_Mac_46x68.balance
-- Copy setup files -- 
cp ../../setup_files_v3.1/input/* .
```
## 4. Run the code

```
mpirun -np 8 ./mitgsmuv &
```
