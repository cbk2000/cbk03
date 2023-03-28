if [[ $# -lt 2 ]]; then
    echo "Error: Insufficient arguments provided."
    echo "Usage: $0 BASEDIR USERNAME"
    exit 1
fi

basedir=$1
username=$2

if [ ! -d "${basedir}/input/dataUser/${username}" ]; then
    echo "User directory does not exist. Exiting..."
    exit 1
fi


cat "${basedir}/input/dataUser/${username}/07UAS"