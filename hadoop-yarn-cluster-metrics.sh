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
#--------------------------------------------------------------------------- #


#!/bin/bash

HOSTNAME="Hop-ResourceMan"
INTERVAL=10
HADOOP_METRICS_FILE="/tmp/resourcemanager-metrics.out"
NODE_NAME="YarnCluster"


while sleep "$INTERVAL"
do

    LINE=`tail -n 100 $HADOOP_METRICS_FILE | grep yarn.ClusterMetrics | tail -n 1`
    TIME=`echo $LINE | cut -d" " -f 1`
    NumActiveNMs=`echo $LINE | awk '{ print $6 }' | cut -d"=" -f 2 | cut -d"," -f 1`
    NumDecommissionedNMs=`echo $LINE | awk '{ print $7 }' | cut -d"=" -f 2 | cut -d"," -f 1`
    NumLostNMs=`echo $LINE | awk '{ print $8 }' | cut -d"=" -f 2 | cut -d"," -f 1`
    NumUnhealthyNMs=`echo $LINE | awk '{ print $9}' | cut -d"=" -f 2 | cut -d"," -f 1`
    NumRebootedNMs=`echo $LINE | awk '{ print $10}' | cut -d"=" -f 2 | cut -d"," -f 1`

    echo "PUTVAL $HOSTNAME/$NODE_NAME-NumActiveNMs/memory interval=$INTERVAL $TIME:$NumActiveNMs"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-NumDecommissionedNMs/memory interval=$INTERVAL $TIME:$NumDecommissionedNMs"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-NumLostNMs/memory interval=$INTERVAL $TIME:$NumLostNMs"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-NumUnhealthyNMs/memory interval=$INTERVAL $TIME:$NumUnhealthyNMs"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-NumRebootedNMs/memory interval=$INTERVAL $TIME:$NumRebootedNMs"

done
