# git 

## 安装    
* ubuntu：`sudo apt install git`  
* debian：`sudo apt install git`  
* centos：`sudo yum install git` 
* windows：在`https://git-scm.com/download/win`下载合适的版本安装即可(64-bit Git for Windows Setup 选择 use mintty) 

## 创建仓库
* 语法：
    * 创建仓库 
        ```
        git init [--bare] [DIR_PATH] 
        ```
    * 更新仓库到最新状态。工作仓库作为可接受提交的仓库时，需要以下命令之一来更新当前仓库文件
        ```
        git checkout -f 
        git reset --hard 
        ```
    * 配置仓库为可提交仓库
        ```
        git config receive.denyCurrentBranch ignore
        ```
* 解释 
    * `--bare`：裸仓库选项，若省略此选项则创建工作仓库。
        * 工作仓库：可以看到仓库中的文件，一般用于新建项目仓库。工作仓库也可配置为可提交仓库，亦可作为服务器仓库，详见"配置仓库为可提交仓库"语法
        * 裸仓库：无法看到仓库中的文件，一般作为服务器仓库。创建裸仓库后还需要配置此仓库为可提交仓库，详见"配置仓库为可提交仓库"语法
    * `DIR_PATH`：要创建仓库的文件夹，若省略此参数则在当前目录下创建仓库
    
## 仓库克隆
* 语法
    * 克隆远程仓库所有分支
        ```
        git clone [--depth=N] URL [NEW_DIR]
        ```
    * 克隆远程仓库所有分支，但是只在本地创建指定分支
        ```
        git clone [--depth=N] -b BRANCH_NAME URL [NEW_DIR] 
        ```
    * 克隆远程仓库指定分支，并且只在本地创建指定分支
        ```
        git clone [--depth=N] --single-branch -b BRANCH_NAME URL [NEW_DIR]
        ```
* 解释
    * `--depth=N`：克隆深度，`N`为数字，表示深度，如`--depth=1`
    * `URL`：git仓库地址
    * `BRANCH_NAME`：远程仓库分支名
    * `NEW_DIR`：在当前目录创建的名为`NEW_DIR`的文件夹，并将仓库克隆在这个文件夹内。省略此参数则与远程仓库的名称相同
    * 注意：此命令不使用`--local`用户环境配置
* 示例
    * 克隆单个分支：`git clone --single-branch -b 分支名 仓库地址`
    * 克隆深度指定为1：`git clone --depth=1 仓库地址`

## 用户配置
* 配置用户属性参数 
    * 语法
        ```
        git config ENV [ATTRIBUTE_NAME ATTRIBUTE_VALUE | -e] 
        ```
    * 解释
        * `ENV`：用户环境配置，可取的值如下：
            1. 局部配置(当前仓库配置，优先级为1)：`--local`
            1. 全局配置(当前用户配置，优先级为2)：`--global`
            1. 系统配置(所有用户配置，优先级为3)：`--system`
        * `ATTRIBUTE_NAME`，属性名称，属性参数在`ATTRIBUTE_VALUE`中配置： 
            * `user.name`：必须。配置用户名，仅用于记录提交日志。`ATTRIBUTE_VALUE`的数据类型为：string 
            * `user.email`：必须。配置用户名，仅用于记录提交日志。`ATTRIBUTE_VALUE`的数据类型为：string 
            * `core.editor`：配置编辑器。`ATTRIBUTE_VALUE`的数据类型为：string。`ATTRIBUTE_VALUE`的值应为`"PATH -w"`形式，其中`PATH`表示编辑器路径。
            * `difftool.NAME.cmd`：配置差异编辑器名称，其中`NAME`表示自定义名称，数据类型为：text。`ATTRIBUTE_VALUE`的数据类型为：string。`ATTRIBUTE_VALUE`的值应为`"PATH --wait --diff \$LOCAL \$REMOTE"`形式，其中`PATH`表示编辑器路径，如果路径中有空格应使用单引号包裹，含有反斜杠应使用转义字符或使用正斜杠代替；`ATTRIBUTE_VALUE`中含有美元符号`$`应使用反斜杠转义(使用编辑器编辑时无需对比符号进行转义)。示例：`git config --local difftool.vscode.cmd "'C:/program/Microsoft VS Code/code.exe' --wait --diff \$LOCAL \$REMOTE"`。
            * `diff.tool`：配置默认生效差异编辑器。`ATTRIBUTE_VALUE`的数据类型为：text。`ATTRIBUTE_VALUE`的值应为已经配置好的配置差异编辑器名称之一。配置成功后应使用命令`git difftool FILE`以使用配置好的差异编辑器进行差异对比FILE的修改，而`git diff FILE`则仍旧使用命令行工具对FILE进行差异比对。
            * `credential.helper`：当使用密码登录时，密码保存策略。`ATTRIBUTE_VALUE`的数据类型为：string，可取以下值：
                * 空字符串：从不记住密码。示例：`git config --local credential.helper ""`
                * store：记住密码。示例：`git config --local credential.helper "store"`
                * manager：使用Windows系统凭据管理密码。示例：`git config --local credential.helper "manager"`
                * cache：使用Linux系统凭据管理密码。示例：`git config --local credential.helper "cache"`
        * `ATTRIBUTE_VALUE`，属性值，详见`ATTRIBUTE_NAME`中对属性值类型的要求
        * `-e`，打开文本编辑器进行手动编辑
* 显示用户属性参数
    * 语法
        ```        
        git config ENV SHOW_ATTR   
        ```
    * 解释
        * `ENV`：用户环境配置，详见"配置用户属性参数"中对`ENV`的介绍
        * `SHOW_ATTR`：显示指定的属性名称或全部的配置值，它可取以下值：
            * `--list`：显示所有的配置属性值
            * `ATTRIBUTE_NAME`：显示指定名称`ATTRIBUTE_NAME`的属性值，可使用的属性名称详见"配置用户属性参数"中对`ATTRIBUTE_NAME`的介绍 
* 删除用户属性参数
    * 语法
        ```        
        git config ENV --unset ATTRIBUTE_NAME
        ```
    * 解释
        * `ENV`：用户环境配置，详见"配置用户属性参数"中对`ENV`的介绍
        * `ATTRIBUTE_NAME`：删除指定名称`ATTRIBUTE_NAME`的属性值，可使用的属性名称详见"配置用户属性参数"中对`ATTRIBUTE_NAME`的介绍 
        * 注意：当删除的属性名称为"credential.helper"时，如果使用密码登录，则密码保存策略为下一个优先级的密码保存策略，以此递归。若最后一个优先级也没有配置`credential.helper`属性，则使用"不保存密码"的策略
* 使用编辑器编辑配置信息：`git config ENV -e`，`ENV`的含义详见"配置用户属性参数"中对`ENV`的介绍

## 文件存储区
* 工作区：git仓库所在的文件夹，工作区中的文件可以在文件系统中浏览。工作区中的文件分为四种：
    * git系统文件：`.git`、`.gitignore`
    * 未被追踪的文件：即没有添加到暂存区中的文件 
    * 已经追踪的文件：已经添加到暂存区的文件
    * 忽略的文件：由`.gitignore`文件列表决定
* 暂存区：使用`git add`保存的文件，工作区中的文件不能在文件系统中浏览
* 仓库：使用`git commit`保存的文件，暂存区的文件不能在文件系统中浏览
* 远程仓库：使用`git push`提交本地仓库中的文件到远程仓库 

## 工作区操作
* 临时存储 
    * 语法
        ```
        git stash [save MSG] [-a|-u] 
        ```
    * 功能：将工作区中已追踪的文件临时存储到堆栈，并将工作区与暂存区恢复到最后一次提交后的状态
    * 解释
        * `MSG`：临时存储说明文字，数据类型为：string
        * `-a`：临时存储未被追踪的文件、已被追踪的文件、忽略的文件
        * `-u`：临时存储未被追踪的文件、已被追踪的文件 
        * 不使用`[-a|-u]`参数：临时存储未已被追踪的文件
* 查看临时存储列表：`git stash list`
* 应用临时存储
    * 语法
        * 恢复最新的临时存储(stash@{0})到当前分支的工作区，并删除最新的临时存储
            ```
            git stash pop
            ```
        * 恢复指定的临时存储到当前分支的工作区，并删除指定的临时存储
            ```
            git stash pop stash@{ID} 
            ```
        * 恢复最新的临时存储(stash@{0})到当前分支的工作区 
            ```
            git stash apply
            ```
        * 恢复指定的临时存储到当前分支的工作区
            ```
            git stash apply stash@{ID} 
            ```
    * 解释
        * `ID`：临时存储id，查看临时存储列表可以获取id
        
## 暂存区操作
* 新增与修改
    * 语法
        ``` 
        git add OPTION_OR_FILE
        ```
    * 解释 
        * `OPTION_OR_FILE`：暂存操作，可以指定文件，也可以指定某个操作，它可取以下值：
            * 文件/文件夹路径：对暂存区新增和修改的文件(夹)进行更新。多个文件由空格分隔
            * `-u`：对暂存区删除和修改的文件进行更新
            * `--ignore-removal .`：对暂存区新增和修改的文件进行更新(git 2.0以上版本) 
            * `.`：对暂存区新增、修改和删除的文件进行更新(git 2.0及以上版本)
            * `-A`：对暂存区新增、修改和删除的文件进行更新
            * `-f`：强制添加到暂存区，即使文件(夹)已经在`.gitignore`列表中
* 删除
    * 语法
        ```  
        git rm [--cached] [-r] [-f] PATH 
        ```
    * 解释
        * `--cached`：仅删除暂存区的文件。省略此参数时，同时删除暂存区与工作区的文件。
        * `[-r][-f]`：`-r`表示递归删除文件夹中的内容，`-f`表示强制删除
        * `PATH`：要删除的文件(夹)的路径 
* 从暂存区提交到本地仓库：`git commit -m MSG`，MSG表示要提交的说明信息，数据类型为：string。
* 从工作区提交已追踪的文件到本地仓库：`git commit -am MSG`，MSG表示要提交的说明信息，数据类型为：string。 

## 仓库操作
* 回滚(不可逆，危险)
    * 语法
        ```
        git reset [OPTION [COMMENT_ID]]
        ```
    * 功能：使用`COMMENT_ID`对应的版本对当前仓库、暂存区进行替换、对工作区中的文件进行覆盖。指针回退
    * 注意：将当前版本指针向前移动，操作成功后，版本指针所在位置之后的版本将会丢失！ 
    * 警告：此操作不可逆！慎用！
    * 解释
        * `OPTION`
            * `--soft`：仅对仓库中的文件进行重置
            * `--mixed`：对仓库和暂存区中的文件进行重置。默认
            * `--hard`：对仓库、暂存区、工作区中已经追踪的文件进行重置 
        * `COMMENT_ID`：省略此参数时，`COMMENT_ID`默认为当前最新的提交ID。提交的唯一ID，可通过"提交日志"获取提交ID。
* 反做(用于撤回，安全) 
    * 语法 
        ```
        git revert COMMENT_ID 
        ```
    * 功能：使用`COMMENT_ID`对应的版本对当前仓库、暂存区进行替换、对工作区中的文件进行覆盖。作为新提交
    * 解释
        * `COMMENT_ID`：提交的唯一ID，可通过"提交日志"获取提交ID。

## 远程仓库操作
* 添加远程仓库：
    * 语法
        ```
        git remote add ALIAS URL 
        ```
    * 功能：添加新的远程仓库
    * 解释
        * `ALIAS`：远程仓库在本地的别名，可自定义
        * `URL`：远程仓库地址，支持多种协议，如：   
            * SSH
                * 如果需要配置ssh免密登录，请查看[配置ssh客户端](index.html?title=/md/ssh)
                * 完整形式：`ssh://{[username@]host[:port]|SSH_CONFIG_HOST_NAME}/git_dir_path`
                * 简化形式：`username@host:git_dir_path`，仅适用于22端口
                * username：远程主机的用户名。如果不指定则默认为本地当前的用户名
                    * github配置。示例`ssh://git@github.com/coderchuan/note.git`
                        * ssh登录用户名:git 
                        * 主机地址:github.com  
                        * 端口:22
                        * 仓库文件夹:git帐号用户名/仓库名.git，如`coderchuan/note.git`
                * host：远程主机地址
                * port：远程主机端口，默认为22 
                * SSH_CONFIG_HOST_NAME：`ssh`配置文件`~/.ssh/config`中配置的`Host`项的值
                * git_dir_path：远程仓库文件夹的路径
                * 示例：
                    ```
                    ssh://github.com/coderchuan/note.git
                        已经配置ssh的config文件，Host项的值为：github.com 
                        github仓库文件夹路径：/coderchuan/note.git 
                    ssh://ubuntu/home/ubuntu/test_git.git
                        已经配置ssh的config文件，Host项的值为：ubuntu
                        github仓库文件夹绝对路径：/home/ubuntu/test_git.git
                    ssh://ubuntu/~/test_git
                        已经配置ssh的config文件，Host项的值为：ubuntu
                        github仓库文件夹相对路径：~/test_git
                    ssh://ubuntu@localhost:6000/~/test_git
                        未配置ssh的config文件
                        github仓库文件夹相对路径：~/test_git
                    ```
            * HTTPS：
                * 形式：`https://domain[:port]/git_dir_path`
                * domain：主机域名或IP地址
                * port：远程主机端口，默认为80
                * git_dir_path：远程仓库文件夹的路径
                * 示例：`https://www.github.com/git_dir_path`
* 重命名远程仓库
    * 语法
        ```
        git remote rename <old> <new>
        ```
    * 解释
        * `old`：旧名称
        * `new`：新名称
* 移除远程仓库
    * 语法
        ```
        git remote remove <name>
        ```
    * 解释
        * `name`：仓库名称
* 修改远程仓库地址、在同一个别名中添加新的远程仓库地址
    * 语法
        * 修改远程仓库地址
            ```
            git remote set-url ALIAS NEW_URL [OLD_URL] 
            ```
        * 在同一个别名中添加新的远程仓库地址
            ```
            git remote set-url --add ALIAS NEW_URL 
            ```
        * 删除远程仓库地址
            ```
            git remote set-url --delete ALIAS NEW_URL 
            ```
    * 解释
        * `ALIAS`：远程仓库别名 
        * `NEW_URL`：远程仓库的新地址
        * `OLD_URL`：远程仓库的旧地址。当此别名中只有一个远程仓库地址时，可省略此参数
    * 注意：更多操作可通过`git config ENV -e`命令实现，例如'删除同一个别名下的多个远程仓库、设置默认的pull仓库'，`ENV`的含义详见"配置用户属性参数"中对`ENV`的介绍
* 查看、解除关联远程仓库、从本地分支中删除已经远程仓库中已经删除的分支
    * 语法
        * 查看已关联的远程仓库的别名 
            ```
            git remote 
            ```
        * 查看已关联的远程仓库的详细信息
            ```
            git remote -v
            ```
        * 解除关联远程仓库
            ```
            git remote rm ALIAS
            ```
        * 从本地分支中删除已经远程仓库中已经删除的分支，运行结果是已经删除的远程分支在本地也会被删除
            ```
            git remote prune ALIAS
            ```
    * 解释
        * `ALIAS`：远程仓库别名 
* 提交本地仓库到远程 
    * 语法
        ```
        git push [-u] [-f] [ALIAS {LO_BRANCH|:RE_BRANCH}] 
        ```
    * 功能：提交本地分支`LO_BRANCH`到远程仓库`ALIAS`的`RE_BRANCH`分支 
    * 解释 
        * `-u`：关联当前提交的分支与被提交的远程分支 
        * `-f`：强制提交
        * `ALIAS`：远程仓库别名。如果之前使用过`-u`参数关联当前分支，则可省略`ALIAS {LO_BRANCH|:RE_BRANCH}`
        * `LO_BRANCH`：本地仓库分支名。省略此参数时表示删除远程仓库分支`RE_BRANCH`
        * `RE_BRANCH`：远程仓库分支名。省略此参数则表示提交到远程同名分支，远程仓库不存在则在远程仓库创建分支
* 拉取远程仓库到本地 
    * 仅拉取远程仓库的分支 
        * 语法 
            ```
            git fetch [ALIAS [RE_BRANCH[:LO_BRANCH]]]
            ```
        * 解释  
            * `ALIAS`：远程仓库别名。省略此参数时，拉取所有仓库分支到本地
            * `RE_BRANCH`：远程仓库分支名。省略此参数则拉取指定仓库的所有分支到本地
            * `LO_BRANCH`：本地分支名。在本地创建名为`LO_BRANCH`的分支，并把远程分支`RE_BRANCH`拉取到本地分支`LO_BRANCH`添加到本地仓库
    * 将拉取的远程同名仓库合并到当前分支的工作区、暂存区、本地仓库
        * 语法 
            ```
            git merge BRANCH_NAME
            ```
        * 功能：合并指定的分支到当前分支
        * 解释  
            * `BRANCH_NAME`：要合并到当前分支的分支名。如果取值`FETCH_HEAD`则表示将最新拉取的同名分支合并到当前分支
    * 拉取并合并同名分支到当前分支的工作区、暂存区、本地仓库
        * 语法 
            ```
            git pull [ALIAS RE_BRANCH[:LO_BRANCH]] 
            ```
        * 解释  
            * `ALIAS`：远程仓库别名。使用`git push`命令时如果使用了`-u`参数，则可省略`ALIAS RE_BRANCH[:LO_BRANCH]`
            * `RE_BRANCH`：远程仓库分支名。
            * `LO_BRANCH`：本地分支名，拉取并合并到本地名为`LO_BRANCH`的分支，如果本地分支不存在，则创建此分支；省略此参数时则拉取并合并到本地同名分支。

## 冲突解决
* 冲突场景
    * 使用`git pull`命令时，发现有冲突提示
        ```
        error: Your local changes to the following files would be overwritten by merge:
            test2.txt
        Please commit your changes or stash them before you merge.
        Aborting
        Updating 8aa374b..bfa4d16
        ```
    * 使用`git push`命令时，有冲突提示 
        ```
        error: failed to push some refs to 'ssh://ubuntu/~/test_git'
        hint: Updates were rejected because the tip of your current branch is behind
        hint: its remote counterpart. Integrate the remote changes (e.g.
        hint: 'git pull ...') before pushing again.
        hint: See the 'Note about fast-forwards' in 'git push --help' for details.
        ```
    * 使用`git status`命令时，有冲突提示
        ```
        Your branch and 'test_git/master' have diverged,
        and have 1 and 1 different commits each, respectively.
        (use "git pull" to merge the remote branch into yours)
        ```
* 冲突分类及解决
    * 修改了文件但是没有执行`git add`命令，即依次执行`git pull`、`git status`命令后显示红色`modified`，按以下步骤解决
        1. git add
        1. git stash
        1. git pull
        1. git stash pop
        1. 编辑冲突文件
        1. git commit -am
        1. git push
    * 修改了文件且执行了`git add`命令，即依次执行`git pull`、`git status`命令后显示绿色`modified`，按以下步骤解决
        1. git stash
        1. git pull
        1. git stash pop
        1. 编辑冲突文件
        1. git commit -am
        1. git push
    * 修改了文件且执行了`git add`和`git commit`命令,即依次执行`git pull`、`git status`命令后显示`both modified`，按以下步骤解决
        1. 编辑冲突文件
        1. git commit -am
        1. git push

## 提交日志
* 查看当前仓库指针所在的位置之前的提交日志
    * 详细日志
        ```
        git log [--stat] [--pretty={oneline|format:FORMAT [--date=DATE_FORMAT]}] [--DATE_LOC=DATE_TIME] [-{S|G}"SEARCH"] [FILE] 
        ```
    * 解释：
        * 无参数：查看当前仓库指针所在的位置之前的提交日志
        * `[--stat]`：查看每个提交日志改动的文件列表
        * `[--pretty={oneline|format:FORMAT [--date=DATE_FORMAT]}]`
            * 功能：显示自定义日志格式 
            * `oneline`：仅显示版本号与日志消息
            * `FORMAT`：日志格式，数据类型为string。它可以由以下含义的格式字符和普通字符串组合：
                * `%H`：完整的提交`hash` 
                * `%h`：简短的提交`hash` 
                * `%T`：树对象的完整`hash`
                * `%t`：树对象的简短`hash`
                * `%P`：父对象的完整`hash`
                * `%p`：父对象的简短`hash`
                * `%an`：作者
                * `%ae`：作者邮箱
                * `%ad`：作者修订日期,可以使用`--date=`参数定制格式
                * `%ar`：作者修订日期,按多久以前的方式显示
                * `%cn`：提交者
                * `%ce`：提交者邮箱
                * `%cd`：提交日期，可以使用`--date=`参数定制格式
                * `%cr`：提交日期，按多久以前的方式显示
                * 注意：还可在每个格式前添加显示的字体、颜色
                    * 语法示例
                        ```
                        git log --pretty=format:"%C([STYLE ]COLOR[ BG_COLOR])%H"
                        ```
                    * 解释 
                        * `STYLE`：样式，可取以下值： 
                            * bold，粗体
                            * dim，暗淡
                            * ul，下划线
                            * blink，加亮
                            * reverse，底色与字体颜色反转
                        * `COLOR`：颜色，它可取以下值：
                            * reset：默认颜色
                            * black
                            * red
                            * green
                            * yellow
                            * blue
                            * magenta
                            * cyan
                            * white
                        * `BG_COLOR`：底色颜色，可取颜色同"COLOR"
            * `DATE_FORMAT`：日志格式中的日期，可取以下值：
                * 已经定义好的格式，形式为`--date=AUTO_FORMAT`，其中`CUS_FORMAT`数据类型为text。如下： 
                    * `local`：以当地时间显示
                    * `iso`：以ISO 8601格式显示时间
                    * `rfc`：以RFC 2822格式显示时间
                    * `short`：仅显示日期
                    * `raw`：以"时间戳 时区"的格式显示
                    * `default`：原始时间格式 
                * 也可灵活自定义格式，形式为`--date=format:CUS_FORMAT`，其中`CUS_FORMAT`数据类型为string。可由以下格式字符和普通字符串组合：
                    * `%A`：星期
                    * `%B`：月份
                    * `%b`：月份缩写
                    * `%c`：适合地区的日期和时间表示
                    * `%d`：两位日 
                    * `%H`：两位24制时
                    * `%I`：两位12制时
                    * `%j`：三位天(001-366)
                    * `%m`：两位月
                    * `%M`：两位分钟
                    * `%p`：上午下午提示符
                    * `%S`：两位秒 
                    * `%U`：两位周(00-53,周日作为一周起始) 
                    * `%W`：两位周(00-53,周一作为一周起始)
                    * `%w`：星期(0-6,星期天为0) 
                    * `%x`：当前语言环境的日期表示
                    * `%X`：当前语言环境的时间表示
                    * `%y`：两位年(00-99)
                    * `%Y`：四位年
                    * `%z`或`%Z`：时区名称。取决于当前操作系统
                    * `%%`：百分号 
        * `[--DATE_LOC={DATE_TIME}]`
            * 功能：按日期搜索日志
            * `DATE_LOC`：搜索范围，它可取以下值：
                * `after`：`DATE_TIME`之后的所有提交
                * `before`：`DATE_TIME`之前的所有提交
            * `DATE_TIME`：要搜索的时间点，两侧应使用中括号`{}`包裹，时间格式为：`{2018-10-08-15:20}`
        * `[-{G|S}"SEARCH"]`
            * 功能：用正则/字符串搜索文件内容所在文件的日志。
            * `G`：正则搜索引擎
            * `S`：字符串搜索引擎 
            * `SEARCH`：正则表达式/搜索字符串，表示文件内容，数据类型为text
        * `[FILE]`：FILE表示文件，在指定的文件中搜索。
    * 修改最后一次提交日志
        * 未push到远程仓库
            * 命令:`git commit --amend`
        * 已经push到远程仓库
            * 命令
                ```
                git commit --amend
                git push -f
                ```
* 查看本地所有提交记录
    ```
    git reflog 
    ```
* 提交ID(COMMENT_ID)
    * `HEAD~__NUM__`：`__NUM__`代表数字，从后往前数第`__NUM__`次提交的COMMENT_ID
    * `HEAD`：最后一次提交ID
    * `FETCH_HEAD`：当前分支最后一次拉取(git fetch)的提交ID 
    * 历史提交ID可通过提交日志命令查看

## 分支操作
* 分支增改删除查
    * 语法
        * 查看分支
            ```
            git branch [-a|-v|-r]
            ```
        * 删除分支
            ```
            git branch {-d|-D} DEL_BRANCH_NAME
            ```
        * 删除远程仓库中的分支
            ```
            git push REM_NAME :REM_BRANCH_NAME
            ```
        * 重命名分支
            ```
            git branch {-m|-M} OLD_BRANCH_NAME NEW_BRANCH_NAME
            ```
        * 创建基于当前分支的新分支
            ```
            git branch CRE_BRANCH_NAME
            ```
        * 创建基于当前分支的新分支并切换到新分支
            ```
            git checkout -b CRE_BRANCH_NAME 
            ```
        * 创建空的新分支并切换到新分支(提交文件`git commit`后可见此分支) 
            ```
            git checkout --orphan CRE_BRANCH_NAME
            git rm -rf .
            ```
    * 解释
        * 无参数：查看当前仓库下的本地分支
        * `-a`：查看当前仓库下的所有分支
        * `-r`：查看当前仓库下的远程分支
        * `-v`：查看当前仓库下的本地分支和分支id
        * `CRE_BRANCH_NAME`：创建新分支的新分支名称
        * `-d`：删除分支选项
        * `-D`：强制删除分支选项
        * `DEL_BRANCH_NAME`：删除分支的分支名称
        * `REM_NAME`：远程仓库名
        * `REM_BRANCH_NAME`：远程分支名
        * `-m`：重命名分支选项
        * `-M`：强制重命名分支选项 
        * `NEW_BRANCH_NAME`：重命名分支的新名称 
* 切换分支、使用其他分支文件覆盖当前工作区并追踪此文件(夹)。未追踪的文件不受影响
    * 切换分支，可浏览历史版本
        * 语法
            ```
            git checkout [-f] [BRANCH_NAME]
            ```
        * 解释
            * `无参数`：切换到当前分支上一次提交后的状态
            * -f：强制覆盖已追踪的文件
            * `BRANCH_NAME`：将要切换到的分支名称或分支的版本ID(可通过提交日志查看提交ID)
    * 使用其他分支文件覆盖当前分支文件(夹)，可用于恢复被删除的文件
        * 语法
            ```
            git checkout [BRANCH_NAME] -- FILE_OR_DIR_NAME
            ```
        * 解释
            * `BRANCH_NAME`：同"切换分支"中的"BRANCH_NAME";
            * `FILE_OR_DIR_NAME`：指定分支的文件(夹)。用于覆盖当前分支的工作区并追踪此文件(夹) 

## 比较差异
* 语法：
    ```
    git {diff|difftool} COMMENT_ID1:FILE1  COMMENT_ID2:FILE2 
    git {diff|difftool} FILE1  FILE2
    git {diff|difftool} FILE3
    ```
* 功能：比较文件差异
* 解释  
    * `COMMENT_ID1`：提交版本1
    * `COMMENT_ID2`：提交版本2
    * `FILE1`：比较任意两个文件的差异，第一个文件
    * `FILE2`：比较任意两个文件的差异，第二个文件。如果比较两个文件在不同的版本中的差异，`FILE2`应与`FILE1`相同 
    * `FILE3`：比较此文件与上一个已提交版本(HEAD)的差异

## 清理
* 语法
    ```
    git clean -OPTION
    ```
* 解释 
    * `OPTION`：文件清理操作，它可取以下值，且可自由组合
        * `n`：显示将会被删除的文件(夹)，不带此参数时将会删除未被跟踪的文件(夹)
        * `f`：删除或显示当前仓库下没有被跟踪的文件
        * `d`：删除或显示当前仓库下没有被跟踪的文件夹
        * `x`：即使这些文件(夹)在.gitignore文件中指定,也会被删除或显示
    * 示例：
        * `git clean -xdnf`：显示将会被删除的未被跟踪的文件(夹).即使这些文件(夹)在.gitignore文件中指定
        * `git clean -dnf`：显示将会被删除的未被跟踪的文件(夹).不包括.gitignore文件中列出的内容
        * `git clean -df`：删除未被跟踪的文件(夹).不包括.gitignore文件中列出的内容

## 文件忽略规则
* 语法规则
    1. 不能以`/`开头
    1. `/`结尾：忽略以当前`.gitignore`文件所在目录为根目录的指定文件夹 
    1. 不以`/`结尾：忽略以当前`.gitignore`文件所在目录为根目录的指定文件
    1. 通配符`*`：匹配多个任意字符
    1. 通配符`**`：匹配任意多个任意中间目录
    1. 通配符`?`：匹配一个任意字符
    1. 范围选择符`[]`：除数量限定符只能使用`*`和`?`外，使用规则与[PCRE正则](index.html?title=/md/regex_pcre)中"元字符->字符范围符"相同
    1. 取反符`!`：表示不忽略已经被忽略的指定文件(夹)。但是该文件(夹)的父文件夹必须没有被忽略，否则无效
* 转义字符。如果需要忽略的文件(夹)名中含有以下字符，可以使用转义： 
    * 空格：`\空格`
    * `#`：`\#`
* 模板。使用已经定义好的模板，无须自定义规则，详见[gitignore模板](https://github.com/github/gitignore)

## 命令行中正常显示中文
```
git config --global core.quotepath false
git config --global gui.encoding utf-8
git config --global i18n.commit.encoding utf-8
git config --global i18n.logoutputencoding utf-8
```
