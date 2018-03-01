# log file
# centos: /var/log/secure
# debian: /var/log/auth.log
log_file=auto

# your public ip
public_ip=

# define max tried logined times
define=

if [ $log_file = "auto" ]; then
	# RHEL-based distro
	if [ -f '/var/log/secure' ]; then
		echo "Log file found: /var/log/secure"
		log_file=/var/log/secure
	# Debian-based distro
	elif [ -f '/var/log/auth.log' ]; then
		echo "Log file found: /var/log/auth.log"
		log_file=/var/log/auth.log
	else
		echo 'Unable to found log file. Please specify it manually in the script.'
		exit 1
	fi
fi

ban(){
list=`cat ${log_file} | grep "Failed" | awk '{print $(NF-3)}' | sort | uniq -c | awk '{print $2"="$1;}'`

if [[ ! -z ${list} ]]; then
for i in ${list}
do
	ip=`echo $i | awk -F= '{print $1}' | head -n 1`
	times=`echo $i | awk -F= '{print $2}' | head -n 1`
	if [[ "${ip}" != "${public_ip}" && "${times}" > "${define}" ]]; then
		# 检查重复
		exist=`iptables -nL | grep ${ip}`
		if [[ -z ${exist} ]]; then
			# 封禁
			iptables -t filter -A INPUT -s ${ip} -j DROP
			# 记录
			date=`date +%Y.%m.%d-%H:%M:%S`
			echo "${date}    ${ip}" >> /home/ban/ssh.conf
		fi
	fi
done
fi
}


#每 1 秒一次
while true
do
	ban
	sleep 1
done
