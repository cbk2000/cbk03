if [[ $# -lt 3 ]]; then
    echo "Error: Insufficient arguments provided."
    echo "Usage: $0 BASEDIR USERNAME NPM"
    exit 1
fi

basedir=$1
username=$2
npm=$3

if [ ! -d "${basedir}/input/dataUser/${username}" ]; then
    echo "User directory does not exist. Exiting..."
    exit 1
fi


echo "$npm" > "${basedir}/input/dataUser/${username}/01NPM"