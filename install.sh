# Script for instalation.

# Flags

SERVEO="<'serveo' from the router document>"
ROUTER_ID="<'_id' from the router document>"

POST_LOGS_URL="<url for the 'logs' endpoint on the server>"



# Instalando o autossh para utilizar com o Serveo:
opkg install autossh
# Mover o script de inicializacao do Serveo:
mv serveo /etc/init.d/
# Permitindo execucao:
chmod +x /etc/init.d/serveo
# Habilitando o servico:
/etc/init.d/serveo enable
# Startar servico:
/etc/init.d/serveo start

# Adicionando scripts ao crontab
chmod +x tester.sh
chmod +x send.sh
crontab -l > mycron
echo "* * * * * /root/chuvisco/tester.sh" >> mycron
echo "00 00 * * * /root/chuvisco/send.sh" >> mycron
crontab mycron
rm mycron

exit 0

