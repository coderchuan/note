## wget
* 功能：文件下载、发送请求
* 语法
    ```
    wget [-P path|-O file] [--post-data PARAMS_STR] URL 
    ```
* 参数：
    * 无参数：除网址外没有其他参数时,直接保存文件到当前目录且保留源文件名 
    * -q：屏蔽`request header`信息
    * -O：保存文件,文件名由file指定 
    * -O-：直接输出而不保存到文件
    * -P：保存文件到path路径下,保留源文件名 
    * URL：网址 
    * path：文件路径 
    * file：文件路径及名称 
    * --post-data：使用POST方式提交请求。
    * PARAMS_STR：数据类型string。POST参数，如"username=sg&password=123&content=test"
* 使用示例(URL表示文件地址) 
    ``` 
    wget URL                            保留原文件名,下载到当前目录
    wget -O NEW_FILE_NAME URL           重新命名并下载。其中NEW_FILE_NAME表示新的文件名 
    wget -O- URL                        直接输出URL中的内容，可模拟GET请求
    wget -qO- URL                       直接输出URL中的内容(屏蔽header信息)，可模拟GET请求
    wget -O- --post-data "a=1&b=2" URL  直接输出URL中的内容，可模拟POST请求 
    wget -qO- --post-data "a=1&b=2" URL 直接输出URL中的内容(屏蔽header信息)，可模拟POST请求 
    ```