#!/bin/sh
#set -x
#export JAVA_HOME=/usr/java/jre1.8.0_101
#export JRE_HOME=/usr/java/jre1.8.0_101
#export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib:$JRE_HOME/lib
#export ORACLE_HOME=/usr/lib/oracle/12.1/client64
#export TNS_ADMIN=$ORACLE_HOME/network/admin
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME/lib
#export PATH=$PATH:$ORACLE_HOME/bin:/usr/local/lib/:$JAVA_HOME/bin:$JRE_HOME/bin

#export PATH=$PATH:/usr/local/lib/:/usr/lib:/usr/lib64/
#export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/lib/oracle/12.1/client64a/lib:/usr/lib:/usr/lib64/:/usr/local/lib
#export NLS_LANG="AMERICAN_AMERICA.ZHS16GBK"
#export NLS_DATE_FORMAT='YYYY-MM-DD'

#WORKSPACE_PATH='/home/workspace/rqalpha/rqalpha/zeus/'
#LOCAL_IP='172.16.50.141'
#names=('ffp' 'ffr' 'peg' 'grcxhs' 'grcxcap' 'ffe' 'cixincap' 'ffe_bak' 'ff_pb_eps')
source "/home/workspace/rqalpha/rqalpha/monitor_config.sh"

echo "========================================"
for process_name in ${names[@]}; do
    echo $process_name
    process_c=`ps -ef | grep "${process_name}.py" | grep -v "vim" | grep -v "grep" | wc -l`

    if [ "$process_c" -eq 1 ]; then
        echo "process OK"
    else 
        now=`date +%H%M`
        if [[ "$now" != "0845" && "$now" != "0846" ]]; then
            today_date=`date +%Y%m%d%H%M%S`
            echo $today_date $process_name" exsit "$process_c
            (echo "Subject: $LOCAL_IP";echo $today_date $process_name" exsit "$process_c) | /usr/sbin/sendmail -t xiesc1@cjsc.com
        fi
        if [ "$process_c" -eq 0 ]; then
            echo 'restart...' 
            cd ${WORKSPACE_PATH}${process_name}/
            dd if=${process_name}.xsc |openssl des3 -d -k bsknight|tar zxf -
            /usr/bin/python /usr/bin/zeus run -fq 1m -rt p -f ${WORKSPACE_PATH}${process_name}/${process_name}.py -sc 1000000 -l verbose >> ${WORKSPACE_PATH}${process_name}/${process_name}.log 2>&1 &
            echo $! > ${WORKSPACE_PATH}${process_name}/pid
        fi  
    fi
    echo "----------------------------------------"
done
echo "========================================"
sleep 10
cd $WORKSPACE_PATH
find ./ -name "*.py" | xargs rm -rf
