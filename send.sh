# Both 'ROUTER_ID' and POST_LOGS_URL need to be seted in the install script

# Getting MAC address
mac=$(cat /sys/class/net/eth0/address)

data="$(cat log.csv)"
# Exceptions
if [ $? -ne 0 ]
then
    exit 1
fi

# Sending data to server
curl -d "api_key=$ROUTER_ID&mac=$mac&data=$data" -X POST $POST_LOGS_URL
# Exceptions
if [ $? -ne 0 ]
then
    exit 1
fi

# Remove file after posted
rm log.csv

exit 0

