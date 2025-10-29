#!/bin/bash
set -euo pipefail

#i will rename all the files here and then move to a different folder for the fuck of it


m=21
c=125
for ((i=2; i<m; i++))               #i will be 2, dont worry
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
echo "Done renaming files."

mkdir "all_files"


for d in run-*/; do
          cp -a "$d"* all_files/
  done

echo "Done copying"
