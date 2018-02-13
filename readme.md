# defender
[![Build Status](https://github.com/nanqinlang/SVG/blob/master/build%20passing.svg)](https://github.com/nanqinlang/defender)
[![language](https://github.com/nanqinlang/SVG/blob/master/language-shell-blue.svg)](https://github.com/nanqinlang/defender)
[![author](https://github.com/nanqinlang/SVG/blob/master/author-nanqinlang-lightgrey.svg)](https://github.com/nanqinlang/defender)
[![license](https://github.com/nanqinlang/SVG/blob/master/license-GPLv3-orange.svg)](https://github.com/nanqinlang/defender)

simple scripts to provide defence


## accesslog.sh
ban ip from `/home/site/access-log/access.log`, the ban rule is in "ban $1" part of the script.
```bash
nohup bash accesslog.sh &
```


## c.sh
ban ip according to the connection numbers noted on netstat.

write value in the script file:
```bash
# your public ip
public_ip=

# max connection number
define=

# port
# such as 80 or 443
#port=80
port=
```

then run it:
```bash
nohup bash c.sh &
```


## ssh.sh
ban ip according to the tried times noted on ssh login log file.

write value in the script file:
```bash
# log file
# centos: /var/log/secure
# debian: /var/log/auth.log
log_file=

# your public ip
public_ip=

# define max tried logined times
define=
```

then run it:
```bash
nohup bash ssh.sh &
```