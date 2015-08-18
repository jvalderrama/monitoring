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
NODE_NAME="RPC-DETAILED-8050"


while sleep "$INTERVAL"
do

    LINE=`tail -n 100 $HADOOP_METRICS_FILE | grep "rpcdetailed.rpcdetailed: port=8050" | tail -n 1`
    TIME=`echo $LINE | cut -d" " -f 1`
    GetApplicationsNumOps=`echo $LINE | awk '{ print $6 }' | cut -d"=" -f 2 | cut -d"," -f 1`
    GetApplicationsAvgTime=`echo $LINE | awk '{ print $7 }' | cut -d"=" -f 2 | cut -d"," -f 1`
    GetNewApplicationNumOps=`echo $LINE | awk '{ print $8 }' | cut -d"=" -f 2 | cut -d"," -f 1`
    GetNewApplicationAvgTime=`echo $LINE | awk '{ print $9}' | cut -d"=" -f 2 | cut -d"," -f 1`
    SubmitApplicationNumOps=`echo $LINE | awk '{ print $10}' | cut -d"=" -f 2 | cut -d"," -f 1`
    SubmitApplicationAvgTime=`echo $LINE | awk '{ print $11}' | cut -d"=" -f 2 | cut -d"," -f 1`
    GetApplicationReportNumOps=`echo $LINE | awk '{ print $12}' | cut -d"=" -f 2 | cut -d"," -f 1`
    GetApplicationReportAvgTime=`echo $LINE | awk '{ print $13}' | cut -d"=" -f 2 | cut -d"," -f 1`
    GetApplicationAttemptsNumOps=`echo $LINE | awk '{ print $14}' | cut -d"=" -f 2 | cut -d"," -f 1`
    GetApplicationAttemptsAvgTime=`echo $LINE | awk '{ print $15}' | cut -d"=" -f 2 | cut -d"," -f 1`
    GetApplicationAttemptReportNumOps=`echo $LINE | awk '{ print $16}' | cut -d"=" -f 2 | cut -d"," -f 1`
    GetApplicationAttemptReportAvgTime=`echo $LINE | awk '{ print $17}' | cut -d"=" -f 2 | cut -d"," -f 1`
    GetContainersNumOps=`echo $LINE | awk '{ print $18}' | cut -d"=" -f 2 | cut -d"," -f 1`
    GetContainersAvgTime=`echo $LINE | awk '{ print $19}' | cut -d"=" -f 2 | cut -d"," -f 1`
    GetContainerReportNumOps=`echo $LINE | awk '{ print $20}' | cut -d"=" -f 2 | cut -d"," -f 1`
    GetContainerReportAvgTime=`echo $LINE | awk '{ print $21}' | cut -d"=" -f 2 | cut -d"," -f 1`
    GetQueueInfoNumOps=`echo $LINE | awk '{ print $22}' | cut -d"=" -f 2 | cut -d"," -f 1`
    GetQueueInfoAvgTime=`echo $LINE | awk '{ print $23}' | cut -d"=" -f 2 | cut -d"," -f 1`
    
    echo "PUTVAL $HOSTNAME/$NODE_NAME-GetApplicationsNumOps/memory interval=$INTERVAL $TIME:$GetApplicationsNumOps"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-GetApplicationsAvgTime/memory interval=$INTERVAL $TIME:$GetApplicationsAvgTime"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-GetNewApplicationNumOps/memory interval=$INTERVAL $TIME:$GetNewApplicationNumOps"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-GetNewApplicationAvgTime/memory interval=$INTERVAL $TIME:$GetNewApplicationAvgTime"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-SubmitApplicationNumOps/memory interval=$INTERVAL $TIME:$SubmitApplicationNumOps"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-SubmitApplicationAvgTime/memory interval=$INTERVAL $TIME:$SubmitApplicationAvgTime"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-GetApplicationReportNumOps/memory interval=$INTERVAL $TIME:$GetApplicationReportNumOps"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-GetApplicationReportAvgTime/memory interval=$INTERVAL $TIME:$GetApplicationReportAvgTime"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-GetApplicationAttemptsNumOps/memory interval=$INTERVAL $TIME:$GetApplicationAttemptsNumOps"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-GetApplicationAttemptsAvgTime/memory interval=$INTERVAL $TIME:$GetApplicationAttemptsAvgTime"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-GetApplicationAttemptReportNumOps/memory interval=$INTERVAL $TIME:$GetApplicationAttemptReportNumOps"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-GetApplicationAttemptReportAvgTime/memory interval=$INTERVAL $TIME:$GetApplicationAttemptReportAvgTime"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-GetContainersNumOps/memory interval=$INTERVAL $TIME:$GetContainersNumOps"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-GetContainersAvgTime/memory interval=$INTERVAL $TIME:$GetContainersAvgTime"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-GetContainerReportAvgTime/memory interval=$INTERVAL $TIME:$GetContainerReportAvgTime"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-GetQueueInfoNumOps/memory interval=$INTERVAL $TIME:$GetQueueInfoNumOps"
    echo "PUTVAL $HOSTNAME/$NODE_NAME-GetQueueInfoAvgTime/memory interval=$INTERVAL $TIME:$GetQueueInfoAvgTime"

done
