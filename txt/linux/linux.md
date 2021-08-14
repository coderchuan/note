# 常用命令

## 安装ifconfig命令 
* ubuntu:`apt install net-tools`

## 查看系统是32位还是64位
* `getconf LONG_BIT`

## 查看系统架构
* `uname -a`

## bash自动补全:安装`bash-completion`

## 进程
* 查看进程号:`pgrep NAME [OPTION]`,查找程序名为`NAME`的正在运行的进程,其中`OPTION`可取以下值
    * `OPTION`
        * `-l`:同时显示程序名称 
* 查看并结束进程
    * `pgrep NAME | xargs kill -9`,杀死程序名为`NAME`的进程  
    * `pkill -9 NAME`,杀死程序名为`NAME`的进程  

## 多语言输入输出
* 配置文件
    * rpm系:`/etc/sysconfig`
    * deb系:`/etc/default/locale`
        * ubuntu
* 使系统支持多语言输入输出
    1. 编辑配置文件并在末尾添加`LANG="C.UTF-8"` 
    2. 重新登录用户

## 链接文件路径 
* 创建软链接：`ln -s 原文件 指向原文件的软链接文件`
    * 注意：原文件的路径必须是绝对路径或相对于软链接文件的路径
* 创建硬链接：`ls 原文件名 新的硬链接文件名`
* 读取文件或链接文件所指向的绝对路径：`readlink -f 文件名`

## linux的`home`目录
* `root`用户:`/root`
* 普通用户:`/home/USERNAME`,其中`USERNAME`表示用户名。(仅限新建用户时指定了`-m`参数未指定`-d`参数时) 

## 新建组
`groupadd GROUPNAME`,其中`GROUPNAME`表示组名

## 显示所有可登录的组
`cat /etc/group | grep -P -v "^[^:]*:[^:]*:(?|[1-9]|\d{2}|[1-4]\d{2}):|nobody|nogroup|nologin"`

## 新建用户
1. 先确定用户要加入哪个组,如果要加入的组不存在,则先`新建组`。设组名为`GROUPNAME`
1. 确定用户的用户名。设用户名为`USERNAME`
1. 执行`useradd -s /bin/bash -m -g GROUPNAME USERNAME`

## 显示所有可登录的用户
`cat /etc/passwd | grep -P -v "^[^:]*:[^:]*:(?|[1-9]|\d{2}|[1-4]\d{2}):|nobody|nogroup|nologin"`

## 将已经存在的用户添加到指定的组
`usermod -a -G GROUPNAME USERNAME`,其中`USERNAME`表示用户名,`GROUPNAME`表示组名

## 更改用户的默认登录shell
1. 查看可用的shell:`cat /etc/shells`
1. 更改到指定的shell:`chsh USERNAME -s NEW_SHELL`,其中`USERNAME`表示用户名,`NEW_SHELL`表示`shell`路径

## 无法使用ssh密码登录远程服务器时添加ssh密钥登录
1. 登录远程服务器,进入目标用户的`home`目录
1. 执行`mkdir .ssh;chmod 700 .ssh;`
1. 复制公钥文本内容,设其文本为`PUBCONTENT`
1. 执行`echo PUBCONTENT >> .ssh/authorized_keys`
1. 执行`chmod 600 .ssh/authorized_keys`
1. 执行`chown -R USERNAME:GROUPNAME .ssh`,其中`USERNAME`表示用户名,`GROUPNAME`表示组名 

## 查看网卡及mac地址
* `` find /sys/ -type f -name address|grep devices|grep -v virtual|grep -Pio "[^/]+/address$"|grep -Pio "^[^/]+"|xargs -i sh -c 'echo "{}\t" `cat /sys/class/net/{}/address`' ``

## 通配符
* `*`:匹配所有字符
* `?`:匹配任意一个字符
* `[]`:范围符,`[abc]`表示匹配"abc"中的一个字符;`[a-z]`表示匹配"a"至"z"中的一个字符;`[1-9]`表示匹配"1"至"9"中的一个字符;`[1\-9]`表示匹配"19-"中的一个字符
* `[!]`或`[^]`:反向范围符,同`[]`,匹配不在此范围中的一个字符 
* `{}`:序列符,生成空格相隔的序列。`..`为连接符,如果`..`连接的不是序列则把`..`及两边的内容看作一个字符串整体。`,`为序列分隔符号,如果有`,`则把两个`,`之间的内容作为序列的一个成员。`{a..c}`表示"a b c",`{a..c,a..7}`表示"a..c a..7"

## 查找文件(夹) 
* 查找指定文件夹下的文件(夹):`find DIR -name TARGET_NAME`,其中`DIR`为指定的文件夹路径。`TARGET_NAME`被检索的名称,符合通配符规则
* 查找当前文件夹的文件(夹):`find -name TARGET_NAME`
* 查找指定文件夹下的文件:`find DIR -type f -name TARGET_NAME`
* 查找当前文件夹的文件:`find -type f -name TARGET_NAME`
* 查找指定文件夹下的文件夹:`find DIR -type d -name TARGET_NAME`
* 查找当前文件夹的文件夹:`find -type d -name TARGET_NAME`

## 将字符串作为命令执行
`sh -c 'COMMAND'`。其中`COMMAND`表示命令 

## 管道`|`
* 功能：将`|`之前的命令输出写入到管道文件,`|`之后的命令将管道文件的路径作为输入参数 
* 示例：`echo 'abc.txt'|cat`。将字符串"abc.txt"作为文本写入到管道文件中,`cat`输出管道文件的内容,内容为"abc.txt"

## xargs命令
* 功能：从管道文件中读取内容作为下一个命令的输入参数
* 示例：
    * 简单使用:`whoami | xargs groups`。`whoami`输出当前用户名称,`groups`命令后接用户名称输出当前用户的所有组 
    * 管道文件的内容多次使用:`echo 123 | xargs -i echo {} {}`。最终输出`123 123`
    * 管道文件的内容多次使用:`` echo release|xargs -i sh -c 'echo {} `cat /etc/*{}*`' ``

## 更改主机名(root权限) 
* `ubuntu`(设`NEW_NAME`是新主机名) 
    1. 修改`/etc/hosts`中的旧主机名为新的主机名
    1. 修改`/etc/hostname`中的旧主机名为新的主机名
    1. 修改`/etc/sysconfig/network`中的旧主机名为新的主机名

## sudo权限配置(编辑/etc/sudoers文件)
* 用户组`sudo`内的用户使用用户密码切换用户和用户组:`%sudo ALL=(ALL:ALL) ALL`
* 用户组`admin`内的用户无条件切换用户和用户组:`%admin ALL=(ALL:ALL) NOPASSWD: ALL`

## 更改交互式命令别名`alias`
* 指定的用户可用
    1. 切换为指定的用户并进入`home`目录
    1. 编辑`.bashrc`文件
    1. 找到定义"alias"的位置,并编辑形式为`alias ll='ls -l'`的语句,保存编辑。其中`ll`表示别名,`ls -l`表示别名`ll`代替的命令
    1. 执行`source .bashrc`

## 获取当前时间
* 格式为"YYYY-mm-dd HH:ii::ss":`date  +"%Y-%m-%d %H:%M:%S"`

## 标准输出输入错误重定向
* 标准位置`STD_IN_OUT_ERR`
    * `/dev/null`:空设备,接受任何输出,并立即销毁 
    * `0`:标准输入
    * `1`:标准输出
    * `2`:标准错误
* 使用语法(当`STD_IN_OUT_ERR`是`1`时可省略) 
    * `STD_IN_OUT_ERR>LOGFILE`:覆盖写入到指定的文件`LOGFILE`
    * `STD_IN_OUT_ERR>>LOGFILE`:追加写入到指定的文件`LOGFILE` 
    * `STD_IN_OUT_ERR&>STD_IN_OUT_ERR_REF`:输出到引用的标准位置。例`2>&1`表示把输出错误也输出到标准输出 
* 使用示例
    * 计划任务中把输出写入日志文件:`` echo start at `date` >>~/start.log 2>&1``
        * 解释:把命令的执行标准输出追加写入到文件`~/start.log`; 把标准错误输出到标准输出。因此无论标准错误还是标准输出都追加写入到文件`~/start.log`了 

## 计划任务 
* 定时字段 
    * 时间字段 
        * 普通字段(占用5个字段,每个字段用空格分隔) 
            1. 分:0-59 
            1. 时:0-23 
            1. 日:1-31 
            1. 月:1-12 
            1. 周:0-7(0与7皆表示周日) 
        * 特殊字段(占用1个字段) 
            * @reboot:当计算机启动时执行一次。可用于软件或脚本开机自启动
            * @yearly,@annually:每年执行一次，相当于`0 0 1 1 *`
            * @monthly:每月执行一次，相当于`0 0 1 * *`
            * @weekly:每周执行一次，相当于`0 0 * * 0`
            * @daily,@midnight:每天执行一次，相当于`0 0 * * *`
            * @hourly:每小时执行一次，相当于`0 * * * *`
    * 时间字段取值 
        * 数值:表示此值符合执行条件
        * 连接符(-):连接两个数值，表示在此范围的值皆符合执行条件
        * 逗号(,):把多个孤立值或(和)多个连续值组成列表，表示在此列表内的值皆符合执行条件
        * `*/n`:取值范围的值/n。表示能够被n整除的值皆符合执行条件 
        * `*`:相当于`*/1`
    * 时间字段组合的含义
        * `周`和`日`都不为`*`:`分时日月`或`分时月周`执行任务 
        * `周`和`日`都为`*`:`分时月`执行任务 
        * 仅`周`为`*`:`分时日月`执行任务 
        * 仅`日`为`*`:`分时月周`执行任务 
* 计划任务类型 
    * 系统计划任务
        * 任务文件:`/etc/crontab` 
        * 编辑方式:使用编辑器编辑任务文件 
        * 语法:`时间字段 用户名 要执行的命令` 
        * 示例:`@reboot root service ssh restart`:开机自动启动ssh
    * 用户计划任务
        * 任务文件:`/var/spool/cron/crontabs/用户名`
        * 编辑方式:`crontab -e`
        * 语法:`时间字段 要执行的命令` 
        * 示例:`0 * * * * rm -rf /etc/log/cron/test/`:每个小时删除`/etc/log/cron/test`目录 
    * 软件专用计划任务
        * 任务文件:`/etc/cron.d/自定义文件名` 
        * 编辑方式:使用编辑器编辑任务文件 
        * 语法:同系统计划任务
        * 示例:同系统计划任务
        * 建议:`/etc/cron.d/`不同的软件或事件存放在不同的任务文件中
* 建立目录软链接
    * `ln -s REAL_PATH SOFT_LINK_PATH`。其中`REAL_PATH`为真实路径,`SOFT_LINK_PATH`为软链接路径
* 文件权限
    * 7:可读可写可执行 
    * 6:可读可写 
    * 5:可读可执行 
    * 4:可读 
    * 3:可执行可写 
    * 2:可写 
    * 1:可执行 

## scp传送文件
* scp下载文件
    * `scp -r [-P PORT] REMOTE_HOST:FILE_PATH LOCAL_SAVE_PATH`
        * 解析
            * PORT:ssh端口。如果端口为22或如果在`.ssh/config`中配置过端口,亦可省略
            * REMOTE_HOST:远程主机,如果在`.ssh/config`中配置过,亦可使用配置的别名 
            * FILE_PATH:远程主机的文件(夹)路径
            * LOCAL_SAVE_PATH:下载到本机的文件的存储路径(可在路径末端写明存储名称,即重命名) 
        * 示例
            * `scp -r 200_45:/var/www/IR/dev/config/test.php d:\`。本机`.ssh/config`文件中配置了别名为`200_45`的`ssh远程主机`,并将文件`/var/www/IR/dev/config/test.php`下载到本地`d:\`路径下
            * `scp -r yang.chuan@192.168.31.106:/var/www/IR/dev/config/test.php d:\`。将`yang.chuan@192.168.31.106`的文件`/var/www/IR/dev/config/test.php`下载到本地`d:\`路径下 
* scp上传文件
    * `scp -r [-P PORT] LOCAL_SAVE_PATH REMOTE_HOST:FILE_PATH`
        * 解析
            * PORT:ssh端口。如果端口为22或如果在`.ssh/config`中配置过端口,亦可省略
            * REMOTE_HOST:远程主机 
            * LOCAL_SAVE_PATH:要上传的文件的本机存储路径 
            * FILE_PATH:远程主机存储上传文件的路径(可在路径末端写明存储名称,即重命名) 
        * 示例
            * `scp -r d:\test.php 200_45:/var/www/IR/dev/config/`。本机`.ssh/config`文件中配置了别名为`200_45`的`ssh远程主机`,并将本地文件`d:\test.php`上传到远程主机`/var/www/IR/dev/config/`路径下 
            * `scp -r d:\test.php yang.chuan@192.168.31.106:/var/www/IR/dev/config/`。将本地文件`d:\test.php`上传到远程主机`yang.chuan@192.168.31.106`的`/var/www/IR/dev/config/`路径下 

## 压缩与解压缩
* 后缀`tar.gz`或`tgz`
    * 查看列表:`tar tzvf  文件名`
    * 压缩:`tar czvf  保存的压缩文件名  要压缩的目录`
    * 解压缩:`tar xzvf  要解压的文件名`
* 后缀`tar`
    * 查看列表:`tar tvf  文件名`
    * 压缩:`tar cvf  保存的压缩文件名  要压缩的目录`
    * 解压缩:`tar xvf  要解压的文件名`

## 文件内键值对提取
1. 文件内容为如下格式,设文件名为`/etc/os-release`
    ```
    ID=ubuntu
    VERSION_ID=20.04
    ```
1. 文件权限为可执行或当前用户为root用户
1. 执行`echo $(. /etc/os-release && echo $ID $VERSION_ID)`
1. 输出`ubuntu 20.04`

## 输出的同时写入文件
* 命令:`tee [-a] file1 [file2 file...]`
* 功能:将标准输入或管道文件中的内容输出到屏幕并定入到file1、file2、file...等文件中 
* 参数:
    `-a`:追加到文件
    `file1`:将内容写入指定的文件名 