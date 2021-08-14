## curl 
* 功能：文件下载、发送请求
* 语法
    ```
    curl [-{socks5|socks4} AGENT_HOST[:AGENT_PORT]] [-O|-o file] [-d PARAMS_STR] URL 
    ```
* 参数
    * 无参数：除网址外没有其他参数时,将网址中的内容直接显示在屏幕上 
    * -o：保存文件,文件名由file指定 
    * -O：保存文件到当前目录且文件名为网址中的文件名 
    * -s：不输出任何信息
    * -L：若有重定向,则跟踪之
    * -S：输出错误信息。通常和s一起使用用于只输出错误信息 
    * URL：网址 
    * file：文件路径及名称 
    * -d：使用POST方式提交请求 
    * AGENT_HOST：socks代理主机
    * AGENT_PORT：socks代理端口。默认值为1080
    * PARAMS_STR：数据类型string。POST参数，如"username=sg&password=123&content=test"
* 使用代理：在参数中添加`-socks5 HOST:PORT`，其中`HOST`表示代理地址，其中`PORT`表示代理端口。例：`curl -socks5 192.168.1.4:9009 http://www.baidu.com`
* 使用示例(URL表示文件地址) 
    ```
    curl -O URL                         保留原文件名,下载到当前目录
    curl -o NEW_FILE_NAME URL           重新命名并下载。其中NEW_FILE_NAME表示新的文件名 
    curl -o ./download.txt URL          下载文件并保存，URL为文件的在线地址
    curl URL                            直接输出URL中的内容，可模拟GET请求
    curl -d "a=1&b=2" URL               直接输出URL中的内容，可模拟POST请求
    curl -socks5 192.168.1.4:9009 -o /mnt/d/bai.html http://www.baidu.com   使用socks5代理下载文件
    ```