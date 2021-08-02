## CMD 
* chm 转 html 
    * 语法：`hh -decompile TARGET_DIR CHM_FILE`
    * `TARGET_DIR`：转成html的存储文件夹
    * `CHM_FILE`：chm文件
    * 示例：`hh -decompile D:\desktop\jquery jquery_3.2.1.CHM`
* 删除文件夹
    * 用法：在`cmd`中执行`help rmdir`命令以获取详细用法
    * 示例：`rmdir /s /q DIR_PATH`，其中`DIR_PATH`为文件夹路径
* 删除文件
    * 用法：在`cmd`中执行`help del`命令以获取详细用法
    * 示例：`del /f /q FILE_PATH`，其中`FILE_PATH`为文件路径
* 查看系统版本：`winver`
* 为Windows命令行添加`sudo`切换管理员命令。在交互提示中输入`y`并等待安装完成即可
    ```
    PowerShell -Command "Set-ExecutionPolicy RemoteSigned -scope Process; iwr -useb https://raw.githubusercontent.com/gerardog/gsudo/master/installgsudo.ps1 | iex"
    ```
