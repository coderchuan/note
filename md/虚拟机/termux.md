# termux 

## 安装termux
* 官方网站：`https://termux.com/` -> `GET IT ON F-Droid` -> `下载APK`

## 推荐软件(软件管理工具pkg，详见[软件安装](index.html?title=/md/linux/软件安装与软件))
* openssh：远程连接工具
    * termux为单用户系统，连接ssh时可以不指定用户名，若指定了用户名则会忽略该用户名 

## 快捷按键
* 可用按键：
    * CTRL
    * ALT
    * FN
    * ESC
    * TAB
    * HOME：行首
    * END：行尾
    * PGUP：上页
    * PGDN：下页
    * INS：插入
    * DEL：后删除
    * BKSP：前删除
    * UP
    * LEFT
    * RIGHT
    * DOWN
    * ENTER
    * BACKSLASH：反斜杠
    * QUOTE：双引号
    * APOSTROPHE：单引号
    * F1~F12
    * 直接输入字符组成的字符串 
* 自定义按键
    * 新建文件夹`~/.termux/`
    * 编辑`~/.termux/termux.properties`文件，示例文件内容如下：
        ```
        extra-keys = [                                           \
            ['ESC','DEL','BKSP','UP','HOME','PGUP','END'],       \
            ['ALT','CTRL','LEFT','DOWN','RIGHT','PGDN','TAB'],   \
            ['`','$','>','|','BACKSLASH','APOSTROPHE','QUOTE']   \
        ]
        ```
        * `extra-keys`是一个数组，在这个数组中，每一个子数组都是一行快捷键。子数组中每一个元素(由单引号或双引号包裹)都是一个快捷键，建议每行按键数量不超过7个，详见可用按键列表
        * 配置文件除最后一行外，每一行都应使用`\`结尾

## 在termux中安装发行版Linux。
* termux中应该已经安装以下软件：
    * `proot`
* 查看手机构架，在termux中执行命令`dpkg --print-architecture`，查看输出结果：
    * `aarch64`：arm64构架
    * `arm`：armhf构架
    * `amd64`：amd64构架
    * `x86_64`：amd64构架
    * `i*86`：i386构架
    * `x86`：i386构架
* 打开`https://github.com/EXALAB/Anlinux-Resources/tree/master/Scripts/Installer`,选择想要安装的发行版,下载`.sh`文件到termux的`~`目录。
* 打开`https://github.com/EXALAB/Anlinux-Resources/tree/master/Rootfs/`,选择想要安装的发行版,选择手机构架,下载`.tar.xz`文件到termux的`~`目录，重命名`.tar.xz`文件与`.sh`文件内容中的`tarball`项的值相同(一般来説是删除文件名中`-构架`,如`ubuntu-rootfs-arm64.tar.xz`更名为`ubuntu-rootfs.tar.xz`)。
* 开始安装。
    1. 进入`~`目录
    1. 执行`.sh`开始安装,如`bash ubuntu.sh`
* 执行成功的标志：`.tar.xz`文件不存在于`~`目录。此时目录下除以下三个文件(夹)外其余文件(夹)可以删除：
    1. start-*.sh 
    1. *-binds
    1. *-fs
* 设置自动登录发行版linux：`echo "bash ~/start-*.sh" >> ~/.bashrc`
* 手动执行登录：`bash ~/start-*.sh`
