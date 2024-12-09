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
search_mode=0 # Flag to track if in search mode
search_results=() # Array to store search result
search_files() {
    read -p "Search for: " search_term
    search_results=($(find . -name "*$search_term*" 2>/dev/null))
    
    if [[ ${#search_results[@]} -eq 0 ]]; then
        echo "No results found for '$search_term'. Press Enter to return."
        read
    else
        search_mode=1 # Enable search mode
        cursor=0 # Reset cursor for navigation
    fi
}

init()
{
clear
echo -e "\e[1;30m Welcome To ABD File Browser"
echo "$PWD"
echo -e "\e[1;30m -------------------------------"
if [[ $show_hidden -eq 1 ]]; then
content=($(ls -a1 --group-directories-first))
else
content=($(ls -1 --group-directories-first))
fi
all_content=${#content[@]} #represents the number of elements in the array
for i in "${!content[@]}"; do
if [[ -d "${content[$i]}" && $i -eq $cursor ]]; then
    echo -e "\e[1;33m > $((i+1)) ${content[$i]}"
elif [[ -d "${content[$i]}" ]]; then
    echo -e "\e[1;33m $((i+1)) ${content[$i]}"
elif [[ $i -ne $cursor ]]; then
    echo -e "\e[1;30m $((i+1)) ${content[$i]}"
elif [[ $i -eq $cursor ]]; then
    echo -e "\e[1;32m > $((i+1)) ${content[$i]}"
fi
done
echo "-------------------------------"
if [[ ${#selected[@]} -ge 1 ]]; then
    echo "Selected Files:${selected[*]}"
else
    echo " "
fi
echo ${prev[@]}
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
                        cursor=$((all_content))
                    fi
                    ;;
                 '[B')
                     ((cursor++))
                     if [[ $cursor -ge $all_content ]]; then #-ge refers to greater or equal to
                         cursor=0
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
         ?)
        #  read -p "Search For: " search_term
        #  find . -name "*$search_term*" 2>/dev/null
        #  read -p "Press any key to continue"
        search_files
         ;;
    esac

}
while true; do
init
navigate
done