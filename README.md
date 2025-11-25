rename.sh ->energy.cpp -> sort.cpp -> cent.sh.
rename and copy files to all files -> extract energy and event number-> sort based on energy and give output file "details" -> move to new directory.

final after urqmd
pickevents.cpp -> copyfiles.sh -> moveresults.sh

pick events you want -> copy files from directory -> rename and move directories and files from job-1 to job-n




# IP-Glasma Sorting

Here I include all the bash and cpp files, parameter files that i have used to sort IP-Glasma events for Pb-Pb collision at 2.76 TeV and Au-Au at 200 GeV
there are comments and i will five the workflow below:


0.  Here i run 2500 events and only need (0-40)%, so I sort first with energy density, then for (0-50)%  I do MUSIC. 
1.  Pick any initial s-factor, e.g., 1.0.
2.  Run all 2500 events, extract final N_ch
3.  Sort events by Nchi, assign centrality percentiles.
4.  In 0–5% bin, compute: <N_ch> = 1/n SUM(N^i_ch), and define C = N_data/ N_sim

5.  Set new global s-factor = old s-factor × C.
6.  Re-run the simulation once, now with correct normalization.
	
