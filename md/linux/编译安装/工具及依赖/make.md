## 安装
1. 在`http://ftp.gnu.org/gnu/make`选择合适的版本下载make源码,注意下载`tar.gz`格式 
1. `tar -xvfz MAKE_FILE`解压,其中`MAKE_FILE`就是下载好的make源码的压缩包
1. 进入解压好的文件夹
1. 执行`./configure --prefix=INSTALL_PATH`,`INSTALL_PATH`为安装路径 
1. 执行`./build.sh`
1. 执行`./make && ./make install` 