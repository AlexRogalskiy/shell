#!/bin/bash

echo "Parent process (PID=$pid) is running"
case_01 & pid=$!
echo "CHild process (PID=$pid) is running"

sleep 20
wait $pid

echo "Parent process: child process is finished"
echo "Parent process: exit"

