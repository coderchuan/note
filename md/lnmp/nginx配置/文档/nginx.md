# NGINX基础

## 安装
* linux 
    * ubuntu：`sudo apt install nginx -y` 
    * debian：`sudo apt install nginx -y` 
    * centos：`sudo yum install nginx -y`

## 配置语法约定 
* 配置项包含关系 
    1. `nginx.conf -> events`
    1. `nginx.conf -> http -> server -> location` 
    1. `nginx.conf -> mail` 
* 配置文件：nginx.conf,以下是配置文件位置:
    ```
    ubuntu      /etc/nginx/nginx.conf 
    windows     安装目录/conf/nginx.conf 
    ```
* 配置项参数类型
    * 有含义的文本      
        * 示例：`on` 
        * 示例：`off` 
        * 示例：`auto`  
    * 整数    
        * 示例：`404`
        * 示例：`9007` 
    * 字符串  
        * 规则    
            * 字符串中不含空格等特殊字符时,无需使用双引号包裹 
            * 字符串中含有空格等特殊字符时,需要使用双引号包裹 
            * 使用双引号包裹的字符串中含有变量时,变量名(不含`$`)需要使用大括号`{}`包裹 
        * 示例 
            ```   
            /image 
            "/program Files"
            "${uri}/img"
            ```
    * 语句块
        * 示例 
            ```
            { listen 9007; }
            ```
* 语句：
    * 每个配置语句使用分号(;)结尾,但是配置参数类型为"块语句"的配置项不用使用分号结尾
    * 每条语句单独一行 
* 注释
    * `#`,语句前 
* 配置块                  
    * 每个配置块(除全局配置外)使用大括号包裹 
* 文件夹
    * 文件夹应该以斜杠(/)结尾 
* 内部重定向              
    * 通过在nginx内部同一个server配置块中进行处理,网址不会改变
* 外部重定向
    * 将网址信息返回给浏览器,让浏览器通过网址重新发起请求,地址栏网址会改变。分为临时重定向(302)与永久重定向(301)
        * 301：永久重定向
            * 当客户端访问旧URL时返回给客户端301状态码和一个新URL,客户端访问新URL并且将新URL永久缓存，当客户端再次访问旧URL时就会自动使用缓存的新URL进行访问。搜索引擎抓取内容时，得到301状态码时也会把内容页使用新的URL保存 
            * 当客户端访问的目录不存在或访问的是目录但是末尾没有斜杠时，nginx会返回301状态码和一个末尾带斜杠的新URL给客户端 
        * 302：临时重定向 
            * 当用户访问旧URL时返回给客户端301状态码和一个新URL,客户端访问新URL但是不缓存。
* 相对路径
    * 路径可以使用绝对路径或相对路径(不推荐),以下是相对路径的默认父目录位置:
        * ubuntu：`/usr/share/nginx/`和`配置文件当前目录`
        * windows：`安装目录`和`配置文件当前目录`
* mime.types文件
    * 文件扩展名与文件类型映射表,mime.types路径如下:
        * ubuntu：`/etc/nginx/mime.types`
        * windows：`安装目录/conf/mime.types` 
* URL格式  
    * 格式
        ```
        WEB_HOST[PORT][URI][PATH_INFO][QUERY]
        ```
    * 关键字解释
        * WEB_HOST 主机地址,分为两部分:
            * PROTOCOL：网络协议,如：`` http://``、`` https:// `` 
            * HOST：主机域名或IP,如：`` www.baidu.com ``、`` 192.168.32.25 `` 
        * PORT：端口号,如：`` :8080 `` 
        * URI：资源路径,以WEB_HOST为根目录的资源路径,如：`` /image/abc.png,/text/ ``。如果未指定此值，URI默认为`/`
        * PATH_INFO   URI与QUERY之间的文本 
        * QUERY       参数,如：`` ?id=35&type=file ``
        * 示例。``` http://www.baidu.com:80/s.php/foo/bar.html?wd=123 ```
* 设定变量
    * 格式 
        ```
        set $VAR_NAME VALUE
        ```
    * 关键字解释 
        * VAR_NAME  
            * 变量名,当要使用这个变量时,应该这样使用：`` ${VAR_NAME} ``，大多数情况下也可以这样使用`$VAR_NAME`
        * VALUE
            * 变量值 
* 文件、报文、正文大小单位 
    * 不带单位：单位为位(b) 
    * k：单位为千位(Kb) 
    * m：单位为兆位(Mb) 
* 常用状态码
    * 200：正常 
    * 301：永久重定向
    * 302：临时重定向 
    * 400：请求无效
    * 401：没有权限 
    * 403：禁止访问 
    * 404：资源不存在
    * 405：资源被禁止
    * 406：无法接受的请求 
    * 407：要求代理身份验证
    * 410：永远不可用
    * 412：先决条件失败
    * 413：请求实体太大
    * 414：URI太长
    * 500：内部服务器错误
    * 501：未实现 
    * 502：网关错误
* 内置变量 
    * `` $document_root ``
        * web根路径,受root,alias影响 
    * `` $uri ``
        * URL中的原始信息：`[URI][PATH_INFO]`
        * location匹配时与此变量进行匹配
    * `` $fastcgi_path_info ``
        * 传递给fastcgi服务器的PATH_INFO参数,受fastcgi_split_path_info影响
    * `` $fastcgi_script_name ``
        * 将要执行的目标脚本,默认为`${uri}`。受fastcgi_index、fastcgi_split_path_info影响
    * `` $request_filename ``
        * 请求访问的目标文件(完整路径),默认为`${document_root}${uri}`。受alias影响
    * `` $host ``
        * URL中的原始信息：`` HOST ``
    * `` $query_string ``或`$args`
        * URL中的原始信息：`` QUERY(不含问号(?)) ``。如：`foo=123&bar=D`。没有参数时为空字符串
    * `` $is_args ``
        * URL中的原始信息：`` QUERY(只包含问号,或空字符) `` 
    * ` $http_user_agent ` 
        * 浏览终端信息：` Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.62 `
    * ` $remote_addr `
        * 客户端地址：` 192.168.32.28 `
    * ` $http_referer `
        * URL跳转来源
    * ` $request_method`
        * 请求方法。通常为"GET"或"POST"
    * `scheme`
        * 请求所使用的协议
    * ` $http_host `
        * 请求的目标主机地址(浏览器地址栏中的值)：` hc.com:9007 `
    * `` $request_uri ``
        * URL中的原始信息：`` [URI][PATH_INFO][QUERY] ``
    * `$scheme://$http_host$request_uri`
        * 客户端完整的请求地址(浏览器地址栏中的地址)
    * ` $request `
        * 请求方法、`[URI][PATH_INFO][QUERY]`、请求所用的协议。它们之间使用空格分隔
    * ` $time_local `
        * 输出此变量时的时间(通常为日志写入时间)：` 16/Mar/2020:00:43:32 +0800 `
    * ` $time_iso8601 `
        * 输出此变量时的时间(通常为日志写入时间),iso8601格式：` 2020-03-16T00:43:32+08:00 `
    * ` $msec `
        * 输出此变量时的时间(通常为日志写入时间),微秒时间戳：` 1584291720.621 `
    * ` $status `
        * HTTP请求状态：` 304 ` 
    * ` $request_time `
        * 请求过程消耗的时间：` 0.000 `       
    * ` $body_bytes_sent `
        * 发送给客户端的文件内容大小：` 0 ` 
    * ` $connection_requests `
        * 这个连接中的请求数量：` 1 `    
    * ` $connection `
        * 连接序号：` 1 `    
    * ` $pipe `
        * 是否通过HTTP-pipelined发送,是p否.：` . ` 
    * ` $remote_user `
        * 客户端用户名称：` - ` 
    * ` $upstream_status `
        * upstream状态：` - `     
    * ` $ssl_protocol `
        * SSL协议版本：` - ` 
    * ` $ssl_cipher `
        * 交换数据的算法：` - ` 
    * ` $upstream_addr `
        * 提供服务的服务器地址：` - `      
    * ` $upstream_response_time `
        * 服务器响应时间：` - ` 
        
## 查看启动失败原因:      
* 权限    root 
* 指令
    ```
    nginx -t          
    ```

## server监听优先级
* 当匹配结果不唯一时,会依照以下规则逐渐匹配直到匹配到唯一的server：
    1. IP匹配(包括域名指向的IP),优先级最高;
    1. 端口匹配,优先级低于IP匹配;
    1. 域名完全匹配,优先级低于端口匹配;
    1. 域名通配符匹配 
        * 域名使用前置通配符匹,优先级低于完全匹配;
        * 域名使用后置通配符匹配,优先级低于前置通配符匹配;
    1. 域名使用正则匹配,优先级低于通配符匹配;
    1. 默认匹配,listen配置项后有default或default_server,优先级低于正则匹配;
    1. 端口相匹配的第一个server,优先级低于默认匹配。

## 配置项
* `index FILE_NAMES` 
    * 含义：默认主页。省略此项配置则默认`FILE_NAMES`为:`index.html`  
    * `FILE_NAMES`：默认主页,多个文件使用空格隔开 
    * 功能：依次检测`$uri/FILE_NAMES`文件是否存在，如果本次请求执行到结束仍没有任何访问结果(没有访问到文件(夹)，没有返回错误码，没有重定向)，则根据`$uri/FILE_NAMES`文件是否存在，自动执行以下动作：
        * 文件存在：发起内部重定向`$uri/FILE_NAMES`
        * 文件不存在：返回404
    * 使用位置：http,server,location
* `try_files FILE_OR_DIR {SPEC_URI|= CODE}`
    * 功能：依次检测文件夹或文件是否存在,如果存在则直接访问,如果`FILE_OR_DIR`不存在,则内部重定向到`SPEC_URI`或返回`CODE`;
    * `FILE_OR_DIR`：指文件夹或文件，多个文件或文件夹使用空格分隔
    * 检测文件：末尾不是以字面字符`/`结尾
    * 检测文件夹：末尾需以字面字符`/`结尾
    * 注意：检测文件夹时，可能会引起301重定向(甚至循环301重定向)，重定向的访问目标是`FILE_OR_DIR`。当`FILE_OR_DIR`同时存在以下情况时会引发301重定向：
        1. `FILE_OR_DIR`是一个真实存在的目录
        1. `FILE_OR_DIR`最后一个字符是字面量字符`/`
        1. `FILE_OR_DIR`倒数第二个字符不是`/`  
    * 常用方法：`try_files $uri $uri/ =404;`
    * 使用位置：server,location 
* `autoindex {(off)|on}`
    * 功能：当访问目标是文件夹时关闭/开启访问文件(夹)列表 
    * 其他参数：
        * `autoindex_exact_size {(on)|off}`
            * 功能：开启/关闭显示文件的确切大小 
        * `autoindex_format {(off)|on}` 
            * 功能：关闭/开启以服务器系统设置时区显示时间
            * `off`：使用GTM时间
            * `on`：使用服务器系统设置时区显示时间
    * 使用位置：http,server,location 
* `types MIME_TYPES`
    * 功能：文件扩展名与文件类型映射表,通常使用include包含mime.types文件来替换此项配置。MIME_TYPES表示配置块，参见使用位置：types
    * 使用位置：http,server,location
    * 示例：`include /etc/nginx/mime.types;`
* `default_type MIME_TYPES_NAME`                
    * 功能：当请求的文件扩展名不在types映射列表中时,使用此类型。一般使用`application/octet-stream`作为此项值 
    * 使用位置：http,server,location
* `{deny|allow} {ADDRESS|unix:|all}` 
    * 功能：禁止/允许某个`IP/unix:`访问 
    * 优先级：与配置的顺序有关,先配置的优先级高,会覆盖和后一个配置重合的部分
    * `ADDRESS`：IP地址或IP段
    * `unix:`：通过`linux socket`访问
    * `all`：所有访问方式
    * 示例
        * `allow 192.168.1.0/24`，允许IP前3(24/8=3)位地址访问即IP前3位符合`192.168.1`，被允许访问
        * `allow 2001:0db8::/32`，允许IP前4(32/8=4)位地址访问即IP前4位符合`2001:0db8`被允许访问
        * `deny 192.168.1.1`，拒绝`192.168.1.1`访问
        * `deny all`，拒绝所有访问
        * `deny unix:`，拒绝通过`linux socket`访问
    * 使用位置：http,server,location,limit_except 
* `charset TEXT_CODE`
    * 功能：设置返回给客户端`Content-Type indicated`的文本解析方式。TEXT_CODE 表示文本编码方式,它可以取以下值:
        * `utf-8`：UTF8编码 
    * 使用位置：http,server,location,if in location 
* `client_max_body_size SIZE` 
    * 功能：设置客户端请求正文的最大允许大小，在"Content-Length"请求标头字段中指定。如果请求中的大小超过配置的值，则会将返回413错误码。
    * 使用位置：http,server,location 
    * `SIZE`：大小配置，详见"配置语法约定->文件、报文、正文大小单位"
* ` include FILE `
    * 功能：将FILE文件中的配置信息包含在使用此语句的位置。
    * 使用位置：任何符合配置语法的位置 
    * `FILE`：表示文件的路径，如` /etc/nginx/modules-enabled/*.conf `
* ` error_log FILE {debug|info|notice|warn|(error)|crit|alert|emerg} `
    * 功能：错误日志,严重程度依次递增,输出的信息量依次递减。子配置优先于全局配置。
    * 使用位置：nginx.conf,http,server,location
    * FILE：表示文件的路径,如:/home/ubuntu/LOG/nginx/error.log 
* ` access_log {off|LOG_FILE [LOG_FORMAT]} `
    * 功能：访问日志。内部重定向只记录最后一次访问
    * 使用位置：http,server,location
    * off选项：关闭访问日志
    * LOG_FILE：LOG文件
    * LOG_FORMAT：LOG格式,可以选择二种方式:
        * 使用log_format已经定义好的FORMAT_NAME名称
        * 省略此参数则使用系统默认的日志格式 
* ` server_tokens {(on)|off} `
    * 功能：是否在返回给客户端的信息中包含`nginx`的版本信息
    * 使用位置：http,server,location 
    * 值类型：text
    * 取值 
        * on:开启,默认 
        * off:关闭 
* ` rewrite PATTERN NEW_URL_OR_URI [flag] `
    * 功能：网址重定向,如果PATTERN匹配成功则此条命令生效,否则跳过
    * 使用位置：server,location,if
    * PATTERN：对$uri进行正则匹配的正则表达式
    * NEW_URL_OR_URI：要替换的URI或URL
        * 如果此值以` http:// `或` https:// `开头,则进行外部重定向
    * flag：重定向选项,当不写flag参数时,依次尝试以下参数,直到执行成功或全部尝试结束。此参数可取以下值:
        * break：终止location中剩下的语句，直接使用NEW_URL_OR_URI资源，若NEW_URL_OR_URI不存在，则直接返回404  
        * last：内部重定向。使用NEW_URL_OR_URI在nginx内部发起请求
        * redirect：外部302临时重定向。将NEW_URL_OR_URI返回客户端,状态码是302,临时重定向 
        * permanent：外部301永久重定向。将NEW_URL_OR_URI返回客户端,状态码是301,永久重定向 
* ` return {CODE | CODE STRING|URL} `
    * 功能：返回状态码或重定向
    * 使用位置：server,location,if
    * CODE：可以使用的状态码 
        * 200：STRING表示返回到网页的字符串,作为html显示(需要设置default_type项的值为text/html)。可用于调试 
        * 301：STRING表示永久重定向的URL或URI
        * 302：STRING表示临时重定向的URL或URI
        * 400等：无STRING 
        * 500等：无STRING 
    * STRING：它的含义与CODE有关 
    * URL：使用302临时重定向到URL 
* ` if (CONDITION) { CONFIG_CODE } `
    * 功能：条件判断
    * 使用位置：server,location
    * CONDITION：判断条件,有以下规则:
        * `VAR`：如果变量不为空且不为0,则为真。
        * `VAR = VAR_OR_CONST`：用于判断=两边的字符串是否相等,相等为真。
        * `VAR != VAR_OR_CONST`：用于判断!=两边的字符串是否相等,不相等为真
        * `VAR ~ PATTERN`：大小写敏感的正则匹配,匹配成功则为真
        * `VAR ~* PATTERN`：大小不敏感的正则匹配,匹配成功则为真
        * `-f  VAR_OR_CONST`：检查文件是否存在,存在为真
        * `!-f VAR_OR_CONST`：检查文件是否存在,不存在为真
        * `-d  VAR_OR_CONST`：检查文件夹是否存在,存在为真
        * `!-d VAR_OR_CONST`：检查文件夹是否存在,不存在为真 
        * `-e  VAR_OR_CONST`：检查文件、目录或符号链接是否存在,存在为真
        * `!-e VAR_OR_CONST`：检查文件、目录或符号链接是否存在,不存在为真
        * `-x  VAR_OR_CONST`：查是否为可执行文件,是则为真 
        * `!-x VAR_OR_CONST`：检查是否为可执行文件,不是则为真 
            * `VAR`：表示变量 
            * `VAR_OR_CONST`：表示变量或常量字符串 
            * `PATTERN`：表示正则表达式 
    * `CONFIG_CODE`：如果判断条件为真,则执行此语句
* `fastcgi_connect_timeout NUM`
    * 功能：设置与fastcgi尝试建立连接的时间。如果与fastcgi尝试建立连接的时间超过NUM秒nginx将会放弃连接
    * 使用位置：http,server,location 
    * 建议取值：300
* `fastcgi_send_timeout NUM`
    * 功能：设置向fastcgi服务器传送数据的时间。如果向fastcgi服务器传送数据的时间超过NUM秒nginx将会断开连接 
    * 使用位置：http,server,location 
    * 建议取值：300
* `fastcgi_read_timeout NUM`
    * 功能：设置fastcgi服务器的响应时间。如果fastcgi服务器的响应时间超过NUM秒nginx将会断开连接 
    * 使用位置：http,server,location 
    * 建议取值：300
* `fastcgi_buffering {(on)|off};`
    * 功能：开启/关闭fastcgi缓冲。开启缓冲时，将fastcgi返回的数据存入缓冲区直到接收完成后或达到缓冲上限了才返回给浏览器。关闭缓冲时，将fastcgi返回的数据实时返回到时浏览器而不存入缓冲区。
    * 使用位置：http,server,location 
* `fastcgi_buffers NUM SIZE`
    * 功能：设置缓冲区的数量(NUM默认为8)和大小(SIZE默认为4k或8k)，用于缓存从FastCGI Server接收到的数据。大于NUM*SIZE大小的部分将被缓存到硬盘。
    * 使用位置：http,server,location 
    * 建议取值：4 128k
* `fastcgi_buffer_size SIZE` 
    * 功能：设置缓冲区读取大小。从缓冲区读取数据时，一次读取的大小。
    * 使用位置：http,server,location 
    * 建议取值：128k
* `fastcgi_busy_buffers_size SIZE`
    * 功能：一旦fastcgi_buffers设置的 buffer被写入，直到buffer里面的数据被完整的传输完（传输到客户端），这些buffer将会一直处在busy状态，我们不能对这些 buffer进行任何别的操作。所有处在busy状态的buffer size加起来不能超过SIZE
    * 使用位置：http,server,location 
    * 建议取值：256k
* `fastcgi_temp_file_write_size FILE_SIZE`
    * 功能：超出`fastcgi_buffers NUM SIZE`中`NUM*SIZE`大小的数据将存入临时文件，文件大小限制为FILE_SIZE
    * 使用位置：http,server,location 
    * 建议取值：256k
* `fastcgi_max_temp_file_size SIZE`
    * 功能：临时缓冲文件大小总和限制为SIZE，设置为0则不限制缓冲临时文件大小。默认为0
    * 使用位置：http,server,location 
* `fastcgi_temp_path PATH`
    * 功能：`fastcgi_temp_file_write_size`项存入临时文件的文件夹
    * 使用位置：http,server,location 
    * 建议：一般情况下无需指定此位置，由nginx决定存储在哪
* `user USER [GROUP]`           
    * 功能：所属用户和所属组,用于权限控制,用户的权限配置优先于组的权限配置。其中USER表示用户;GROUP表示用户组。省略`GROUP`时默认为与`USER`同名的用户组名。以A用户启动且A没有root权限时，user设置为A和名为A的用户组
    * 默认：默认`user nobody`
    * 使用位置：nginx.conf
* `worker_processes {auto|NUM}`
    * 功能：工作进程数量。NUM表示数字,可以自定义配置,配置为auto表示自动处理。此项关系到并发性能
    * 使用位置：nginx.conf
* `pid FILE`
    * 功能：服务守护进程文件,文件内容为进程PID。
    * `FILE`：表示文件的路径,如:`/run/nginx.pid`
    * 使用位置：nginx.conf
* `load_module FILE`            
    * 功能：加载模块。
    * `FILE`：表示文件的路径,如:`/usr/share/nginx/modules/ngx_stream_module.so`
    * 使用位置：nginx.conf
* `events EVENTS_CONF`
    * 功能：events配置
    * `EVENTS_CONF`：配置块
    * 使用位置：nginx.conf
* `http HTTP_CONF`
    * 功能：http配置
    * `HTTP_CONF`：配置块,配置块中的配置项详见使用位置为：http的配置项
    * 使用位置：nginx.conf
* `worker_connections NUM`
    * 功能：同一个工作进程同时能处理的连接数量。NUM表示数字,通常使用512 
    * 使用位置：events
* `accept_mutex {on|off}`       
    * 功能：只唤醒一个工作进程处理新的连接,防止"惊群问题"发生,on表示开启。不配置此项时默认为on 
    * 使用位置：events
* `multi_accept {on|off}`       
    * 功能：同一个工作进程同时处理多个连接,on表示开启。不配置此项时默认为off 
    * 使用位置：events
* `use {select|poll|kqueue|epoll|resig|/dev/poll|eventport}`
    * 功能：强制指定事件驱动模型。不配置此项时自动选择处理,无需人工干预 
    * 使用位置：events
* `log_format FORMAT_NAME FORMAT`
    * 功能：日志格式定义
    * `FORMAT_NAME`：表示自定义日志名称     
    * `FORMAT`：字符串自定义日志格式,可以使用内置变量。
    * 使用位置：http
* `sendfile {on|off}`                           
    * 功能：以sendfile方式传输文件,on表示开启。不配置此项时默认为off
    * 使用位置：http
* `sendfile_max_chunk SIZE`                     
    * 功能：sendfile方式最大能够传输的文件大小。
    * `SIZE`：表示大小设置,详见"配置语法约定->文件、报文、正文大小单位"
    * 使用位置：http
* `keepalive_timeout TIMEOUT [header_timeout]`  
    * 功能：连接超时时间。header_timeout表示使用请求头部中的timeout值,这个参数可以使浏览器自动关闭连接
    * `TIMEOUT`：数字,超时时间,单位为秒 
    * 使用位置：http
* `keepalive_requests NUMBER`
    * 功能：同一个连接中的请求次数限制。NUMBER表示数字,即限制次数。当不配置此项时,默认值为100
    * 使用位置：http
* `server SERVER_CONF`                          
    * 功能：server配置。重要,通常使用include包含文件替换此项配置。
    * `SERVER_CONF`：配置块,配置块中的配置项详见使用位置为：http的配置项。 
    * 使用位置：http
* `FILE_TYPE FILE_EXT` 
    * 功能：映射文件后缀对应的文件类型,可以无限制地增加此项配置。 
    * `FILE_TYPE`：表示文件类型,例如:`text/html`
    * `FILE_EXT`：文件后缀,多个后缀使用空格分隔,例如:`html htm shtml` 
    * 使用位置：types
* `listen {[IP:]PORT|IP{(:80)|:PORT}}`
    * 功能：http添加对端口PORT的监听,本项server添加对本机IP地址访问的监听。可以无限制地增加此项配置,如无此项配置则相当于"listen 80;"
    * `PORT`：整数,表示端口,例如:`8080` 
    * `IP`：表示ipv4地址或ipv6地址,例如:`192.168.32.28`,`[::]`(表示本机ipv6地址)。省略IP参数相当于监听本机ipv4地址  
    * 示例：
        ```
        listen 9006;                http添加对端口9006的监听,本项server添加对本机ipv4地址访问的监听
        listen [::]:9006;           http添加对端口9006的监听,本项server添加对本机ipv6地址访问的监听 
        listen 192.168.32.28;       http添加对端口80的监听,本项server添加对本机192.168.32.28地址访问的监听 
        listen 192.168.32.28:9005;  http添加对端口9005的监听,本项server添加对本机192.168.32.28地址访问的监听 
        ```
    * 使用位置：http
* `server_name SERVER_NAME ...`                             
    * 功能：对指定的本机域名(或IP)进行监听。可以使用通配符(*,通配符必须前置或后置且与其他字符用英文句点分隔)和正则表达式(正则表达式须以~符号开头,PREG) 
    * `SERVER_NAME`：表示域名,多个域名使用空格分隔 
    * 使用位置：http
* `root PATH`
    * 功能：将$document_root赋值为PATH，被赋值后的$document_root末尾没有斜杠`/`。省略此项配置则默认为:相对路径的默认父目录下的/html 
    * `PATH`：文件夹路径。将会被作为网站的根目录  
    * 使用位置：http 
* `location [=|^~|~|~*| ] PATTERN LOCATION_CONF`
    * 功能：匹配规则,可以无限制地增加此项配置。匹配优先级按以下顺序排序 
    * `PATTERN`：表示匹配规则或正则表达式(PREG)。匹配优先级如下，依次递减：
        * `=`：精确匹配。$uri完全匹配 PATTERN 字符串 
        * `^~`：前缀匹配。URI开头匹配 PATTERN 字符串 
        * `~`：正则匹配。URI与区分大小写的正则 PATTERN 匹配 
        * `~*`：正则忽略大小写匹配。URI与不区分大小写的正则 PATTERN 匹配 
        * 空格：低优先级前缀匹配。 
        * 全部匹配失败：如果http server中的index配置的文件存在,则访问http server中root配置的路径下的index配置的文件 
    * `LOCATION_CONF`：配置块,配置块中的配置项详见使用位置为：location的配置项
    * 使用位置：http
* `alias PATH`
    * 功能：将$document_root赋值为PATH。$request_filename被重新赋值，赋值规则如下:
    * `PATH`：文件夹路径
    * 赋值规则，与location中使用的匹配方式有关，有以下规则：
        * 精确匹配：$request_filename被重新赋值为:$document_root。
        * 前缀匹配：$request_filename被重新赋值为:$document_root+$uri截去前缀匹配的内容剩下的文本
        * 低优先级前缀匹配：同上 
        * 正则匹配：$request_filename被重新赋值为:$document_root。建议结合正则捕获组使用
        * 正则忽略大小写匹配  同上 
    * 示例 
        ```
        location ~ ([^/]*)$ {
            alias /home/ubuntu/www1/$1;
        }
        ```
    * 使用位置：location
* `proxy_pass URL`
    * 功能：代理，匹配location配置成功，则转到代理`URL`所代表的主机
    * URL：表示代理主机地址,如`http://192.168.32.28` 
    * 示例：
        * 配置示例：`proxy_pass http://192.168.32.28;`
        * 含义解释：访问`http://192.168.1.1/proxy/test.html`,则表示访问代理`http://192.168.32.28/proxy/test.html`
    * 使用位置：location
* `fastcgi_pass {IP:PORT|unix:UNIX_SOCKET}`
    * 功能：cgi服务器。cgi配置详见php.md中关于Fastcgi配置的介绍。
    * IP：服务器IP
    * PORT：服务器端口 
    * UNIX_SOCKET：SOCKET文件路径 
    * 示例1：`fastcgi_pass unix:/var/run/php-fpm/php-fpm.sock`
    * 示例2：`fastcgi_pass 192.168.32.28:9008` 
    * 使用位置：location
* `fastcgi_index FILE_NAME`
    * 功能：fastcgi服务器默认访问文件 
    * `FILE_NAME`：如果`URI`以`/`结束,则对$fastcgi_script_name重新赋值为`URI`+`FILE_NAME`
    * 使用位置：location
* `fastcgi_split_path_info PATTERN`
    * 对$fastcgi_script_name和$fastcgi_path_info变量进行重新赋值 
    * `PATTERN`：正则表达式对`$uri`进行匹配。必须包含两个捕获组:
        * 第一个捕获组中的内容赋值给`$fastcgi_script_name` 
        * 第二个捕获组中的内容赋值给`$fastcgi_path_info` 
    * 使用位置：location
* `fastcgi_param  PARAMS_NAME PARAMS_VALUE`
    * 功能：fastcgi服务器传入参数设置。应该使用`include fastcgi_params;`先包含默认参数设置。
    * `PARAMS_NAME`：参数名,可取以下值:
        * `SCRIPT_FILENAME`：fastcgi服务器执行的脚本文件路径 
        * `PATH_INFO`：PATH_INFO值 
        * `PATH_TRANSLATED`：根路径与PATH_INFO组成的新路径 
    * `PARAMS_VALUE`：参数值 
    * 使用位置：location
    * 静态页面匹配示例：
        ```
        location / {
            root /var/www;
            index index.html;
            try_files $uri $uri/ =404;
        }
        ```
    * php动态匹配示例：
        * 不含PATH_INFO信息的配置方式
            ```
            location ~ \.php$ {
                include fastcgi_params;
                fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
                fastcgi_pass 127.0.0.1:9000;
                try_files $uri =404;
            }
            ```
        * 含PATH_INFO信息的配置方式
            ```           
            location ~ \.php/.*$|\.php$ {
                fastcgi_pass            unix:/tmp/php-fpm.sock;
                fastcgi_split_path_info ^((?U).+\.php)(/.+)$;
                include                 fastcgi_params;
                fastcgi_param           SCRIPT_FILENAME         $document_root$fastcgi_script_name;
                fastcgi_param           PATH_INFO               $fastcgi_path_info;
                fastcgi_param           PATH_TRANSLATED         $document_root$fastcgi_path_info;
            }
            ```

# 常见问题
* 页面加载缓慢，解决方法：
    * 关闭缓冲`fastcgi_buffering off`
