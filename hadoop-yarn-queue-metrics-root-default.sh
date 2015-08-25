# -------------------------------------------------------------------------- #
# Copyright 2015, Atos Spain SA                                              #
#                                                                            #
# Licensed under the Apache License, Version 2.0 (the "License"); you may    #
# not use this file except in compliance with the License. You may obtain    #
# a copy of the License at                                                   #
#                                                                            #
#     http://www.apache.org/licenses/LICENSE-2.0                             #
#                                                                            #
# Unless required by applicable law or agreed to in writing, software        #
# distributed under the License is distributed on an "AS IS" BASIS,          #
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.   #
# See the License for the specific language governing permissions and        #
# limitations under the License.                                             #
#--------------------------------------------------------------------------- 

#!/bin/bash

HOSTNAME="Hop-ResourceMan"
INTERVAL=10
HADOOP_METRICS_FILE="/tmp/resourcemanager-metrics.out"
NODE_NAME="YarnQueueMetricsRootDefault"


while sleep "$INTERVAL"
do

    LINE=`tail -n 100 $HADOOP_METRICS_FILE | grep "yarn.QueueMetrics: Queue=root.default" | tail -n 1`
    TIME=`echo $LINE | cut -d" " -f 1`
    running_0=`echo $LINE | awk '{ print $6 }' | cut -d"=" -f 2 | cut -d"," -f 1`
    running_60=`echo $LINE | awk '{ print $7 }' | cut -d"=" -f 2 | cut -d"," -f 1`
    running_300=`echo $LINE | awk '{ print $8 }' | cut -d"=" -f 2 | cut -d"," -f 1`
    running_1440=`echo $LINE | awk '{ print $9}' | cut -d"=" -f 2 | cut -d"," -f 1`
    AppsSubmitted=`echo $LINE | awk '{ print $10}' | cut -d"=" -f 2 | cut -d"," -f 1`
    AppsRunning=`echo $LINE | awk '{ print $11}' | cut -d"=" -f 2 | cut -d"," -f 1`
    AppsPending=`echo $LINE | awk '{ print $12}' | cut -d"=" -f 2 | cut -d"," -f 1`
    AppsCompleted=`echo $LINE | awk '{ print $13}' | cut -d"=" -f 2 | cut -d"," -f 1`
    AppsKilled=`echo $LINE | awk '{ print $14}' | cut -d"=" -f 2 | cut -d"," -f 1`
    AppsFailed=`echo $LINE | awk '{ print $15}' | cut -d"=" -f 2 | cut -d"," -f 1`
    AllocatedMB=`echo $LINE | awk '{ print $16}' | cut -d"=" -f 2 | cut -d"," -f 1`
    AllocatedVCores=`echo $LINE | awk '{ print $17}' | cut -d"=" -f 2 | cut -d"," -f 1`
    AllocatedContainers=`echo $LINE | awk '{ print $18}' | cut -d"=" -f 2 | cut -d"," -f 1`
    AggregateContainersAllocated=`echo $LINE | awk '{ print $19}' | cut -d"=" -f 2 | cut -d"," -f 1`
    AggregateContainersReleased=`echo $LINE | awk '{ print $20}' | cut -d"=" -f 2 | cut -d"," -f 1`
    AvailableMB=`echo $LINE | awk '{ print $21}' | cut -d"=" -f 2 | cut -d"," -f 1`
    AvailableVCores=`echo $LINE | awk '{ print $22}' | cut -d"=" -f 2 | cut -d"," -f 1`
    PendingMB=`echo $LINE | awk '{ print $23}' | cut -d"=" -f 2 | cut -d"," -f 1`
    PendingVCores=`echo $LINE | awk '{ print $24}' | cut -d"=" -f 2 | cut -d"," -f 1`
    PendingContainers=`echo $LINE | awk '{ print $25}' | cut -d"=" -f 2 | cut -d"," -f 1`
    ReservedMB=`echo $LINE | awk '{ print $26}' | cut -d"=" -f 2 | cut -d"," -f 1`
    ReservedVCores=`echo $LINE | awk '{ print $27}' | cut -d"=" -f 2 | cut -d"," -f 1`
    ReservedContainers=`echo $LINE | awk '{ print $28}' | cut -d"=" -f 2 | cut -d"," -f 1`
    ActiveUsers=`echo $LINE | awk '{ print $29}' | cut -d"=" -f 2 | cut -d"," -f 1`
    ActiveApplications=`echo $LINE | awk '{ print $30}' | cut -d"=" -f 2 | cut -d"," -f 1`

    echo "PUTVAL $HOSTNAME/$NODE_NAME-running_0/memory interval=$INTERVAL $TIME:$running_0"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-running_60/memory interval=$INTERVAL $TIME:$running_60"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-running_300/memory interval=$INTERVAL $TIME:$running_300"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-running_1440/memory interval=$INTERVAL $TIME:$running_1440"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-AppsSubmitted/memory interval=$INTERVAL $TIME:$AppsSubmitted"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-AppsRunning/memory interval=$INTERVAL $TIME:$AppsRunning"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-AppsPending/memory interval=$INTERVAL $TIME:$AppsPending"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-AppsCompleted/memory interval=$INTERVAL $TIME:$AppsCompleted"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-AppsFailed/memory interval=$INTERVAL $TIME:$AppsFailed"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-AppsKilled/memory interval=$INTERVAL $TIME:$AppsKilled"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-AllocatedMB/memory interval=$INTERVAL $TIME:$AllocatedMB"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-AllocatedVCores/memory interval=$INTERVAL $TIME:$AllocatedVCores"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-AllocatedContainers/memory interval=$INTERVAL $TIME:$AllocatedContainers"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-AggregateContainersAllocated/memory interval=$INTERVAL $TIME:$AggregateContainersAllocated"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-AggregateContainersReleased/memory interval=$INTERVAL $TIME:$AggregateContainersReleased"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-AvailableMB/memory interval=$INTERVAL $TIME:$AvailableMB"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-AvailableVCores/memory interval=$INTERVAL $TIME:$AvailableVCores"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-PendingMB/memory interval=$INTERVAL $TIME:$PendingMB"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-PendingVCores/memory interval=$INTERVAL $TIME:$PendingVCores"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-PendingContainers/memory interval=$INTERVAL $TIME:$PendingContainers"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-ReservedMB/memory interval=$INTERVAL $TIME:$ReservedMB"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-ReservedVCores/memory interval=$INTERVAL $TIME:$ReservedVCores"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-ReservedContainers/memory interval=$INTERVAL $TIME:$ReservedContainers"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-ActiveUsers/memory interval=$INTERVAL $TIME:$ActiveUsers"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-ActiveApplications/memory interval=$INTERVAL $TIME:$ActiveApplications"

    export INTERVAL=$INTERVAL
    export APPS_SUBMITTED=$AppsSubmitted
    export APPS_RUNNING=$AppsRunning
    export APPS_PENDING=$AppsPending
    export APPS_COMPLETED=$AppsCompleted

    /usr/bin/env ruby <<-EORUBY

      r_AppsSubmitted=ENV['APPS_SUBMITTED']
      r_AppsRunning=ENV['APPS_RUNNING']
      r_AppsPending=ENV['APPS_PENDING']
      r_AppsCompleted=ENV['APPS_COMPLETED']
      #puts "ruby /etc/collectd/scalingd \"#{r_AppsSubmitted} #{r_AppsRunning} #{r_AppsPending} #{r_AppsCompleted}\""
      system("ruby /etc/collectd/scalingd #{r_AppsSubmitted} #{r_AppsRunning} #{r_AppsPending} #{r_AppsCompleted}")

    EORUBY

done
