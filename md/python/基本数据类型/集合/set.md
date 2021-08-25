## set 
* 关键字:set
* 名称:集合
* 可变性:可变
* 字面值:使用大括号包裹的元素列表,每个元素必须可hash且唯一,如`{1,2,3,"abc"}`
* 构造set的方式
    * 使用字面值赋值
    * 集合推导式赋值,如`{c for c in 'abracadabra' if c not in 'abc'}`
    * `set(object)`:`object`表示可迭代对象,如`'foobar'`、`['a', 'b', 'foo']`。若省略object则表示空集合
* 相等比较:集合中只内部元素作比较,如果两个集合中的元素都一一对应,即使它们的元素顺序不同也是相等的
* 方法(设obj为set实例) 
    * 集合长度
        * `len(obj)`:返回集合obj中的元素数量 
    * 拷贝
        * `obj.copy()`:返回原集合的浅拷贝
    * 判断
        * `x in obj`:如果x元素在obj集合则返回True 
        * `x not in obj`:如果x元素不在obj集合则返回True 
        * `obj.isdisjoint(otherobj)`:如果obj中与otherobj没有交集则返回True
        * `obj.issubset(otherobj)`或`obj<=otherobj`:如果obj被包含在otherobj中则返回True 
        * `obj<otherobj`:如果obj被包含在otherobj中且obj与otherobj不相等则返回True 
        * `obj.issuperset(otherobj)或obj>=otherobj`:如果otherobj被包含在obj中则返回True 
        * `obj>otherobj`:如果otherobj被包含在obj中且obj与otherobj不相等则返回True 
    * 集合运算 
        * `obj.union(*others)`或`obj | other1 | other2 ...`:返回obj与其他集合的并集 
        * `obj.intersection(*others)`或`obj & other1 & other2 ...`:返回obj与其他集合的交集 
        * `obj.difference(*others)`或`obj - other1 - other2 ...`:返回obj与其他集合的差集 
        * `obj.symmetric_difference(other)`或`obj ^ other`:返回obj与other的交集的补集 
    * 修改集合
        * `obj.update(*others)`或`set |= other | ...`:将obj修改为obj与others的并集
        * `obj.intersection_update(*others)`或`obj &= other1 & other2 ...`:将obj修改为obj与others的交集
        * `obj.difference_update(*others)`或`obj -= other | ...`:将obj修改为obj与others们并集的差集 
        * `obj.symmetric_difference_update(other)`或`obj ^= other`:将obj修改为obj与other的交集的补集 
        * `obj.add(ele)`:将元素ele添加到obj集合中
        * `obj.remove(ele)`:将ele从集合obj中删除。如果 elem 不存在于集合中则会引发 KeyError
        * `obj.discard(ele)`:如果ele存在于集合obj中则将ele从集合obj中删除 
        * `obj.pop()`:从集合obj中删除任意一个元素,并将删除的元素返回
        * `obj.clear()`:将集合obj中的所有元素清空
    