#!/bin/bash

function generate_template_weekly_data_array {
    # Declare an associative array
    declare -A TEMPLATE_WEEKLY_DATA
    
    # Assign values to the array using the provided or default variables
    TEMPLATE_WEEKLY_DATA["00SCORE"]="0"
    TEMPLATE_WEEKLY_DATA["01AKUNGH"]="0"
    TEMPLATE_WEEKLY_DATA["02REPOGH"]="0"
    TEMPLATE_WEEKLY_DATA["03GHPAGE"]="0"
    TEMPLATE_WEEKLY_DATA["04LOG"]="0"
    TEMPLATE_WEEKLY_DATA["05LOGTIME"]="0"
    TEMPLATE_WEEKLY_DATA["06LOGJOROK"]="0"
    TEMPLATE_WEEKLY_DATA["07UPDATE"]="0"
    TEMPLATE_WEEKLY_DATA["08QuizNPM"]="0"
    TEMPLATE_WEEKLY_DATA["09QuizAGitHub"]="0"
    TEMPLATE_WEEKLY_DATA["10ManualNPM"]="0"
    TEMPLATE_WEEKLY_DATA["11ManualAGitHub"]="0"
    TEMPLATE_WEEKLY_DATA["12Jorok"]="0"
    TEMPLATE_WEEKLY_DATA["13index"]="0"
    TEMPLATE_WEEKLY_DATA["14links"]="0"
    TEMPLATE_WEEKLY_DATA["15mypubkey"]="0"
    TEMPLATE_WEEKLY_DATA["16pubkeystat"]="0"
    TEMPLATE_WEEKLY_DATA["17shasum"]="0"
    TEMPLATE_WEEKLY_DATA["18myrank"]="0"
    TEMPLATE_WEEKLY_DATA["19peerRank"]="0"
    TEMPLATE_WEEKLY_DATA["20tarOpen"]="0"
    TEMPLATE_WEEKLY_DATA["21assignment"]="0"
    
    
    
    # Return the array by echoing it to stdout
    declare -p TEMPLATE_WEEKLY_DATA
}
