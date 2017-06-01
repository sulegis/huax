#!/bin/bash
session=""
target_time="07:41:00"
cookie_other="cookie_dept=7; cookie_SessionType=; cookie_selectdate=2017-06-15; card_list_url=http%3A//wx.motherchildren.com/index.php%3Fg%3DWap%26m%3DWxView%26d%3DregisterAndAppoint%26a%3Dindex%23selectCard.html%3Fschedulid%3D49401%26regSchedulidInfo%3D%257B%2522date%2522%253A%25222017-06-15%2522%252C%2522docName%2522%253A%2522%25u674E%25u94A6%25u4F2F%2522%252C%2522deptname%2522%253A%2522%25u513F%25u79D1%25u95E8%25u8BCA%2522%252C%2522sumfee%2522%253A%252253%2522%257D; tgw_l7_route=2cdd9f28c76f60c83147696ff4b9fce6"

gmt_time=""

while [ "$gmt_time" != "$target_time" ]
do
echo now $gmt_time, waiting for $target_time
gmt_time=`curl -s --head "http://wx.motherchildren.com/index.php?g=WapApi&m=Register&a=getDoctorDetail&doctorid=5504&date=2017-06-04" | grep Date: | egrep -o '[[:digit:]]{1,2}\:[[:digit:]]{1,2}\:[[:digit:]]{1,2}'`
done

echo BINGO~ $gmt_time, Click!!!
curl -v \
-H 'Host: wx.motherchildren.com' \
-H 'Connection: keep-alive' \
-H 'Accept: */*' \
-H 'User-Agent: AppleWebKit/537.36 (KHTML, like Gecko)' \
-H 'X-Requested-With: XMLHttpRequest' \
-H 'Referer: http://wx.motherchildren.com/index.php?g=Wap&m=WxView&d=registerAndAppoint&a=index' \
-H 'Accept-Encoding: gzip, deflate' \
-H 'Accept-Language: zh-CN,zh;q=0.8,en-us;q=0.6,en;q=0.5;q=0.4' \
-H "Cookie: PHPSESSID=$session; $cookie_other" \
"http://wx.motherchildren.com/index.php?g=WapApi&m=Register&a=submitReg&tagArray=149%2C433%3B521%2C435&schedulid=49401&userid=754120" | gunzip | more
