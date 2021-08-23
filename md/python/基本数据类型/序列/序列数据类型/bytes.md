## 字节串
* 关键字:bytes
* 类型:不可变序列 
* 名称:字节串
* 注意:bytes中的每个字节都表示一个8位二进制,码位值只能处理0-255之间。字面值只能为ascii字符,若码位值大于127则应使用转义表示
* 字面值
    * 双引号 
        * 示例:b"abc,'def'"
    * 单引号
        * 示例:b'abc,"def"'
    * 三引号
        * 示例
            * b'''abc,"def1","ghi2"'''
            * b"""abc,'def1','ghi2'"""
    * 使用小括号表示字面值:如`(b'...')`
* 转义字符
    * `\NEWLINE`
        * 含义:将上下现行的内容拼接起来,其中`NEWLINE`表示换行,即另起一行
        * 示例
            ```python
            a="a\
            b"
            print(a)
            #输出:ab
            ```
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
* 拼接:两个字符串仅由空格分隔时,会被拼接为一个字符串。如print("a" "b")的结果为ab
* 构造字节串的方法
    * 赋值
        * 无前缀的字符串或u前缀:使用unicode编码,如`"123"`,`u"123"`
        * b或B前缀:表示字符串是bytes类型,如`b"zoot"`。每个字符占用一个字节
        * `br`或`rb`前缀:不区分大小写,表示字符串是bytes类型且其中的符号不转义
    * 指定长度的以零值填充的`bytes`对象:`bytes(10)`
    * 通过由整数组成的可迭代对象:`bytes(range(20))`
    * 通过缓冲区协议复制现有的二进制数据1:`bytes(obj)`
    * 通过缓冲区协议复制现有的二进制数据2:`bytes(b'123')`
* 格式化
    * `b'...%[NAME]F...'%MAP`:同字符串中的`"...%[NAME]F..."%MAP`格式化。其中`MAP`的键为字节串,值为字节串或数字
* 方法(设obj为bytes实例) 
    * 十六进制转换
        * `static bytes.fromhex(string)`:从给定的十六进制符号或ASCII空白符号组成的字符串返回字节串(每两个十六进制符号转换为一个字节)。其中的空白符号将被忽略。
        * `obj.hex([sep[, bytes_per_sep]])`:返回字节串的十六进制符号(每一个字节转换为两个十六进制符号),返回的格式可以通过以下参数指定 
            * sep:指定分隔符。默认为空字符串
            * bytes_per_sep:每个分隔符分隔的字节数,默认为1字节
    * 查找
        * `obj.count(sub[, start[, end]])`:返回子字节串`sub`在索引start至end之间出现的次数。未指定end时默认在start至末尾查找;未指定start和end时默认在整个字节串中查找
        * `obj.find(sub[, start[, end]])`:返回字节串在索引start到end之间出现子字节串sub的最小索引
        * `obj.rfind(sub[, start[, end]])`:返回字节串在索引start到end之间出现子字节串sub的最大索引
        * `obj.index(sub[, start[, end]])`:返回字节串在索引start到end之间出现子字节串sub的最小索引。若未查找到则抛出`ValueError`
        * `obj.rindex(sub[, start[, end]])`:返回字节串在索引start到end之间出现子字节串sub的最大索引。若未查找到则抛出`ValueError`
    * 分割与拼接
        * `obj.join(iterable)`:返回使用当前的字节串拼接可迭代的对象`iterable`的拼接结果 
        * `obj.split(sep=None, maxsplit=-1)`:返回将当前字节串使用`sep`分割后的结果(list)。如果指定了`maxsplit`则只分割`maxsplit`次 
        * `obj.partition(sep)`:返回当前字节串从左至右被子字节串`sep`分割的第一个结果。结果是一个有三个元素的元组,第一个元素为`sep`分割的前一部分的字节串,第二个元组为`sep`,第三个元组为`sep`分割的后一部分的字节串。若在当前字节串中未找到子字节串`sep`则第一个元素和第三个元素为空字节串
        * `obj.rpartition(sep)`:返回当前字节串从右至左被子字节串`sep`分割的第一个结果。结果是一个有三个元素的元组,第一个元素为`sep`分割的前一部分的字节串,第二个元组为`sep`,第三个元组为`sep`分割的后一部分的字节串。若在当前字节串中未找到子字节串`sep`则第一个元素和第三个元素为空字节串
    * 替换
        * `obj.replace(old, new[, count])`:返回当前字节串中将`old`子字节串替换为`new`子字节串的新字节串,若指定了count则只替换count次
        * `obj.expandtabs(tabsize=8)`:返回将当前字节串中的每一个`\t`字节转换为`tabsize`个`b' '`的结果
    * 映射表
        * `static maketrans(from, to)`:返回二进制串`from`与二进制串`to`的映射表,`from`与`to`的长度必须相等
        * `obj.translate(table, /, delete=b'')`:返回将当前字节串映通过映射表转换为`to`对应关系的字节串。其中`delete`字节串中指定的每一个字节都会在被返回的字节串中删除 
    * 首尾处理
        * `obj.removeprefix(prefix, /)`:返回去除字节串`prefix`前缀的字节串
        * `obj.removesuffix(suffix, /)`:返回去除字节串`suffix`后缀的字节串
        * `obj.strip([chars])`:返回当前字节串将前后字节移除在`chars`中列出的每一个字节的结果 
        * `obj.lstrip([chars])`:返回当前字节串将前导字节移除在`chars`中列出的每一个字节的结果
        * `obj.rstrip([chars])`:返回当前字节串将结尾字节移除在`chars`中列出的每一个字节的结果
    * 转换为字符串
        * `obj.decode(encoding="utf-8", errors="strict")`:返回将字节串转换为字符串(指定编码)的转换结果
    * 判断
        * `obj.endswith(suffix[, start[, end]])`:如果字节串在索引start至end之间以`suffix`结尾则返回True
        * `obj.startswith(prefix[, start[, end]])`:如果字节串在索引start至end之间以`suffix`开头则返回True
        * `obj.isalnum()`:如果当前字节串中的所有字节都是英文字母或数字0-9所对应的字节则返回True
        * `obj.isalpha()`:如果当前字节串中的所有字节都是英文字母所对应的字节则返回True
        * `obj.isdigit()`:如果当前字节串中的所有字节都是数字0-9所对应的字节则返回True
        * `obj.isascii()`:如果当前字节串中的所有字节都是ascii字符所对应的字节则返回True
        * `obj.islower()`:如果当前字节串中没有大写英文字母对应的字节则返回True
        * `obj.isspace()`:如果当前字节串中的所有字节都是`b' \t\n\r\x0b\f'`列表中的一个字节,则返回True
        * `obj.istitle()`:如果当前字节串中的所有被ascii单词边界(任何不表示英文大小写字母的字节)分隔的单词首字节为大写字母对应的字节,则返回True
    * 对齐
        * `obj.center(width[, fillbyte])`
            * 若当前字节串的长度小于width,则返回被`fillbyte`这个字节填充后长度为`width`的字节串。原字节串居中
            * 若当前字节串的长度大于等于width,则返回原字节串
        * `obj.ljust(width[, fillbyte])`
            * 若当前字节串的长度小于width,则返回被`fillbyte`这个字节填充后长度为`width`的字节串。原字节串居左
            * 若当前字节串的长度大于等于width,则返回原字节串
        * `obj.rjust(width[, fillbyte])`
            * 若当前字节串的长度小于width,则返回被`fillbyte`这个字节填充后长度为`width`的字节串。原字节串居右
            * 若当前字节串的长度大于等于width,则返回原字节串
        * `obj.zfill(width)`
            * 若当前字节串的长度小于width,则返回被`b'0'`这个字节填充后长度为`width`的字节串。原字节串居右,若有正负号则位于字节串起始位置
            * 若当前字节串的长度大于等于width,则返回原字节串 
    * 大小写转换
        * `obj.capitalize()`:返回将当前字节串中的第一个字节(ascii中的英文字母)转换为大写字母且其余的ascii字母转换为小写的结果
        * `obj.upper()`:返回将当前字节串中的所有表示英文小写字母的字节转换为表示英文大写字母字节的结果