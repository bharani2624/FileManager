#!/bin/bash
selected=()
show_hidden=0
select=0
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
    echo " > $((i+1)) ${content[$i]}"
else
    echo "  $((i+1)) $count ${content[$i]}"
fi
done
echo "-------------------------------"
if [[ $select -eq 1 ]]; then
echo "Selected Files:{$selected[*]}"
else
    echo " "
fi
#echo "Selected Files: ${selected[*]}"
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
                '[D')
                    cd ..
                    cursor=0
                    ;; 
             esac
            ;;
        'Q' |'q' )
        exit 0
        ;;
    '')
        selected+=({"${content[$cursor]}"})
        #echo "Selected Files:[${selected[*]}]"
        ;;
     'A'|'a')
         show_hidden=$((!show_hidden))
         cursor=0
         init
         ;;
    esac

}
cursor=0
while true; do
init
navigate
done

