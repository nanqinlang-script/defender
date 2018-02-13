# log file
# centos: /var/log/secure
# debian: /var/log/auth.log

# your public ip
local_ip=

# define max tried logined times
define=

ban(){
list=`cat /var/log/auth.log | grep "Failed" | awk '{print $(NF-3)}' | sort | uniq -c | awk '{print $2"="$1;}'`

if [[ ! -z ${list} ]]; then
for i in ${list}
do
	ip=`echo $i | awk -F= '{print $1}' | head -n 1`
	times=`echo $i | awk -F= '{print $2}' | head -n 1`
	if [[ "${ip}" != "${local_ip}" && "${times}" > "${define}" ]]; then
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
