#!/bin/bash
    read -p "Search For: " search_term
    mapfile -t content < <(find . -name "$search_term" 2>/dev/null)
    if [[ ${#content[@]} -eq 0 ]]; then
        echo "No results found for '$search_term'. Press Enter to return."
        read
        init
    else
        cursor=0
        all_content=${#content[@]}
    fi
for i in "${!content[@]}"; do
echo "${content[$i]}"
done 