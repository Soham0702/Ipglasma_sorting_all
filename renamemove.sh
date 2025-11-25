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

prefix1="Initial_Distribution_input_filename"
prefix2="Initial_Binaries_input_filename"


offset=0
for d in "${!dirs[@]}"; do
    m=1 
    echo
    dir="${dirs[$d]}"
    echo "Checking directory: $dir"
    if [[ ! -d "$dir" ]]; then
        echo "  Directory missing, skipping."
        offset=$((offset + sz))
        continue
    fi  
    sz="${sizes[$d]}"
    for ((j=0; j<sz; j++)); do
        idx=$((offset + j))
        [[ $idx -lt ${#ids[@]} ]] || break
        id="${ids[$idx]}"
        mv "$dir/job-$id" "$dir/jobtmp-$id/"
        mv "$dir/jobtmp-$id/results/epsilon-u-Hydro-TauHydro-$id.dat" "$dir/jobtmp-$id/epsilon-u-Hydro-TauHydro-$m.dat"
        mv "$dir/jobtmp-$id/results/NcollList$id.dat" "$dir/jobtmp-$id/NcollList$m.dat"
        rm -rf "$dir/jobtmp-$id"/results/
        rm -rf "$dir/jobtmp-$id/music_EOS"
        rm -rf "$dir/jobtmp-$id/EOS"
        cp -r "/home/soham/jets/ipglasma/ipglasma_master/check/0-50_1250/job-test/EOS" "$dir/jobtmp-$id/"
        mv "$dir/jobtmp-$id/music_input_run_$id" "$dir/jobtmp-$id/music_input_run_$m"
        sed -i \
            -e "s|^$prefix1.*|$prefix1  epsilon-u-Hydro-TauHydro-$m.dat|" \
            -e "s|^$prefix2.*|$prefix2  NcollList$m.dat|" \
                  "$dir/jobtmp-$id/music_input_run_$m"
        rm "$dir/jobtmp-$id"/particle_list*
        rm "$dir/jobtmp-$id"/hadrons_list.dat
        rm "$dir/jobtmp-$id"/fort.30
        rm "$dir/jobtmp-$id"/trigger_particle.dat
        rm "$dir/jobtmp-$id"/tables.dat
        rm "$dir/jobtmp-$id"/OSCAR.input
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
