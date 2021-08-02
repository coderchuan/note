## web控制器
* 类名：`\yii\web\Controller`
* 继承：`\yii\base\Controller`
* 调用:`http(s)://host[:port]/index.php?r=控制器id/动作id`
* 定义时须继承的类:`\yii\web\Controller`
* [官方文档](https://www.yiichina.com/doc/api/2.0/yii-web-controller)
* 重要特性
    * 布局与渲染
        * `public string renderAjax($view, $params = [])`
            * 功能：渲染视图,不使用布局,可推送变量,加载视图中注册的cs/js文件,适用于局部页面的渲染
            * 参数
                * view:视图。详见`\yii\base\Controller`的`render()`方法 
                * params:参数。关联数据，详见`\yii\base\Controller`的`render()`方法 
            * 返回值：string。渲染的html文本  
            * 注意：`加载视图中注册的cs/js文件`是与函数`renderPartial()`的唯一区别 
          