#!/bin/bash
init()
{
clear
echo "Welcome To ABD File Browser"
echo "Current Working Directory:$PWD"
echo "-------------------------------"
if [[ $show_hidden -eq 1 ]]; then
content=($(ls -a1 --group-directories-first))
else
content=($(ls -1 --group-directories-first))
fi
all_content=${#content[@]}
echo "-------------------------------"
}
init
