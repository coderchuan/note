## ntpdate
* 功能:立即从网络更新时间
* 命令
    1. `ntpdate TIME_SERVER`,其中`TIME_SERVER`表示时间同步服务器,有以下服务器可用
        * cn.ntp.org.cn
        * edu.ntp.org.cn
        * jp.ntp.org.cn
    1. `hwclock -w`
* 权限:root 