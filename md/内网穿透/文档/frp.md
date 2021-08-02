## frp 
* 配置
    * 服务端
        * `[common]`
            * 基础配置
                * `bind_addr`
                    * 功能：与frp客户端通讯
                    * 类型：text
                    * 取值：服务网卡的地址IP地址
                        * `0.0.0.0`:监听所有服务器网卡的IPv4地址。默认值
                        * `[::]:`监听所有服务器网卡的IPv6地址 
                        * `其他ip值`:监听指定的服务器网卡地址 
                * `bind_port`
                    * 功能：与frp客户端通讯的TCP端口
                    * 类型：int
                    * 取值:7000,默认 
                * `bind_udp_port`
                    * 功能：与frp客户端通讯的UDP端口(辅助创建P2P连接实现xtcp模式) 
                    * 类型：int
                    * 取值
                        * 0:关闭
                        * 其他值:开启
                * `kcp_bind_port`
                    * 功能：与frp客户端通讯的KCP(基于upd实现)端口  
                    * 类型：int 
                    * 取值
                        * 0:关闭
                        * 其他值:开启
                * `proxy_bind_addr`
                    * 功能：外网访问的地址
                    * 类型：text
                    * 取值：同`bind_addr`
                * `log_file`
                    * 功能：记录日志
                    * 类型：text
                    * 取值
                        * `./frps.log`,默认
                        * 文件路径,日志保存路径
                        * console,日志输出到标准输出
                * `log_level`
                    * 功能：日志等级
                    * 类型：text 
                    * 取值,以下值依次宽松
                        * trace
                        * debug
                        * info,默认
                        * warn
                        * error
                * `log_max_days`
                    * 功能：日志保存时间(天) 
                    * 类型：int      
                    * 取值：3,默认
                * `disable_log_color`  
                    * 功能：禁用标准日志中的颜色 
                    * 类型：bool 
                    * 取值：false,默认
                * `detailed_errors_to_client`
                    * 功能：服务端返回详细的日志给客户端
                    * 类型：bool
                    * 取值：true,默认
                * `heart_beat_timeout`
                    * 功能：服务端和客户端心跳连接的超时时间(秒) 
                    * 类型：int
                    * 取值：90,默认 
                * `user_conn_timeout`
                    * 功能：用户建立连接后等待客户端响应的超时时间(秒)
                    * 类型：int
                    * 取值：10,默认  
            * http和htts配置
                * `vhost_http_port`
                    * 功能：为 HTTP 类型监听的端口 
                    * 类型：int 
                    * 取值
                        * 0,关闭
                        * 80,在80端口监听http请求
                        * 其他值,在指定的端口监听http请求
                * `vhost_https_port`
                    * 功能：为 HTTPS 类型监听的端口 
                    * 类型：int 
                    * 取值
                        * 0,关闭
                        * 80,在80端口监听https请求
                        * 其他值,在指定的端口监听https请求 
                * `vhost_http_timeout`
                    * 功能：HTTP 请求的超时秒数
                    * 类型：int 
                    * 取值
                        * 60,超过60秒则认为当前页面无回应,默认
                        * 其他值,超过指定的秒数则认为当前页面无回应,默认
                * `custom_404_page`
                    * 功能：自定义 404 错误页面地址
                    * 类型：text 
                    * 取值
                        * 未设置,使用系统默认的错误页面
                        * 自定义的URL 
            * 权限配置 
                * `authentication_method`
                    * 功能：鉴权方式,服务端与客户端面需要保持一致
                    * 类型：text 
                    * 取值 
                        * token,默认
                        * oidc 
                * `authenticate_heartbeats`
                    * 功能：开启心跳消息鉴权,服务端与客户端面需要保持一致
                    * 类型：bool 
                    * 取值：false,默认  
                * `authenticate_new_work_conns`
                    * 功能：开启建立连接时的鉴权,服务端与客户端面需要保持一致
                    * 类型：bool
                    * 取值：false,默认 
                * `token`
                    * 功能：token鉴权方式的token值,服务端与客户端面需要保持一致
                    * 类型：string 
                    * 取值：客户端需要设置一样的值才能鉴权通过 
            * 并发控制
                * `allow_ports`
                    * 功能：允许代理的服务端端口
                    * 类型：text 
                    * 取值：每个值之间用逗号分隔,每个值可取以下格式
                        * int,如8080
                        * 连接符,如1000-2000
                * `max_pool_count`
                    * 功能：最大的连接池大小
                    * 类型：int 
                    * 取值：5,默认
                * `max_ports_per_client`
                    * 功能：单个客户端同时连接的数量
                    * 类型：int
                    * 取值
                        * 0,无限制,默认 
                        * 5,限制为5 
                        * 其他值,限制为指定的值
                * `tls_only`
                    * 功能：只接受启用了 TLS 的客户端连接
                    * 类型：bool 
                    * 取值：false,默认
            * 监控面板配置
                * `dashboard_addr`
                    * 功能：服务端监控面板地址
                    * 类型：text 
                    * 取值：同`bind_addr`
                * `dashboard_port`
                    * 功能：监控面板端口
                    * 类型：int 
                    * 取值
                        * 0,关闭监控面板,默认
                        * 5114,在5114端口可访问监控面板
                        * 其他值,在指定的端口访问监控面板
                * `dashboard_user`
                    * 功能：监控面板登录用户名
                    * 类型：text 
                    * 取值：admin,默认
                * `dashboard_pwd`
                    * 功能：监控面板登录密码
                    * 类型：text 
                    * 取值：admin,默认 
    * 客户端(被访问端)
        * `[common]`
            * 基础配置 
                * `server_addr`
                    * 功能：frp服务端通讯的公网ip或域名，用于和服务端通讯
                    * 类型：text
                    * 取值
                        * 0.0.0.0,默认值。此时表示无服务端
                        * 其他ip地址,将指定的ip地址作为服务端
                * `server_port`
                    * 功能：frp服务端端口(保持与服务端通讯) 
                    * 类型：int
                    * 取值
                        * 7000,默认值
                        * 其他值,使用指定的端口
                * `http_proxy`
                    * 功能：连接服务端使用的代理地址。当本机无法直接连接到服务端时,使用代理连接
                    * 类型：text
                    * 取值
                        * 格式为`{protocol}://user:passwd@host:port`
                            * `protocol`:代理协议,可取`http`,`socks5`
                            * `user`:用户名
                            * `passwd`:密码
                            * `host`:代理主机的IP或域名
                            * `port`:代理主机的端口
                        * 未设置此项,不使用代理地址,其他符合指定的格式的值,使用此代理连接到服务端 
                * `log_file`
                    * 功能：日志文件地址
                    * 类型：text
                    * 取值
                        * `./frpc.log`,默认日志文件
                        * `console`,标准输出
                * `log_level`:同服务端`log_level`
                * `log_max_days`:同服务端`log_max_days`
                * `disable_log_color`:同服务端`disable_log_color`
                * `pool_count`
                    * 功能：连接池大小
                    * 类型：int
                    * 取值
                        * 0,无限制
                        * 其他值,限制指定的数值
                * `user`
                    * 功能：在代理配置名称前加`{user}.`,例如代理名称为`[ssh]`,设置此值后,名称为`{user}.ssh`
                    * 类型：text
                    * 取值
                        * 未设置此项时,代理配置名称前加前缀
                        * 其他值,在代理配置名称前加指定的前缀 
                * `dns_server`
                    * 功能：frp客户端使用的`DNS`服务器IP
                    * 类型：text 
                    * 取值：未设置此项时默认使用系统的`dns`地址 
                * `login_fail_exit`
                    * 功能：启动时连接到服务器失败后是否退出
                    * 类型：bool
                    * 取值 
                        * true,连接到服务器失败后直接退出程序,默认
                        * false,连接到服务器失败后不退出程序,尝试重新连接
                * `protocol`
                    * 功能：与服务端通讯的通讯协议
                    * 类型：text
                    * 取值
                        * tcp,默认 
                        * websocket 
                        * kcp
                * `tls_enable`
                    * 功能：是否启用 TLS 协议加密连接
                    * 类型：bool
                    * 取值
                        * false,默认
                        * true,启用TLS加密
                * `heartbeat_interval`
                    * 功能：向服务端发送心跳包的间隔秒数
                    * 类型：int 
                    * 取值
                        * 30,默认 
                        * 其他值,指定的秒数 
                * `heartbeat_timeout`
                    * 功能：服务端回复心跳包的超时秒数 
                    * 类型：int 
                    * 取值
                        * 90,默认 
                        * 其他值,指定的秒数 
                * `start`
                    * 功能：只启用指定的代理配置
                    * 类型：text 
                    * 取值
                        * 未配置此项时,默认启用全部的代理配置 
                        * 每个代理配置名称使用逗号`,`隔开 
            * 权限配置 
                * `authentication_method`:同服务端`authentication_method`
                * `authenticate_heartbeats`:同服务端`authentication_method`
                * `authenticate_new_work_conns`:同服务端`authenticate_new_work_conns`
                * `token`:同服务端`token`
            * 监控面板配置
                * `admin_addr`
                    * 功能：客户端监控面板本地地址 
                    * 类型：text 
                    * 取值
                        * 0.0.0.0,默认,本机所有的网卡地址
                        * 其他ip,指定的网卡ip 
                * `admin_port`
                    * 功能：客户端监控面板本地地址端口 
                    * 类型：int
                    * 取值
                        * 0,默认,关闭客户端监控面板
                        * 其他值,指定的端口
                * `admin_user`
                    * 功能：用户名
                    * 类型：text 
                    * 取值 
                        * admin,默认
                        * 其他值,指定的用户名 
                * `admin_pwd`
                    * 功能：密码
                    * 类型：text 
                    * 取值 
                        * admin,默认
                        * 其他值,指定的密码 
        * `[proxy_config]`代理配置。名称可自定义,如`[ssh]`,`[web]`,可定义多个代理配置 
            * 基础配置 
                * `type`
                    * 功能：指定代理的类型
                    * 类型：text
                    * 取值 
                        * tcp,默认
                        * udp
                        * http
                        * https
                        * stcp 
                        * sudp
                        * xtcp
                        * tcpmux(不常用) 
                * `use_encryption`
                    * 功能：frp客户端与服务端之间的信息传输是否启用加密功能
                    * 类型：bool
                    * 取值
                        * false:不启用加密功能,默认
                        * true:启用加密。
                * `use_compression`
                    * 功能：frp客户端与服务端之间的信息传输是否启用压缩功能
                    * 类型：bool
                    * 取值
                        * false:不启用压缩功能,默认
                        * true:启用压缩功能
                * `proxy_protocol_version`
                    * 功能：是否发送`proxy protocol协议`(基于TCP协议的代理) 
                    * 类型：text 
                    * 取值
                        * 未设置此项值,不发送`proxy protocol协议`
                        * v1,版本1
                        * v2,版本2。此值可用于获取用户的真实IP 
                * `bandwidth_limit`
                    * 功能：限制当前的代理的宽带速度
                    * 类型：text 
                        * 取值
                            * 0:不限制,默认
                            * 5MB:最大宽带速度为5MB 
                            * 1024KB:最大的宽带速度为124KB 
                * `local_ip`
                    * 功能：需要被代理的服务的IP地址,可以是所在 frpc 能访问到的任意 IP 地址 
                    * 类型：text
                    * 取值
                        * 127.0.0.1:部署在本机的服务,默认
                        * 192.168.1.36:部署在`192.168.1.36`的内网服务
                * `local_port`
                    * 功能：需要被代理的服务的端口
                    * 类型：int 
                    * 取值
                        * 80:被代理的服务所在的端口为80
                * `plugin`
                    * 功能：客户端插件名称，如果配置了 plugin，则 local_ip 和 local_port 无效
                    * 类型：text 
                    * 取值
                        * https2http:启用https代理的插件
                * `plugin_params`
                    * 功能：插件需要的参数
                    * 类型：map(每个配置的参数需要以`plugin_`作为前缀)
                    * `https2http`插件参数配置示例 
                        * `plugin_local_addr = IP:PORT`:https的服务地址为`IP`端口为`PORT`
                        * `plugin_crt_path = CRT`:https的`.crt`文件路径为`CRT`
                        * `plugin_key_path = KEY`:https的`.key`文件路径为`KEY`
                        * `plugin_host_header_rewrite = IP`:替换发送到本地服务 HTTP 请求中的 Host 字段为`IP`
                * `group`
                    * 功能：负载均衡分组名称,用户请求会以轮询的方式发送给同一个 group 中的代理
                    * 类型：text 
                    * 取值
                        * 未配置此项时不启用负载均衡
                        * web:均衡分组名称为`web`
                * `group_key`
                    * 功能：负载均衡分组密钥,只有同一个`group`且同一个`group_key`才会被加入同一个负载均衡组中
                    * 类型：text 
                    * 取值
                        * 未配置此项时不启用负载均衡密钥验证
                        * pq:均衡分组密钥为`pq`
            * TCP、UDP
                * `remote_port`
                    * 功能：frps绑定到frpc的端口,用户访问此端口的请求会被转发到 local_ip:local_port
                    * 类型：int
                    * 取值
                        * 80:绑定的端口为80
            * HTTP
                * `custom_domains`
                    * 功能：frps绑定的IP或域名,当用户访问此域名时则被解析到当前的代理服务中
                    * 类型：text数组,使用逗号分隔
                    * 取值
                        * 未配置:则必须配置`subdomain`
                        * `106.75.241.124`:服务器的IP是`106.75.241.124`
                        * `www.myweb.com`:服务器的域名是`www.myweb.com`
                * `subdomain`
                    * 功能：frps绑定的子域名,当用户访问此域名时则被解析到当前的代理服务中
                    * 类型：text
                    * 取值
                        * 未配置:则必须配置`custom_domains`
                        * `www`:二级域名的前缀是`www`
                        * `abc`:二级域名的前缀是`abc`
                * `locations`
                    * 功能：URL路由匹配(最大前缀匹配),当用户访问此路由时则被解析到当前的代理服务中
                    * 类型：text数组,使用逗号分隔
                    * 取值
                        * 未配置:不启用路径匹配模式
                        * `abc`:路由前缀为`abc`时对应到此服务
                * `http_user`
                    * 功能：访问站点的用户名
                    * 类型：text
                    * 取值
                        * 未配置:不使用frp访问控制
                        * abc:访问的用户名为`abc`
                * `http_pwd`
                    * 功能：访问站点的密码(配置了`http_user`时才有效) 
                    * 类型：text
                    * 取值
                        * 未配置:密码为空
                        * abc:访问的密码为`abc`
                * `host_header_rewrite`
                    * 功能：替换发送到本地服务的`Header`的`Host`字段 
                    * 类型：text 
                    * 取值
                        * 未配置:不替换
                        * `127.0.0.1`:替换为`127.0.0.1`
                * `headers`
                    * 功能：添加发送到本地服务的`Header`的字段 
                    * 类型：map(每个配置的参数需要以`header_`作为前缀) 
                    * 配置示例
                        * `header_abc = 123`:在发送到本地服务的Header中添加值为`123`的字段`abc` 
            * HTTPS
                * `custom_domains`:同`HTTP`的此项配置
                * `sub_domain`:同`HTTP`的此项配置
            * STCP、SUDP、XTCP
                * `role = server`
                    * 功能：定义运行frpc的是被访问端还是访问端
                    * 类型：text 
                        * server:被访问端
                        * visitor:访问端
                * `sk`
                    * 功能：密钥,被访问端和访问端的密钥需要一致才能建立连接 
                    * 类型：text 
                    * 取值 
                        * kkk:密钥是`kkk`
    * 访问端 
        * `[common]`
            * `server_addr`:同被访问端的此项配置
            * `server_port`:同被访问端的此项配置
        * `[proxy_config]`代理配置。名称可自定义,如`[ssh]`,`[web]`,可定义多个代理配置
            * STCP、SUDP、XTCP
                * `type`
                    * 功能：指定代理的类型
                    * 类型：text
                    * 取值 
                        * tcp,默认
                        * udp
                        * http
                        * https
                        * stcp 
                        * sudp
                        * xtcp
                        * tcpmux(不常用) 
                * `role = server`
                    * 功能：定义运行frpc的是被访问端还是访问端
                    * 类型：text 
                        * server:被访问端
                        * visitor:访问端
                * `server_name`
                    * 功能：被访问端fpc代理服务的名称 
                    * 类型：text
                    * 取值
                        * ssh:被访问端的代理名称为`ssh`
                        * web:被访问端的代理名称为`web`
                * `bind_addr`
                    * 功能：访问端frpc的IP地址,访问端只需要访问此bind_addr:bind_port即可访问被访问端的服务
                    * 类型：text
                    * 取值
                        * `127.0.0.1`:访问端正在运行frpc的IP为`127.0.0.1`
                * `bind_port`
                    * 功能：访问端frpc的端口,访问端只需要访问此bind_addr:bind_port即可访问被访问端的服务
                    * 类型：int
                    * 取值
                        * `8086`:访问端正在运行frpc的端口为`8086`
* 开启kcp模式(当frp客户端网络状况不佳时建议使用此模式) 
    * 服务端添加以下选项
        ```
        [common]
        kcp_bind_port 
        ```
    * 客户端添加以下选项 
        ```
        [common]
        protocol = kcp
        ```
* 代理配置类型及配置项
    * tcp、udp
        * 服务端 
            ```
            [common]
            bind_port
            ```
        * 客户端
            ```
            [common]
            server_addr 
            server_port 

            [tcp_or_udp]
            type 
            local_ip 
            local_port 
            remote_port 
            ```
    * http
        * 服务端
            ```
            [common]
            bind_port 

            [http]
            vhost_http_port 
            ```
        * 客户端
            ```
            [common]
            server_addr 
            server_port 

            [http]
            type 
            local_port 
            custom_domains 
            subdomain
            locations 
            ```
    * https
        * 服务端
            ```
            [common]
            bind_port 

            [https]
            vhost_https_port  
            ```
        * 客户端
            ```
            [common]
            server_addr 
            server_port

            [https]
            type 
            custom_domains 
            plugin 
            plugin_local_addr 
            plugin_crt_path 
            plugin_key_path  
            plugin_host_header_rewrite  
            ```
    * stcp(加密的tcp传输)、sudp(加密的udp传输)
        * 服务端
            ```
            [common]
            bind_port 
            ```
        * 客户端
            ```
            [common]
            server_addr 
            server_port 

            [stcp_or_sudp]
            type 
            sk 
            local_ip 
            local_port 
            ```
        * 访问端 
            ```
            [common]
            server_addr 
            server_port 

            [stcp_or_sudp_or_xtcp]
            type 
            role 
            server_name 
            sk 
            bind_addr 
            bind_port 
            ```
    * xtcp
        * 服务端
            ```
            [common]
            bind_port 
            bind_udp_port 
            ```
        * 客户端
            ```
            [common]
            server_addr 
            server_port 

            [xtcp]
            type 
            sk 
            local_ip 
            local_port 
            ```
        * 访问端 
            ```
            [common]
            server_addr 
            server_port 

            [stcp_or_sudp_or_xtcp]
            type 
            role 
            server_name 
            sk 
            bind_addr 
            bind_port 
            ```
* 获取用户的真实IP 
    * `http`有以下三种方式 
        1. php `$_SERVER['HTTP_X_FORWARDED_FOR']`
        1. 使用`HTTP_X_FORWARDED_FOR`
            * `nginx`的`server`配置
                * `set_real_ip_from IP;`其中`IP`表示`frpc`所在的内网IP,若内网服务与frpc在同一台服务器上,则可使用`127.0.0.1`
                * `real_ip_header X-Forwarded-For;`
                * `real_ip_recursive on;`
            * php `$_SERVER['REMOTE_ADDR']`
        1. 使用`proxy_protocol_version`配置项
            * `nginx`的`server`配置
                * `listen PORT proxy_protocol;`其中`PORT`表示web监听的端口
                * `set_real_ip_from IP;`其中`IP`表示`frpc`所在的内网IP,若内网服务与frpc在同一台服务器上,则可使用`127.0.0.1`
                * `real_ip_header proxy_protocol;`   
                * `real_ip_recursive on;`
            * `frpc.ini`代理配置
                * `proxy_protocol_version = v2`
            * php `$_SERVER['REMOTE_ADDR']`
    * `https`使用`proxy_protocol_version`配置项
        * `nginx`的`server`配置
            * `listen PORT ssl http2 proxy_protocol;`其中`PORT`表示web监听的端口
                * `set_real_ip_from IP;`其中`IP`表示`frpc`所在的内网IP,若内网服务与frpc在同一台服务器上,则可使用`127.0.0.1`
            * `real_ip_header proxy_protocol;`
            * `real_ip_recursive on;`
        * `frpc.ini`代理配置
            * `proxy_protocol_version = v2`
        * php `$_SERVER['REMOTE_ADDR']`
    
