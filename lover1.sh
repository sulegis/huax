#!/bin/bash
target_time="23:15:00"
gmt_time=""


while [ "$gmt_time" != "$target_time" ]
do
echo now $gmt_time, waiting for $target_time
gmt_time=`curl -s --head "http://wx.motherchildren.com/index.php?g=WapApi&m=Register&a=getDoctorDetail&doctorid=5504&date=2017-06-04" | grep Date: | egrep -o '[[:digit:]]{1,2}\:[[:digit:]]{1,2}\:[[:digit:]]{1,2}'`
done

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
