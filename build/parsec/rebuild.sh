rm -rf ${TOP_DIR}/bitcodes/LLVM9.0/parsec/*
rm -rf ./parsec-3.0
rm -rf *.gz
wget http://parsec.cs.princeton.edu/download/3.0/parsec-3.0-core.tar.gz
wget http://parsec.cs.princeton.edu/download/3.0/parsec-3.0-input-sim.tar.gz
wget http://parsec.cs.princeton.edu/download/3.0/parsec-3.0-input-native.tar.gz
tar xvf parsec-3.0-core.tar.gz
tar xvf parsec-3.0-input-sim.tar.gz
tar xvf parsec-3.0-input-native.tar.gz