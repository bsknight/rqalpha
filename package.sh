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
rm rqalpha/monitor.sh

find ./  -path './zeus' -prune -name "*.py" | xargs python -m py_compile 
find ./ -name "*.py.swp" | xargs rm -rf
find ./ -name "tags" | xargs rm -rf
find $WORKPATH/pkg/rqalpha/rqalpha/zeus -name "*.log" | xargs rm -rf
find $WORKPATH/pkg/rqalpha/rqalpha/zeus -name "pid" | xargs rm -rf
find $WORKPATH/pkg/rqalpha/rqalpha/zeus -name "persist" | xargs rm -rf

cd $WORKPATH/pkg/rqalpha/rqalpha/zeus/ffp
tar -zcvf - ./ffp.py|openssl des3 -salt -k bsknight| dd of=ffp.xsc
cd $WORKPATH/pkg/rqalpha/rqalpha/zeus/ffr
tar -zcvf - ./ffr.py|openssl des3 -salt -k bsknight| dd of=ffr.xsc
cd $WORKPATH/pkg/rqalpha/rqalpha/zeus/peg
tar -zcvf - ./peg.py|openssl des3 -salt -k bsknight| dd of=peg.xsc
cd $WORKPATH/pkg/rqalpha/rqalpha/zeus/grcxcap
tar -zcvf - ./grcxcap.py|openssl des3 -salt -k bsknight| dd of=grcxcap.xsc
cd $WORKPATH/pkg/rqalpha/rqalpha/zeus/grcxhs
tar -zcvf - ./grcxhs.py|openssl des3 -salt -k bsknight| dd of=grcxhs.xsc

cd $WORKPATH/pkg/rqalpha
find ./ -name "*.py" | xargs rm -rf

cd $WORKPATH/pkg/
tar czf $WORKPATH/pkg/zeus.bin.tgz ./rqalpha
