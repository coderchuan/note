## 命名规范
* 类
    1. 类名与文件名完全一致
    1. 使用大驼峰命名
    1. 控制器类名必须使用`Controller`后缀
* 动作方法
    1. 方法为`public`权限 
    1. 方法名以`action`为前缀的小驼峰命名
* 命名空间：要求遵循php命名空间规则且命名空间与当前文件目录保存一致
* 使用其他类(类没有定义命名空间时可以直接使用类名)
    * 引用类：`use 命名空间\类名`
    * 使用其他类时直接使用`命名空间\类名`,详见[引入命名空间](index.html?title=/md/php/命名空间)

## 名称空间与路径相对应
* 控制器
    * 控制台应用:`@app/commands`
    * 网页应用:`@app/controllers`
* 模型：`@app/models`
* 视图：`@app/views`

## 映射规则
* 视图名映射规则 
    * 控制器的默认视图文件在`@app/views/ControllerID`目录下，其中ControllerID对应控制器ID
    * 对于小部件渲染的视图文件默认放在`WidgetPath/views`目录，其中`WidgetPath`代表小部件类文件所在的目录
    * 省略扩展名。默认使用`.php`作为扩展名
    * 以双斜杠`//ViewName`作为视图名前缀，对应的视图文件路径为`@app/views/ViewName`。例如`//site/about`对应到`@app/views/site/about.php`
    * 视图名以单斜杠`/ViewName`开始，对应的视图文件为当前模块下的视图文件夹。例如，如果当前模块为`user`，`/user/create`对应成`@app/modules/user/views/user/create.php`
    * 不使用`//`和`/`作为视图名前缀，使用控制器默认视图目录中的视图文件
* 路由映射规则
    * 定位规则：使用`[模块id/]控制器id/动作id`形式进行定位。其中`模块id`仅使用modules时才需在路由中指明
        1. 模块id
            * id组成：目录`@app/modules`下的目录名作为`模块id`，此目录中存放模块中的文件
            * 定位规则：直接定位到指定模块，即`@app/modules/模块id`目录 
            * 示例
                * 模块id:`user`对应模块:`user`，即`@app/modules/user`目录 
        1. 控制器id，用于定位控制器
            * id组成：仅包含英文大小写字母、数字、下划线、短横线和正斜杠
                * 英文大写字母：只出现在子目录名中
                * 英文小写字母、数字、下划线：只出现在子目录名和控制器类名中
                * 短横线(`-`)用于描述控制器类名，将以`大驼峰命名法`命名的控制器类名去除`Controller`后缀，剩下的部分改写为`短横线命名`，得出的字符串即可描述控制器类名。如`post-comment`描述`PostCommentController`控制器类名
                * 正斜杠(`/`)用于描述子目录名(子目录名不能包含短横线)，当一个控制器类在`控制器目录`下的子目录中时，可使用`/`来描述子目录。如`admin/post-comment`描述`控制器目录\admin`下的`PostCommentController`控制器类 
            * 定位规则
                * 如果有`/`，将最后一个`/`后的第一个字母转换为大写，然后把所有的`/`转换为`\`
                * 如果有`-`，把`-`分隔的每一个单词的首字母转换为大写，然后删除所有的`-`
                * 如果只有一个单词，则将该单词的首字母转换为大写
                * 增加`Controller`后缀
                * 增加`app\控制器目录\`作为前缀
                * 控制台应用的`控制器目录`为`commands`
                * 网页应用的`控制器目录`为`controllers`
            * 示例(设控制器目录为`controllers`)
                * 控制器id:`article`对应控制器类:`app\controllers\ArticleController`
                * 控制器id:`post-comment`对应控制器类`app\controllers\PostCommentController`
                * 控制器id:`admin/post-comment`对应控制器类`app\controllers\admin\PostCommentController`
                * 控制器id:`adminPanels/post-comment`对应控制器类`app\controllers\adminPanels\PostCommentController`
        1. 动作id，用于定位动作方法
            * 内联动作：在控制器中定义的名称前缀为`action`的公有方法
                * id组成：仅包含英文小写字母、数字、下划线和中横杠
                    * 英文小写字母、数字、下划线：出现在动作方法名中
                    * 短横线(`-`)用于描述动作方法名，将以`小驼峰命名法`命名的动作方法名去除`action`前缀，剩下的部分改写为`短横线命名`，得出的字符串即可描述动作方法名。如`hello-world`描述`actionHelloWorld`方法名
                * 定位规则
                    * 如果有`-`，把`-`分隔的每一个单词的首字母转换为大写，然后删除所有的`-`
                    * 如果只有一个单词，则将该单词的首字母转换为大写
                    * 增加`action`前缀
                * 示例
                    * 动作id:`say-hello`对应动作方法`actionSayHello`
            * 独立动作：通过继承`yii\base\Action`或它的子类来定义动作类，通过定位规则运行`public function run()`方法
                * id组成：任意字符
                * 定位规则
                    * 重载控制器中的`public function actions()`方法，该方法的返回值为数组，格式如下:
                        ```php
                        public function actions()
                        {
                            return [
                                //形式一。"action"=>"action类"
                                "动作id1"=>"app\commands\action\test",

                                //形式二。"action_id"=>"action类配置"
                                "动作id2"=>[
                                    //自定义action类。形式为"class"=>"action类"
                                    "class"=>"继承的yii\base\Action类名",    
                                    //初始化自定义action类的属性值。形式为"属性名"=>"属性值"
                                    "属性名1"=>"属性值1",      
                                ],    
                            ];
                        }
                        ``` 
                    * 被定位的类运行`public function run()`方法