#!/bin/sh
echo 'hduser' | sudo -S -k -- sh  -c 'echo 199.60.17.170 HadoopSlave61>>/etc/hosts'
echo HadoopSlave61>>/usr/local/hadoop/etc/hadoop/slaves
ssh-copy-id -i /home/hduser/.ssh/id_rsa.pub -o StrictHostKeyChecking=no hduser@HadoopSlave61
/usr/local/hadoop/sbin/start-dfs.sh
/usr/local/hadoop/sbin/start-yarn.sh
