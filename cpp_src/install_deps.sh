# move julia to usr/local 
ls -la /usr/local/include
ls -la /usr/local

git clone https://github.com/clemapfel/jluna.git
cd jluna
mkdir build
cd build

cmake .. -DCMAKE_CXX_COMPILER=$(which g++-10)

make install 

ctest --verbose 

cd ../../



