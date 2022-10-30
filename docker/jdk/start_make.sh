#!/bin/bash
#cd $WORK_PATH/$OPENJDK_SRC_DIR/jdk

#yum install -y java-1.7.0-openjdk-devel

chmod a+x ./configure

./configure --with-target-bits=64 --with-debug-level=slowdebug --enable-debug-symbols ZIP_DEBUGINFO_FILES=0

echo "************************************************************************"
echo "************************************************************************"
echo "************************************************************************"
echo ""
echo ""
echo "start make"
echo ""
echo ""
echo "************************************************************************"
echo "************************************************************************"
echo "************************************************************************"

make all CONF=linux-x86_64-normal-server-slowdebug ZIP_DEBUGINFO_FILES=0 DISABLE_HOTSPOT_OS_VERSION_CHECK=OK


echo "make end" > make.txt
#yum -y install yum-utils

#debuginfo-install -y glibc-2.17-326.el7_9.x86_64 libgcc-4.8.5-44.el7.x86_64 libstdc++-4.8.5-44.el7.x86_64