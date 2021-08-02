## strtotime
* `int strtotime(string $time,int $now=time())`
    * 功能：将使用英文描述的时间与日期转换为Unix时间戳
    * 返回值：返回Unix时间戳，否则返回false
    * 参数
        * $time：时间或日期的字符串 
            * 如果分隔符使用的(/),则会被这样解析m/d/y
            * 如果分隔符使用的(-或.),则会被这样解析d-m-y、Y-m-d或d.m.y
        * $now：参照时间戳。用于计算当$time为类似"+1 day"或"next day"这样的字符串时的参照时间，示例如下：
            ```php 
            date("Y-m-d",strtotime("first day of 2020-02-02"))          2020-02-01
            date("Y-m-d",strtotime("last day of 2020-02-02"))           2020-02-29
            date("Y-m-d",strtotime("2020-02-02 + 35 day"))              2020-03-08 
            date("Y-m-d",strtotime("2020-03-31 -1 month"))              2020-03-02 
            date("Y-m-d",strtotime("first day of 2020-03-31 -1 month")) 2020-02-01 
            date("Y-m-d",strtotime("last day of 2020-03-31 -1 month"))  2020-02-29 
            date("Y-m-d",strtotime("first day of"))                     当月第一天
            date("Y-m-d",strtotime("last day of"))                      当月最后一天
            ```