## range 
* 类型:不可变序列
* 名称:范围(整数)
* 构造 
    * `range(stop)`:stop表示范围的最后一个整数。整个表达式表示从0至stop的整数列表
    * `range(start,stop[,step])`:start表示范围的第一个整数,stop表示范围的最后一个整数,step表示步长,默认为1。整个表达式表示从start至stop且步长为step的整数列表
* 比较:可以使用`==`和`!=`来比较两个range的列表是否相等