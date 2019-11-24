
echo " "
echo "Shuvisco Instalador"
echo " "

### LOGIC ####

# Arquivo de configuracao do cliente
#server="SERVER=\"104.196.63.49\"" 
server="SERVER=\"192.168.1.106:5000\""
software_client_version="SOFTWARE_CLIENT_VERION=\"bom de guerra\""
# Verificar se o arquivo de configuracao ja existe
cat /etc/shuvisco.conf
if [ $? -ne 0 ]
then
    # Arquivo ainda nao existe 
    echo $server >> /etc/shuvisco.conf
    echo $software_client_version >> /etc/shuvisco.conf
    chmod +x /etc/shuvisco.conf
else
    # Arquivo ja existe
    sed -i "/SERVER/c\\$server" /etc/shuvisco.conf
    sed -i "/CLIENT_VERION/c\\$software_client_version" /etc/shuvisco.conf
fi

# Mover o script de inicializacao do Serveo:
mv /root/shuvisco/serveo /etc/init.d/serveo
# Permitindo execucao:
chmod +x /etc/init.d/serveo
# Habilitando o servico:
/etc/init.d/serveo enable
# Startar servico:
/etc/init.d/serveo start

# Adicionando scripts ao crontab
chmod +x /root/shuvisco/tester.sh
chmod +x /root/shuvisco/send.sh

crontab -l > mycron
# Verificando se ja existe algo no crontab referene ao shuvisco
grep -i "shuvisco" mycron
if [ $? -ne 0 ]
then
    # Nenhum rastro de versao anterior instalada
    echo "* * * * * /root/shuvisco/tester.sh" >> mycron
    echo "00 00 * * * /root/shuvisco/send.sh" >> mycron
else
    # Vestigios encontrados
    sed -i "/tester.sh/c\\* * * * * /root/shuvisco/tester.sh" mycron
    sed -i "/send.sh/c\\00 00 * * * /root/shuvisco/send.sh" mycron
fi

crontab mycron
rm mycron

# sudo makeself --notemp shuvisco/ install.run "Extracting files..." ./install.sh

exit 0

