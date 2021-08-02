## 与nginx的通信接口配置
* 文件位置:使用命令`find /etc/php/ -type f -name www.conf`查找
* 配置项在`[www]`下，有两种配置，可任选其一。配置语法如下
    * 使用TCP/IP 
        ```conf 
        ;此项的值应与nginx的server配置中的fastcgi_pass项相同
        listen = localhost:9008
        ```
    * 使用unix_socket
        ```conf
        ;此项的值应与nginx的server配置中的fastcgi_pass项相同
        listen = /tmp/php-fpm.sock
        ;listen.owner应与nginx的用户配置为同一个用户
        listen.owner = www-data
        ```