#!/bin/bash

rm -rf ${TOP_DIR}/bitcodes/LLVM9.0/SPEC2017/*
rm -rf ./SPEC2017
tar -xf /project/benchmarks/SPEC2017.tar.gz
exit
chmod +x -R  
cp gClang.cfg SPEC2017/config .
cp make.def ./NAS/config/make.def
cp suite.def ./NAS/config/suite.def
cd NAS
mkdir bin
CC=gclang CXX=gclang++ make suite -j
cd bin

for file in ./*
do
    get-bc "$file"
done

mv ./*.bc ${TOP_DIR}/bitcodes/LLVM9.0/NAS/
cd ${TOP_DIR}/bitcodes/LLVM9.0/NAS/
tar -czf nas.tgz *
