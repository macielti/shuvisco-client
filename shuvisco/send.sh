# Load configs
/etc/shuvisco.conf

# Getting MAC address
mac=$(cat /sys/class/net/eth0/address)

logs="$(cat log.csv)"
# Exceptions
if [ $? -ne 0 ]
then
    exit 1
fi

# Sending data to server
curl -d "router_id=$ROUTER_ID&mac=$mac&logs=$logs" -X POST "http://$SERVER/log/"
# Exceptions
if [ $? -ne 0 ]
then
    exit 1
fi

# Remove file after posted
rm log.csv

exit 0

