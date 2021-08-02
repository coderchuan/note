# URL处理

## 路由
* 普通路由:调用控制器动作的字符串描述,一般为`[MODULE_ID/]CONTROLLER_ID/ACTION_ID`
* 默认路由:详见`应用程序配置`
* 全拦截路由:详见`应用程序配置`

## 创建URL
* `Yii::$app->urlManager->createUrl($params)`绝对路由
    * `params`:array
        * 第一个元素的键值为`0`:路由格式,`[MODULE_ID/]CONTROLLER_ID/ACTION_ID`
        * 第二个元素开始:键为get参数的名称或锚点`#`,值为get参数的值或锚点名称
    * `return`:按`urlManager`规则生成的不包含`host:port`信息的URL 
* `Yii::$app->urlManager->createAbsoluteUrl($params, $scheme = null)`绝对路由
    * `params`:同`Yii::$app->urlManager->createUrl($params)`
    * `scheme`:协议,默认为当前请求的协议。常用的协议为`http(s)`
    * `return`:按`urlManager`规则生成的包含`host:port``信息的URL 
* `\yii\helpers\Url::to($params)`相对路由
    * `params`:array
        * 第一个元素的键值为`0`:路由格式 
            * 空字符串:返回当前请求的路由
            * 不存在`/`:当前控制器的路由
            * 不以`/`开头:`当前模块ID/`附加到路由之前。若在`应用程序`中而不是模块中,则`/`附加到路由之前
            * 以`/`开头:绝对路由 
        * 第二个元素开始:键为get参数的名称或锚点`#`,值为get参数的值或锚点名称
    * `return`:按`urlManager`规则生成的不包含`host:port`信息的URL 
* `\yii\helpers\Url::toRoute($params)`相对路由
    * `params`:同`\yii\helpers\Url::to($params)`
    * `scheme`:协议
        * string:返回含有协议的完整的URL
        * false:返回按`urlManager`规则生成的不包含`host:port`信息的URL

## URL美化
* PATH_INFO:`http(s)://www.example.com/index.php/home/index/index/a/1/b?a=7`,其中`/home/index/index/a/1/b`表示PATH_INFO 
* 配置
    * 在`应用程序配置`中的`urlManager`项中进行如下配置
        * `suffix`:url后缀。默认为空字符串
        * `normalizer`:url规范化
            * false:关闭url规范化。默认
            * array:数组,配置如下
                * `class`:必须,建议使用`yii\web\UrlNormalizer`
                * `collapseSlashes`:是否(true|false)合并多个连续的`/`为单个`/`,默认为true 
                * `normalizeTrailingSlash`:是否(true|false)去除尾部的`/`,默认为true 
                * `action`:跳转到规范化后的URL时使用的方式 
                    * `\yii\web\UrlNormalizer::ACTION_REDIRECT_TEMPORARY`:临时重定向
                    * `\yii\web\UrlNormalizer::ACTION_REDIRECT_PERMANENT`:永久重定向。默认 
                    * `\yii\web\UrlNormalizer::ACTION_NOT_FOUND`:404 
        * `enablePrettyUrl`:是否开启URL美化,取值如下,其中`ENTRANCE_URL`表示入口URL,`CONTROLLER_ID`表示控制器ID,`ACTION_ID`表示动作ID,`URL_QUERY_STR`表示URL查询参数 
            * `false`:路由形式为`ENTRANCE_URL?r=CONTROLLER_ID/ACTION_ID&URL_QUERY_STR`
            * `true`:路由形式为`ENTRANCE_URL/CONTROLLER_ID/ACTION_ID?URL_QUERY_STR`
        * `showScriptName`:是否显示脚本名称(仅当`enablePrettyUrl`为`true`时有效) 
            * `false`:入口URL形式为`http(s)://HOST:PORT`
            * `true`:入口URL形式为`http(s)://HOST:PORT/index.php`
        * `enableStrictParsing`:是否启用严格解析模式(仅当`enablePrettyUrl`为`true`时有效) 
            * `true`:必须与`rules`规则中至少一条规则完全相匹配,否则抛出`yii\web\NotFoundHttpException`异常 
            * `false`:如果没有与任何一条`rules`规则相匹配,则将`PATH_INFO`作为请求路由
        * `rules`:array。美化规则(仅当`enablePrettyUrl`为`true`时有效),每个元素有以下形式:
            * 数组形式,有以下键值规则
                * 配置项
                    * pattern:`METDOD PATTERN_STRING`
                        * METDOD:请求方法,可选`PUT,POST,GET,DELETE`,多个方法可使用`,`分隔
                        * PATTERN_STRING,匹配规则,把URL除去QUERY_STRING后把需要进行URL美化的连续字符串部分以`/`或`//`分隔,每段字符串可以使用以下方式描述 
                            * text文本:即与URL中的`/`位置之间完全相同的文本  
                            * `<KEY:PATTERN>`:`KEY`表示匹配到的正则内容的名称,可在`route`中使用;`PATTERN`表示正则表达式 
                            * `<KEY>`:`KEY`表示当前`/`位置之间的非`/`字符连续文本内容,可在`route`中使用或作为`get`参数的键名 
                    * route:string。路由。pattern对应的路由,把路由以`/`分隔,每段字符串可以使用以下方式描述 
                        * text文本:即路由的实际文本
                        * `<KEY>`:`KEY`表示在`pattern`中匹配到的内容
                    * defaults:array。可选项。URL的GET参数的默认值,健表示`get`参数名,`value`表示`get`参数值
                    * suffix:string。可选项。URL的后缀,例如可取`.json`或`.html`
                    * class:string。必选项。默认为`yii\web\UrlRule`
                * 示例
                    ```php 
                    [
                        "pattern"=>"<controller>/<action>/<name:[a-zA-Z]>",  
                        "route"=>"<controller>/<action>",   
                        "defaults"=>["name"=>"yang","age"=>26] 
                    ]
                    ```
            * 键值对形式:`pattern=>route`,其中`pattern`同数组形式的`pattern`,`route`同数组形式的`route`
                * 示例
                    ```php
                    '<controller:(post|comment)>/create' => '<controller>/create',
                    '<controller:(post|comment)>/<id:\d+>/<action:(update|delete)>' => '<controller>/<action>',
                    '<controller:(post|comment)>/<id:\d+>' => '<controller>/view',
                    '<controller:(post|comment)>s' => '<controller>/index',
                    ```
            * 组合形式:当`pattern`和`user`都有相同的前缀的时候(例如在模块中),可使用此方式
                * 示例
                    ```php 
                    new \yii\web\GroupUrlRule([
                        'prefix' => 'admin',                    //相同的前缀,例如模块id
                        'rules' => [
                            'login' => 'user/login',            //pattern=>route,同数组形式的`pattern`和`route`
                            'logout' => 'user/logout',
                            'dashboard' => 'default/dashboard',
                        ],
                    ]),
                    ```
    * 示例
        ```php 
        'urlManager' => [
            'enablePrettyUrl' => true,      
            'showScriptName' => false,
            'enableStrictParsing' => false,
            'rules' => [
                // ...
            ],
        ],
        ```

## 模块自己管理URL规则
1. 模块实现`yii\base\BootstrapInterface`的`bootstrap($app)`方法 
    ```php 
    public function bootstrap($app)
    { 
        $app->getUrlManager()->addRules([
            //定义规则,同`urlManager`中的`rule`中的元素 
        ], false);
    }
    ```
1. 在`应用程序配置`的`bootstrap`属性中指定`class`为此模块  