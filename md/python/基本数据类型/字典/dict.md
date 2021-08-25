## dict
* 关键字:dict
* 名称:字典
* 可变性:可变
* 字面值:由键值对组成或空字典,如`{'jack': 4098, 'sjoerd': 4127,'other':'sjoerd'}`、`{}`
* 相等比较:字典中只以键和值作为比较,不排列顺序,如果两个字典的键值相等,即使它们的元素顺序不同也是相等的。只能使用`==`符号进行比较相等还是不相等,如果使用其他的比较符号`<,<=,>=>`则抛出`TypeError`
* 构造字典的方式
    * 使用字面值赋值
    * 使用字典推导式:如`{x: x ** 2 for x in range(10)}`
    * 使用构造函数  
        * `dict(**kwarg)`:使用0个或多个关键字参数,示例如下
            * `dict()`
            * `dict(a=1,b=2)`
        * `dict(mapping,**kwarg)`:使用现有的`字典`与`0个或多个关键字参数`,示例如下
            * `dict({"c":3},a=1,b=2)`
            * `dict({"c":3,"d":4})`
        * `dict(iterable,**kwarg)`:使用现有的可迭代的元素为长度为2的子序列的序列与`0个或多个关键字参数`,示例如下
            * `dict([("c",3),("d",4)],a=1,b=2)`
            * `dict([("c",3),("d",4)])`
* 方法(设obj为dict实例) 
    * 判断
        * `key in obj`:如果在obj中存在键`key`则返回True
        * `key not in obj`:如果obj中不存在键`key`则返回True
    * 获取字典信息
        * `list(obj)`:返回字典的键
        * `reversed(obj)`:返回字典的逆序键为元素的迭代器
        * `obj.keys()`:返回字典obj的键组成的`dict_keys`视图对象 
        * `obj.values()`:返回字典obj的值组成的`dict_values`视图对象 
        * `obj.items()`:返回字典obj的`dict_items`视图对象 
        * `len(obj)`:返回字典的键值对数量
        * `obj[key]`:返回字典的键为`key`的值
        * `iter(obj)`:返回字典的键为元素的迭代器
        * `obj.copy()`:返回字典的浅拷贝
        * `obj.get(key[, default])`:如果`obj`中存在键`key`则返回此键对应的值,如果不存在则返回default,如果未指定default则返回None 
        * `static dict.fromkeys(iterable[, value])`:使用`iterable`的键创建一个新字典,并将值全部设置为`value`(默认值为None) 
        * `obj | other`:将obj与other两个字典合并,如果它们有相同的键,则后者覆盖前者,返回合并后的字典
    * 修改
        * `obj[key]=value`:将字典的键为`key`的项赋值为`value` 
        * `del obj[key]`:将字典的键为`key`的项删除 
        * `obj.clear()`:移除字典中的所有元素
        * `obj.pop(key[, default])`:如果字典中存在key则将其删除并返回删除的元素,如果不存在且指定了default,则返回default。如果未指定default且key不存在于字典中,则抛出`KeyError`
        * `obj.popitem()`:从字典中移除并返回一个键值对。键值对的顺序由`LIFO`(后进先出)决定。如果字典为空,则抛出`KeyError`
        * `obj.setdefault(key[, default])`:如果字典中存在键为`key`的项则返回它的值,如果不存在则将defaul设置为字典的值,并返回default。default默认为None
        * `obj.update([other])`:将other字典中的键值对添加到obj中。如果obj中的键在other中存在,则使用other中的健值覆盖obj中的键对应的值。
        * `obj.update(*)`:先将关键字参数转换为一个字典,后续同`obj.update([other])` 
        * `obj |= other`:将obj与other两个字典合并,如果它们有相同的键,则后者覆盖前者。将合并后的字典赋值给obj 