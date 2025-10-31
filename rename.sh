#!/bin/bash
set -euo pipefail

#i will rename all the files here and then move to a different folder for the fuck of it


m=21                                                                                                                                                                                                                                                                                                             
k=125
for ((i=1; i<2; i++))
do
        folder="run-$i"
        cd "$folder" || { echo "Failed to cd into $folder"; exit 1; }
    
        for ((j=124;j>=0;j--))
        do
                echo "moving item $k"
                mv "epsilon-u-Hydro-TauHydro-$j.dat" "epsilon-u-Hydro-TauHydro-$k.dat"
                mv "NcollList$j.dat" "NcollList$k.dat"
                mv "NpartList$j.dat" "NpartList$k.dat"
                mv "usedParameters$j.dat" "usedParameters$k.dat"
                mv "NgluonEstimators$j.dat" "NgluonEstimators$k.dat"
                ((k--))
        done
        cd ..
done
echo "Done renaming files 1"

c=126
for ((i=2; i<3; i++))
do
        folder="run-$i"
        cd "$folder" || { echo "Failed to cd into $folder"; exit 1; }
    
        for ((j=0;j<125;j++))
        do
                echo "moving item $c"
                mv "epsilon-u-Hydro-TauHydro-$j.dat" "epsilon-u-Hydro-TauHydro-$c.dat"
                mv "NcollList$j.dat" "NcollList$c.dat"
                mv "NpartList$j.dat" "NpartList$c.dat"
                mv "usedParameters$j.dat" "usedParameters$c.dat"
                mv "NgluonEstimators$j.dat" "NgluonEstimators$c.dat"
                ((c++))
        done
        cd ..
done
echo "Done renaming files 2"

mkdir "all_files"

for d in run-*/; do
          cp -a "$d"* all_files/
  done
