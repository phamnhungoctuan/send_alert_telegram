HOSTS="https://tuanpham.dev"

KEY=""

URL="https://api.telegram.org/bot${KEY}/sendMessage"
DATE="$(date "+%d %b %Y %H:%M")"

for myHost in $HOSTS
do
  statusCode=$(curl -m 5 -s -o /dev/null -w "%{http_code}" $myHost)
  if [ $statusCode != 200 ]; then
    # 100% failed 
    TEXT="ALERT! Web : $myHost is down (ping failed) at $DATE"

    curl -s -d "chat_id=${USER_ID}&text=${TEXT}&disable_web_page_preview=true&parse_mode=markdown" $URL > /dev/null
  fi
done 

* * * * * sh ./root/ping.sh >> /var/log/ping-server.log
