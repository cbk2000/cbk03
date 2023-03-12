#!/bin/bash

# define the function that creates the SCORET file
function main() {
  output_dir=$1
  info_SIAK=$2
  map_NPM=$3

  # create output directory if it does not exist
  mkdir -p "${output_dir}"

  # check if SCORET.txt exists in the output directory
  if [ -f "${output_dir}/SCORET.txt" ]; then
    echo "init_scoret.sh: SCORET.txt already exists in the output directory. Completed..."
    exit 1
  fi

  # read the matching 10-digit combinations from input files and store them in an array
  readarray -t indexes < <(grep -o -F -f "$info_SIAK" "$map_NPM" | awk '{print $1}' | sort | uniq)

  # create a new file with the specified format, including the matching indexes
  for index in "${indexes[@]}"; do
    echo "${index}      0     0     0     0     0     0     0     0     0     0     0    -1    -1" >> "${output_dir}/SCORET.txt"
  done

  echo "init_scoret.sh: Initial generation of the SCORET.txt file completed."
}

# check if the required number of arguments is provided
if [ $# -ne 3 ]; then
  echo "Usage: $0 <output_directory> <info_SIAK_file> <map_NPM_file>"
  exit 1
fi

# call the function with the command line arguments
main "$1" "$2" "$3"
