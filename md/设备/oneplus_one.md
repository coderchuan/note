## oneplus one 刷机 (所需文件在仓储硬盘:/设备/oneplus_one.rar，解压出来即可)
* 计算机环境配置
    1. Windows10设置-更新和安全-恢复-高级启动-立即重新启动-疑难解答-高级选项-启动设置-禁用驱动程序强制签名
    1. 在计算机上安装`一加万能工具包5.3.exe`,简称"工具包"
    1. 运行工具包，进行如下操作：驱动安装-黑砖驱动,然后再安装ADB MTP PTP驱动，安装完成后关闭工具包
    1. 重启计算机 
* 基本操作 
    * 进入9008模式:使用数据线连接计算机与手机,长按电源与音量上键
    * 进入fastboot模式:断开数据线连接计算机,长按电源与音量上键
    * 进入recovery模式:长按电源与音量下键 
    * 刷入卡刷包
        1. 断开数据线与计算机的连接,将手机重启进入fastboot模式,通过数据线连接手机与计算机
        1. 在工具包中进行如下操作:Recovery卡刷-浏览选择`.zip`卡刷包,安装完成后手机自动开机,有以下事项需要注意
            * 刷入前置包时不要勾选`双清系统和格式化System`
            * 刷入主体包时需要勾选`双清系统和格式化System`
            * 刷入基带包时不要勾选`双清系统和格式化System`
    * 刷入线刷救砖包
        1. 进入9008模式
        1. 管理员运行线刷救砖包中的`Msm8974DownloadTool.exe`,简称"救砖工具"
        1. 使用数据线连接计算机,手机长按"电源+音量加键"直到计算机发现新设备,此时"救砖工具"的设备类型中出现"Com设备"行,点击start,直到出现"已经下载完成"字样,此时点击"stop",然后关闭"救砖工具"
    * 刷入twrp(刷入后可在"recovery模式"下使用MTP连接计算机传输文件)
        * 刷入步骤 
            1. 配置好"计算机环境"
            1. 断开数据线与计算机的连接,将手机重启进入fastboot模式,通过数据线连接手机与计算机
            1. 在工具包中进行如下操作:Fastboot线刷-自由线刷-浏览选择twrp.img,等待安装完成,在Windows任务管理器中结束任务"工具包"
            1. 将手机重启进入recovery模式,勾选"Never show this",并点击"Keep Read Only"
        * twrp中挂载选项中的"启用MTP"功能无效的解决方法
            1. 在Windows10设备管理器-类似"Android Devices"的选项-"ADB Interface"-卸载设备(勾选删除此设备的驱动程序)-卸载
            1. 在twrp中点击"停用MTP",再点击"启用MTP"即可在计算机中发现存储设备
        * 使用`adb shell`命令进入手机命令行(如果已经配置好环境变量且手机进入开发都模式,可直接到`使用adb命令`步骤)
            1. 将"ADB_Tool"复制到`C:\Program Files\`目录下
            1. 在环境变量`PATH`中添加`C:\Program Files\ADB_Tool`,手机中开启开发者调试模式 
            1. 使用adb命令
                * 进入手机命令行:`adb shell`
                * 从手机下拉文件到本地计算机:`adb pull PHONE_FILE_PATH PC_FILE_PATH`,把手机的文件(夹)`PHONE_FILE_PATH`拉取到本地计算机`PHONE_FILE_PATH`
                * 从本地计算机推送文件到手机:`adb push PC_FILE_PATH PHONE_FILE_PATH`,把本地计算机的文件(夹)`PHONE_FILE_PATH`推送到手机`PHONE_FILE_PATH`
    * 修改mac地址
        1. 进入`ubuntu touch`系统
        1. 切换为`root用户`(需要先为`phablet`用户设置密码):`sudo su - root`
        1. 挂载系统分区可写:`mount -o rw,remount /`
        1. 编辑`nano /persist/WCNSS_qcom_cfg.ini`文件,修改`Intf0MacAddress`项,其值为`12位16进制数`
        1. 重启:`reboot`
    * 备份和恢复(首先配置好计算机环境)
        1. 手机进入fastboot并用数据线连接计算机
        1. 运行'工具包'
        1. 选择第二页的'备份/还原系统',点击备份系统/还原系统,等待完成即可备份或还原系统。备份的文件存储于手机'/sdcard/A0001_Backup'
* 机况(后置摄像头左侧标有机器号)
    * 1号机
        * 外观:黑色
        * 功能:全部正常
    * 2号机
        * 外观:白色
        * 功能:全部正常
    * 3号机
        * 外观:白色,电源键下方后盖有个月型缺口
        * 功能:屏幕在使用相机时右侧会闪屏,话筒损坏
* 刷系统
    * 刷入`ubuntu touch`系统((如果手机中已经是此系统,需要重新安装以恢复初始状态,可以直接到`使用ubports安装`步骤) 
        1. 线刷`出厂包`
        1. 卡刷底包`cm13`
            1. 卡刷前置包`cm_base.zip`
            1. 卡刷主体包`cm13.zip`
            1. 卡刷基带包`bacon_firmware.zip`
        1. 使用ubports安装
            1. 断开Windows的网络连接 
            1. 将ubports工具源下的ubports文件夹、ubports-installer文件夹复制到`C:\Users\当前用户名\AppData\Roaming\`文件夹下
            1. 运行ubports,选择机型,选择系统版本,勾选Wipe Userdata,勾选Bootstrap,按提示进行安装直到完成 
            1. 恢复Windows的网络连接 
    * 刷入`h2os2.0`
        1. 配置好"计算机环境"
        1. 线刷`h2os底包`,内测码:0528 0728 0528 0728
        1. 卡刷`h2os2.0.zip`
