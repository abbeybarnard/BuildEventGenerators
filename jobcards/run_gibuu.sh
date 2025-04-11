#!/bin/bash

# Generate GiBUU events
# GiBUU 2023
/exp/uboone/app/users/abarnard/BuildEventGenerators/GiBUU/release/testRun/./GiBUU.x < GiBUU2023_MicroBooNE_nue.job

# Convert to Nuisance format
for i in {1..5}; do PrepareGiBUU -i EventOutput.Pert.0000000${i}.root -f abbey_combined_flux.root,nue_CV_AV_TPC_5MeV_bin -o GiBUU_${i}.prep.root; done
#for i in {10..49}; do PrepareGiBUU -i EventOutput.Pert.000000${i}.root -f abbey_combined_flux.root,nue_CV_AV_TPC_5MeV_bin -o GiBUU_${i}.prep.root; done
#for i in {50..100}; do PrepareGiBUU -i EventOutput.Pert.00000${i}.root -f abbey_combined_flux.root,nue_CV_AV_TPC_5MeV_bin -o GiBUU_${i}.prep.root; done
#PrepareGiBUU -i EventOutput.Pert.00000001.root -f abbey_combined_flux.root,nue_CV_AV_TPC_5MeV_bin -o GiBUU.prep.root

# Convert to Nuisance flat tree format
for i in {1..5}; do nuisflat -i GiBUU:GiBUU_${i}.prep.root -o samples/GiBUU_${i}.flat.root; done
#nuisflat -i GiBUU:GiBUU.prep.root -o samples/GiBUU.flat.root

cd samples
hadd GiBUU2023.flat.root GiBUU*.flat.root
# Bit's I've commented out! 
#mv GiBUU2023.flat.root /pnfs/uboone/persistent/users/apapadop/GiBUU_Samples/GiBUU2023/GiBUU2023_300runs.root
#rm *.root
#cd ..

# Remove unnecessary files
rm *.prep.root
rm *.dat
rm GiBUU_database_decayChannels.txt
rm GiBUU_database.tex
rm main.run
rm PYR.RG
rm EventOutput.Pert.000000*.root
#mv GiBUU.prep.root samples/
