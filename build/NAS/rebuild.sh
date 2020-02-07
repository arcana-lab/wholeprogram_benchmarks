if [ $1 == "clean" ]
then
    rm -rf ./NAS
else
    rm -rf ${TOP_DIR}/bitcodes/LLVM9.0/NAS/*
    rm -rf ./NAS
    git clone https://github.com/benchmark-subsetting/NPB3.0-omp-C.git NAS
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

fi
