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
p_server="1.1.1.1"
ping_result=$(ping -q $p_server -w 60)

# Extract number of sended packages
n_sended=$(echo "$ping_result" | awk -F' ' '/transmitted,/{print $1}')
n_good_packages=$(echo "$ping_result" | awk -F' ' '/transmitted,/{print $4}')

if [ $good_packages -lt 42 ]
then
    echo "$timestamp,1,$n_sended,$n_good_packages,$p_server" >> /root/shuvisco/log.csv
else
    echo "$timestamp,0,$n_sended,$n_good_packages,$p_server" >> /root/shuvisco/log.csv
fi

exit 0
