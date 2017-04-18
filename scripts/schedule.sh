#!/bin/bash
# My first script

ACT_YARN_ID=$(/usr/local/hadoop/bin/yarn application -list -appStates ACCEPTED| wc -l)

RUN_YARN_ID=$(/usr/local/hadoop/bin/yarn application -list -appStates RUNNING| wc -l)
echo "Accepted Apps: $ACT_YARN_ID" | tee -a $LOG_FILE
echo "Running Apps: $RUN_YARN_ID" | tee -a $LOG_FILE
LOG_FILE="scheduleLog.txt"

NoAcceptedApps=$((ACT_YARN_ID-2))

NoRunningApps=$((RUN_YARN_ID-2))

TotalApps=$((NoAcceptedApps+NoRunningApps))

now=$(date)

NoInstances=$(python count_instances.py 2>&1)

if [ $NoAcceptedApps -gt 1 ] && [ $NoInstances -lt 7 ];
then 
	echo "$now Time to scale up. Total Running Apps:$NoRunningApps Total Accepted Apps:$NoAcceptedApps. Total Instances:$NoInstances" | tee -a $LOG_FILE
	chmod 755 /home/hduser/deploy.py
  python /home/hduser/deploy.py
else
  if  [ $TotalApps -ne 0 ];
  then
  	echo "$now All is good.Total Running Apps:$NoRunningApps Total Accepted Apps:$NoAcceptedApps. Total Instances:$NoInstances  " | tee -a $LOG_FILE
  else
    if [ $NoInstances -gt 2 ];
    then
      echo "$now Time to scale down. Total Running Apps:$NoRunningApps Total Accepted Apps:$NoAcceptedApps. Total Instances:$NoInstances" | tee -a $LOG_FILE
      python /home/hduser/destroy.py
      sh /home/hduser/Cleanup.sh
    else
	    echo "Nothing is executing. Running on min resources Total Running Apps:$NoRunningApps Total Accepted Apps:$NoAcceptedApps. Total Instances:$NoInstances" | tee -a $LOG_FILE
    fi  
  fi
fi
