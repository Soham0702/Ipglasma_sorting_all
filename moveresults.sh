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
    sz="${sizes[$d]}"
    echo "Checking directory: $dir"
    if [[ ! -d "$dir" ]]; then
        echo "  Directory missing, skipping."
        offset=$((offset + sz))
        continue
    fi  
    mkdir -p "$dir/dummy"
    for ((j=0; j<sz; j++)); do
        idx=$((offset + j))
        [[ $idx -lt ${#ids[@]} ]] || break
        id="${ids[$idx]}"
        src="$dir/job-$id"
        tmp="$dir/dummy/jobtmp-$m"

        mv "$src" "$tmp"
        mv "$tmp/epsilon-u-Hydro-TauHydro-$id.dat" "$tmp/epsilon-u-Hydro-TauHydro-$m.dat"
        mv "$tmp/NcollList$id.dat" "$tmp/NcollList$m.dat"
        mv "$tmp/music_input_run_$id" "$tmp/music_input_run_$m"
        ((m++))
    done
    for ((k=1; k<m; k++)); do
        if [[ -d "$dir/dummy/jobtmp-$k" ]]; then
            mv "$dir/dummy/jobtmp-$k" "$dir/dummy/job-$k"
        fi  
    done
    mv "$dir/dummy"/* "$dir"
    rm -rf "$dir/dummy"
    offset=$((offset + sz))
done
echo
echo "all done."
