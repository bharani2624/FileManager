#!/bin/bash
echo -e "\e[47m"
selected=()
show_hidden=0
select=0
cursor=0
prev=()
prevcount=0
currcount=0
cp=""
original_color=$(tput sgr0)
search_content=()
t_height=$(tput lines)
t_width=$(tput cols)
toggle=0
init()
{
clear
echo -e "\e[1;30m Welcome To ABD File Browser"
echo "$PWD"
echo -e "T-Toggle For Options"
if [[ $toggle -eq 1 ]]; then 
echo -e "C:Copy"
echo -e "P:Paste"
echo -e "R:Delete"
echo -e "Q:Quit"
echo -e "S-Select"
fi
echo -e "\e[1;30m -------------------------------"
if [[ $search_mode -eq 1 ]]; then
    all_content=${#search_content[@]}
    content=("${search_content[@]}")
else
    if [[ $show_hidden -eq 1 ]]; then
    content=($(ls -a1 --group-directories-first))
    else
    content=($(ls -1 --group-directories-first))
    fi
    all_content=${#content[@]} #represents the number of elements in the array
fi

files_per_page=$((t_height - 4))  # Subtract header and footer lines
start_index=$((cursor - (cursor % files_per_page))) 

for ((i=start_index; i<start_index + files_per_page && i<all_content; i++)); do
            item=${content[$i]}
if [[ -d "$item" && $i -eq $cursor ]]; then
    echo -e "\e[1;33m ⭐ $((i+1)) ${item}"
elif [[ -d "$item" ]]; then
    echo -e "\e[1;33m $((i+1)) ${item/}"
elif [[ $i -ne $cursor ]]; then
    echo -e "\e[1;30m $((i+1)) ${item/}"
elif [[ $i -eq $cursor ]]; then
    echo -e "\e[1;32m > $((i+1)) ${item}"
fi

done
echo "-------------------------------"
if [[ ${#selected[@]} -ge 1 ]]; then
    echo "Selected Files:${selected[*]}"
else
    echo " "
fi
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
                    if [[ $cursor -lt 0 ]]; then #-lt denotes lesser than
                        cursor=$((all_content - 1))
                    fi
                    ;;
                 '[B')
                     ((cursor++))
                     if [[ $cursor -gt $all_content ]]; then #-ge refers to greater or equal to
                         cursor=0
                     fi
                     ;;
                '[5~')  # Page Up
                    ((cursor-=files_per_page))
                    if [[ $cursor -lt 0 ]]; then
                        cursor=0
                    fi
                    ;;
                '[6~')  # Page Down
                    ((cursor+=files_per_page))
                    if [[ $cursor -ge $all_content ]]; then
                        cursor=$((all_content - 1))
                    fi
                    ;;  
                '[D')
                    prev[prevcount]=$PWD
                    ((prevcount++))
                    currcount=$prevcount
                    cd ..
                    cursor=0
                    ;;
                '[C')
                    $((currcount--))
                    cd ${prev[$currcount]}
                    ;;     
             esac
            ;;
        'Q' |'q' )
        echo -e "$(tput sgr0)"
        clear
        exit 0
        ;;
        'S' | 's')
            selected+=({"${content[$cursor]}"})
        ;;
        'A'|'a')
            show_hidden=$((!show_hidden))
            cursor=0
            init
            ;;
         'T'|'t')
            toggle=$((!toggle))
            init
         ;;   
         'r'|'R')
            read -p "Enter the new name: " new_name
            mv "${content[$cursor]}" "$new_name" || echo "Rename was not successful"
         ;;
         'c'|'C')
            cp="$PWD/${content[$cursor]}"
         ;;
         'p'|'P')
         if [ -d $cp ]; then
            cp -r $cp .
         else
            cp $cp .
         fi
         ;;
         'd'|'D')
         if [ -d ${content[$cursor]} ]; then
            rm -r "$PWD/${content[$cursor]}"
         else
            rm "$PWD/${content[$cursor]}"
         fi
         ;;
         '')
         if [ -d  ${content[$cursor]} ]; then
            cd ${content[$cursor]} 
            unset prev[@]
         else
            xdg-open "${content[$cursor]}"
         fi
         ;;
        '?' )
        read -p "Search For: " search_term
        mapfile -t search_content < <(find . -name "*$search_term*" 2>/dev/null)
        if [[ ${#search_content[@]} -eq 0 ]]; then
            echo "No results found for '$search_term'. Press Enter to return."
            read
        else
            search_mode=1
            cursor=0
    fi
    ;;
    esac

}
while true; do
init
navigate
done 
