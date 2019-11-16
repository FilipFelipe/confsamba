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



clear
echo "fazendo backup"
hoje=$(date +%F)
#criando backup com a data atual
cp /etc/samba/smb.conf /etc/samba/smb.conf_backup$hoje
rm /etc/samba/smb.conf
cp smb.conf /etc/samba
clear 

echo "configurando usuarios e grupos ..."
#criando grupos 
echo "Criando grupos"
groupadd financeiro 
groupadd admin 


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

echo "finalizado"
smbpasswd -a admin_controle
smbpasswd -a financeiro_controle

