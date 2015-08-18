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
NODE_NAME="RPC-DETAILED-8030"


while sleep "$INTERVAL"
do

    LINE=`tail -n 100 $HADOOP_METRICS_FILE | grep "rpcdetailed.rpcdetailed: port=8030" | tail -n 1`
    TIME=`echo $LINE | cut -d" " -f 1`
    RegisterApplicationMasterNumOps=`echo $LINE | awk '{ print $6 }' | cut -d"=" -f 2 | cut -d"," -f 1`
    RegisterApplicationMasterAvgTime=`echo $LINE | awk '{ print $7 }' | cut -d"=" -f 2 | cut -d"," -f 1`
    AllocateNumOps=`echo $LINE | awk '{ print $8 }' | cut -d"=" -f 2 | cut -d"," -f 1`
    AllocateAvgTime=`echo $LINE | awk '{ print $9}' | cut -d"=" -f 2 | cut -d"," -f 1`
    FinishApplicationMasterNumOps=`echo $LINE | awk '{ print $10}' | cut -d"=" -f 2 | cut -d"," -f 1`
    FinishApplicationMasterAvgTime=`echo $LINE | awk '{ print $11}' | cut -d"=" -f 2 | cut -d"," -f 1`
    
    echo "PUTVAL $HOSTNAME/$NODE_NAME-RegisterApplicationMasterNumOps/memory interval=$INTERVAL $TIME:$RegisterApplicationMasterNumOps"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-RegisterApplicationMasterAvgTime/memory interval=$INTERVAL $TIME:$RegisterApplicationMasterAvgTime"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-AllocateNumOps/memory interval=$INTERVAL $TIME:$AllocateNumOps"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-AllocateAvgTime/memory interval=$INTERVAL $TIME:$AllocateAvgTime"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-FinishApplicationMasterNumOps/memory interval=$INTERVAL $TIME:$FinishApplicationMasterNumOps"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-FinishApplicationMasterAvgTime/memory interval=$INTERVAL $TIME:$FinishApplicationMasterAvgTime"
    
done
