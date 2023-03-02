#!/bin/bash

## Fix this, ini temp solution aja
cd ..

# Check if username is provided as an argument
if [[ $# -eq 0 ]]; then
  echo "Error: No username provided."
  exit 1
fi

# Set username as the first argument
username=$1
echo "Creating user directory for $username"

# Check if the user directory already exists
if [ -d "input/dataUser/${username}" ]; then
  echo "User directory already exists."
  exit 1
fi

# Create the user directory and 11 DW directories
mkdir -p "input/dataUser/${username}"
for i in $(seq -f "%02g" 0 11); do
  mkdir -p "input/dataUser/${username}/DW${i}"
done


# # Create example files under each DW directory
# for i in $(seq -f "%02g" 0 11); do
#   echo "Example file in DW${i}" > "pdir/input/dataUser/${username}/DW${i}/example.txt"
# done

# Create example files in the user directory
# echo "Example file in user directory" > "pdir/input/dataUser/${username}/example.txt"

user_data_template=$(source scripts/user_data_array.sh; generate_template_user_data_array "" "" "${username}")

eval $user_data_template


for user_data in "${!TEMPLATE_USER_DATA[@]}"; do
  data="${TEMPLATE_USER_DATA[$user_data]}"
  echo "$data" > "input/dataUser/${username}/${user_data}"
done
