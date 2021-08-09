## ntpd
* 渐近地从网络更新时间
    * 命令(服务的形式运行)
        * ubuntu:`service ntp start`
        * centos:`service ntpd start`
* 立即从网络更新时间
    * 命令:`ntpd -gq`
    * 权限:root 
* 配置文件:`/etc/ntp.conf`
    * `driftfile PATH`
        * 含义:记录CPU时钟频率的历史偏差,用于对时钟进行调整。一般无须修改
        * PATH:记录CPU时钟频率的历史偏差的文件路径。默认值:/var/lib/ntp/drift
        * 示例:`driftfile /var/lib/ntp/drift`
    * `restrict [IP_VERSION] IP [mask MASK_CODE] PARAMS`
        * 含义:访问权限控制。连接到ntpd服务可以查询当前系统时间,修改系统时间等。当本机从上层服务器获取到时间后,需要将获取到的时间写入到本机系统时间,这时本地的ntpd也会连接到本地的ntpd服务,对当前系统时间进行改写,因此必须对本地ip赋予最大权限。
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
            * `notrust`:当对方(上层服务端和客户端)未经过身份验证时,拒绝连接。不指定默认不进行身份验证
            * `nopeer`:不与同一层次的其他ntp服务器进行时间同步。不指定默认允许
        * 示例
            * restrict default kod nomodify notrap nopeer noquery       #禁止ipv4地址将本机作为时间同步服务器
            * restrict -6 default kod nomodify notrap nopeer noquery    #禁止ipv6地址将本机作为时间同步服务器
            * restrict default kod nomodify notrap nopeer               #允许ipv4地址将本机作为时间同步服务器
            * restrict -6 default kod nomodify notrap nopeer            #允许ipv6地址将本机作为时间同步服务器
            * restrict 127.0.0.1                                        #本机IPV4地址,最大权限
            * restrict -6 ::1                                           #本机IPV4地址,最大权限 
    * `server IP OPTION`
        * 含义:指定ntp的上层服务器
        * IP:上层ntp服务器的IP地址或域名
        * OPTION:上层服务器的参数
            * `key KEY_ID`:当上层服务器启用了身份验证时,此项必须被指定。其中`KEY_ID`表示需要被验证的`key_file`文件中的ID值
            * `prefer`:当配置了多个上层服务器时,使用此参数的将被优先被使用。同一个优先级的将按顺序依次使用
            * `burst`:当服务器可以被访问时,发送8个短促的数据包而不是一个普通的数据包。每个数据包的间隔为2秒。不推荐使用
            * `iburst`:当服务器不可以被访问时,发送8个短促的数据包而不是一个普通的数据包。每个数据包的间隔为2秒,推荐使用 
        * 示例
            ```
            server localhost        iburst
            server ntp.ntsc.ac.cn   iburst prefer
            ```
    * `keys KEY_FILE`:身份验证用的文件。`KEY_FILE`表示此文件的绝对路径
    * `trustedkey IDS`:身份验证文件中的可以信任的ID值。IDS表示ID值,多个ID需要用空格分隔
* 查看是否处于同步状态:执行`ntpq -c asso`,若`condition`的值为`sys.peer`则表示已经处于同步状态了 