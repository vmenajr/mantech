#!/usr/bin/env bash

function print_flag() {
    konstant=$1
    url=$2
    bytes=$(od -An -w1 -t d1 -v < <(curl -s -L ${url}))
    flag=''
    echo k=${konstant}
    while read byte; do
        d=$((${byte} ^ ${konstant}))
        #echo ${byte} '=>' ${d}
        flag="${flag}$(echo ${d} | awk '{printf("%c",$1)}')"
    done < <(printf "%s" "$bytes")
    echo ${flag}
}

print_flag $((0xa4 ^ 0xae ^ 0x9c ^ 0x6f)) https://www.mantech.com/sites/default/files/2019-03/Algo1_message.txt
print_flag $((0x54 ^ 0x6e ^ 0x40 ^ 0x4d ^ 0x43 ^ 0x68 ^ 0x63 ^ 0x72 ^ 0x62 ^ 0x79 ^ 0x21)) https://www.mantech.com/sites/default/files/2019-03/Algo2_message.txt
exit

flag=''
#v=$((0x54 ^ 0x6e ^ 0x40 ^ 0x4d ^ 0x43 ^ 0x68 ^ 0x63 ^ 0x72 ^ 0x62 ^ 0x79 ^ 0x21))
v=$((0xa4 ^ 0xae ^ 0x9c ^ 0x6f))
echo v=${v}
#bytes=$(od -An -w1 -t d1 -v < <(curl -L https://www.mantech.com/sites/default/files/2019-03/Algo2_message.txt))
bytes=$(od -An -w1 -t d1 -v < <(curl -L https://www.mantech.com/sites/default/files/2019-03/Algo1_message.txt))
while read byte; do
    d=$((${byte} ^ ${v}))
	echo ${byte} '=>' ${d}
    flag="${flag}$(echo ${d} | awk '{printf("%c",$1)}')"
done < <(printf "%s" "$bytes")
echo ${flag}
exit

