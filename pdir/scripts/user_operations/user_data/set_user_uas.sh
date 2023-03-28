if [[ $# -lt 3 ]]; then
    echo "Error: Insufficient arguments provided."
    echo "Usage: $0 BASEDIR USERNAME UAS"
    exit 1
fi

basedir=$1
username=$2
UAS=$3

if [ ! -d "${basedir}/input/dataUser/${username}" ]; then
    echo "User directory does not exist. Exiting..."
    exit 1
fi


echo "$UAS" > "${basedir}/input/dataUser/${username}/07UAS"