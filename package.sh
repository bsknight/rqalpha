#!/bin/sh
cd ..
WORKPATH=`pwd`
rm -rf pkg
mkdir pkg
cp rqalpha/ ./pkg/rqalpha/ -r
cd ./pkg/rqalpha/

shc -r -f rqalpha/monitor.sh
mv rqalpha/monitor.sh.x rqalpha/handler
rm rqalpha/monitor.sh.x.c

find ./  -path './zeus' -prune -name "*.py" | xargs python -m py_compile 
find ./ -name "*.py.swp" | xargs rm -rf
find ./ -name "tags" | xargs rm -rf
find $WORKPATH/pkg/rqalpha/rqalpha/zeus -name "*.log" | xargs rm -rf

cd $WORKPATH/pkg/rqalpha/rqalpha/zeus
tar -zcvf - $WORKPATH/pkg/rqalpha/rqalpha/zeus/ffp/ffp.py|openssl des3 -salt -k bsknight| dd of=$WORKPATH/pkg/rqalpha/rqalpha/zeus/ffp/ffp.xsc
tar -zcvf - $WORKPATH/pkg/rqalpha/rqalpha/zeus/ffr/ffr.py|openssl des3 -salt -k bsknight| dd of=$WORKPATH/pkg/rqalpha/rqalpha/zeus/ffr/ffr.xsc
tar -zcvf - $WORKPATH/pkg/rqalpha/rqalpha/zeus/peg/peg.py|openssl des3 -salt -k bsknight| dd of=$WORKPATH/pkg/rqalpha/rqalpha/zeus/peg/peg.xsc
tar -zcvf - $WORKPATH/pkg/rqalpha/rqalpha/zeus/grcxcap/grcxcap.py|openssl des3 -salt -k bsknight| dd of=$WORKPATH/pkg/rqalpha/rqalpha/zeus/grcxcap/grcxcap.xsc
tar -zcvf - $WORKPATH/pkg/rqalpha/rqalpha/zeus/grcxhs/grcxhs.py|openssl des3 -salt -k bsknight| dd of=$WORKPATH/pkg/rqalpha/rqalpha/zeus/grcxhs/grcxhs.xsc

cd $WORKPATH/pkg/rqalpha
find ./ -name "*.py" | xargs rm -rf

cd $WORKPATH/pkg/
tar czf $WORKPATH/pkg/zeus.bin.tgz $WORKPATH/pkg/
