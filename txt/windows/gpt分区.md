# GPT分区

## GUID
* 设置`GPT`磁盘分区的`分区类型GUID`
    1. 使用快捷键`Win+R`,运行`diskpart`命令
    1. 列出磁盘`list disk`
    1. 选择要设置`分区类型GUID`的分区所在的磁盘`select disk 磁盘序号`，如`select disk 0`
    1. 列出分区`list part`
    1. 选择要设置`分区类型GUID`的分区`select part 分区序号`，如`select part 2`
    1. 设置`分区类型GUID`，`set id=分区类型GUID值 override`，有以下值可取：
        * EFI 分区：`set id=C12A7328-F81F-11D2-BA4B-00A0C93EC93B override`
        * 恢复分区：`set id=DE94BBA4-06D1-4D40-A16A-BFD50179D6AC override`
        * 数据分区：`set id=EBD0A0A2-B9E5-4433-87C0-68B6B72699C7 override`
        * 保留分区：`set id=E3C9E316-0B5C-4DB8-817D-F92DF00215AE override`
