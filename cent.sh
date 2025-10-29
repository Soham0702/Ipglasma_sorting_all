
#!/bin/bash
set -euo pipefail

dirs=(0-5_125 5-10_125 10-20_250 20-30_250 30-40_250 40-50_250 50-60_250 60-70_250 70-80_250 80-90_250 90-100_250)
for d in "${dirs[@]}"; do mkdir -p "$d"; done

mapfile -t ids < <(awk '{print $1}' details)

sizes=(125 125 250 250 250 250 250 250 250 250 250)

offset=0
for bi in "${!dirs[@]}"; do
  dir="${dirs[$bi]}"
  sz="${sizes[$bi]}"
  for ((j=0; j<sz; j++)); do
    idx=$((offset + j))
    [[ $idx -lt ${#ids[@]} ]] || break
    id="${ids[$idx]}"
    for prefix in "epsilon-u-Hydro-TauHydro-" "NcollList" "NpartList" "usedParameters" "NgluonEstimators"; do
        src="all_files/${prefix}${id}.dat"
        if [[ -f "$src" ]]; then
            cp -- "$src" "$dir/"
        else
            echo "WARN: missing $src" >&2
        fi
    done
  done
  offset=$((offset + sz))
done
