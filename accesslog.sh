ban(){

# 获取目标名
name=$1
# 读取 /home/site/access-log/access.log 日志
ips=`cat /home/site/access-log/access.log |grep ${name} | awk '{print $4}'`

if [[ ! -z ${ips} ]]; then
for ip in ${ips}
do
	# 检查重复
	exist=`iptables -nL | grep ${ip}`
	# 封禁并记录到文本
	[[ -z ${exist} ]] && iptables -t filter -A INPUT -s ${ip} -j DROP && date=`date +%Y.%m.%d-%H:%M:%S` && echo "${date}    ${name}    ${ip}" >> /home/ban/accesslog.conf
done
fi

}


#每 1800 秒循环一次
while true
do
	# 输入 $1

	ban 'wp-login'
	ban 'UptimeRobot'
	ban 'qihoobot'
	ban 'Baiduspider'
	ban 'Mediapartners-Google'
	ban 'Adsbot-Google'
	ban 'Feedfetcher-Google'
	ban 'Yahoo'
	ban 'Slurp'
	ban 'YoudaoBot'
	ban 'Sosospider'
	ban 'Sogou'
	ban 'MSNBot'
	ban 'ia_archiver'
	ban 'Tomato'
	ban 'FeedDemon'
	ban 'JikeSpider'
	ban 'Library'
	ban 'Alexa'
	ban 'Toolbar'
	ban 'AskTbFXTV'
	ban 'AhrefsBot'
	ban 'CrawlDaddy'
	ban 'CoolpadWebkit'
	ban 'Feedly'
	ban 'UniversalFeedParser'
	ban 'ApacheBench'
	ban 'Swiftbot'
	ban 'ZmEuoBot'
	ban 'jaunty'
	ban 'Python-urllib'
	ban 'lightDeckReports'
	ban 'YYSpider'
	ban 'DigExt'
	ban 'Yisou'
	ban 'MJ12bot'
	ban 'heritrix'
	ban 'Easou'
	ban 'Ezooms'
	ban 'Yodao'
	ban 'Bingbot'
	ban 'Teoma'
	ban 'twiceler'
	ban 'Scrubby'
	ban 'Robozilla'
	ban 'Gigabot'
	ban 'Googlebot-image'
	ban 'Googlebot-mobile'
	ban 'psbot'
	ban 'DuckDuckBot'
	ban 'YandexBot'
	ban 'Exabot'
	ban 'facebot'
	ban 'facebookexternalhit'
	ban 'Scrapy'
	ban 'HttpClient'
	ban 'Curl'
	ban 'Wget'
	ban 'Idm'
	ban 'Aria2'
	ban 'Axel'
	ban 'Thunder'
	ban 'Youtube'
	ban 'Movgrab'
	ban 'torrent'
	ban 'Transmission'
	ban 'vuze'
	ban 'blogspot'
	ban '444'

	sleep 1800
done
