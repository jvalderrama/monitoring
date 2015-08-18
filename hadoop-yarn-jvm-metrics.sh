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
NODE_NAME="RESOURCE-MANAGER-JVM"


while sleep "$INTERVAL"
do

LINE=`tail -n 100 $HADOOP_METRICS_FILE | grep jvm.JvmMetrics | tail -n 1`
TIME=`echo $LINE | cut -d" " -f 1`
MemHeapUsedM=`echo $LINE | awk '{ print $10 }' | cut -d"=" -f 2 | cut -d"," -f 1`
MemNonHeapUsedM=`echo $LINE | awk '{ print $7 }' | cut -d"=" -f 2 | cut -d"," -f 1`
MemNonHeapCommittedM=`echo $LINE | awk '{ print $8 }' | cut -d"=" -f 2 | cut -d"," -f 1`
MemNonHeapMaxM=`echo $LINE | awk '{ print $9 }' | cut -d"=" -f 2 | cut -d"," -f 1`
MemHeapCommittedM=`echo $LINE | awk '{ print $11 }' | cut -d"=" -f 2 | cut -d"," -f 1`
MemHeapMaxM=`echo $LINE | awk '{ print $12 }' | cut -d"=" -f 2 | cut -d"," -f 1`
MemMaxM=`echo $LINE | awk '{ print $13 }' | cut -d"=" -f 2 | cut -d"," -f 1`
GcCountPS_Scavenge=`echo $LINE | awk '{ print $15 }' | cut -d"=" -f 2 | cut -d"," -f 1`
GcTimeMillisPS_Scavenge=`echo $LINE | awk '{ print $17 }' | cut -d"=" -f 2 | cut -d"," -f 1`
GcCountPS_MarkSweep=`echo $LINE | awk '{ print $19 }' | cut -d"=" -f 2 | cut -d"," -f 1`
GcTimeMillisPS_MarkSweep=`echo $LINE | awk '{ print $21 }' | cut -d"=" -f 2 | cut -d"," -f 1`
GcCount=`echo $LINE | awk '{ print $22 }' | cut -d"=" -f 2 | cut -d"," -f 1`
GcTimeMillis=`echo $LINE | awk '{ print $23 }' | cut -d"=" -f 2 | cut -d"," -f 1`
ThreadsNew=`echo $LINE | awk '{ print $24 }' | cut -d"=" -f 2 | cut -d"," -f 1`
ThreadsRunnable=`echo $LINE | awk '{ print $25 }' | cut -d"=" -f 2 | cut -d"," -f 1`
ThreadsBlocked=`echo $LINE | awk '{ print $26 }' | cut -d"=" -f 2 | cut -d"," -f 1`
ThreadsWaiting=`echo $LINE | awk '{ print $27 }' | cut -d"=" -f 2 | cut -d"," -f 1`
ThreadsTimedWaiting=`echo $LINE | awk '{ print $28 }' | cut -d"=" -f 2 | cut -d"," -f 1`
ThreadsTerminated=`echo $LINE | awk '{ print $29 }' | cut -d"=" -f 2 | cut -d"," -f 1`

echo "PUTVAL $HOSTNAME/$NODE_NAME-MemHeapUsedM/memory interval=$INTERVAL $TIME:$MemHeapUsedM"
echo "PUTVAL $HOSTNAME/$NODE_NAME-MemNonHeapUsedM/memory interval=$INTERVAL $TIME:$MemNonHeapUsedM"
echo "PUTVAL $HOSTNAME/$NODE_NAME-MemNonHeapCommittedM/memory interval=$INTERVAL $TIME:$MemNonHeapCommittedM"
echo "PUTVAL $HOSTNAME/$NODE_NAME-MemNonHeapMaxM/memory interval=$INTERVAL $TIME:$MemNonHeapMaxM"
echo "PUTVAL $HOSTNAME/$NODE_NAME-MemHeapCommittedM/memory interval=$INTERVAL $TIME:$MemHeapCommittedM"
echo "PUTVAL $HOSTNAME/$NODE_NAME-MemHeapMaxM/memory interval=$INTERVAL $TIME:$MemHeapMaxM"
echo "PUTVAL $HOSTNAME/$NODE_NAME-MemMaxM/memory interval=$INTERVAL $TIME:$MemMaxM"
echo "PUTVAL $HOSTNAME/$NODE_NAME-GcCountPS_Scavenge/memory interval=$INTERVAL $TIME:$GcCountPS_Scavenge"
echo "PUTVAL $HOSTNAME/$NODE_NAME-GcTimeMillisPS_Scavenge/memory interval=$INTERVAL $TIME:$GcTimeMillisPS_Scavenge"
echo "PUTVAL $HOSTNAME/$NODE_NAME-GcCountPS_MarkSweep/memory interval=$INTERVAL $TIME:$GcCountPS_MarkSweep"
echo "PUTVAL $HOSTNAME/$NODE_NAME-GcTimeMillisPS_MarkSweep/memory interval=$INTERVAL $TIME:$GcTimeMillisPS_MarkSweep"
echo "PUTVAL $HOSTNAME/$NODE_NAME-GcCount/memory interval=$INTERVAL $TIME:$GcCount"
echo "PUTVAL $HOSTNAME/$NODE_NAME-GcTimeMillis/memory interval=$INTERVAL $TIME:$GcTimeMillis"
echo "PUTVAL $HOSTNAME/$NODE_NAME-ThreadsNew/memory interval=$INTERVAL $TIME:$ThreadsNew"
echo "PUTVAL $HOSTNAME/$NODE_NAME-ThreadsRunnable/memory interval=$INTERVAL $TIME:$ThreadsRunnable"
echo "PUTVAL $HOSTNAME/$NODE_NAME-ThreadsBlocked/memory interval=$INTERVAL $TIME:$ThreadsBlocked"
echo "PUTVAL $HOSTNAME/$NODE_NAME-ThreadsWaiting/memory interval=$INTERVAL $TIME:$ThreadsWaiting"
echo "PUTVAL $HOSTNAME/$NODE_NAME-ThreadsTimedWaiting/memory interval=$INTERVAL $TIME:$ThreadsTimedWaiting"
echo "PUTVAL $HOSTNAME/$NODE_NAME-ThreadsTerminated/memory interval=$INTERVAL $TIME:$ThreadsTerminated"

done
