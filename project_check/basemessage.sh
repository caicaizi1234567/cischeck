#!/bin/bash
cat <<EOF
EOF
rm /basemessage/out.txt
rm /basemessage/password.txt
rmdir /basemessage
mkdir /basemessage
touch /basemessage/out.txt
touch /basemessage/password.txt
data1=`date`
echo "${data1}"
echo "${data1}" >> /basemessage/out.txt

data2="os"
echo "${data2}"
echo "${data2}" >> /basemessage/out.txt

data3=`hostname`
echo "${data3}"
echo "${data3}" >> /basemessage/out.txt

data4=`cat /etc/issue`
echo "${data4}"
echo "${data4}" >> /basemessage/out.txt

data5=`cat /proc/net/arp | awk '{print $4}' | grep :`
echo "${data5}"
echo "${data5}" >> /basemessage/out.txt

data6=`hostname -I | awk '{print $1}'`
echo "${data6}"
echo "${data6}" >> /basemessage/out.txt

echo "1.密码历史检查"
echo "1.密码历史检查" >> /basemessage/password.txt
data7=$(cat /etc/pam.d/common-password | grep remember)
if [ $? -eq 0 ];then
	data8=`cat /etc/pam.d/common-password | grep remember | awk '{print $7}'`
	echo "${data8}" >> /basemessage/password.txt
	echo "通过"
	echo "通过" >> /basemessage/password.txt
else
	echo "未通过"
	echo "empty" >> /basemessage/password.txt
	echo "未通过" >> /basemessage/password.txt
fi

echo "2.密码最长使用期限"
echo "2.密码最长使用期限" >> /basemessage/password.txt
data9=$(cat /etc/login.defs | grep PASS_MAX_DAYS | grep -v ^# | awk '{print $2}')
if [ $? -eq 0 ];then
	data10=`cat /etc/login.defs | grep PASS_MAX_DAYS | grep -v ^# | awk '{print $2}'`
	if [ ${data10} -lt 90 ];then
		echo "${data10}" >> /basemessage/password.txt
		echo "通过"
		echo "通过" >> /basemessage/password.txt
	else
		echo "未通过"
		echo "${data10}" >> /basemessage/password.txt
		echo "未通过" >> /basemessage/password.txt
	fi
else
	echo "未通过"
	echo "empty" >> /basemessage/password.txt
	echo "未通过" >> /basemessage/password.txt
fi

echo "3.密码最短使用期限"
echo "3.密码最短使用期限" >> /basemessage/password.txt
data11=$(cat /etc/login.defs | grep PASS_MIN_DAYS | grep -v ^# | awk '{print $2}')
if [ $? -eq 0 ];then
	data12=`cat /etc/login.defs | grep PASS_MIN_DAYS | grep -v ^# | awk '{print $2}'`
	if [ ${data12} -gt 1 ];then
		echo "${data12}" >> /basemessage/password.txt
		echo "通过"
		echo "通过" >> /basemessage/password.txt
	else
		echo "未通过"
		echo "${data12}" >> /basemessage/password.txt
		echo "未通过" >> /basemessage/password.txt
	fi
else
	echo "未通过"
	echo "empty" >> /basemessage/password.txt
	echo "未通过" >> /basemessage/password.txt
fi

echo "4.密码是否符合复杂度要求"
echo "4.密码是否符合复杂度要求" >> /basemessage/password.txt
if [ -e /etc/pam.d/common-password ];then
	find_file="/etc/pam.d/common-password"
	find_str1="dcredit = -1 ocredit = -1 lcredit = -1 ucredit = -1"
	if [ `grep -c "$find_str1" $find_file` -ne '0' ];then
		echo "yes"
		echo "yes" >> /basemessage/password.txt
		echo "通过" >> /basemessage/password.txt
	else
		echo "no"
		echo "no" >> /basemessage/password.txt
		echo "未通过" >> /basemessage/password.txt
	fi
else
	echo "not find this file"
	echo "not find this file"
	echo "未通过" >> /basemessage/password.txt
fi

echo "5.密码长度不得低于8位"
echo "5.密码长度不得低于8位" >> /basemessage/password.txt
if [ -e /etc/pam.d/common-password ];then
	data14=$(cat /etc/pam.d/common-password | grep -o "$minlen = 14" | awk '{print $3}')
	if [ $? -eq 1 ];then
		data13=`cat /etc/pam.d/common-password | grep -o "$minlen = 14" | awk '{print $3}'`
		if [ ${data13} -gt 8 ];then
			echo "通过"
			echo "${data13}" >> /basemessage/password.txt
			echo "通过" >> /basemessage/password.txt
		else
			echo "未通过"
			echo "${data13}" >> /basemessage/password.txt
			echo "未通过" >> /basemessage/password.txt
		fi
	else
		echo "未通过"
		echo "empty" >> /basemessage/password.txt
		echo "未通过" >> /basemessage/password.txt
	fi
else
	echo "not find this file" >> /basemessage/password.txt
	echo "未通过" >> /basemessage/password.txt
	echo "未通过"
fi

echo "6.用户不能重复使用最近5次内以使用的口令"
echo "6.用户不能重复使用最近5次内已使用的口令" >> /basemessage/password.txt
data15=$(cat /etc/pam.d/common-password | grep remember)
if [ $? -eq 0 ];then
	data16=`cat /etc/pam.d/common-password | grep remember | awk '{print $3}'`
	if [ ${data16} -gt 4 ];then
		echo "通过"
		echo "${data16}" >> /basemessage/password.txt
		echo "通过" >> /basemessage/password.txt
	else
		echo "未通过"
		echo "${data16}" >> /basemessage/password.txt
		echo "未通过" >> /basemessage/password.txt
	fi
else
	echo "未通过"
	echo "empty" >> /basemessage/password.txt
	echo "未通过" >> /basemessage/password.txt
fi

echo "安全审计"

echo "1.确保日志审计服务开启"
echo "1.确保日志审计服务开启" >>/basemessage/password.txt
data17=$(systemctl is-enabled auditd)
if [ $? -eq 0 ];then
	data18=`systemctl is-enabled auditd`
	enabled="enabled"
	if [ grep -c "$enabled" "$data18" -ne '0' ];then
		echo "通过"
		echo "${data18}" >> /basemessage/password.txt
		echo "通过" >> /basemessage/password.txt
	else
		echo "未通过"
		echo "no service" >> /basemessage/password.txt
		echo "未通过" >> /basemessage/password.txt
	fi
else
	echo "未通过"
	echo "no service" >> /basemessage/password.txt
	echo "未通过" >> /basemessage/password.txt
fi

echo "2.配置syslog.conf相关选项"
echo "2.配置syslog.conf相关选项" >> /basemessage/password.txt
if [ -e /etc/rsyslog.conf ];then
	data19=$(cat /etc/rsyslog.conf | grep loghost)
	if [ $? -eq 0 ];then
		echo "通过"
		echo "${data19}" >> /basemessage/password.txt
		echo "通过" >> /basemessage/password.txt
	else
		echo "未通过"
		echo "empty" >> /basemessage/password.txt
		echo "未通过" >> /basemessage/password.txt
	fi
else
	echo "未通过"
	echo "file not exits" >> /basemessage/password.txt
	echo "未通过" >> /basemessage/password.txt
fi

echo "3.配置认证日志"
echo "3.配置认证日志" >> /basemessage/password.txt
if [ -e /etc/rsyslog.conf ];then
	data20=$(cat /etc/rsyslog.conf | grep authpriv)
	if [ $? -eq 0 ];then
		echo "通过"
		echo "${data20}" >> /basemessage/password.txt
		echo "通过" >> /basemessage/password.txt
	else
		echo "未通过"
		echo "result is empty" >> /basemessage/password.txt
		echo "未通过" >> /basemessage/password.txt
	fi
else
	echo "未通过"
	echo "file is empty" >> /basemessage/password.txt
	echo "未通过" >> /basemessage/password.txt
fi

echo "4.配置使用ntp"
echo "4.配置使用ntp" >> /basemessage/password.txt
if [ -e /etc/ntp.conf ];then
	data21=$(ps -ef | grep xntp)
	if [ $? -eq 0 ];then
		echo "通过"
		echo "进程已开启" >> /basemessage/password.txt
		echo "通过" >> /basemessage/password.txt
	else
		echo "未通过"
		echo "进程未开启" >> /basemessage/password.txt
		echo "未通过" >> /basemessage/password.txt
	fi
else
	echo "未通过"
	echo "file not exits" >> /basemessage/password.txt
	echo "未通过" >> /basemessage/password.txt
fi

echo "5.配置远程日志服务器"
echo "5.配置远程日志服务器" >> /basemessage/password.txt
data22=$(grep -E '^[^#]\s*\S+\.\*\s+@' /etc/rsyslog.conf /etc/rsyslog.d/*.conf)
if [ $? -eq 0 ];then
	data23="target=<FQDN or IP of remote loghost>"
	if [ grep -c "$data23" "data22" -ne '0' ];then
		echo "通过"
		echo "${data23}" >> /basemessage/password.txt
		echo "通过" >> /basemessage/password.txt
	else
		echo "未通过"
		echo "${data22}" >> /basemessage/password.txt
		echo "未通过" >> /basemessage/password.txt
	fi
else
	echo "未通过"
	echo "empty" >> /basemessage/password.txt
	echo "未通过" >> /basemessage/password.txt
fi

echo "6.配置安全日志"
echo "6.配置安全日志" >> /basemessage/password.txt
data24=$(grep -E '*.err|authpriv|auth.none' /etc/rsyslog.conf)
if [ $? -eq 0 ];then
	echo "通过"
	echo "${data24}" >> /basemessage/password.txt
	echo "通过" >> /basemessage/password.txt
else
	echo "未通过"
	echo "empty" >> /basemessage/password.txt
	echo "未通过" >> /basemessage/password.txt
fi

echo "7.审计进程保护"
echo "7.审计进程保护" >> /basemessage/password.txt
echo "等保3级" >> /basemessage/password.txt
echo "未通过" >> /basemessage/password.txt

echo "1.禁用共享账户"
echo "1.禁用共享账户" >> /basemessage/password.txt
data25=$(cat /etc/passwd)
if [ $? -eq 0 ];then
	echo "通过"
	echo "结果与管理员确认" >> /basemessage/password.txt
	echo "通过" >> /basemessage/password.txt
else
	echo "未通过"
	echo "empty" >> /basemessage/password.txt
	echo "未通过" >> /basemessage/password.txt
fi

echo "2.锁定无关账户"
echo "2.锁定无关账户" >> /basemessage/password.txt
echo "通过"
echo "nologin" >> /basemessage/password.txt
echo "通过" >> /basemessage/password.txt

echo "3.清除UID为0的非root用户"
echo "3.清除UID为0的非root用户" >> /basemessage/password.txt
data26=`awk -F: '($3 == 0) {print $1}' /etc/passwd`
data27="root"
if [ "$data26" == "$data27" ];then
	echo "通过"
	echo "${data26}" >> /basemessage/password.txt
	echo "通过" >> /basemessage/password.txt
else
	echo "未通过"
	echo "${data26}" >> /basemessage/password.txt
	echo "未通过" >> /basemessage/password.txt
fi

echo "4.设置umask值"
echo "4.设置umask值" >> /basemessage/password.txt
echo "未通过"
echo "empty" >> /basemessage/password.txt
echo "未通过" >> /basemessage/password.txt

echo "5.重要系统文件权限访问控制"
echo "5.重要系统文件权限访问控制" >> /basemessage/password.txt
permissionpasswd=`ls -l /etc/passwd | awk '{print $1}'`
permissiongroup=`ls -l /etc/group | awk '{print $1}'`
permissionshadow=`ls -l /etc/group | awk '{print $1}'`
permissiongshadow=`ls -l /etc/group | awk '{print $1}'`
ypermission="-rw-r--r--"
gshadow="----------"
if [ $permissionpasswd = $ypermission ] && [ $permissiongroup = $ypermission ] && [ $permissionshadow = $gpermission ] && [ $permissiongshadow = $gpermission ];then
	echo "通过"
	echo "644 000" >> /basemessage/password.txt
	echo "通过" >> /basemessage/password.txt
else
	echo "未通过"
	echo "文件权限不在受控范围内" >> /basemessage/password.txt
	echo "未通过" >> /basemessage/password.txt
fi

echo "6.控制任何人都要写权限的文件"
echo "6.控制任何人都要写权限的文件" >> /basemessage/password.txt
data28=$(find / -xdev -type f -perm -0002)
if [ $? -eq 0 ];then
	echo "未通过"
	echo "file exits" >> /basemessage/password.txt
	echo "未通过" >> /basemessage/password.txt
else
	echo "通过"
	echo "empty" >> /basemessage/password.txt
	echo "通过" >> /basemessage/password.txt
fi

echo "7.删除没有属主的文件"
echo "7.删除没有属主的文件" >> /basemessage/password.txt
data29=$(find / -xdev -nouser)
if [ $? -eq 0 ];then
	echo "未通过"
	echo "file exits" >> /basemessage/password.txt
	echo "未通过" >> /basemessage/password.txt
else
	echo "通过"
	echo "empty" >> /basemessage/password.txt
	echo "通过" >> /basemessage/password.txt
fi
