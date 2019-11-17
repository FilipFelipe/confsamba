echo "iniciando"
yum install figlet
figlet Samba - IFSP
echo -e "Clique em \e[1;33Qualquer\e[0m tecla para continuar..."
read -n 1
echo "instalando samba"
#instalando samba
yum install samba samba-client samba-doc samba-swat
clear 


echo "criando as pastas"
#criando as pastas
mkdir /home/publica
mkdir /home/financeiro
mkdir /home/arquivos
mkdir /home/admin


sleep 2
clear
echo "fazendo backup"
hoje=$(date +%F)
#criando backup com a data atual
cp /etc/samba/smb.conf /etc/samba/smb.conf_backup_$hoje
rm /etc/samba/smb.conf
cp smb.conf /etc/samba
sleep 2
clear 

echo "configurando usuarios e grupos ..."
sleep 2
#criando grupos 
echo "Criando grupos"
groupadd financeiro 
groupadd admin 

sleep 2
echo "Criando usuarios"
#criando usuarios de controle 
useradd admin_controle
useradd financeiro_controle

#atribuindo usuarios aos grupos
gpasswd -a admin_controle admin
gpasswd -a financeiro_controle financeiro

#mudando grupos
chgrp financeiro /home/financeiro
chgrp admin /home/admin
clear

chmod 777 -R /home/publica
chmod 770 -R /home/financeiro
chmod 755 -R /home/arquivos
chmod 770 -R /home/admin
clear 
echo "atribuindo senha admin_controle"
smbpasswd -a admin_controle
echo "atribuindo senha financeiro_controle"
smbpasswd -a financeiro_controle
clear
echo "configuração do samba finalizada !!!"
read op
echo "Deseja reiniciar o samba ?"

sleep 2
echo "reinciando o samba"
systemctl stop smb
systemctl start smb 
sleep 1
echo "finalizado"
systemctl status smb