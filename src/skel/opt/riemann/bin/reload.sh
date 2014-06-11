#!/bin/bash

pid=$( pgrep -f 'java.*riemann' )

if [ -z "${pid}" ]; then
    logger -t restart_riemann -- "Can't find Riemann PID"
else
    logger -t restart_riemann -- "Sending signal to ${pid}"
    
    kill -HUP ${pid}
fi
