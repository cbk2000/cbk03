#!/bin/bash

function generate_template_user_data_array {
    
    # Set default values for each argument if not provided or is null
    local NPM="${1:-0000000000}"
    local CLASS="${2:-T}"
    local GITHUB="${3:-cbkadal}"
    local EMAIL="${4:-cbkadal@os.vlsm.org}"
    local NAME="${5:-Cicak Bin Kadal}"
    local UTS="${6:--1}"
    local UAS="${7:--1}"
    
    # Declare an associative array
    declare -A TEMPLATE_USER_DATA
    
    # Assign values to the array using the provided or default variables
    TEMPLATE_USER_DATA["01NPM"]="$NPM"
    TEMPLATE_USER_DATA["02CLASS"]="$CLASS"
    TEMPLATE_USER_DATA["03GITHUB"]="$GITHUB"
    TEMPLATE_USER_DATA["04EMAIL"]="$EMAIL"
    TEMPLATE_USER_DATA["05NAME"]="$NAME"
    TEMPLATE_USER_DATA["06UTS"]="$UTS"
    TEMPLATE_USER_DATA["07UAS"]="$UAS"
    
    # Return the array by echoing it to stdout
    declare -p TEMPLATE_USER_DATA
}
