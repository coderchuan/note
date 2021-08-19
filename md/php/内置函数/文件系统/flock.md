## 文件锁
* `flock(resource $handle, int $operation, int &$wouldblock = null): bool`
    * 功能：锁定文件
    * `handle`:文件句柄,可用fopen()函数获得
    * `operation`:锁类型
        * `LOCK_SH`:共享锁,如果文件被独占锁占用,则阻塞直到独占锁被释放(默认)或返回False。取决于`LOCK_NB`是否被指定
        * `LOCK_EX`:独占锁,如果文件被其他独占锁或共享锁锁定,则阻塞直到其他锁被释放(默认)或返回False。取决于`LOCK_NB`是否被指定
        * `LOCK_NB`:非阻塞锁(windows不支持),可与共享锁、独占锁进行或运算以叠加特性 
        * `LOCK_UN`:释放锁
    * `wouldblock`:引用参数,用于返回值
        * `1`:未获取到锁是因为其他锁的占用而被阻塞  
        * `null`或其他值:其他原因导致未获取到锁     
    * 返回值
        * `true`:锁定成功或释放成功
        * `false`:锁定失败或释放失败