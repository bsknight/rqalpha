set -x
yesterday_str=`date +%Y-%m-%d -d "-1 days"`
#yesterday_str=`date +%Y-%m-%d -d`
cp select.template select.sql
sed "s/today_date/$yesterday_str/" select.template > select.sql
res=`sqlplus -S CJHJDM/CJHJDM@172.16.48.205:1521/cjhjdm @./select.sql`
echo $res

if [ "$res" -eq 0 ]; then
    today_date=`date +%Y%m%d%H%M%S`
    echo $today_date valuation data error
    echo $today_date valuation data error | /usr/sbin/sendmail -t xiesc1@cjsc.com
else 
    echo "valuation data OK"
fi


