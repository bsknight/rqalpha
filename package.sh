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
rm rqalpha/monitor.log
rm rqalpha/dev.sh
rm package.sh
rm ./.git/ -rf
rm ./.github/ -rf

cd $WORKPATH/pkg/rqalpha
rm general.conf
find ./ -name "*.py" | xargs python -m py_compile 
find ./ -name "*.py.swp" | xargs rm -rf
find ./ -name "tags" | xargs rm -rf
find $WORKPATH/pkg/rqalpha/rqalpha/zeus -name "*.log" | xargs rm -rf
find $WORKPATH/pkg/rqalpha/rqalpha/zeus -name "pid" | xargs rm -rf
find $WORKPATH/pkg/rqalpha/rqalpha/zeus -name "persist" | xargs rm -rf

cd $WORKPATH/pkg/rqalpha/rqalpha/zeus/cixincap
tar -zcvf - ./cixincap.py|openssl des3 -salt -k bsknight| dd of=cixincap.xsc
rm ./persist -rf
rm *.pyc

cd $WORKPATH/pkg/rqalpha/rqalpha/zeus/ffe
tar -zcvf - ./ffe.py|openssl des3 -salt -k bsknight| dd of=ffe.xsc
rm ./persist -rf
rm *.pyc

cd $WORKPATH/pkg/rqalpha/rqalpha/zeus/ffp
tar -zcvf - ./ffp.py|openssl des3 -salt -k bsknight| dd of=ffp.xsc
rm ./persist -rf
rm *.pyc

cd $WORKPATH/pkg/rqalpha/rqalpha/zeus/ffr
tar -zcvf - ./ffr.py|openssl des3 -salt -k bsknight| dd of=ffr.xsc
rm ./persist -rf
rm *.pyc

cd $WORKPATH/pkg/rqalpha/rqalpha/zeus/peg
tar -zcvf - ./peg.py|openssl des3 -salt -k bsknight| dd of=peg.xsc
rm ./persist -rf
rm *.pyc

cd $WORKPATH/pkg/rqalpha/rqalpha/zeus/grcxcap
tar -zcvf - ./grcxcap.py|openssl des3 -salt -k bsknight| dd of=grcxcap.xsc
rm ./persist -rf
rm *.pyc

cd $WORKPATH/pkg/rqalpha/rqalpha/zeus/grcxhs
tar -zcvf - ./grcxhs.py|openssl des3 -salt -k bsknight| dd of=grcxhs.xsc
rm ./persist -rf
rm *.pyc

cd $WORKPATH/pkg/rqalpha/rqalpha/zeus/ffe_bak
tar -zcvf - ./ffe_bak.py|openssl des3 -salt -k bsknight| dd of=ffe_bak.xsc
rm ./persist -rf
rm *.pyc

cd $WORKPATH/pkg/rqalpha
find ./ -name "*.py" | xargs rm -rf

cd $WORKPATH/pkg/
tar czf $WORKPATH/pkg/zeus.bin.tgz ./rqalpha
