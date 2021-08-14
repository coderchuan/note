# Composer

## 安装
* `Composer`依赖
    * ` php `
    * `php-zip` 
    * `php-curl`
    * `php-dom`
    * `php-mbstring`
* ubuntu
    * 第一步
        ```
        curl -sS https://getcomposer.org/installer | php 
        或 
        wget https://mirrors.cloud.tencent.com/composer/composer.phar 
        ```
    * 第二步，添加到环境变量，以下两种方式任选其一
        * `ubuntu、debian、centos`
            ```
            mv composer.phar /usr/local/bin/composer
            ```
        * 通用。添加到`/etc/profile`，详见[环境变量](index.html?title=/md/linux/终端配置)中环境变量相关内容
* windows
    * 下载并安装：`https://getcomposer.org/Composer-Setup.exe`

## 更换、还原源地址
* 查看源地址：`composer config -g -l` ,输出结果中的`repositories.packagist.org.url`项即为源地址。在linux中还可在命令后加` | grep url`以直接获取该项的值
* 更换
    * 语法
        ```
        composer config -g repo.packagist composer URL 
        ```
    * 解释 
        * URL：镜像地址，有以下地址可用：
            1. 推荐 `https://packagist.mirrors.sjtug.sjtu.edu.cn`
            1. `https://mirrors.huaweicloud.com/repository/php/`
            1. `https://mirrors.aliyun.com/composer/`
            1. `https://mirrors.cloud.tencent.com/composer/`
            1. `https://packagist.phpcomposer.com`
* 还原：`composer config -g --unset repos.packagist`

    




