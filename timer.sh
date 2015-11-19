#!/bin/bash

# set LOGFILE to the full path of your desired logfile; make sure
# you have write permissions there. set RETAIN_NUM_LINES to the
# maximum number of lines that should be retained at the beginning
# of your program execution.
# execute 'logsetup' once at the beginning of your script, then 
# use 'log' how many times you like.

#LOGFILE=quicklog.sh.log
LOGFILE="/var/log/fifo-`date +'%Y-%m-%d'`.log"
RETAIN_NUM_LINES=10
HOSTNAME="Hop-ResourceMan"
INTERVAL=5
HADOOP_METRICS_FILE="/tmp/resourcemanager-metrics.out"
NODE_NAME="YarnQueueMetricsRootDefault"

function logsetup {
    TMP=$(tail -n $RETAIN_NUM_LINES $LOGFILE 2>/dev/null) && echo "${TMP}" > $LOGFILE
    exec > >(tee -a $LOGFILE)
    exec 2>&1
}

function log {
    echo "[$(date)]: $*"
}

logsetup


while sleep "$INTERVAL"
do

  LINE_TIME=`tail -n 100 $HADOOP_METRICS_FILE | grep "yarn.QueueMetrics: Queue=root.panacea" | tail -n 1`
  TIME=`echo $LINE_TIME | cut -d" " -f 1`

  LINE=`tail -n 100 $HADOOP_METRICS_FILE | grep "yarn.QueueMetrics: Queue=root.panacea" | tail -n 2`
  reg="(yarn.QueueMetrics.*)(yarn.QueueMetrics)"
  if [[ $LINE =~ $reg ]]; then
   LINE=${BASH_REMATCH[1]}
  fi

  running_0=`echo $LINE | awk '{ print $5 }' | cut -d"=" -f 2 | cut -d"," -f 1`
  running_60=`echo $LINE | awk '{ print $6 }' | cut -d"=" -f 2 | cut -d"," -f 1`
  running_300=`echo $LINE | awk '{ print $7 }' | cut -d"=" -f 2 | cut -d"," -f 1`
  running_1440=`echo $LINE | awk '{ print $8 }' | cut -d"=" -f 2 | cut -d"," -f 1`   
  FairShareMB=`echo $LINE | awk '{ print $9 }' | cut -d"=" -f 2 | cut -d"," -f 1`
  FairShareVCores=`echo $LINE | awk '{ print $10 }' | cut -d"=" -f 2 | cut -d"," -f 1`
  SteadyFairShareMB=`echo $LINE | awk '{ print $11 }' | cut -d"=" -f 2 | cut -d"," -f 1`
  SteadyFairShareVCores=`echo $LINE | awk '{ print $12 }' | cut -d"=" -f 2 | cut -d"," -f 1`
  MinShareMB=`echo $LINE | awk '{ print $13 }' | cut -d"=" -f 2 | cut -d"," -f 1`
  MinShareVCores=`echo $LINE | awk '{ print $14 }' | cut -d"=" -f 2 | cut -d"," -f 1`
  MaxShareMB=`echo $LINE | awk '{ print $15 }' | cut -d"=" -f 2 | cut -d"," -f 1`
  MaxShareVCores=`echo $LINE | awk '{ print $16 }' | cut -d"=" -f 2 | cut -d"," -f 1`
  AppsSubmitted=`echo $LINE | awk '{ print $17 }' | cut -d"=" -f 2 | cut -d"," -f 1`
  AppsRunning=`echo $LINE | awk '{ print $18 }' | cut -d"=" -f 2 | cut -d"," -f 1`
  AppsPending=`echo $LINE | awk '{ print $19 }' | cut -d"=" -f 2 | cut -d"," -f 1`
  AppsCompleted=`echo $LINE | awk '{ print $20 }' | cut -d"=" -f 2 | cut -d"," -f 1`
  AppsKilled=`echo $LINE | awk '{ print $21 }' | cut -d"=" -f 2 | cut -d"," -f 1`
  AppsFailed=`echo $LINE | awk '{ print $22 }' | cut -d"=" -f 2 | cut -d"," -f 1`
  AllocatedMB=`echo $LINE | awk '{ print $23 }' | cut -d"=" -f 2 | cut -d"," -f 1`
  AllocatedVCores=`echo $LINE | awk '{ print $24 }' | cut -d"=" -f 2 | cut -d"," -f 1`
  AllocatedContainers=`echo $LINE | awk '{ print $25 }' | cut -d"=" -f 2 | cut -d"," -f 1`
  AggregateContainersAllocated=`echo $LINE | awk '{ print $26 }' | cut -d"=" -f 2 | cut -d"," -f 1`
  AggregateContainersReleased=`echo $LINE | awk '{ print $27 }' | cut -d"=" -f 2 | cut -d"," -f 1`
  AvailableMB=`echo $LINE | awk '{ print $28 }' | cut -d"=" -f 2 | cut -d"," -f 1`
  AvailableVCores=`echo $LINE | awk '{ print $29 }' | cut -d"=" -f 2 | cut -d"," -f 1`
  PendingMB=`echo $LINE | awk '{ print $30 }' | cut -d"=" -f 2 | cut -d"," -f 1`
  PendingVCores=`echo $LINE | awk '{ print $31 }' | cut -d"=" -f 2 | cut -d"," -f 1`
  PendingContainers=`echo $LINE | awk '{ print $32 }' | cut -d"=" -f 2 | cut -d"," -f 1`
  ReservedMB=`echo $LINE | awk '{ print $33 }' | cut -d"=" -f 2 | cut -d"," -f 1`
  ReservedVCores=`echo $LINE | awk '{ print $34 }' | cut -d"=" -f 2 | cut -d"," -f 1`
  ReservedContainers=`echo $LINE | awk '{ print $35 }' | cut -d"=" -f 2 | cut -d"," -f 1`
  ActiveUsers=`echo $LINE | awk '{ print $36 }' | cut -d"=" -f 2 | cut -d"," -f 1`
  #TODO-ActiveApplications=`echo $LINE | awk '{ print $37 }' | cut -d"=" -f 2 | cut -d"\\" -f 1`

  log AppsRunning $AppsRunning , AppsCompleted: $AppsCompleted

done
