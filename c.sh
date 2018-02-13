# your public ip
public_ip=

# max connection number
define=

# port
port=443

# requirement
#apt-get install -y net-tools
# or
#yum install -y net-tools

ban(){
ips=`netstat -an |grep ^tcp.*:${port}|egrep -v 'LISTEN|127.0.0.1'|awk -F"[ ]+|[:]" '{print $6}'|sort|uniq -c|sort -rn|awk -v str=${define} '{if ($1>str){print $2}}'`

if [[ ! -z ${ips} ]]; then
for ip in ${ips}
do
	if [[ "${ip}" != "${public_ip}" ]]; then
		# 检查重复
		exist=`iptables -nL | grep ${ip}`
		if [[ -z ${exist} ]]; then
			# 封禁
			iptables -t filter -A INPUT -s ${ip} -j DROP
			date=`date +%Y.%m.%d-%H:%M:%S`
			# 记录
			echo "${date}    ${ip}" >> /home/ban/c.conf
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
