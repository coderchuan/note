## 内存视图对象
* 关键字:memoryview
* 特性:创建对于`object`引用的对象,而无需进行拷贝
* 构建内存视图对象
    * `memoryview(object)`:其中object必须支持缓冲区协议,内置类型中支持此协议的类型有`bytes`和`bytearray`
* 序列的类型
    * 如果object是可变序列,则`memoryview`支持可变序列中的不改变对象长度的所有切片方法,如下:
        * `s[i] = x`:将序列s中的索引为i的元素值替换为x
        * `s[i:j] = t`:将序列s从索引i到j之间的元素值替换为可迭代对象t,t中的元素必须与索引i至j之间的元素数量相等
        * `s[i:j:k] = t`:将s序列中的索引为i到j之间且步长为k的元素值替换为可迭代对象t,和的元素个数必须与`s[i:j:k]`相同
    * 如果object是不可变序列,则`memoryview`不支持可变序列中的任何方法
* `hash`:如果object是不可变序列,则`memoryview`对象可以进行`hash`运算,相当于将object中的字符(节)串进行hash运算
* 方法(设obj为memoryview实例) 
    * `obj.__eq__(exporter)` 或 `==`判断:如果相等则返回True 
        * 如果memoryview对象a与b的`tolist()`方法返回的结果相等,则a与b相等
    * `obj.tobytes(order=None)`:返回转换为bytes字节串的结果。其中`order`可取以下值
        * 'C'或Nnone:按行读取。默认
        * 'A':按内存中的数据存储顺序方式读取
        * 'F':按列读取
    * `obj.hex([sep[, bytes_per_sep]])`:返回转换为十六进制的结果。同`bytes`的`hex()`方法
    * `obj.tolist()`:返回将`obj`转换为`list`形式的结果
    * `obj.toreadonly()`:返回`obj`的引用且只读实例
    * `obj.release()`:释放(解除引用)。执行此方法后任何对视图的进一步操作将引发`ValueError`(执行`release()`方法除外)
    * `obj.cast(format[, shape])`:返回将`obj`转化为新的形状的结果
        * format:新的形状中最后一个维度元素的数据类型,它可取以下值 
            * 'b'或'B':int类型的数据 
            * 'c':bytes数据类型 
        * shape:新数据类型的形状,有以下示例可作参考(假定数据的字节数为6字节)
            * `[6]`:数据长度6字节。总共1个维度,这个维度的元素个数为6
            * `[2,3]`:数据长度2*3=6字节。总共2个维度,维度一的元素个数为2,维度二的元素个数为3
            * `[2,3,1]`:数据长度2*3*1=6字节。总共3个维度,维度一的元素个数为2,维度二的元素个数为3,维度三的元素个数为1
* 属性
    * obj:引用的下层对象的实例
    * nbytes:字节长度
    * readonly:当前实例是否是只读
    * format:当前的形状中的最后一个维度元素的数据类型(详见`cast()`方法) 
    * shape:当前实例的形状(元组)。当ndim为0时返回空元组
    * itemsize:当前形状中的最后一个维度元素的字节大小 
    * ndim:维度(整数)
    * strides:每个维度中元素的字节大小,如`(2,3,1)`表示维度1中每个元素的字节大小为2,维度2中每个元素的字节大小为3,维度3中每个元素的字节大小为1。当ndim为0时返回空元组
    * suboffsets:仅供PIL数组内部使用
    * c_contiguous:内存是否为`C-contiguous`
    * f_contiguous:内存是否为`F-contiguous`
    * contiguous:内存是否为`contiguous`