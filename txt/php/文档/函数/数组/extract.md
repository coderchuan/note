## extract
* `int extract ( array &$array , int $flags = EXTR_OVERWRITE , string $prefix = "" )`
    * 功能：将关联数组的每一个元素都转换为变量,变量名字就是键名(键名必须满足变量名命名规范) 
    * 参数
        * `array`:array,要转换为变量的关联数组
        * `flags`：:int,对于有冲突或非法的键名要采取的措施,有以下选项可以选择
            * EXTR_OVERWRITE,如果有冲突则覆盖。默认
            * EXTR_SKIP,如果冲突则不覆盖
            * EXTR_PREFIX_SAME,如果有冲突则把键名前加前缀后的字符串作为变量名
            * EXTR_PREFIX_ALL,给所有的变量名前加上前缀
            * EXTR_PREFIX_INVALID,仅在非法的键名前加上前缀作为变量名
            * EXTR_IF_EXISTS,仅覆盖已经存在的变量,不存在的变量则不处理
            * EXTR_PREFIX_IF_EXISTS,如果已经存在的变量与数组的键名有相同的则把键名前加前缀作为变量名,其余的元素不处理
            * EXTR_REFS,把变量作为数组元素的引用。此值可以与以上的其他值使用按位或结合  
        * `prefix`:string,当命名有冲突或非法的键名时使用此`前缀."_"`作为变量名的前缀   