#!/bin/bash
# https://github.com/Hyy2001X/AutoBuild-Actions
# AutoBuild Module by Hyy2001

[ -f /tmp/cloud_version ] && rm -f /tmp/cloud_version
if [ ! -f /bin/AutoUpdate.sh ];then
	echo "不受支持的固件" > /tmp/cloud_version
	exit
fi
Github=`awk -F '[=]' '/Github/{print $2}' /bin/AutoUpdate.sh | awk 'NR==1'`
Author=${Github##*com/}
Github_Tags=https://api.github.com/repos/$Author/releases/latest
GET_Version=`wget -q $Github_Tags -O - | egrep -o 'R[0-9]+.[0-9]+.[0-9]+.[0-9]+' | awk 'END {print}'`
if [ -z "$GET_Version" ];then
	echo "未知" > /tmp/cloud_version
	exit
else
	echo "$GET_Version" > /tmp/cloud_version
fi
exit
