
echo " "
echo "Shuvisco Instalador"
echo " "

### LOGIC ####

# Arquivo de configuracao do cliente
url='"POST_LOGS_URL="ec2-18-229-150-184.sa-east-1.compute.amazonaws.com"' 
# Verificar se o arquivo de configuracao ja existe
cat /etc/shuvisco.conf
if [ $? -ne 0 ]
then
    # Arquivo ainda nao existe 
    echo $url >> /etc/shuvisco.conf
    chmod +x /etc/shuvisco.conf
else
    # Arquivo ja existe
    sed -i "/POST_LOGS_URL/c\\$url" /etc/serveo.conf
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
chmod +x /root/shuvisco/shuvisco.conf

crontab -l > mycron
# Verificando se ja existe algo no crontab referene ao shuvisco
grep -i "arroz" install.sh
if [ $? -ne 0 ]
then
    # Nenhum rastro de versao anterior instalada
    echo "* * * * * /root/shuvisco/tester.sh" >> mycron
    echo "00 00 * * * /root/shuvisco/send.sh" >> mycron
    crontab mycron
    rm mycron
else
    # Vestigios encontrados
    sed -i "/shuvisco/c\\* * * * * /root/shuvisco/tester.sh" mycron
    sed -i "/shuvisco/c\\00 00 * * * /root/shuvisco/send.sh" mycron
fi

# sudo makeself --notemp shuvisco/ install.run "Extracting files..." ./install.sh

exit 0

