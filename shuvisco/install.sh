
echo ""
echo "Shuvisco Instalador"
echo ""

### LOGIC ####
# Script for instalation.

# Instalando o autossh para utilizar com o Serveo:
opkg update
opkg install autossh
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
chmod +x /root/chuvisco/shuvisco.conf

crontab -l > mycron
echo "* * * * * /root/shuvisco/tester.sh" >> mycron
echo "00 00 * * * /root/shuvisco/send.sh" >> mycron
crontab mycron
rm mycron

# sudo makeself --notemp shuvisco/ install.run "Extracting files..." ./install.sh

exit 0

