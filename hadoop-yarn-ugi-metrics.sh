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
NODE_NAME="UGI"


while sleep "$INTERVAL"
do

    LINE=`tail -n 100 $HADOOP_METRICS_FILE | grep "ugi.UgiMetrics: Context=ugi" | tail -n 1`
    TIME=`echo $LINE | cut -d" " -f 1`
    LoginSuccessNumOps=`echo $LINE | awk '{ print $5 }' | cut -d"=" -f 2 | cut -d"," -f 1`
    LoginSuccessAvgTime=`echo $LINE | awk '{ print $6 }' | cut -d"=" -f 2 | cut -d"," -f 1`
    LoginFailureNumOps=`echo $LINE | awk '{ print $7 }' | cut -d"=" -f 2 | cut -d"," -f 1`
    LoginFailureAvgTime=`echo $LINE | awk '{ print $8}' | cut -d"=" -f 2 | cut -d"," -f 1`
    GetGroupsNumOps=`echo $LINE | awk '{ print $9}' | cut -d"=" -f 2 | cut -d"," -f 1`
    GetGroupsAvgTime=`echo $LINE | awk '{ print $10}' | cut -d"=" -f 2 | cut -d"," -f 1`
        
    echo "PUTVAL $HOSTNAME/$NODE_NAME-LoginSuccessNumOps/memory interval=$INTERVAL $TIME:$LoginSuccessNumOps"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-LoginSuccessAvgTime/memory interval=$INTERVAL $TIME:$LoginSuccessAvgTime"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-LoginFailureNumOps/memory interval=$INTERVAL $TIME:$LoginFailureNumOps"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-LoginFailureAvgTime/memory interval=$INTERVAL $TIME:$LoginFailureAvgTime"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-GetGroupsNumOps/memory interval=$INTERVAL $TIME:$GetGroupsNumOps"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-GetGroupsAvgTime/memory interval=$INTERVAL $TIME:$GetGroupsAvgTime"

done
