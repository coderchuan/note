## fopen
* `fopen(string $filename,string $mode,bool $use_include_path = false,resource $context = ?): resource`
    * 功能:将filename所指定的资源绑定到流上。通常用来打开文件
    * filename:文件路径或URL
    * mode:打开模式,有以下模式可选
        * `r`:只读(打开时文件指针在文件始,如果文件不存在则报错) 
        * `w`:只写(打开时文件指针在文件始,如果文件不存在则创建,打开文件时将文件内容清空) 
        * `a`:只追(打开时文件指针在文件尾,如果文件不存在则创建) 
        * `c`:只覆写(打开时文件指针在文件始,如果文件不存在则创建) 
        * `x`:新建只写(打开时文件指针在文件始,如果文件不存在则创建,如果文件已存在则报错) 
        * `+`:读取与覆写(此模式只能与其他模式配合使用,如"r+","w+","a+","c+","x+")  
    * use_include_path:是否在include目录中查找文件,默认为false 
    * context:上下文。默认不使用上下文
