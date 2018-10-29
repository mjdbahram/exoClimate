#!/bin/bash


function progress () {
    START=$(date +%s.%N);
    f=0.1;
    echo -ne "\r\n";
    while true; do
           sleep $f && END=$(date +%s.%N) &&  s=$(echo "$END - $START" | bc) && echo -ne "\r\t[                             ] Elapsed: ${s} secs." \
        && sleep $f && END=$(date +%s.%N) &&  s=$(echo "$END - $START" | bc) && echo -ne "\r\t[>                            ] Elapsed: ${s} secs." \
        && sleep $f && END=$(date +%s.%N) &&  s=$(echo "$END - $START" | bc) && echo -ne "\r\t[=>                           ] Elapsed: ${s} secs." \
        && sleep $f && END=$(date +%s.%N) &&  s=$(echo "$END - $START" | bc) && echo -ne "\r\t[==>                          ] Elapsed: ${s} secs." \
        && sleep $f && END=$(date +%s.%N) &&  s=$(echo "$END - $START" | bc) && echo -ne "\r\t[===>                         ] Elapsed: ${s} secs." \
        && sleep $f && END=$(date +%s.%N) &&  s=$(echo "$END - $START" | bc) && echo -ne "\r\t[====>                        ] Elapsed: ${s} secs." \
        && sleep $f && END=$(date +%s.%N) &&  s=$(echo "$END - $START" | bc) && echo -ne "\r\t[=====>                       ] Elapsed: ${s} secs." \
        && sleep $f && END=$(date +%s.%N) &&  s=$(echo "$END - $START" | bc) && echo -ne "\r\t[======>                      ] Elapsed: ${s} secs." \
        && sleep $f && END=$(date +%s.%N) &&  s=$(echo "$END - $START" | bc) && echo -ne "\r\t[=======>                     ] Elapsed: ${s} secs." \
        && sleep $f && END=$(date +%s.%N) &&  s=$(echo "$END - $START" | bc) && echo -ne "\r\t[========>                    ] Elapsed: ${s} secs." \
        && sleep $f && END=$(date +%s.%N) &&  s=$(echo "$END - $START" | bc) && echo -ne "\r\t[=========>                   ] Elapsed: ${s} secs." \
        && sleep $f && END=$(date +%s.%N) &&  s=$(echo "$END - $START" | bc) && echo -ne "\r\t[==========>                  ] Elapsed: ${s} secs." \
        && sleep $f && END=$(date +%s.%N) &&  s=$(echo "$END - $START" | bc) && echo -ne "\r\t[===========>                 ] Elapsed: ${s} secs." \
        && sleep $f && END=$(date +%s.%N) &&  s=$(echo "$END - $START" | bc) && echo -ne "\r\t[============>                ] Elapsed: ${s} secs." \
        && sleep $f && END=$(date +%s.%N) &&  s=$(echo "$END - $START" | bc) && echo -ne "\r\t[=============>               ] Elapsed: ${s} secs." \
        && sleep $f && END=$(date +%s.%N) &&  s=$(echo "$END - $START" | bc) && echo -ne "\r\t[==============>              ] Elapsed: ${s} secs." \
        && sleep $f && END=$(date +%s.%N) &&  s=$(echo "$END - $START" | bc) && echo -ne "\r\t[===============>             ] Elapsed: ${s} secs." \
        && sleep $f && END=$(date +%s.%N) &&  s=$(echo "$END - $START" | bc) && echo -ne "\r\t[================>            ] Elapsed: ${s} secs." \
        && sleep $f && END=$(date +%s.%N) &&  s=$(echo "$END - $START" | bc) && echo -ne "\r\t[=================>           ] Elapsed: ${s} secs." \
        && sleep $f && END=$(date +%s.%N) &&  s=$(echo "$END - $START" | bc) && echo -ne "\r\t[==================>          ] Elapsed: ${s} secs." \
        && sleep $f && END=$(date +%s.%N) &&  s=$(echo "$END - $START" | bc) && echo -ne "\r\t[===================>         ] Elapsed: ${s} secs." \
        && sleep $f && END=$(date +%s.%N) &&  s=$(echo "$END - $START" | bc) && echo -ne "\r\t[====================>        ] Elapsed: ${s} secs." \
        && sleep $f && END=$(date +%s.%N) &&  s=$(echo "$END - $START" | bc) && echo -ne "\r\t[=====================>       ] Elapsed: ${s} secs." \
        && sleep $f && END=$(date +%s.%N) &&  s=$(echo "$END - $START" | bc) && echo -ne "\r\t[======================>      ] Elapsed: ${s} secs." \
        && sleep $f && END=$(date +%s.%N) &&  s=$(echo "$END - $START" | bc) && echo -ne "\r\t[=======================>     ] Elapsed: ${s} secs." \
        && sleep $f && END=$(date +%s.%N) &&  s=$(echo "$END - $START" | bc) && echo -ne "\r\t[========================>    ] Elapsed: ${s} secs." \
        && sleep $f && END=$(date +%s.%N) &&  s=$(echo "$END - $START" | bc) && echo -ne "\r\t[=========================>   ] Elapsed: ${s} secs." \
        && sleep $f && END=$(date +%s.%N) &&  s=$(echo "$END - $START" | bc) && echo -ne "\r\t[==========================>  ] Elapsed: ${s} secs." \
        && sleep $f && END=$(date +%s.%N) &&  s=$(echo "$END - $START" | bc) && echo -ne "\r\t[===========================> ] Elapsed: ${s} secs.";
           sleep $f && END=$(date +%s.%N) &&  s=$(echo "$END - $START" | bc) && echo -ne "\r\t[============================>] Elapsed: ${s} secs.";
    done;
}


while true; do progress; done &
echo "Making ...."
mkdir -p outputs/ 
mkdir -p ./outputs/snapshots/
mkdir -p ./outputs/results/
rm -f ./outputs/results/*
rm -f ./outputs/snapshots/*
cd src/; make clean &> /dev/null; make &> /dev/null; 
kill $!; trap 'kill $!' SIGTERM
echo -ne "\n"
cd ..

while true; do progress; done &
echo "And Running ..."
python multi.py

kill $!; trap 'kill $!' SIGTERM
echo -ne "\n"

echo -ne "... And finish "
echo -ne 
echo
echo
echo 
echo -ne "You may see the results in ./output/results/"
echo
echo


