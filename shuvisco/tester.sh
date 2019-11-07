# Getting the antenna IP
antenna_ip=$(route -n | awk '{if($4=="UG")print $2}')
# Verify if the antenna is connected
ping $antenna_ip -c 1 -w 2
if [ $? -ne 0 ]
then
    echo 'Antenna not connected.'
    exit 1
fi

# Getting the timestamp
timestamp=$(date +%s)
# Testing the connection
wget -q --spider http://google.com
resultado=$?
echo '$resultado; $timestamp' >> /root/shuvisco/log.csv

exit 0
