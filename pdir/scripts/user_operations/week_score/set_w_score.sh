if [[ $# -lt 4 ]]; then
    echo "Error: Insufficient arguments provided."
    echo "Usage: $0 BASEDIR USERNAME WEEK SCORE"
    exit 1
fi

basedir=$1
username=$2
week=$3
score=$4

if [ ! -d "${basedir}/input/dataUser/${username}" ]; then
    echo "User directory does not exist. Exiting..."
    exit 1
fi

if [ ! -d "${basedir}/input/dataUser/${username}/DW${week}" ]; then
    echo "Week $3 directory does not exist. Exiting..."
    exit 1
fi

echo "Writing score to file"
echo "$score" > "${basedir}/input/dataUser/${username}/DW${week}/00SCORE"