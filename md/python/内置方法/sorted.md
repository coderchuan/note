## sorted
* `sorted(iterable, *, key=None, reverse=False)`
    * 含义:使用`<`来进行比较各项的大小
    * iterable:要进行排序的可迭代对象
    * key:关键字参数。对可迭代对象的元素进行处理的函数,例如:key=str.lower。默认为None
    * reverse:关键字参数。是否反序比较。默认为False
    * 返回值:返回排序好的可迭代对象