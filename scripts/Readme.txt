##############################################READ ME###########################################################################################################3
A Brief Description of the scripts we made for the Auto Scaling Hadoop Cluster on Apache Cloud Stack

-createLoad.sh

Creates the load on the hadoop cluster


-schedule.sh

Monitors the  server and schedules the spawing of new instances or destroying the existing instances based on the load


-deploy.py

deploys the new data nodes for the hadoop cluster


-destroy.py

destroys the existing instances on the hadoop cluster


-setup_hadoop

Makes necssary changes in the newly spawned node to make it ready to be data node and contacts master node by creating local_script.sh


-local_script.sh

contacts the master node and executes commands to attach the newly spawned data node


-Cleanup.sh

Cleans the /etc/hosts file of master for the nodes that got destroyed to avoid any confusion between the ip_address and host names on cluster setup_hadoop


-sync_hosts.sh

The file copies the /etc/hosts of master to all the slave nodes,thereby ensuring proper data replication to the newly spawned data node.


-count_instances.py

The code helps to know how many active instances are running in the cloud environment at the given point of time.




