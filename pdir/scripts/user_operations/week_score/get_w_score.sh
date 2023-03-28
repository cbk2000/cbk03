if [[ $# -lt 3 ]]; then
    echo "Error: Insufficient arguments provided."
    echo "Usage: $0 BASEDIR USERNAME WEEK"
    exit 1
fi

basedir=$1
username=$2
week=$3

if [ ! -d "${basedir}/input/dataUser/${username}" ]; then
    echo "User directory does not exist. Exiting..."
    exit 1
fi

if [ ! -d "${basedir}/input/dataUser/${username}/DW${week}" ]; then
    echo "Week $3 directory does not exist. Exiting..."
    exit 1
fi

cat "${basedir}/input/dataUser/${username}/DW${week}/00SCORE"