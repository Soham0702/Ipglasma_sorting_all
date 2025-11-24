#!/bin/bash
set -euo pipefail

dirs=(0-5_50 5-10_50 10-20_100 20-30_100 30-40_100 40-50_100)
for d in "${dirs[@]}"; do mkdir -p "$d"; done

mapfile -t ids < <(awk '{print $1}' chosenlist.dat)                                                                                                                                                                                                                                                                                                                                            

sizes=(50 50 100 100 100 100)

offset=0
for bi in "${!dirs[@]}"; do
    dir="${dirs[$bi]}"
    sz="${sizes[$bi]}"
    for ((j=0; j<sz; j++)); do
        idx=$((offset + j))
        [[ $idx -lt ${#ids[@]} ]] || break
        id="${ids[$idx]}"
        src="/home/soham/jets/ipglasma/ipglasma_master/check/0-50_1250/job-${id}"
        if [[ -d "$src" ]]; then
        cp -r "$src" "$dir/"
        else
        echo "WARN: missing $src" >&2
        fi
      done
    offset=$((offset + sz))
done
