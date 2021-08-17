## str 
* 类型:不可变序列
* 名称:字符串
* 构造:同基本数据类型`str`
* 成员方法
    * `str.isascii()`:如果字符串中的所有字符均在以下列表中且长度大于0则返回True
        * 列表:Unicode码值为0-127的所有字符
    * `str.isalpha()`:如果字符串中的所有字符均在以下列表中且长度大于0则返回True
        * 列表:Unicode字符类别为"Lm","Lt","Lu","Ll","Lo"的字符
    * `str.isdecimal()`:如果字符串中的所有字符均在以下列表中且长度大于0则返回True
        * 列表:Unicode字符类别为"Nd"的字符
    * `str.isdigit()`:如果字符串中的所有字符均在以下列表中且长度大于0则返回True
        * 列表:Unicode字符类别为"Nd"的字符和"Nd"类别中被经过特殊处理的但是不属于"Nd"类别的字符,如角标字符 
    * `str.isnumeric()`:如果字符串中的所有字符均在以下列表中且长度大于0则返回True 
        * 列表:Unicode字符类别为"Nd","Nl","No"的字符 
    * `str.isalnum()`:如果字符串中的所有字符均在以下列表中且长度大于0则返回True
        * 列表:Unicode字符类别为"Lm","Lt","Lu","Ll","Lo","Nd","Nd"类别中被经过特殊处理的但是不属于"Nd"类别的字符,"Nl","No"
    * `str.isspace()`:如果字符串中的所有字符均在以下列表中且长度大于0则返回True。判断是否是空白字符
        *  列表:Unicode字符类别为"Zs"的字符。
    * `str.capitalize()`:返回首字母大写,其余字母小写的字符串
    * `str.casefold()`:返回消除歧义后的字母(类似于把所有大写转为小写,把不同形态的同一个字母转换为同一种字母,如会把'ß'转换为'ss')
    * `str.center(width[, fillchar])`:返回长度为width的且原字符居中的字符串,原字符两侧由fillchar所指定的字符填充。默认使用空格填充
    * `str.count(sub[, start[, end]])`:返回子串sub在字符索引start和end间的重复的次数
    * `str.encode(encoding="utf-8", errors="strict")`:将字符串转换为指定编码类型的bytes字符串
    * `str.endswith(suffix[, start[, end]])`:如果字符串在索引start到end的子串以suffix结尾则返回true
    * `str.expandtabs(tabsize=8)`:将字符串中的一个制表符号转换为指定数量的空格
    * `str.find(sub[, start[, end]])`:在字符串的索引start和end间找到的sub子串的最小起始索引
    * `str.format(*args, **kwargs)`:同基本数据类型`str`中的`format()`格式化
    * `str.format_map(mapping)`:同基本数据类型`str`中的`format_map()`格式化
    * `str.index(sub[, start[, end]])`:在字符串的索引start和end间找到的sub子串的最小起始索引,未查找到将会抛出`ValueError`
    * `str.islower()`:如果字符串中有至少一个区分大小写的字符且其余区分大小写的字符均为小写则返回True
    * `str.isupper()`:如果字符串中有至少一个区分大小写的字符且其余区分大小写的字符均为大写则返回True
    * `str.isprintable()`:如果字符串的字符均为可打印字符或字符串为空则返回True
    * `str.istitle()`:判断单词首字母是否大写且其余字母均为小写,如果是则返回True
    * `str.isidentifier()`:如果字符串是有效的python标识符号则返回True
    * `str.join(iterable)`:使用str对可迭代对象iterable(元素必须为字符串或字符)进行拼接。字符串也属性可迭代对象
