#!/bin/bash


# Check if username is provided as an argument
if [[ $# -eq 0 ]]; then
    echo "Error: No arguments provided."
    exit 1
fi

basedir=$1
cd $basedir

# Set username as the first argument
username=$2
echo "Creating user directory for $username"

week=$3
echo "Generating directories for $week"


# Check if the user directory already exists
if [ -d "input/dataUser/${username}" ]; then
    echo "User directory already exists."
else
    echo "Creating user directory."
    # Create the user directory and 11 DW directories
    mkdir -p "input/dataUser/${username}"
    mkdir -p "input/dataUser/${username}/DW${week}"
fi



# Create example files under each DW directory

echo "Writing weekly data templates"

weekly_data_template=$(source scripts/weekly_data_array.sh; generate_template_weekly_data_array)
eval $weekly_data_template

for user_data in "${!TEMPLATE_WEEKLY_DATA[@]}"; do
    data="${TEMPLATE_WEEKLY_DATA[$user_data]}"
    echo "$data" > "input/dataUser/${username}/DW${week}/${user_data}"
done

# Create example files in the user directory
# echo "Example file in user directory" > "pdir/input/dataUser/${username}/example.txt"

echo "Writing user data templates"
user_data_template=$(source scripts/user_data_array.sh; generate_template_user_data_array "" "" "${username}")

eval $user_data_template

if [ ! -f "input/dataUser/${username}/${user_data}" ]; then
    echo "$data" > "input/dataUser/${username}/${user_data}"
fi


exit 0
