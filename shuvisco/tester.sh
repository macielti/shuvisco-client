# Getting the antenna IP
antenna_ip=$(route -n | awk '{if($4=="UG")print $2}')
# Verify if the antenna is connected
ping $antenna_ip -c 1 -w 2
if [ $? -ne 0 ]
then
    echo "Antenna not connected."
    exit 1
fi

# Getting the timestamp
timestamp=$(date +%s)
# Testing the connection
if [ $(ping -q 1.1.1.1 -w 60 | awk -F" " '/transmitted,/{print $4}') -lt 42 ]
then
    echo "1,$timestamp" >> /root/shuvisco/log.csv
else
    echo "0,$timestamp" >> /root/shuvisco/log.csv
fi

exit 0
