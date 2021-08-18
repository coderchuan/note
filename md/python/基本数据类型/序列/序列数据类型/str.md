## 字符串 
* 关键字:str 
* 类型:不可变序列
* 名称:字符串
* 字面值 
    * 双引号 
        * 示例:"字符串,'子字符串'"
    * 单引号
        * 示例:'字符串,"子字符串"'
    * 三引号
        * 示例
            * '''字符串,"子字符串1","子字符串2"'''
            * """字符串,'子字符串1','子字符串2'"""
* 转义字符
    * `\NEWLINE`
        * 含义:将上下现行的内容拼接下来,其中`NEWLINE`表示换行,即另起一行
        * 示例
            ```python
            a="a\
            b"
            print(a)
            #输出:ab
            ```
    * `\\`:表示`\`
    * `\'`:表示`'`
    * `\"`:表示`"`
    * `\a`:表示响铃符
    * `\b`:表示退格符
    * `\f`:表示换页符
    * `\n`:表示换行符
    * `\r`:表示回车符
    * `\t`:表示水平制表符
    * `\v`:表示垂直制表符
    * `\ooo`:表示八进制值所代表的字符,其中`ooo`表示八进制数字的字面值 
    * `\xhh`:表示十六进制所代表的字符,其中`xhh`表示十六进制数字的字面值 
    * `\N{name}`:表示`Unicode`字符,其中`name`表示unicode数据库中名为name的字符
    * `\uxxxx`:表示码位为`xxxx`的字符,其中`xxxx`表示十六进制数字的字面值(无0x前缀) 
    * `\Uxxxx`:表示码位为`xxxxxxxx`的字符,其中`xxxxxxxx`表示十六进制数字的字面值(无0x前缀) 
* 拼接:两个字符串仅由空格分隔时,会被拼接为一个字符串
* 构造字符串的方法
    * 赋值 
        * 无前缀的字符串或u前缀:使用unicode编码,如`"123"`,`u"123"`
        * r或R前缀:表示`\`不是转义字符,如`r"c:\windows"`
        * b或B前缀:表示字符串是bytes类型,如`b"zoot"`。每个字符占用一个字节
        * f或F前缀:表示字符串的格式化,详见格式化。
    * 格式化
        * 字符串前加f或F前缀,在字符串中使用`{NAME[F]}`来对字符串进行格式化
            * NAME:指格式化的字符串时使用到的变量名
            * F:指格式化的选项,F可取以下值 
                * 省略:不进行格式化
                * `!FUNC`,FUNC可取以下值
                    * `r`:表示调用`repr()`函数的返回值作为格式化后的内容
                    * `s`:表示调用`str()`函数的返回值作为格式化后的内容
                    * `a`:表示调用`ascii()`函数的返回值作为格式化后的内容
                * `:FORMAT`,FORMAT遵循以下语法
                    * 语法:`[[fill]align][sign][#][0][width][grouping_option][.precision][type]`
                    * 解释
                        * fill:填充字符,当要格式化的字符串的宽度不够时,使用此填充字符来填充。省略则使用空格填充
                        * align:填充字符的位置
                            * `>`:填充字符在符号的右侧。除数字外的默认值
                            * `<`:填充字符在符号的左侧。数字的默认值 
                            * `=`:填充字符在符号与要格式化的字符串之间
                            * `^`:填充字符在符号与要格式化的字符串两侧 
                        * sign:符号,在要格式化的字符串前添加的符号,可添加的符号有"+"、"-"、" "。默认使用空字符串作为符号
                        * `#`:添加此符号后当要转换的结果是二进制,八进制,十六进制时自动在数字前添加`0b`,`0o`,`0x`前缀
                        * `0`:当未设置align和fill时才可设置此选项,加入此项相当于设置fill为'0',设置align为'='。
                        * width:格式化后的字符串的最小宽度
                        * grouping_option:数字千分位分隔符
                            * "_"
                            * ","
                        * precision:精度,对于不同的type类型有不同的含义
                            * 'f'或'F'或'%':小数位数
                            * 'g'或'G':有效位数 
                            * 'e'或'E':有效位数,并且整数部分始终为一位
                            * 'o'或'b'或'd'或'x'或'X'或'n':不允许指定此选项
                            * 'c',则表示格式化后的字符串长度 
                        * type
                            * 'c':字符格式 
                            * 'o':八进制数字格式
                            * 'b':二进制数字格式
                            * 'd':十进制整数格式
                            * 'x':十六进制整数格式(9以上的编码使用小写字母)
                            * 'X':十六进制整数格式(9以上的编码使用大写字母)。在指定'#'的情况下,前缀'0x'也将被转为大写形式'0X'
                            * 'e':使用科学计数法格式化
                            * 'E':使用科学计数法格式化,科学计数法的'e'符号为大写 
                            * 'f':定点小数
                            * 'F':定点小数,但会将nan转为NAN,将inf转为INF  
                            * 'g':常规数字格式
                            * 'G':常规数字格式,但会将nan转为NAN,将inf转为INF  
                            * '%':将数字乘以100,定点小数,并且在末尾添加'%'
                            * 'n':十进制数字格式,并且会根据区域来自动使用数字千分位分隔符 
                            * 未指定:对于不同的被格式化的值类型,有不同的含义
                                * int:相当于指定了'd' 
                                * float:相当于指定了'g'
                                * decimal:相当于'g'或'G'
            * 输入"{"和"}"字符:在字符串中使用"{{"和"}}"即可输入"{"和"}"字符本身 
        * 在字符串中使用`"...%[NAME]F..."%MAP`的形式进行格式化
            * NAME:表示`(变量名)`的形式,即变量名使用小括号包裹。
                * 如果使用了变量名,即形式为`"...%(变量名)F..."%MAP`,则MAP表示字典,字典中的键必须与NAME相对应
                * 如果没有使用变量名,即形式为`"...%F..."%MAP`,则MAP表示变量或常量
            * F:指格式化的选项,同f或F前缀格式化方式的FUNC和FORMAT 
        * 使用`str.format()`函数进行格式化,在字符串中使用`{[INDEX_OR_NAME][F]}`形式的语法
            * `INDEX_OR_NAME`:绑定的变量索引,与`format()`参数列表的顺序相对应(第一个参数的索引为`0`),如果没有指定`INDEX`,则默认从0开始自动编号。如果使用的是名称而不是数字索引,则在format中应传入与名称对应的关键字参数 
            * `F`:同字符串前加f或F前缀的格式化规则
        * 使用`str.format_map(dict)`函数进行格式化,在字符串中使用`{NAME[F]}`形式的语法
            * `NAME`:`format_map(dict)`函数中的参数字典中使用与`NAME`相对应的键 
            * `F`:同字符串前加f或F前缀的格式化规则
        * 示例
            ```python 
            abc=float(123.456)
            precision=2
            sign="+"
            #格式一:f前缀嵌套格式化
            print(f"{abc:{sign}020.{precision}f}") 
            #格式二:f前缀非嵌套格式化
            print(f"{abc:+020.2f}") 
            #格式三:f前缀未使用格式化语法
            print(f"The numeric is {abc},it's sign is '{sign}'")
            #格式四:%形式的变量格式化
            print("%+020.2f"%abc) 
            #格式五:%形式的字典格式化
            print("%(abc)+020.2f"%{"abc":abc})
            #格式六:format()数字索引形式的格式化
            print("{0:{1}020.{2}f}".format(abc,sign,precision)) 
            #格式七:format()自动数字索引形式的格式化
            print("{:{}020.{}f}".format(abc,sign,precision)) 
            #格式八:format()关键字形式的格式化
            print("{abc:{sign}020.{precision}f}".format(abc=abc,precision=precision,sign=sign)) 
            #格式九:format_map()关键字形式的格式化
            print("{abc:{sign}020.{precision}f}".format_map({'abc':abc,'precision':precision,'sign':sign})) 
            ```
        * 注意:f或F前缀格式化语法中的各项参数亦可使用`{NAME[F]}`形式的格式化进行嵌套,详见f或F前缀格式化中的示例1 
    * `str(object='',encoding='utf-8',errors='strict')`
        * 含义:构造字符串
        * object:字符串,同`赋值`
        * encoding:字符串的编码。默认为`utf-8`
        * errors:错误处理方式。默认为`strict`
        * 返回:字符串
* 成员方法([unicode字体信息网](https://www.fileformat.info/info/unicode/category/index.htm))
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
    * `str.format(*args, **kwargs)`:同`format()`格式化
    * `str.format_map(mapping)`:同`format_map()`格式化
    * `str.index(sub[, start[, end]])`:在字符串的索引start和end间找到的sub子串的最小起始索引,未查找到将会抛出`ValueError`
    * `str.islower()`:如果字符串中有至少一个区分大小写的字符且其余区分大小写的字符均为小写则返回True
    * `str.isupper()`:如果字符串中有至少一个区分大小写的字符且其余区分大小写的字符均为大写则返回True
    * `str.isprintable()`:如果字符串的字符均为可打印字符或字符串为空则返回True
    * `str.istitle()`:判断单词首字母是否大写且其余字母均为小写,如果是则返回True
    * `str.isidentifier()`:如果字符串是有效的python标识符号则返回True
    * `str.join(iterable)`:使用str对可迭代对象iterable(元素必须为字符串或字符)进行拼接。字符串也属性可迭代对象
