## 禁止Windows自动更新
1. 以管理员身份运行打开命令提示符
1. 执行命令 `sc.exe config wuauserv start= disabled & sc.exe stop wuauserv`

## 启动Windows自动更新 
1. 以管理员身份运行打开命令提示符 
1. 执行命令 `sc.exe config wuauserv start= auto`