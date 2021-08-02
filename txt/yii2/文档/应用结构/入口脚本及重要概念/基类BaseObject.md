## 基类BaseObject
* 类名:`\yii\base\BaseObject`
* 定义时需要继承的类:`\yii\base\BaseObject`
* [官方文档](https://www.yiichina.com/doc/api/2.0/yii-base-baseobject) 
* 重要特性  
    * 初始化
        * 特点：在类被构造时自动调用
        * 形式：有两种，如下：
            ```php
            public void __construct($config = [])
            {
                //初始化语句
                //...
                //后调用父类的构造函数
                parent::__construct($config);
            }
            ```
            ```php
            public function init()
            {
                //先调用父类的初始化函数 
                parent::init();
                //初始化语句
                //...
            }
            ```
    * 魔术方法(参考php`魔术方法`) 
        * `__call()`
        * `__get()`
        * `__isset()`
        * `__set()`
        * `__unset()`
    * 类信息
        * `public static string className()`、`类名::class`
            * 功能：获取当前类名。
            * 参数：无
            * 返回值：返回类名(完全限定)
        * `public boolean hasMethod($name)`
            * 功能：判断是否存在指定的方法
            * 参数
                * name：要判断的方法名称
            * 返回值：bool
        * `public boolean canGetProperty($name, $checkVars = true)`
            * 功能：判断属性是否可以被读取
            * 参数：
                * name:属性名
                * checkVars:是否将成员变量视为属性。默认:true
            * 返回值:bool
        * `public boolean canSetProperty($name, $checkVars = true)`
            * 功能：判断属性是否可以被赋值
            * 参数：
                * name:属性名
                * checkVars:是否将成员变量视为属性。默认:true
            * 返回值:bool
        * `public boolean hasProperty($name, $checkVars = true)`
            * 功能：判断是否存在指定名称的属性
            * 参数
                * name:属性名
                * checkVars:是否将成员变量视为属性。默认:true
            * 返回值:bool
