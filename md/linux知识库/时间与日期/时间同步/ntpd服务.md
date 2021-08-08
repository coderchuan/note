## ntpd
* 配置
    * 配置文件:`/etc/ntp.conf`
        * `driftfile PATH`
            * 含义:记录CPU时钟频率的历史偏差,用于对时钟进行调整。一般无须调整
            * PATH:记录CPU时钟频率的历史偏差的文件路径。默认值:/var/lib/ntp/drift
            * 示例:`driftfile /var/lib/ntp/drift`
        * `restrict [IP_VERSION] IP [mask MASK_CODE] PARAMS`
            * 含义:对客户端请求时间同步和对服务端时间修改进行权限控制
            * IP_VERSION:IP协议版本,可取以下值
                * `-6`:ipv6
                * `-4`:ipv4。默认
            * IP:该条规则限定指定的IP地址客户端,可取以下值
                * `default`:指定所有的IP地址
                * 限定指定的IP地址,如`192.168.32.5`
                * 与`MASK_CODE`配合限定指定网段的ip地址,如`192.168.1.0 mask 255.255.255.0`
            * MASK_CODE:子网掩码,与IP配合使用
            * PARAMS:ntp权限配置,可取以下值,可取多个值,每个值用空格隔开
                * `kod`:当请求的类型不在权限内时,返回kod包(可以御防"kiss of death"DDOS攻击)
                * `ignore`:忽略所有的类型的ntp请求。不指定则不忽略
                * `nomodify`:禁止客户端修改服务器时间。不指定默认允许
                * `noquery`:不提供ntp校时服务。不指定默认允许
                * `notrap`:不接受远程登录请求。不指定默认允许
                * `nopeer`:不与同一层次的其他ntp服务器进行时间同步。不指定默认允许
            * 示例
                * restrict default kod nomodify notrap nopeer noquery
                * restrict -6 default kod nomodify notrap nopeer noquery
                * restrict 127.0.0.1
                * restrict -6 ::1
        * `server IP OPTION`
            * 含义:指定ntp的上层服务器
            * IP:上层ntp服务器的IP地址或域名
            * OPTION:上层服务器的参数
                * `prefer`:当配置了多个上层服务器时,使用此参数的将被优先被使用。同一个优先级的将按顺序依次使用
                * `burst`:当服务器可以被访问时,发送8个短促的数据包而不是一个普通的数据包。每个数据包的间隔为2秒。不推荐使用
                * `iburst`:当服务器不可以被访问时,发送8个短促的数据包而不是一个普通的数据包。每个数据包的间隔为2秒,推荐使用
    * 配置文件:`/etc/sysconfig/ntpd`
        * `SYNC_HWCLOCK`
            * 含义:是否同步硬件时间
            * 取值:text文本,如下
                * yes,同步到硬件时间
                * no,不同步到硬件时间。默认
            * 示例:`SYNC_HWCLOCK=yes`