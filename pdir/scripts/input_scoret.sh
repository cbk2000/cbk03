#!/bin/bash

# Check if the required arguments are provided
if [ $# -ne 4 ]; then
  echo "Usage: $0 <output_directory> <info_SIAK_file> <map_NPM_file> <data_user_dir>"
  exit 1
fi

# Set the output directory from the command line argument
output_dir="$1"

# Check if the output directory and SCORET.txt file exist
if [ ! -d "${output_dir}" ] || [ ! -f "${output_dir}/SCORET.txt" ]; then
  echo "SCORET.txt does not exist in the output directory. Completed..."
  exit 1
fi

# Read the student IDs from the info_SIAK file
readarray -t student_ids < "$2"

# Map the student IDs to GitHub account names
declare -A id_to_github_map
while read -r id github_account; do
  echo $id
  echo $github_account
  id_to_github_map["$id"]="$github_account"
done < "$3"

# Iterate over each student ID
for id in "${student_ids[@]}"; do
  id="${id// }"  # Remove any whitespace characters from the ID
  echo "Processing student with ID $id"
  
  # Check if the student has a GitHub account mapped
  if [[ ! ${id_to_github_map["$id"]} ]]; then
    echo "Student with ID ${id} has no mapped GitHub account. Skipping..."
    continue
  fi

  # Set the path to the student's directory
  student_dir="$4/${id_to_github_map["$id"]}"

  # Check if the student's directory exists
  if [ ! -d "$student_dir" ]; then
    echo "Directory for student with ID ${id} does not exist. Skipping..."
    continue
  fi

  # Initialize the array for storing the weekly scores
  scores=()

  # Iterate over each weekly score
  for i in {00..11}; do
    # Set the path to the weekly score file
    score_file="$student_dir/DW$i/00SCORE"

    # Check if the weekly score file exists
    if [ ! -f "$score_file" ]; then
      echo "Weekly score file for student with ID ${id} and week $i does not exist. Skipping..."
      continue 2 # Continue to the next student ID
    fi

    # Read the weekly score from the file and append it to the scores array
    score=$(cat "$score_file")
    scores+=("$score")
  done

  # Initialize the midterm and final scores
  midterm_score=-1
  final_score=-1

  # Check if the midterm and final files exist
  if [ -f "$student_dir/06UTS" ]; then
    midterm_score=$(cat "$student_dir/06UTS")
  fi

  if [ -f "$student_dir/07UAS" ]; then
    final_score=$(cat "$student_dir/07UAS")
  fi

  # Generate the SCORET.txt line for the student
  scores_str=$(printf "%6s" "${scores[@]}")
  midterm_formatted=$(printf "%6s" "$midterm_score")
  final_formatted=$(printf "%6s" "$final_score")
#   echo "${id} ${scores_str} ${midterm_formatted} ${final_formatted}" >> "${output_dir}/SCORET.txt"

# Generate the SCORET.txt line for the student
# scores_str=$(printf "%4s" "${scores[@]}")
if grep -q "^${id} " "${output_dir}/SCORET.txt"; then
  sed -i "s/^${id} .*/${id} ${scores_str} ${midterm_formatted} ${final_formatted}/" "${output_dir}/SCORET.txt"
else
  echo "${id} ${scores_str} ${midterm_formatted} ${final_formatted}" >> "${output_dir}/SCORET.txt"
fi


done

echo "Generation of SCORET.txt completed."