#!/bin/zsh -eu
# Ugly scripts to find a string into deployment description and return only matching image
# Help to find which deploy uses an env var value or anything contained into a deployment spec 

tmp_file=$1
regex=$2

if [ ! -f $tmp_file ] ; then
    set -x
    kubectl describe deploy --all-namespaces | grep -E -i "($regex|Image:)" > $tmp_file
    set +x
fi

# Load text file lines into a bash array.
OLD_IFS=$IFS
IFS=$'\n'
lines=( $(cat $tmp_file) )
IFS=$OLD_IFS

lines_length=${#lines[@]}
for (( i=0; i<lines_length; i++ ))
do  
    current_line=${lines[$i]}
    if [[ ! $current_line =~ "Image:" ]] ; then
        echo $current_line
        continue
    fi

    next_line=${lines[$i+1]}
    if [[ ! $next_line =~ "Image:" ]] ; then
        echo ""
        echo $current_line
        continue
    fi
done
