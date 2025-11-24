#!/bin/bash

mapfile -t ids < <(awk '{print $1}' chosenlist.dat)

# Directories to check
dirs=(
    "0-5_50"
    "5-10_50"
    "10-20_100"
    "20-30_100"
    "30-40_100"
    "40-50_100"
     )

sizes=(50 50 100 100 100 100)

offset=0
for d in "${!dirs[@]}"; do
    m=1 
    echo
    dir="${dirs[$d]}"
    echo "Checking directory: $dir"
    [[ -d "$dir" ]] || { echo "  Directory missing, skipping."; continue; }
    sz="${sizes[$d]}"
    for ((j=0; j<sz; j++)); do
        idx=$((offset + j))
        [[ $idx -lt ${#ids[@]} ]] || break
        id="${ids[$idx]}"
        mv "$dir/job-$id" "$dir/jobtmp-$id/"
        mv "$dir/jobtmp-$id"/results/* "$dir/jobtmp-$id/"
        rm -rf "$dir/jobtmp-$id"/results/
        mv "$dir/jobtmp-$id/epsilon-u-Hydro-TauHydro-$id.dat" "$dir/jobtmp-$id/epsilon-u-Hydro-TauHydro-$m.dat"
        mv "$dir/jobtmp-$id/NcollList$id.dat" "$dir/jobtmp-$id/NcollList$m.dat"
        mv "$dir/jobtmp-$id" "$dir/jobtmp-$m"
        ((m++))
    done
    for ((k=1; k<m; k++)); do                                                                                                                                                                                                                                                                                                                                                                
        if [[ -d "$dir/jobtmp-$k" ]]; then
            mv "$dir/jobtmp-$k" "$dir/job-$k"
        fi
    done
    offset=$((offset + sz))
done
echo
echo "all done."
