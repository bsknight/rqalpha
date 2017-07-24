#!/bin/sh
#set -x
export JAVA_HOME=/usr/java/jre1.8.0_101
export JRE_HOME=/usr/java/jre1.8.0_101
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib:$JRE_HOME/lib
export ORACLE_HOME=/usr/lib/oracle/12.1/client64
export TNS_ADMIN=$ORACLE_HOME/network/admin
export PATH=$PATH:$ORACLE_HOME/bin::/usr/local/lib/:$JAVA_HOME/bin:$JRE_HOME/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME/lib
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/lib/oracle/12.1/client64a/lib:/usr/lib:/usr/lib64/:/usr/local/lib
export NLS_LANG="AMERICAN_AMERICA.ZHS16GBK"
export NLS_DATE_FORMAT='YYYY-MM-DD'

WORKSPACE_PATH='/home/workspace/rqalpha/rqalpha/zeus/'

names=('ffp' 'ffr' 'peg' 'grcxhs' 'grcxcap')
#names=('ffp' 'ffr' 'peg')

echo "========================================"
for process_name in ${names[@]}; do
    echo $process_name
    process_c=`ps -ef | grep "${process_name}.py" | grep -v "vim" | grep -v "grep" | wc -l`

    if [ "$process_c" -eq 1 ]; then
        echo "process OK"
    else 
        today_date=`date +%Y%m%d%H%M%S`
        echo $today_date $process_name" exsit "$process_c
        echo $today_date $process_name" exsit "$process_c | /usr/sbin/sendmail -t xiesc1@cjsc.com
        if [ "$process_c" -eq 0 ]; then
            echo 'restart...' 
            cd ${WORKSPACE_PATH}${process_name}/
            /usr/bin/python /usr/bin/zeus run -fq 1m -rt p -f ${WORKSPACE_PATH}${process_name}/${process_name}.py -sc 1000000 -l verbose >> ${WORKSPACE_PATH}${process_name}/${process_name}.log 2>&1 &
            echo $! > ${WORKSPACE_PATH}${process_name}/pid
        fi  
    fi
    echo "----------------------------------------"
done
echo "========================================"
