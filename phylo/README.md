To make the phylogeny file:

  1. Extract the family names
  2. Check they are all families (switch DIPSACALES to DIPSACALESGEN)
     and add to synonymy list
  3. build `taxa` file
  4. `$ phylomatic -t taxa -f R20100701.new > phylo1`
  5. Check the mismatch list, listing synonyms in the `synonyms` file 
  6. `$ cp wikstrom.ages ages; phylocom bladj -f phylo1 > phylo.new`
  7. `$ phylocom new2fy -f phylo.new > phylo.fy`
  8. `$ awk '{print $1 "|" $2 "|" $6 "|" $7}' phylo.fy > phylo.csv`
  8. Edit `phylo.csv` to add colors
