## list 
* 类型:可变序列 
* 名称:列表
* 构造 
    * `[]`:空list
    * `[a, b, c]`:含有三个元素的list
    * `[x for x in iterable]`:可迭代对象
    * `list()`或`list(iterable)`
* 成员方法 
    * `sort(*, key=None, reverse=False)` 
        * 含义:使用`<`来进行比较各项的大小 
        * key:关键字参数。对可迭代对象的元素值进行处理的函数,例如:key=str.lower。默认为None 
        * reverse:关键字参数。是否反序比较。默认为False 
        * 返回值:不返回值,对原迭代对象进行修改 