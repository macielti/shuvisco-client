# Load configs
. /etc/shuvisco.conf

# function to search for news versions of the client
check_version_update()
{
    # verify new version for software client
    grep -i "$SOFTWARE_CLIENT_VERION" log.response

    if [ $? -ne 0 ]
    then
        # in case of there is a new version disponible to download
        echo "A new version of the client was found..."
        echo "Starting the upgrade procedure..."
        cd ..
        echo "Downloading the instal.run..."
        rm install.run
        wget "https://github.com/macielti/shuvisco-client/blob/master/install.run?raw=true" -O install.run
        echo "OK..."
        echo "Instaling the new version..."
        chmod +x install.run
        ./install.run
        echo "OK..."
        echo "The new verson was installed with success..."
    fi
}

# Getting MAC address
mac=$(cat /sys/class/net/eth0/address)

logs="$(cat log.csv)"
# Exceptions
if [ $? -ne 0 ]
then
    exit 1
fi

# Sending data to server
wget --post-data="router_id=$ROUTER_ID&mac=$mac&logs=$logs" "http://$SERVER/log/" -O log.response
# Verify the success of the operation
grep -i "success" log.response
if [ $? -ne 0 ]
then
    # if not success
    rm log.response
    exit 0
else
    # if is all ok
    rm log.csv;

    check_version_update;

    rm log.response;
fi

exit 0
