#!/bin/bash
#********************************
# Author: David Hiller
# hiller@chemie.uni-frankfurt.de
#********************************
#Version: 1.0


#---------------------------------------------------------------------------------------------
# Get the users input
directory="$PWD"
read -p "Enter a list of atomic numbers separated by spaces: " atomic_numbers
atomic_numbers_array=($atomic_numbers)
length=${#atomic_numbers_array[@]}
#---------------------------------------------------------------------------------------------





#---------------------------------------------------------------------------------------------
# Add some value (+2) to the atomic index/number because of the first two lines of
# xyz-file: e.g. Num Atoms and a comment
line_number=()
for ((i=0; i<$length; i++)); do
	updated_value=$((atomic_numbers_array[i] + 2))
	line_number+=("$updated_value")
done
#---------------------------------------------------------------------------------------------





#---------------------------------------------------------------------------------------------
# Create new files from basename and suffix; keep the originals unchanged
for file in "$directory"/*.xyz; do
	filename=$(basename "$file" .xyz)
	truncated_xyzfile="$directory/${filename}-truncated.xyz"
	touch $truncated_xyzfile
	echo ${#line_number[@]} > $truncated_xyzfile
	echo "this is an auto generated and post processed xyz file" >> $truncated_xyzfile
done
#---------------------------------------------------------------------------------------------





#---------------------------------------------------------------------------------------------
# extract the values from orig. xyz file and copy them to the truncated form
for line_number in "${line_number[@]}"; do
	sed -n "${line_number}p" "$file" >> "$truncated_xyzfile"
done
#---------------------------------------------------------------------------------------------
