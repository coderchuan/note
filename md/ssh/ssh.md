# ssh 

## 安装
* 安装服务端
    * ubuntu      
        ` sudo apt install openssh-server `
    * debian      
        ` sudo apt install openssh-server `
    * centos      
        ` sudo yum install openssh-server `
    * windows     
        * 设置->应用->应用和功能->可选功能(如果可选功能下有OpenSSH服务器,则已经安装,无需操作后继步骤)->添加功能->OpenSSH服务器->安装 
* 安装客户端
    * ubuntu      
        ` sudo apt install openssh-client `
    * debian     
        ` sudo apt install openssh-client `
    * centos      
        ` sudo yum install openssh-client `
    * windows     
        * 设置->应用->应用和功能->可选功能(如果可选功能下有OpenSSH客户端,则已经安装,无需操作后继步骤)->添加功能->OpenSSH客户端->安装 

## 配置服务器:
* 公钥:
    * 文件路径                                    
        * linux：`~/.ssh/authorized_keys`,此文件权限`600`,`.ssh`文件夹权限700 
        * windows：`C:\users\%USERNAME%\.ssh\authorized_keys` 
    * 使用方法：将公钥追加到此文件并在客户端使用私钥即可使用ssh免密登录，详见**添加公钥到远程Linux主机**
* 配置文件: 
    * 文件路径                                    
        * linux：`/etc/ssh/sshd_config` 
        * windows：`C:\ProgramData\ssh\sshd_config` 
            * `Match Group administrators`：注释此项
            * `AuthorizedKeysFile __PROGRAMDATA__/ssh/administrators_authorized_keys`：注释此项 
    * 配置项 
        * `ListenAddress[:port]`：要监听的本机IP(可指定端口)，支持ipv4和ipv6。默认监听所有，`0.0.0.0`表示所有ipv4地址，`::`表示所有ipv6地址。可以配置多项
        * `Prot`：服务端口,不配置此项且`ListenAddress`中未指定端口时,默认22。当`ListenAddress`中指定端口时，此项被忽略
        * `TCPKeepAlive`：当与ssh服务器建立后每隔一段时间就发送TCP心跳包以防止连接断开
            * `yes`：发送心跳包
            * `no`：不发送心跳包
        * `PasswordAuthentication`：允许密码登录。默认开启
            * `yes`：允许密码登录
            * `no`：禁止登录
        * `PermitRootLogin`：root用户登录权限设定。默认root禁止密码登录
            * `yes`：允许密钥和密码登录。必须同时设置`PasswordAuthentication yes`
            * `no`：禁止登录 
            * `without-password`或`prohibit-password`：禁止密码登录
            * `forced-commands-only`：只允许root用户使用密钥登录,并且不登录交互shell,只执行`/root/.ssh/authorized_keys`对应的公钥前的命令,命令指定的方式为`command="SH" ssh-rsa AAAABE...ADAQ`,其中`SH`是脚本路径,`ssh-rsa AAAABE...ADAQ`是添加的公钥 

## 配置客户端:
* 私匙
    * 文件路径                                    
        * linux：`~/.ssh/id_rsa`,此文件权限`600`,`.ssh`文件夹权限`700` 
        * windows：`C:\users\%USERNAME%\.ssh\id_rsa` 
* 配置文件
    * 文件路径
        * linux：`~/.ssh/config`,此文件权限`600`
        * windows：`C:\users\%USERNAME%\.ssh\config` 
    * 配置项
        * `Include PATH`：包含其他配置文件，`PATH`表示要包含的配置文件路径。此配置项必须放在文件顶部。Windows命令行下无效
        * `Host HOSTALIAS`：`HOSTALIAS`表示主机别名。可以直接使用命令`ssh HOSTALIAS`连接,但是在git中必须使用与`HostName`相同的值 
        * `User USERNAME`：`USERNAME`表示主机用户名。github中此项的值必须为`git`
        * `HostName IP_OR_DOMAIN`：`IP_OR_DOMAIN`表示主机IP或域名 
        * `Port PORT`：`PORT`表示端口,若不指定此行,默认为22 
        * `IdentityFile ID_RSA_FILE`：`ID_RSA_FILE`表示私钥文件,若不指定此行,默认为`~/.ssh/id_rsa` 
        * `ProxyCommand ssh HOSTALIAS_O -W %h:%p`：用于代理(跳板),·HOSTALIAS_O`表示使用此别名的主机进行代理,`HOSTALIAS_O`应该事先配置好。不配置此项时表示不使用代理 
        * `KexAlgorithms +diffie-hellman-group1-sha1`:当连接`ssh`出现`Unable to negotiate with ... no matching key exchange method found. Their offer: diffie-hellman-group1-sha1`错误时添加此项
    * 注意，美观要求
        * `include`应与其他语句间有至少一行空行 
        * 每组配置间应有至少一行空行 
    * 配置示例1   
        ```                                     
        Host host1                          
        User username                      
        HostName 192.168.35                
        Port 5001                           
        IdentityFile ~/.ssh/id_rsa         
        ```
    * 配置示例2   
        ```                                    
        Host host2                          
        User username                       
        HostName 192.168.48                 
        Port 5001                           
        IdentityFile ~/.ssh/id_rsa           
        ProxyCommand ssh host1 -W %h:%p     
        ```
    * 配置示例3                                       
        ```
        Host github.com                     
        User git                           
        HostName github.com               
        Port 22                              
        IdentityFile ~/.ssh/id_rsa          
        ``` 
        
## 密钥 
* 命令
    ```
    ssh-keygen [-q] [-b bits] [-t dsa | ecdsa | ed25519 | rsa | rsa1] [-N new_passphrase] [-C comment] [-f output_keyfile]
    ssh-keygen [-q] [-b bits] [-t dsa | ecdsa | ed25519 | rsa | rsa1] [-N new_passphrase] [-C comment] [-f output_keyfile]
    ssh-keygen -p [-P old_passphrase] [-N new_passphrase] [-f keyfile]
    ssh-keygen -i [-m key_format] [-f input_keyfile]
    ssh-keygen -e [-m key_format] [-f input_keyfile]
    ssh-keygen -y [-f input_keyfile]
    ssh-keygen -c [-P passphrase] [-C comment] [-f keyfile]
    ssh-keygen -l [-v] [-E fingerprint_hash] [-f input_keyfile]
    ssh-keygen -B [-f input_keyfile]
    ssh-keygen -D pkcs11
    ssh-keygen -F hostname [-f known_hosts_file] [-l]
    ssh-keygen -H [-f known_hosts_file]
    ssh-keygen -R hostname [-f known_hosts_file]
    ssh-keygen -r hostname [-f input_keyfile] [-g]
    ssh-keygen -G output_file [-v] [-b bits] [-M memory] [-S start_point]
    ssh-keygen -T output_file -f input_file [-v] [-a rounds] [-J num_lines] [-j start_line] [-K checkpt] [-W generator]
    ssh-keygen -s ca_key -I certificate_identity [-h] [-n principals] [-O option] [-V validity_interval] [-z serial_number] file ...
    ssh-keygen -L [-f input_keyfile]
    ssh-keygen -A
    ssh-keygen -k -f krl_file [-u] [-s ca_public] [-z version_number] file ...
    ssh-keygen -Q -f krl_file file ...
    ```
* 功能：生成私匙和公匙。
* 权限：当前用户 
* 参数：
    * 无参数：默认由rsa算法生成公私匙对。执行此命令后，共按下三次回车即可生成默认的随机公私匙对,若不设置名称则生成的私匙为`~/.ssh/id_rsa`、生成的公匙为`~/.ssh/id_rsa.pub`:
        * 生成公私匙对时将会提示输入保存公私匙对的文件(含路径)，可以直接回车忽略以使用默认值，即直接按下一次回车键 
        * 生成公私匙对时还会提示输入使用公私匙的密码和确认密码，可以直接回车忽略以不设置密码，即直接再按下两次回车键  
    * `-q`：安静模式。对于在创建过程中不必要的信息不予显示
    * `-b`：指定密钥长度。
        * RSA算法,最小要求1024位,无最大限制。默认是2048
        * DSA算法,最小要求1024位,最大要求1024位。默认是1024
        * ECDSA算法,只能从256,384,521中选择一个数字。默认为512
        * Ed25519算法,忽略-b参数。长度由算法决定 
    * `-t`：生成私匙和公匙的算法指定:
        * `rsa`：默认
        * `rsa1`
        * `dsa`
        * `ecdsa`
        * `ed25519`
    * `-C`：注释信息。例如可以输入使用此公私匙对的用户名
    * `-f`：指定生成公私匙对的文件路径和名称。
* 使用示例：
    * 直接在命令行中运行`ssh-keygen`指令，执行后按下三次回车键 
    * 指定用户名(通过注释)、指定文件保存路径，执行以下指令后按下两次回车键
        ```
        ssh-keygen -C "coderchuan" -f ~/.ssh/github
        ```

## 登录
* 指令
    ```
    ssh [user@]host [-p port] [-i identity_file]
    ssh SSH_CONFIG_HOST_NAME
    ssh [user@]host [-p port] -o ProxyCommand='ssh proxyUser@proxyHost [-p proxyPort] -W %h:%p'
    ssh [user@]hostname [command] [-1246AaCfGgKkMNnqsTtVvXxYy] [-b bind_address] [-c cipher_spec] [-D [bind_address:]port] [-E log_file] [-e escape_char] [-F configfile] [-I pkcs11] [-i identity_file] [-J [user@]host[:port]] [-L address] [-l login_name] [-m mac_spec] [-O ctl_cmd] [-o option] [-p port] [-Q query_option] [-R address] [-S ctl_path] [-W host:port] [-w local_tun[:remote_tun]] 
    ```
* 功能：远程登录 
* 权限：当前用户 
* 参数：
    * `user`：要登录的远程主机的用户名。如果不指定则默认为本地当前的用户名
    * `host`：要登录的远程主机的ip 
    * `port`：要登录的远程主机的端口,默认值为22 
    * `-i identity_file`：指定要使用的私匙,identity_file表示私匙文件。若不指定则使用默认的私匙id_rsa。   
    * `-o ProxyCommand ProxyCommand='ssh proxyUser@proxyHost [-p proxyPort] -W %h:%p'`：释义如下：
        * `proxyUser`：代理(跳板机)用户名
        * `proxyHost`：代理(跳板机)IP 
        * `proxyPort`：代理(跳板机)端口 
        * `%h:%p`：代表targetHost:targetPort。表示代理(跳板机)对于输入应该定向到targetHost:targetPort 
    * `hostname`：远程主机地址
    * `command`：直接在远程主机执行命令而不是登录。 
    * `-A`：允许代理(使用此参数时不能使用配置文件`~/.ssh/config`中设置的别名)。使用此命令前需要将指定的密匙加入代理配置(`ssh-agent bash`、`ssh-add`)      
    * `-W host:port`：输出输入交互的`host:port`,即要连接的远程主机的ip和端口。此参数用于代理(跳板机)，`%h:%p`可代替`host:port`表示主命令中的ip地址和端口   
    * `-1`：使用第一版ssh协议 
    * `-2`：使用第二版ssh协议。默认 
    * `-4`：使用IPV4 
    * `-6`：使用IPV6  
    * `SSH_CONFIG_HOST_NAME`：`ssh`配置文件`~/.ssh/config`中配置的`Host`项的值。此命令可直接使用`config`配置文件登录
* 使用示例：
    ```
    ssh centos@192.168.23.130 -p 22 -o ProxyCommand='ssh ubuntu@192.168.23.129 -p 22 -W %h:%p'      
        连接主机centos@192.168.23.130:22,跳板机是ubuntu@192.168.23.129:22;
        使用配置文件(./ssh/config)可以达到相同的效果 

    ssh ubuntu@192.168.23.129 -p 22                                                                 
        连接主机ubuntu@192.168.23.129:22
    ```
    
## 文件传送:
* 指令
    ```
    scp [-P port] [-346BCpqrv] [-c cipher] [-F ssh_config] [-i identity_file]
        [-l limit] [-o ssh_option] [-S program]
        <{LOCAL_DIR_FILE REMOTE_DIR_FILE}|{REMOTE_DIR_FILE LOCAL_DIR_FILE}> 
    ```
* 功能：基于ssh传送/获取文件 
* 权限：具有该文件/文件夹权限的用户组或用户
* 参数：
    * `-3`：文件通过本地传送,如果没有此选项,文件将在多个远程主机之间复制而不通过本地主机。此选项将会禁用进度条 
    * `-4`：使用IPV4 
    * `-6`：使用IPV6  
    * `-B`：脚本模式(不交互) 
    * `-r`：递归,传送文件夹时需要使用此选项 
    * `-F ssh_config`：使用指定的ssh_config配置文件而不是默认的ssh_config配置文件 
    * `-i identity_file`：使用指定的私钥文件,而不是默认的私钥文件 
    * `-P`：ssh端口
    * `LOCAL_DIR_FILE`：本地文件夹或文件 
    * `REMOTE_DIR_FILE`：远程文件夹或文件。形式为: `USERNAME[@HOST]:DIR_FILE`(其中`@HOST`为不使用配置文件时需要配置的参数，如果使用ssh配置文件则只需要指定`USERNAME`，即ssh配置文件中的`Host`项的值即可)。
* 文件传输时有以下几种情况：
    * 发送方发送的是文件时:
        1. 如果接收方的路径是文件夹,则把文件传送至此文件夹下。此文件夹必须存在 
        1. 如果接收方的路径是文件,则把文件传送至此文件的文件夹下,并以此文件名命名。此文件的上级文件夹必须存在  
    * 发送方发送的是文件夹时:
        1. 如果收方文件夹已经存在,则将文件夹传送至此文件夹下 
        1. 如果收方文件夹不存在,则将文件夹传送至此,并命名文件夹。此文件夹的上级文件夹必须存在  
* 使用示例：
    ```
    scp -P6000 -r "d:\ui"  ubuntu@192.168.1.4:~/abc/

    scp -P6000 -r "d:\ui"  ubuntu@192.168.1.4:~/abc/
    ``` 

## 添加公钥到当前主机当前用户
* linux 
    * 命令
        ```
        cat PUBFILE >> ~/.ssh/authorized_keys
        ```
    * 参数
        * `PUBFILE`：表示公钥文件,例如`/home/ubuntu/b.pub` 

## 添加公钥到远程Linux主机
* windows
    * powershell
        * 命令
            ```
            ssh [-p port] username@host "echo $(type PUBFILE) >> ~/.ssh/authorized_keys;chmod 600 ~/.ssh/authorized_keys"
            ```
        * 参数：
            * `PUBFILE`：表示公钥文件,例如`c:\user\yang\.ssh\myid.pub` 
            * `port`：远程主机ssh端口号 
            * `username`：要添加公钥的用户名
            * `host`：要添加公钥的主机IP  
    * cmd 
        * 命令
            ```
            set /p temp_pub=<"PUBFILE"  
            ssh [-p port] username@host "echo %temp_pub% >> ~/.ssh/authorized_keys;chmod 600 ~/.ssh/authorized_keys"
            ```
        * 参数：同`powershell`
* linux 
    * 命令
        ```
        ssh-copy-id {-i PUBFILE} {username@host [-p port]}
        ```
        ```
        ssh [-p port] username@host "echo $(cat PUBFILE) >> ~/.ssh/authorized_keys;chmod 600 ~/.ssh/authorized_keys"
        ```
        ```
        ssh [-p port] username@host "echo `cat PUBFILE` >> ~/.ssh/authorized_keys;chmod 600 ~/.ssh/authorized_keys"
        ```
        ```
        cat PUBFILE | ssh username@host [-p port] 'cat - >> ~/.ssh/authorized_keys;chmod 600 ~/.ssh/authorized_keys'
        ```
    * 说明：以上任意一条命令皆可。推荐使用`ssh-copy-id`
    * 参数：
        * `PUBFILE`：PUBFILE表示公钥路径及文件 
        * `username`：要添加公钥的用户名
        * `host`：要添加公钥的主机IP
        * `-p port`：要添加公钥的主机端口,port表示端口号 
    * 示例：`ssh-copy-id -i "/mnt/c/Users/yang/.ssh/myId.pub" root@192.168.1.7 -p8022`

## SSH建立隧道
* 防止断连
    * 设置`/etc/ssh/sshd_config`中的`TCPKeepAlive yes`
    * 在连接参数中设置 `-o TCPKeepAlive=yes` 
* 转发类型
    * 本地转发：
        * 语法：`ssh [-o TCPKeepAlive=yes] -[C][g][[f]N]L [LOCAL_ADDRESS:]LOCAL_PORT:AIM_ADDRESS:AIM_PORT {[username@]host[:port]|SSH_CONFIG_HOST_NAME`
        * 含义：在本机建立隧道，此隧道把本机与`host`中介主机联通，所有对`LOCAL_ADDRESS:LOCAL_PORT`的访问都将由中介主机`host`发起对`AIM_ADDRESS:AIM_PORT`的访问
        * `-o TCPKeepAlive=yes`：定时发送跳包以防止断连
        * `LOCAL_ADDRESS`：将要与服务器绑定的本地IP地址，ipv6地址需要在两端加`[`和`]`。默认为回环地址
        * `LOCAL_PORT`：将要与服务器绑定的本地端口
        * `AIM_ADDRESS`：服务器上被绑定的IP，ipv6地址需要在两端加`[`和`]`，此IP必须可以被`host`中介主机访问 
        * `AIM_PORT`：服务器上被绑定的端口
        * `username`：ssh登录用户名，如果转发成功，则相当于此用户访问被转发的访问内容。如果不指定则默认为本地当前的用户名
        * `host`：中介主机。ssh登录的主机地址
        * `port`：ssh登录端口。默认为22
        * `SSH_CONFIG_HOST_NAME`：`ssh`配置文件`~/.ssh/config`中配置的`Host`项的值 
        * `f`：后台启用，和`N`一起使用以在后台启用隧道
        * `N`：不打开远程shell
        * `g`：将`LOCAL_ADDRESS`的默认值指定为`全零地址`
        * `C`：压缩数据传输 
    * 远程转发
        * 语法：`ssh [-o TCPKeepAlive=yes] -[C][g][[f]N]R [REMOTE_ADDRESS:]REMOTE_PORT:AIM_ADDRESS:AIM_PORT {[username@]host[:port]|SSH_CONFIG_HOST_NAME`
        * 含义：在`host`主机建立隧道，此隧道把`host`主机与本机联通，所有对`host`主机的`REMOTE_ADDRESS:REMOTE_PORT`访问都将由本机发起对`AIM_ADDRESS:AIM_PORT`的访问
        * `-o TCPKeepAlive=yes`：定时发送跳包以防止断连
        * `REMOTE_ADDRESS`：将要与服务器绑定的远程IP地址，ipv6地址需要在两端加`[`和`]`，此IP必须在host主机中，默认值为全零地址。此值必须在host主机中的`/etc/ssh/sshd_config`文件中设置`GatewayPorts yes`才会生效否则会将此值替换为远程回环地址。
        * `REMOTE_PORT`：将要与服务器绑定的远程端口
        * `AIM_ADDRESS`：服务器上被访问的IP，ipv6地址需要在两端加`[`和`]`，此IP必须可以被本机访问 
        * `AIM_PORT`：服务器上被访问的端口
        * `username`：ssh登录用户名，如果转发成功，则相当于此用户访问被转发的访问内容。如果不指定则默认为本地当前的用户名
        * `host`：ssh登录的主机地址
        * `port`：ssh登录端口。默认为22
        * `SSH_CONFIG_HOST_NAME`：`ssh`配置文件`~/.ssh/config`中配置的`Host`项的值 
        * `f`：后台启用，和`N`一起使用以在后台启用隧道
        * `N`：不打开远程shell
        * `g`：将`REMOTE_ADDRESS`的默认值指定为`全零地址`
        * `C`：压缩数据传输 
    * 动态转发
        * 语法：`ssh [-o TCPKeepAlive=yes] -[C][g][[f]N]D [LOCAL_ADDRESS:]LOCAL_PORT {[username@]host[:port]|SSH_CONFIG_HOST_NAME`
        * 含义：在本机建立隧道(`socks5或socks4`代理，代理服务器的地址为`LOCAL_ADDRESS:LOCAL_PORT`)，转发所有的端口请求，所有对`LOCAL_ADDRESS:LOCAL_PORT`的代理访问都将由中介主机`host`发起对目标地址的访问。
        * `-o TCPKeepAlive=yes`：定时发送跳包以防止断连
        * `LOCAL_ADDRESS`：本机代理地址，ipv6地址需要在两端加`[`和`]`。默认为回环地址
        * `LOCAL_PORT`：本机代理端口
        * `username`：ssh登录用户名，如果转发成功，则相当于此用户访问被转发的访问内容。如果不指定则默认为本地当前的用户名
        * `host`：ssh登录的主机地址
        * `port`：ssh登录端口。默认为22
        * `SSH_CONFIG_HOST_NAME`：`ssh`配置文件`~/.ssh/config`中配置的`Host`项的值 
        * `f`：后台启用，和`N`一起使用以在后台启用隧道
        * `N`：不打开远程shell
        * `g`：将`LOCAL_ADDRESS`的默认值指定为`全零地址`
        * `C`：压缩数据传输

## socks代理配置
* Win10
    1. 设置->网络和Internet->代理->手动设置代理
    1. 地址中填写`http://socks=HOST`，其中`HOST`表示代理地址。例：`http://socks=192.168.1.4`
    1. 端口中填写代理地址的端口。例：`9009`
* curl：详见：[curl的socks的用法](index.html?title=/md/linux/wget_curl)
