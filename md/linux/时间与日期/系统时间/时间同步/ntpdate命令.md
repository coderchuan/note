## ntpdate
* 功能:立即从网络更新时间
* 命令`ntpdate [-a KEY_ID -k KEY_FILE] TIME_SERVER`
    * `KEY_FILE`:用于身份验证的文件。文件内容应至少与时间服务器中的一项相同
    * `KEY_ID`:当时间服务器启用了身份验证时,此项必须被指定,`KEY_FILE`文件中的被用于身份验证的ID值
    * `TIME_SERVER`:表示时间同步服务器,有以下服务器可用
        * cn.ntp.org.cn
        * edu.ntp.org.cn
        * jp.ntp.org.cn 
* 权限:root 