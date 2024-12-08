#!/bin/bash

selected=()
show_hidden=0
init()
{
clear
echo "Welcome To ABD File Browser"
echo "$PWD"
echo "-------------------------------"
if [[ $show_hidden -eq 1 ]]; then
content=($(ls -a1 --group-directories-first))
else
content=($(ls -1 --group-directories-first))
fi
all_content=${#content[@]} #represents the number of elements in the array
for i in "${!content[@]}"; do
if [[ $i -eq $cursor ]]; then
echo " > ${content[$i]}"
else
echo "   ${content[$i]}"
fi
done
echo "-------------------------------"
echo "Selected Files: ${selection[*]}"
}
navigate()
{
    read -rsn1 input
    case $input in
        $'\x1b')
            read -rsn2 -t 0.1 input
            case $input in
                '[A')
                    ((cursor--))
                    if [[ $cursor -lt 0 ]]; then
                        cursor=$((all_content))
                    fi
                    ;;
                 '[B')
                     ((cursor++))
                     if [[ $cursor -ge $all_content ]]; then
                         cursor=0
                     fi
                     ;;
             esac      
    esac

}
cursor=-1
while true; do
init
navigate
done

