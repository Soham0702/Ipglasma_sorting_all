#!/usr/bin/env bash                                                                                                                                                      
set -euo pipefail

dirs=(0-50_2500)
for d in "${dirs[@]}"; do mkdir -p "$d"; done

mapfile -t ids < <(awk '{print $1}' details)

sizes=(2500)

for((i=0;i<2500;i++));do
    echo "${ids[i]}"
done > "${dirs[0]}/list.dat"

offset=0
for bi in "${!dirs[@]}"; do
  dir="${dirs[$bi]}"
  sz="${sizes[$bi]}"
  for ((j=0; j<sz; j++)); do
    idx=$((offset + j))
    [[ $idx -lt ${#ids[@]} ]] || break
    id="${ids[$idx]}"
    src1="all_files/epsilon-u-Hydro-TauHydro-$id.dat"
    src2="all_files/NcollList$id.dat"                                                                                                                                     
    if [[ -f "$src1" ]]; then
      cp -- "$src1" "$dir/"
    else
      echo "WARN: missing $src1" >&2
    fi  
    if [[ -f "$src2" ]]; then
      cp -- "$src2" "$dir/"
    else
      echo "WARN: missing $src2" >&2
    fi  
  done
  offset=$((offset + sz))
done
