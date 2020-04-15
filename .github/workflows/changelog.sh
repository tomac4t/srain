#!/bin/bash
set -ex
CHANGELOG_LINE=`grep -oP "^========================" /home/tom/Projects/srain/doc/changelog.rst -n | awk -F: '{print $1}'`;
CHANGELOG_LINE_ONE=`echo $CHANGELOG_LINE | awk '{print $1}'`;
CHANGELOG_LINE_TWO=`echo $CHANGELOG_LINE | awk '{print $2}'`;
CHANGELOG_LASTEST_BEGIN=`expr $CHANGELOG_LINE_ONE + 2`
CHANGELOG_LASTEST_END=`expr $CHANGELOG_LINE_TWO - 5`
sed -n "$CHANGELOG_LASTEST_BEGIN","$CHANGELOG_LASTEST_END"p /home/tom/Projects/srain/doc/changelog.rst  > change.log 
#https://blog.csdn.net/Dax1n/article/details/80826509
#截取指定行之间的日志到新的文件中 