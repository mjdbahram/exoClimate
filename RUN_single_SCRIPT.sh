#!/bin/bash
run_status="single_planet"
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
mkdir -p ./outputs/parameters/
rm -f ./outputs/results/*
rm -f ./outputs/snapshots/*
rm -f ./outputs/parameters/*
cd src/;bash setup.sh #make clean &> /dev/null; make &> /dev/null; 
kill $!; trap 'kill $!' SIGTERM
echo -ne "\n"

cd ..



cp world_values.txt ./outputs/parameters/

while true; do progress; done &
echo "And Running ..."
./src/climate_simulation.run<<eof
"world_values.txt"
run_status
eof

kill $!; trap 'kill $!' SIGTERM
echo -ne "\n"


bash ./src/ploter1.sh


echo -ne "... And finish "
echo -ne 
echo
echo
echo 
echo -ne "You may see the results in ./output/results/"
echo
echo

