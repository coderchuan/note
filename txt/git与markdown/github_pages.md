## github pages
1. 新建名为`USERNAME.github.io`的公共仓库，创建时勾选`Initialize this repository with a README`，其中`USERNAME`为`github`用户名
1. 进入`USERNAME.github.io`的设置页面，找到`GitHub Pages`选项
    1. Source选项中选中master分支
    1. 点击`Choose a theme`
    1. 选择一个主题，在新页面打开`View on GitHub`，下载`_layouts/default.html`文件备用，下载完成后关闭此页面
    1. 回到选项主题的页面，点击右上角`Select theme`
1. 在个人电脑中克隆此仓库
    1. 配置用户名与邮箱
    1. 对`_config.yml`文件进行修改,在文件中修改以下配置(无则创建)
        ````
        markdown: GFM
        ````
    1. 在仓库根目录创建文件夹`_layouts`
    1. 把先前下载的`default.html`文件放入文件夹`_layouts`，并编辑`default.html`以自定义页面风格
    1. 添加并编辑`index.md`文本文件
    1. 提交此仓库到`github`
1. 访问`USERNAME.github.io`即可查看`index.md`内容
    * 按`USERNAME.github.io`命名的仓库，访问页面为`https://USERNAME.github.io`
    * 如果此处的仓库名不为`USERNAME.github.io`，则访问页面为`https://USERNAME.github.io/仓库名`
