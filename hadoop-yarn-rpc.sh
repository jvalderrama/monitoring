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
NODE_NAME="RPC-8050"


while sleep "$INTERVAL"
do

    LINE=`tail -n 100 $HADOOP_METRICS_FILE | grep "rpc.rpc: port=8050" | tail -n 1`
    TIME=`echo $LINE | cut -d" " -f 1`
    ReceivedBytes=`echo $LINE | awk '{ print $6 }' | cut -d"=" -f 2 | cut -d"," -f 1`
    SentBytes=`echo $LINE | awk '{ print $7 }' | cut -d"=" -f 2 | cut -d"," -f 1`
    RpcQueueTimeNumOps=`echo $LINE | awk '{ print $8 }' | cut -d"=" -f 2 | cut -d"," -f 1`
    RpcQueueTimeAvgTime=`echo $LINE | awk '{ print $9}' | cut -d"=" -f 2 | cut -d"," -f 1`
    RpcProcessingTimeNumOps=`echo $LINE | awk '{ print $10}' | cut -d"=" -f 2 | cut -d"," -f 1`
    RpcProcessingTimeAvgTime=`echo $LINE | awk '{ print $11}' | cut -d"=" -f 2 | cut -d"," -f 1`
    RpcAuthenticationFailures=`echo $LINE | awk '{ print $12}' | cut -d"=" -f 2 | cut -d"," -f 1`
    RpcAuthenticationSuccesses=`echo $LINE | awk '{ print $13}' | cut -d"=" -f 2 | cut -d"," -f 1`
    RpcAuthorizationFailures=`echo $LINE | awk '{ print $14}' | cut -d"=" -f 2 | cut -d"," -f 1`
    RpcAuthorizationSuccesses=`echo $LINE | awk '{ print $15}' | cut -d"=" -f 2 | cut -d"," -f 1`
    NumOpenConnections=`echo $LINE | awk '{ print $16}' | cut -d"=" -f 2 | cut -d"," -f 1`
    CallQueueLength=`echo $LINE | awk '{ print $17}' | cut -d"=" -f 2 | cut -d"," -f 1`
    
    echo "PUTVAL $HOSTNAME/$NODE_NAME-ReceivedBytes/memory interval=$INTERVAL $TIME:$ReceivedBytes"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-SentBytes/memory interval=$INTERVAL $TIME:$SentBytes"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-RpcQueueTimeNumOps/memory interval=$INTERVAL $TIME:$RpcQueueTimeNumOps"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-RpcQueueTimeAvgTime/memory interval=$INTERVAL $TIME:$RpcQueueTimeAvgTime"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-RpcProcessingTimeNumOps/memory interval=$INTERVAL $TIME:$RpcProcessingTimeNumOps"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-RpcProcessingTimeAvgTime/memory interval=$INTERVAL $TIME:$RpcProcessingTimeAvgTime"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-RpcAuthenticationFailures/memory interval=$INTERVAL $TIME:$RpcAuthenticationFailures"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-RpcAuthenticationSuccesses/memory interval=$INTERVAL $TIME:$RpcAuthenticationSuccesses"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-RpcAuthorizationFailures/memory interval=$INTERVAL $TIME:$RpcAuthorizationFailures"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-RpcAuthorizationSuccesses/memory interval=$INTERVAL $TIME:$RpcAuthorizationSuccesses"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-NumOpenConnections/memory interval=$INTERVAL $TIME:$NumOpenConnections"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-CallQueueLength/memory interval=$INTERVAL $TIME:$CallQueueLength"

done
