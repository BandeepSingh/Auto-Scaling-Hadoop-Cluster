#!/bin/bash
while read line
do
echo "$line"
scp /etc/hosts hduser@$line:/etc/hosts
done < /usr/local/hadoop/etc/hadoop/slaves
