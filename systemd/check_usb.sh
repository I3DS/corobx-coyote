#!/bin/bash

counter=0

while true
do
    ls /dev/vzense-hid > /dev/null 2>&1
    a=`echo $?`
    echo $a
    if [[ $a == 2 ]];
    then
        exit 0
    fi
    
    if [[ $counter == 60 ]];
    then
        echo "Unable to find the vzense systemlink. Waited 60 seconds."
        exit 1
    fi
    counter=$((counter+1))
    sleep 1
done