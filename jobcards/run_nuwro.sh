i#!/bin/bash

#https://nuwro.github.io/user-guide/

# Generate NuWro events
# old fashioned way
##nuwro -i NuWroCard_CC_Ar_uBFlux.txt -p "beam_particle = 14"  -p "beam_inputroot_flux = hEnumu_cv" -p "beam_inputroot = MCC9_FluxHist_volTPCActive.root"
# new way, May 22 2023
nuis gen NuWro -f  abbey_combined_flux.root,nue_CV_AV_TPC_5MeV_bin -P nue -n 500000 -t Ar -o NuWroCard_CC_Ar_uBFlux.prep.root

# Prepare NuWro events for Nuisance
# old way
##PrepareNuwroEvents -f eventsout.root -F MCC9_FluxHist_volTPCActive.root,hEnumu_cv -o NuWroCard_CC_Ar_uBFlux.prep.root
# new way, May 22 203
PrepareNuWroEvents -F abbey_combined_flux.root,nue_CV_AV_TPC_5MeV_bin,12 NuWroCard_CC_Ar_uBFlux.prep.root -o NuWro.prep.root

# Convert to Nuisance flat tree
nuisflat -i NuWro:NuWro.prep.root -o samples/NuWro_new.flat.root

# Remove unnecessary files
rm NuWroCard_CC_Ar_numu.prep.root
rm NuWro.*
rm NuWroCard_CC_Ar_numu.prep.root.*
rm Ar*.txt
rm q*.txt
rm T.txt
rm random_seed
rm totals.txt
