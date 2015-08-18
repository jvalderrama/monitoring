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

INTERVAL=60

while sleep "$INTERVAL"
do

  IFS=$'\r\n' GLOBIGNORE='*' :; NODES=($(yarn node --list 2> /dev/null | sed -e '1,/Node-Id/d' | awk '{ print $1 }' ))

  for node in "${NODES[@]}"
  do

    NODE_NAME=`echo $node | cut -d ":" -f 1 `

    STATUS=`yarn node --status $node 2> /dev/null`

    CONTAINERS=`echo $STATUS | awk '{ print $25 }'`

    MEMORY_USED=`echo $STATUS | awk '{ print $28 }'`
    MEMORY_USED=${MEMORY_USED::-2}


    TOTAL_MEMORY=`echo $STATUS | awk '{ print $31 }'`
    TOTAL_MEMORY=${TOTAL_MEMORY::-2}

    CPU_USED=`echo $STATUS | awk '{ print $34 }'`

    CPU_CAPACITY=`echo $STATUS | awk '{ print $38 }'`

    DATE=`date +%s`

    echo "PUTVAL $NODE_NAME/YARN-Containers/memory interval=$INTERVAL $DATE:$CONTAINERS"
    echo "PUTVAL $NODE_NAME/YARN-MemoryUsed/memory interval=$INTERVAL $DATE:$MEMORY_USED"
    echo "PUTVAL $NODE_NAME/YARN-MemoryCapacity/memory interval=$INTERVAL $DATE:$TOTAL_MEMORY"
    echo "PUTVAL $NODE_NAME/YARN-CPUUsed/memory interval=$INTERVAL $DATE:$CPU_USED"
    echo "PUTVAL $NODE_NAME/YARN-CPUCapacity/memory interval=$INTERVAL $DATE:$CPU_CAPACITY"

  done
done
