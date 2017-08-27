#!/bin/bash

#
# Copyright 2017 Tw UxTLi51Nus
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -e


# Start interactive shell if desired
if [ "$1" == "/bin/bash" ]; then

    exec /bin/bash

else
    
    # Start Master
    if [ "$1" == "master" ]; then

        exec "${SPARK_HOME}/bin/spark-class" "org.apache.spark.deploy.master.Master"

    # Start Slave
    elif [ "$1" == "slave" ]; then

        if [ -n "$2" ]; then

            exec "${SPARK_HOME}/bin/spark-class" "org.apache.spark.deploy.worker.Worker" "${2}"

        else
            
            echo "Missing Spark Master URL... exiting"
            exit 1
            
        fi

    # else: error
    else

        echo "Unknown parameter: $1"
        exit 1

    fi

fi
