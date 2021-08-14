## PDO数据库连接类 
* public PDO __construct(string $dsn,string $username,string $passwd,array $options=array()) 
    * 功能:构造函数
    * 返回值:PDO对象实例
    * $dsn:数据库连接信息,
        * mysql或mariadb,形式："SQLDriverName:host=HOST;dbname=DBName;port=PORT"
            * SQLDriverName:mysql
            * HOST:主机IP或域名
            * DBName:数据库名称。可不指定数据库
            * PORT:端口。如果配置的默认端口3306,此参数可以省略
        * sqlite3,形式："SQLDriverName:file_path"
            * SQLDriverName:sqlite
            * file_path:db文件路径。建议使用绝对路径
    * $username：数据库用户名。sqlite无密码可使用空字符串
    * $passwd：数据库密码。。sqlite无密码可使用空字符串
    * $options：连接配置,有以下参数可以配置,使用array(OPTIONS=>bool,....)的形式配置,其中OPTIONS可取以下值
        * PDO::ATTR_PERSISTENT：true|false,持久连接|非持久连接
        * PDO::ATTR_EMULATE_PREPARES：true|false,本地对SQL语句进行预处理|sql服务器端对SQL语句进行预处理
* public int exec(string $statement)
    * 功能：执行SQL语句(执行前不对语句进行安全检查)
    * 返回值：受影响的行数
* public PDOStatement query(string $statement)
    * 功能：执行SQL查询语句,返回查询结果(执行前不对语句进行安全检查)
    * 返回值：语句对象PDOStatement(包含查询结果),查询结果是私有的,只有通过PDOStatement对象的方法fetchAll或fetch才能获取。亦可使用for循环遍历每一行数据(一维数组)
    * $statement：SQL语句
* publicstring quote(string $string,int $parameter_type=PDO::PARAM_STR)
    * 功能:对输入的字符串进行安全检查,并返回安全的且两边带单引号的字符串
    * 返回值:转换后的字符串
    * $parameter_type:数据库驱动类型,一般无须设置
* publicPDOStatement prepare(string $statement,array $driver_options=array())
    * 功能:生成安全的SQL语句对象PDOStatement
    * 返回值:语句对象PDOStatement(不含查询结果),想要包含查询结果,则可以使用返回的对象调用成员方法execute(),即可得到包含查询结果的PDOStatement对象
    * $statement:SQL语句
    * $driver_options:为PDOStatement对象设置属性。一般无须设置
* publicbool beginTransaction(void)
    * 功能:启动事务,关闭自动提交。(关闭后通过PDO对象实例对数据库做出更改后直到调用PDO::commit()结束事务才被提交)
    * 返回值:关闭成功返回true,关闭失败返回false
* publicbool commit(void)
    * 功能:提交事务。开启自动提交
    * 返回值:提交成功返回true,提交失败返回false
* publicbool inTransaction(void) 
    * 功能:检查事务当前是否处于激活状态。此方法仅对支持事务的数据库驱动起作用
    * 返回值:如果处于激活状态则返回true,否则返回false
* publicbool rollBack(void)
    * 功能:回滚已经启动的事务.如果没有事务激活,则抛出一个异常
    * 返回值:回滚成功返回true,回滚失败返回false
* publicstring errorCode(void)
    * 功能:获取上一次数据库操作的通用SQLSTATE状态码
    * 返回值:通用SQLSTATE状态码(ANSI:SQL标准中定义的标识符) 
* publicarray errorInfo(void)
    * 功能:获取上一次数据库操作的错误信息
    * 返回值:数组。由三列组成
        * 0:通用SQLSTATE代码
        * 1:特定的数据库的错误代码
        * 2:错误消息
* publicmixed getAttribute(int $attribute)
    * 功能:获取数据库连接属性
    * 返回值:调用成功返回数据库连接属性,调用失败返回NULL
    * $attribute:可以取以下值
        * PDO::ATTR_AUTOCOMMIT
        * PDO::ATTR_CASE
        * PDO::ATTR_CLIENT_VERSION
        * PDO::ATTR_CONNECTION_STATUS
        * PDO::ATTR_DRIVER_NAME
        * PDO::ATTR_ERRMODE
        * PDO::ATTR_ORACLE_NULLS
        * PDO::ATTR_PERSISTENT
        * PDO::ATTR_PREFETCH
        * PDO::ATTR_SERVER_INFO
        * PDO::ATTR_SERVER_VERSION
        * PDO::ATTR_TIMEOUT
* publicbool setAttribute(int $attribute,mixed $value)
    * 功能:设置连接属性
    * 返回值:设置成功返回true,设置失败返回false
    * $attribute:属性
    * $value:属性值。属性与属性值对应关系如下
        * PDO::ATTR_CASE:指定大小写
            * PDO::CASE_LOWER:强制列名为小写
            * PDO::CASE_UPPER:强制列名为大写
            * PDO::CASE_NATURAL:保留数据库返回的列名
        * PDO::ATTR_ERRMODE:错误报告模式
            * PDO::ERRMODE_SILENT:错误代码
            * PDO::ERRMODE_WARNING:警告消息
            * PDO::ERRMODE_EXCEPTION:抛出异常
        * PDO::ATTR_ORACLE_NULLS:转换NULL和空字符串
            * PDO::NULL_NATURAL:不转换
            * PDO::NULL_EMPTY_STRING:将空字符串转换成NULL
            * PDO::NULL_TO_STRING:将NULL转换成空字符串
        * PDO::ATTR_STRINGIFY_FETCHES:是否把数值转换为字符串
            * false:不转换
            * true:转换
        * PDO::ATTR_STATEMENT_CLASS:设置从PDOStatement派生类提供的语句类(不能用于持久连接)
            * array(string:$className,array(mixed $parames,...)) $className表示类名,$parames表示PDOStatement派生类的构造函数的参数列表
        * PDO::ATTR_TIMEOUT:超时时间(单位:秒)
            * int:秒数
        * PDO::MYSQL_ATTR_USE_BUFFERED_QUERY:是否使用缓冲查询。仅用于mysql和mariadb
            * true:使用
            * false:不使用 
        * PDO::ATTR_DEFAULT_FETCH_MODE:默认的返回模式
            * PDO::FETCH_ASSOC:列名键数组
            * PDO::FETCH_NUM:数值键数组
            * PDO::FETCH_BOTH:数值键和列名键同时存在的数组(默认) 
            * PDO::FETCH_OBJ:列名对应值的匿名对象 
            * PDO::FETCH_BOUND:返回true,且将值传递给bindColumn中绑定的变量
            * PDO::FETCH_CLASS
            * PDO::FETCH_INTO
            * PDO::FETCH_LAZY
* publicstatic array getAvailableDrivers(void) 
    * 功能:查询受支持的数据库数组
    * 返回值:受支持的数据库数组
* publicstring lastInsertId(string $name=NULL) 
    * 功能:查询最后插入行的ID或序列值
    * 返回值:返回最后插入行的ID或序列值。不输入$name参数时,返回列名为id的最后插入行值或者自增字段的最后插入行值
    * $name:列名

## PDOStatement(SQL语句与结果集类)
* publicbool bindParam(mixed $parameter,mixed &$variable,int $data_type=PDO::PARAM_STR,int $length=0,mixed $driver_options=array())
    * 功能:绑定变量到SQL语句中,可以防止注入攻击
    * 返回值:绑定成功返回true,绑定失败返回false
    * $parameter:使用?代替变量时,此时$parameter应该是?的序列号(从1开始);使用:name代替变量时,此时$parameter应该是:name
    * $variable:要绑定到SQL语句中的变量
    * $data_type:绑定的数据类型,可以参照bindColumn的$type列出的数据类型
    * $length:数据长度。一般无须设置
    * $driver_options:数据库驱动参数。一般无须设置
* publicbool bindValue(mixed $parameter,mixed $value,int $data_type = PDO::PARAM_STR)
    * 功能:绑定值到SQL语句中,可以防止注入攻击
    * 返回值:绑定成功返回true,绑定失败返回false
    * $parameter:使用?代替变量时,此时$parameter应该是?的序列号(从1开始);使用:name代替变量时,此时$parameter应该是:name
    * $value:要绑定到SQL语句中的值
    * $data_type:绑定的数据类型,可以参照bindColumn的$type列出的数据类型
* publicbool bindColumn(mixed $column,mixed &$param,int $type=PDO::PARAM_STR,int $maxlen=0,mixed $driverdata=array())
    * 功能:把查询结果绑定到PHP变量中
        * 在prepaer之后且在execute之前绑定列到PHP变量,执行execute和fetch后结果对应一行数据到PHP变量中(由于只能对应一行数据到PHP变量中,因此fetchAll的结果只能对应最后一行数据)。
    * 返回值:绑定成功返回true,绑定失败返回false
    * $column:查询语句中的列序号(从1开始)或列名
    * $param:要绑定的php变量
    * $type:要绑定的列的数据类型,可以取以下值
        * PDO::PARAM_BOOL:布尔 
        * PDO::PARAM_INT:整型 
        * PDO::PARAM_STR:字符串型(默认) 
        * PDO::PARAM_NULL:空值 
        * PDO::PARAM_STR_NATL:地区字符集
        * PDO::PARAM_STR_CHAR:常规字符集
        * PDO::PARAM_LOB:大对象数据类型
        * PDO::PARAM_STMT:记录集类型
        * PDO::PARAM_INPUT_OUTPUT:存储过程的INOUT参数 
    * $maxlen:数据的最大长度。一般无须设置
    * $driverdata:数据库驱动参数。一般无须设置
* publicbool execute(array $input_parameters=array())
    * 功能:执行对象中的SQL语句
    * 返回值:执行成功返回true,执行失败返回false
    * $input_parameters:绑定参数,绑定的值都被视为字符串。使用此参数可以省略bindParam或bindValue,绑定形式如:$key=>值,语句中使用?代替变量时,此时$key应该是?的序列号(从1开始);使用:name代替变量时,此时$key应该是:name。例:array(":id"=>1425,"2"=>"yang")
* publicmixed fetch(int $fetch_style=PDO::FETCH_BOTH,int $cursor_orientation=PDO::FETCH_ORI_NEXT,int $cursor_offset=0)
    * 功能:获取结果集中的下一行数据
    * 返回值:以数组形式返回一行数据
    * $fetch_style:返回形式,有以下形式
        * PDO::FETCH_ASSOC:列名键数组
        * PDO::FETCH_NUM:数值键数组
        * PDO::FETCH_BOTH:数值键和列名键同时存在的数组(默认) 
        * PDO::FETCH_OBJ:列名对应值的匿名对象    
        * PDO::FETCH_BOUND:返回true,且将值传递给bindColumn中绑定的变量 
        * PDO::FETCH_CLASS
        * PDO::FETCH_INTO
        * PDO::FETCH_LAZY
    * $cursor_orientation:可滚动游标,该值决定了哪一行将被返回,有以下值
        * PDO::FETCH_ORI_NEXT:在结果集中获取下一行  
        * PDO::FETCH_ORI_PRIOR:在结果集中获取上一行
        * PDO::FETCH_ORI_FIRST:在结果集中获取第一行
        * PDO::FETCH_ORI_LAST:在结果集中获取最后一行
        * PDO::FETCH_ORI_ABS:根据行号从结果集中获取需要的行  
        * PDO::FETCH_ORI_REL:根据当前游标位置的相对位置从结果集中获取需要的行
    * $cursor_offset:当$cursor_orientation的值为PDO::FETCH_ORI_ABS或PDO::FETCH_ORI_REL,此参数表示行值
* publicarray fetchAll(int $fetch_style=PDO::FETCH_BOTH,mixed $fetch_argument=PDO::FETCH_COLUMN,$ctor_args=array())
    * 功能:获取结果集中的所有行数据
    * 返回值:以数组形式返回所有行数据
    * $fetch_style:返回形式,有以下形式
        * PDO::FETCH_COLUMN:只抓取指定的列,参数由$fetch_argument指定,列数以0开始排序
        * PDO::FETCH_GROUP|PDO::FETCH_COLUMN:以指定的列为键值返回,参数由$fetch_argument指定,列数以0开始排序
        * PDO::FETCH_CLASS:返回指定类的实例,映射每行的列到类中对应的属性名。实例类名由$fetch_argument指定,构造函数的参数由$ctor_args指定
        * PDO::FETCH_FUNC:将每行的列作为参数传递给指定的函数,并返回调用函数后的结果。函数名由$fetch_argument指定 
        * PDO::FETCH_ASSOC:列名键数组
        * PDO::FETCH_NUM:数值键数组
        * PDO::FETCH_BOTH:数值键和列名键同时存在的数组(默认) 
        * PDO::FETCH_OBJ:列名对应值的匿名对象    
        * PDO::FETCH_BOUND:返回true,且将值传递给bindColumn中绑定的变量 
        * PDO::FETCH_INTO
        * PDO::FETCH_LAZY
    * $fetch_argument:当$fetch_style的值为PDO::FETCH_COLUMN或PDO::FETCH_GROUP|PDO::FETCH_COLUMN或PDO::FETCH_CLASS或PDO::FETCH_FUNC时,有不同的含义
    * $ctor_args:当$fetch_style的值为PDO::FETCH_CLASS时,构造函数的参数由$ctor_args指定
* publicstring fetchColumn(int $column_number=0)
    * 功能:从结果集中的下一行获取指定的列
    * 返回值:返回获取的数据
    * $column_number:列的序号,列数以0开始排序
* publicmixed fetchObject(string $class_name="stdClass",array $ctor_args=array())
    * 功能:获取下一行并作为一个对象返回
    * 返回值:获取数据成功时返回类实例,失败时返回false
    * $class_name:类名称
    * $ctor_args:类构造函数的参数
* publicarray getColumnMeta(int $column)
    * 功能:获取结果集中一列的元数据
    * 返回值:以数组形式返回结果集中一列的元数据
    * $column:列的序号,列数以0开始排序
* publicint columnCount(void)
    * 功能:获取结果集中的列数
    * 返回值:返回结果集中的列数
* publicint rowCount(void )
    * 功能:获取结果集的行数
    * 返回值:返回结果集的行数
* publicvoid debugDumpParams(void)
    * 功能:打印语句执行的过程及调试信息
    * 返回值:无返回值
* publicstring errorCode(void)
    * 功能:获取上一次数据库操作的通用SQLSTATE状态码
    * 返回值:通用SQLSTATE状态码(ANSI:SQL标准中定义的标识符) 
* publicarray errorInfo(void)
    * 功能:获取上一次数据库操作的错误信息
    * 返回值:数组。由三列组成
        * 0:通用SQLSTATE代码
        * 1:特定的数据库的错误代码
        * 2:错误消息
* publicbool setFetchMode(int $fetch_style,string $fetch_argument,array $ctor_args) 
    * 功能:设置默认的获取数据的模式
    * 返回值:设置成功返回true,设置失败返回false
    * $fetch_style:详见PDO::fetchAll()的同名参数
    * $fetch_argument:详见PDO::fetchAll()的同名参数
    * $ctor_args:详见PDO::fetchAll()的同名参数
* publicmixed getAttribute(int $attribute)
    * 功能:获取数据库连接属性
    * 返回值:调用成功返回数据库连接属性,调用失败返回NULL
    * $attribute:可以取的值详见PDO::getAttribute
* publicbool setAttribute(int $attribute,mixed $value)
    * 功能:设置连接属性
    * 返回值:设置成功返回true,设置失败返回false
    * $attribute:属性
    * $value:属性值。属性与属性值对应关系详见PDO::getAttribute
* publicbool nextRowset(void)
    * 功能:在一个多行集语句句柄中推进到下一个行集
    * 返回值:成功时返回true,或者在失败时返回false
* publicbool closeCursor(void)
    * 功能:关闭游标,使语句能再次被执行
    * 返回值:关闭成功返回true,关闭失败返回false
