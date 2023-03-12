#!/bin/bash

# The main functionality
function main(){
    # Variables
    working_dir=$(cd "$(dirname "$0")"; pwd)
    config="$working_dir/config.txt"
    input=""
    output=""
    week=""
    npm_user=""
    info_SIAK=""

    # Call the get_values function
    get_values

    # Initial Generation
    if [[ $week == "*" ]]; then
        echo "script.sh: Running Input Check"
        input_file="/path/to/input/file"

        # Iterate through the lines of the input file
        while read line; do
            # Get the username and week from the line
            username=$(echo "$line" | cut -d ' ' -f 2)
            username=$(echo $username | sed 's/[[:space:]\r\n]//g')

            if [[ $username == "" ]]; then
                continue
            fi

            for week_iterator in {00..11}; do
                bash "$working_dir/scripts/input_check.sh" "$working_dir" "$username" "$week_iterator"
            done
            
        done < "$working_dir/$input/$npm_user"

    else
        echo "script.sh: Running Input Check"
        bash "$working_dir/scripts/input_check.sh" "$working_dir" "$username" "$week"
    fi

    # Check if SCORET has been previously generated or not
    echo "script.sh: Running SCORET Check"
    bash "$working_dir/scripts/init_scoret.sh" "$working_dir/$output" "$working_dir/$input/$info_SIAK" "$working_dir/$input/$npm_user"

    # echo "script.sh: Processing absen directory"
    # bash "$working_dir/scripts/absen_process.sh" "$working_dir/$input" "$week" "$working_dir/$output"

    # echo "script.sh: Processing quiz directory"
    # bash "$working_dir/scripts/quiz_process.sh" "$working_dir/$input" "$week" "$working_dir/$output"

}

# Read configuration and check for unset configs
function get_values(){

    echo "script.sh: Reading configuration file..."

    while IFS= read -r line || [[ -n "$line" ]]
    do
        if [[ $line == *"INPUT="* ]]; then
            echo "script.sh: Getting Input Path..."
            # Take the value
            input=${line#*=}
            # Clean the value from \r, \n, and extra space
            input=$(echo $input | sed 's/[[:space:]\r\n]//g')
            echo "script.sh: Input Path: $working_dir/$input"
        fi

        if [[ $line == *"OUTPUT="* ]]; then
            echo "script.sh: Getting Output Path..."
            # Take the value
            output=${line#*=}
            # Clean the value from \r, \n, and extra space
            output=$(echo $output | sed 's/[[:space:]\r\n]//g')
            echo "script.sh: Output Path: $working_dir/$output"
        fi

        if [[ $line == *"CURRENT_WEEK="* ]]; then
            echo "script.sh: Getting Current Week..."
            # Take the value
            week=${line#*=}
            # Clean the value from \r, \n, and extra space
            week=$(echo $week | sed 's/[[:space:]\r\n]//g')
            echo "script.sh: Week: $week"
        fi

        if [[ $line == *"NPM_USER="* ]]; then
            echo "script.sh: NPM to User Filename..."
            # Take the value
            npm_user=${line#*=}
            # Clean the value from \r, \n, and extra space
            npm_user=$(echo $npm_user | sed 's/[[:space:]\r\n]//g')
            echo "script.sh: Filename: $npm_user"
        fi

        if [[ $line == *"INFO_SIAK="* ]]; then
            echo "script.sh: NPM for SIAK Filename..."
            # Take the value
            info_SIAK=${line#*=}
            # Clean the value from \r, \n, and extra space
            info_SIAK=$(echo $info_SIAK | sed 's/[[:space:]\r\n]//g')
            echo "script.sh: Filename: $info_SIAK"
        fi

    done < "$config"

    # Checking if any configuration was not set
    if [[ -z $input ]]; then
        echo "script.sh: Input directory is not set"
        exit 1
    fi

    if [[ -z $output ]]; then
        echo "script.sh: Output directory is not set"
        exit 1
    fi

    if [[ -z $week ]]; then
        echo "script.sh: The current week is not set"
        exit 1
    fi

    if [[ -z $npm_user ]]; then
        echo "script.sh: The NPM to User Mapping file is not set"
        exit 1
    fi

    if [[ -z $info_SIAK ]]; then
        echo "script.sh: The NPM from SIAK file is not set"
        exit 1
    fi

    echo "script.sh: Variables are set successfully"
}

# Call the main function
main