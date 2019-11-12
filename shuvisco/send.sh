# Load configs
. /etc/shuvisco.conf

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
    rm log.csv
    rm log.response
fi

exit 0

