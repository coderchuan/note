#!/bin/bash

work_path=$(dirname $(readlink -f $0))
md_path="${work_path}/md"

index_file="${work_path}/index/index.md"
base_url="./index.html?title=";

function createIndex(){
    local files=$(ls $1)
    local index_file=$2
    local level=0;
    if [ "$3" == "" ];then
        echo "## 我的笔记" > $index_file 
    else level=`expr $3 + 1`;
    fi 

    local space_num="";
    local lever_str="1. ";

    if [ "${level}" == '0' ] ;then
        lever_str="1. ";
    else lever_str="* ";
    fi

    for ((i=0;i<${level};i++))
    do 
        space_num="${space_num}    ";
    done

    for file in ${files[*]}
        do
            local name=$(echo "$file" | grep -oP ".+(?=\\.[^\\.]+\$)")
            local static_site_path=$(echo "$1" | grep -oP "(?<=^$work_path).+")
            if [ -f "$1/$file" ] && [ $file != "index.md" ] ;then
                local path_str="$static_site_path/$name";
                echo "${space_num}${lever_str}[$name](${base_url}$path_str)" >> $index_file
                echo -e "\033[32;5;1m已经创建索引:${path_str}\033[0m"
            elif [ -d "$1/$file" ] ;then
                path_str="$file";
                echo "${space_num}${lever_str}$path_str" >> $index_file
                createIndex "$1/$file" $index_file ${level} 
            fi
        done
}

echo ""
echo -e "\033[32;5;1m开始创建索引\033[0m"

createIndex $md_path $index_file

echo -e "\033[32;5;1m索引创建完成\033[0m"
echo ""

