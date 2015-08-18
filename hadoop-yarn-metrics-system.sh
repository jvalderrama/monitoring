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
NODE_NAME="METRICS_SYSTEM"


while sleep "$INTERVAL"
do

    LINE=`tail -n 100 $HADOOP_METRICS_FILE | grep "metricssystem.MetricsSystem: Context=metricssystem" | tail -n 1`
    TIME=`echo $LINE | cut -d" " -f 1`
    NumActiveSources=`echo $LINE | awk '{ print $5 }' | cut -d"=" -f 2 | cut -d"," -f 1`
    NumAllSources=`echo $LINE | awk '{ print $6 }' | cut -d"=" -f 2 | cut -d"," -f 1`
    NumActiveSinks=`echo $LINE | awk '{ print $7 }' | cut -d"=" -f 2 | cut -d"," -f 1`
    NumAllSinks=`echo $LINE | awk '{ print $8}' | cut -d"=" -f 2 | cut -d"," -f 1`
    Sink_fileNumOps=`echo $LINE | awk '{ print $9}' | cut -d"=" -f 2 | cut -d"," -f 1`
    Sink_fileAvgTime=`echo $LINE | awk '{ print $10}' | cut -d"=" -f 2 | cut -d"," -f 1`
    Sink_fileDropped=`echo $LINE | awk '{ print $11}' | cut -d"=" -f 2 | cut -d"," -f 1`
    Sink_fileQsize=`echo $LINE | awk '{ print $12}' | cut -d"=" -f 2 | cut -d"," -f 1`
    SnapshotNumOps=`echo $LINE | awk '{ print $13}' | cut -d"=" -f 2 | cut -d"," -f 1`
    SnapshotAvgTime=`echo $LINE | awk '{ print $14}' | cut -d"=" -f 2 | cut -d"," -f 1`
    PublishNumOps=`echo $LINE | awk '{ print $15}' | cut -d"=" -f 2 | cut -d"," -f 1`
    PublishAvgTime=`echo $LINE | awk '{ print $15}' | cut -d"=" -f 2 | cut -d"," -f 1`
    DroppedPubAll=`echo $LINE | awk '{ print $15}' | cut -d"=" -f 2 | cut -d"," -f 1`
        
    echo "PUTVAL $HOSTNAME/$NODE_NAME-NumActiveSources/memory interval=$INTERVAL $TIME:$NumActiveSources"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-NumAllSources/memory interval=$INTERVAL $TIME:$NumAllSources"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-NumActiveSinks/memory interval=$INTERVAL $TIME:$NumActiveSinks"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-NumAllSinks/memory interval=$INTERVAL $TIME:$NumAllSinks"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-Sink_fileNumOps/memory interval=$INTERVAL $TIME:$Sink_fileNumOps"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-Sink_fileAvgTime/memory interval=$INTERVAL $TIME:$Sink_fileAvgTime"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-Sink_fileDropped/memory interval=$INTERVAL $TIME:$Sink_fileDropped"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-Sink_fileQsize/memory interval=$INTERVAL $TIME:$Sink_fileQsize"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-SnapshotNumOps/memory interval=$INTERVAL $TIME:$SnapshotNumOps"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-SnapshotAvgTime/memory interval=$INTERVAL $TIME:$SnapshotAvgTime"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-PublishNumOps/memory interval=$INTERVAL $TIME:$PublishNumOps"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-PublishAvgTime/memory interval=$INTERVAL $TIME:$PublishAvgTime"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-DroppedPubAll/memory interval=$INTERVAL $TIME:$DroppedPubAll"

done
