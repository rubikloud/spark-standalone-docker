#!/bin/bash

set -e


# Start interactive shell if desired
if [ "$1" == "/bin/bash" ]; then

    exec /bin/bash

else
    
    # Start Master
    if [ "$1" == "master" ]; then
        # if using w/ 'exec', script terminates after completion of
        # this command, the rest of the script is not executed (BUG?)
        # put exec in front of command
        "${SPARK_HOME}/sbin/start-master.sh"

    # Start Slave
    elif [ "$1" == "slave" ]; then

        if [ -n "$2" ]; then

            # if using w/ 'exec', script terminates after completion of
            # this command, the rest of the script is not executed (BUG?)
            # put exec in front of command
            "${SPARK_HOME}/sbin/start-slave.sh" "${2}"

        else
            
            echo "Missing Spark Master URL... exiting"
            exit 1
            
        fi

    # else: error
    else

        echo "Unknown parameter: $1"
        exit 1

    fi

    # view logfile of started service:
    exec tail -f ${SPARK_HOME}/logs/*

fi
