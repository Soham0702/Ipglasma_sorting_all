
#!/bin/bash
set -euo pipefail

dirs=(0-5_250 5-10_250 10-20_500 20-30_500 30-40_500 40-50_500 50-60_500 60-70_500 70-80_500 80-90_500 90-100_500)
for d in "${dirs[@]}"; do mkdir -p "$d"; done

mapfile -t ids < <(awk '{print $1}' details)

sizes=(250 250 500 500 500 500 500 500 500 500 500)

offset=0
for bi in "${!dirs[@]}"; do
  dir="${dirs[$bi]}"
  sz="${sizes[$bi]}"
  for ((j=0; j<sz; j++)); do
    idx=$((offset + j))
    [[ $idx -lt ${#ids[@]} ]] || break
    id="${ids[$idx]}"
    for prefix in "epsilon-u-Hydro-TauHydro-" "NcollList"; do
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
