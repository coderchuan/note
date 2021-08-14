## server配置
* 文件位置:`/etc/nginx/sites-enabled/自定义文件名.conf`目录下
* 包含生效  
    1. 打开`/etc/nginx/nginx.conf`
    1. 编辑/增加`http`项中的最后一行
        ```
        include /etc/nginx/sites-enabled/*.conf;
        ```
* 配置语法
    * php
        * 需要更改的配置项
            ```
            server_name
            root
            index
            listen
            fastcgi_pass
            ```
        * 配置内容
            ```conf 
            server {
                fastcgi_buffering       off;
                server_name             localhost;
                root                    /var/www/yii2_web/web;
                index                   index.php; 

                listen                  80;
                listen                  [::]:80;
                charset                 utf-8;
                client_max_body_size    128M;

                location ~ \.php/.*$|\.php$ {
                    #使用unix_sock文件
                    fastcgi_pass            unix:/tmp/php-fpm.sock;
                    #使用TCP/IP
                    #fastcgi_pass           localhost:9008 
                    fastcgi_split_path_info ^((?U).+\.php)(/.+)$;
                    include                 fastcgi_params;
                    fastcgi_param           SCRIPT_FILENAME         $document_root$fastcgi_script_name;
                    fastcgi_param           PATH_INFO               $fastcgi_path_info;
                    fastcgi_param           PATH_TRANSLATED         $document_root$fastcgi_path_info;
                }
                
                location / {
                    try_files $uri $uri/ = 404;
                }
            }
            ```