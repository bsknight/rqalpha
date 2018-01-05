#!/bin/sh
export PATH=$PATH:/usr/local/lib/:/usr/lib:/usr/lib64/
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/lib/oracle/12.1/client64a/lib:/usr/lib:/usr/lib64/:/usr/local/lib
export NLS_LANG="AMERICAN_AMERICA.ZHS16GBK"
export NLS_DATE_FORMAT='YYYY-MM-DD'

WORKSPACE_PATH='/home/workspace/rqalpha/rqalpha/zeus/'
names=('ffp' 'ffr' 'peg' 'ffe' 'cixincap' 'ffe_bak' 'ff_pb_eps' 'trend')
