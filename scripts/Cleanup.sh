#!/bin/bash

sudo -S -k -- sh  -c "sed -i.bak '/HadoopSlave/d' /etc/hosts"
sudo -S -k -- sh  -c "sed -i.bak '/HadoopSlave/d' /usr/local/hadoop/etc/hadoop/slaves"
