#!/bin/bash

if [[ $(which jq) == "" ]] ; then
    echo "Could not find jq command"
    exit 1
fi

xcolors="./xcolors.json"
if [[ ! -e "${xcolors}" ]] ; then
    echo "Could not find xcolors.json"
    exit 1
fi

# Somewhere to store conversions, so we aren't repeating them
memo=()

while read line ; do

    # If we have a cterm background, add a gui background
    if [[ $( echo "${line}" | grep -0 'ctermbg=[0-9]*' ) != "" ]] ; then

        # Extract the number for the colour
        code=$( echo "${line}" | grep -o 'ctermbg=[0-9]*' | cut -d'=' -f2 )

        # Check if we've already found this converstion
        if [[ "${memo[${code}]}" != "" ]] ; then

            hex=${memo[${code}]}

        # Find the hex value for this number
        else

            hex=$( cat xcolors.json | jq -r ". | map(select(.number == ${code})) | .[].hex" )
            memo[${code}]=${hex}
        fi

        # Add it to the line
        line="${line} guibg=${hex}"
    fi

    # If we have a cterm foreground, add a gui foreground
    if [[ $( echo "${line}" | grep -0 'ctermfg=[0-9]*' ) != "" ]] ; then

        # Extract the number for the colour
        code=$( echo "${line}" | grep -o 'ctermfg=[0-9]*' | cut -d'=' -f2 )

        # Check if we've already found this converstion
        if [[ "${memo[${code}]}" != "" ]] ; then

            hex=${memo[${code}]}

        # Find the hex value for this number
        else

            hex=$( cat xcolors.json | jq -r ". | map(select(.number == ${code})) | .[].hex" )
            memo[${code}]=${hex}
        fi

        # Add it to the line
        line="${line} guifg=${hex}"
    fi

    echo $line
done
