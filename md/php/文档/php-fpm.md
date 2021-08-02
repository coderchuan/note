# php-fpm

## php-fpm.conf
* `[global]`配置
    * `log_level = ERROE_LEVE`：非必须。错误级别。ERROE_LEVE表示错误级别,可取以下值：alert, error, warning, notice, debug, 错误级别依次降
    * `error_log = LOG_FILE_PATH`：必须。错误日志文件。LOG_FILE_PATH表示错误日志文件 

## www.conf
* `[www]`配置
    * `user = USERNAME`：必须。运行php-fpm服务进程的用户。
        * `USERNAME`：用户名 
    * `group = GROUPNAME`：非必须。运行php-fpm服务进程的所属用户组。不设置时默认为user所在的用户组
        * `GROUPNAME`：组名
    * `listen = {IP:PORT|UNIX_SOCKET}`：必须。监听设置
        * `IP`：对本机被访问的IP进行监听
        * `PORT`：对本机PORT进行监听 
        * `UNIX_SOCKET`：SOCKET文件将要存放的路径。使用SOCKET文件进行监听。设置此项后，还可设置以下项：
            * `listen.owner = USERNAME`：非必须。监听文件的所属用户。仅当listen选用UNIX_SOCKET时有效。默认值为启动该进程的用户。 
                * `USERNAME`：用户名
                * 注意：应满足listen.owner=监听UNIX_SOCKET的进程(例如nginx)的所属用户或listen.group=监听UNIX_SOCKET进程所在的组，否则监听此文件的进程无权限访问此文件
            * `listen.group = GROUPNAME`：非必须。监听文件的所属用户组。仅当listen选用UNIX_SOCKET时有效。省略此项默认为listen.owner所在组 
                * `GROUPNAME`：组名
            * `listen.mode = MODE`：非必须。监听文件的权限。仅当listen选用UNIX_SOCKET时有效，省略此项默认设置为:0660
                * `MODE`：权限数字,三位数字或四位数字
        * 示例：`listen = 127.0.0.1:9006`、`listen = /tmp/php-fpm.sock`
    * `pm = RUN_MODE`：必须。进程运行模式。RUN_MODE可取以下值：
        * `dynamic`：由php-fpm自动管理进程数量。适用于普通大小内存的服务器，适用于普通并发状况。设置此项后还可以设置以下配置，其中NUM表示整数
            * `pm.max_children = NUM`：必须。子进程最大数 
            * `pm.min_spare_servers = NUM`：必须。处于空闲状态的最少子进程。如果空闲进程数量小于这个值，那么相应的子进程会被创建 
            * `pm.max_spare_servers = NUM`：必须。最大空闲子进程数量。空闲子进程数量超过这个值，那么相应的子进程会被杀掉 
            * `pm.start_servers = NUM`：非必须。启动时php-fpm主进程时将会启动的子进程数量。应介于pm.min_spare_servers与pm.max_spare_servers之间，不设置时默认为(pm.min_spare_servers+pm.max_spare_servers)/2
        * `ondemand`：空闲进程为0，当有请求访问时才创建子进程。适用于小内存服务器，不适用于高并发状况。设置此项后还可以设置以下配置，其中NUM表示整数
            * `pm.max_children = NUM`：必须。子进程最大数 
            * `pm.process_idle_timeout = NUM`：必须。子进程空闲NUM秒后被杀死 
        * `static`：固定数量的子进程。适用于大内存服务器，适用于高并发状况。设置此项后还可以设置以下配置，其中NUM表示整数
            * `pm.max_children = NUM`：必须。固定的子进程数量，其中NUM表示整数
    * `pm.max_requests = NUM`：非必须。每个子进程处理的最大请求数量，其中NUM表示整数。指定为0则不限制。不指定时默认为0
    * `request_slowlog_timeout = NUM`：非必须。当php脚本执行时间超过NUM秒后记录慢日志。NUM取0表示关闭慢日志，默认为0
    * `pm.max_requests = NUM`：非必须。当请求次数超过NUM次后重启php-fpm服务。NUM取0表示不自动重启，默认为0
    * `slowlog = LOG_SLOW_FILE_PATH`：如果request_slowlog_timeout开启，则此项必须配置。慢日志文件路径。 