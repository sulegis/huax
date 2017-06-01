#!/bin/bash
#@echo off & setlocal enabledelayedexpansion

FILENAME=$1
echo "curl -v \\" > exec.sh
cat $1 |while read line
do
  if [[ ${line:0:3} == "GET" ]]
  then
     	echo \"$(echo $(echo $line | grep -o " .* "))\" \\ >> exec.sh
  else
  	echo -H \"$line\" \\ >> exec.sh 
  fi
done

echo "| gunzip | more" >> exec.sh
chmod +x exec.sh
cat exec.sh
./exec.sh
