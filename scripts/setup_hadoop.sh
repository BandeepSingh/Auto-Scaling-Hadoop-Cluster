#!/bin/sh

sshpass -phduser scp -o StrictHostKeyChecking=no hduser@199.60.17.168:/home/hduser/count_node.txt /home/hduser/
CURR_VALUE=$(cat /home/hduser/count_node.txt)
NEW_VALUE=$((CURR_VALUE+1))
echo $NEW_VALUE
touch /home/hduser/count_node.txt
chmod +777 /home/hduser/count_node.txt
echo $NEW_VALUE|cat >/home/hduser/count_node.txt

#sshpass -phduser ssh hduser@199.60.17.168 "rm /home/hduser/count_node.txt"
sshpass -phduser scp -o StrictHostKeyChecking=no /home/hduser/count_node.txt hduser@199.60.17.168:/home/hduser/

#Update hostname in new slave
slave_name="HadoopSlave$NEW_VALUE"
sudo hostname $slave_name

#Update /etc/hosts file in new slave with master and new slaves ip address. Removing the default configurations (127.0.0.1 and 127.0.0.0)
ip="$(ifconfig | grep -A 1 'eth0' | tail -1 | cut -d ':' -f 2 | cut -d ' ' -f 1)"
ip_master="199.60.17.168"

echo 'hduser' | sudo -S -k -- sh  -c "echo $ip $slave_name>> /etc/hosts"
echo 'hduser' | sudo -S -k -- sh  -c "echo $ip_master HadoopMaster>> /etc/hosts"
echo 'hduser' | sudo -S -k -- sh  -c "sed -i.bak '/127/d' /etc/hosts"

#creating dynamic local script
touch /home/hduser/local_script.sh
chmod 777 /home/hduser/local_script.sh
echo "#!/bin/sh">> /home/hduser/local_script.sh
echo "echo 'hduser' | sudo -S -k -- sh  -c 'echo $ip $slave_name>>/etc/hosts'">>/home/hduser/local_script.sh
echo "echo $slave_name>>/usr/local/hadoop/etc/hadoop/slaves">> /home/hduser/local_script.sh
echo "ssh-copy-id -i $HOME/.ssh/id_rsa.pub -o StrictHostKeyChecking=no hduser@$slave_name">> /home/hduser/local_script.sh
echo "/usr/local/hadoop/sbin/start-dfs.sh">> /home/hduser/local_script.sh
echo "/usr/local/hadoop/sbin/start-yarn.sh">> /home/hduser/local_script.sh

sshpass -phduser ssh -o StrictHostKeyChecking=no hduser@199.60.17.168 'sh ' < /home/hduser/local_script.sh



