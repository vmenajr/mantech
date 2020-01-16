#!/usr/bin/env bash
# https://www.mantech.com/mantech-cyber-challenge
#
url_bin1=https://www.mantech.com/sites/default/files/2019-03/Algo1_algorithm.txt
url_msg1=https://www.mantech.com/sites/default/files/2019-03/Algo1_message.txt
url_bin2=https://www.mantech.com/sites/default/files/2019-03/Algo2_algorithm.txt
url_msg2=https://www.mantech.com/sites/default/files/2019-03/Algo2_message.txt

function print_flag() {
    konstant=$1
    url=$2
    bytes=$(od -An -w1 -t d1 -v < <(curl -s -L ${url}))
    flag=''
    echo -n k=${konstant},\ 
    while read byte; do
        d=$((${byte} ^ ${konstant}))
        #echo ${byte} '=>' ${d}
        flag="${flag}$(echo ${d} | awk '{printf("%c",$1)}')"
    done < <(printf "%s" "$bytes")
    echo ${flag}
}

curl -s --output /tmp/asm.bin ${url_bin1}; /usr/local/Cellar/binutils/2.32/bin/objdump -D -Mintel,x86-64 -m i386 -b binary /tmp/asm.bin
echo
curl -s --output /tmp/asm.bin ${url_bin2}; /usr/local/Cellar/binutils/2.32/bin/objdump -D -Mintel,x86-64 -m i386 -b binary /tmp/asm.bin
echo
echo
echo

print_flag $((0xa4 ^ 0xae ^ 0x9c ^ 0x6f)) ${url_msg1}
print_flag $((0x54 ^ 0x6e ^ 0x40 ^ 0x4d ^ 0x43 ^ 0x68 ^ 0x63 ^ 0x72 ^ 0x62 ^ 0x79 ^ 0x21)) ${url_msg2}

