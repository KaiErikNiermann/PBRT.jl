# install jluna
git clone https://github.com/clemapfel/jluna.git
cd jluna
mkdir build
cd build

cmake .. -DCMAKE_CXX_COMPILER=/usr/bin/g++-10 

sudo make install 

ctest --verbose 

cd ../..

wget https://julialang-s3.julialang.org/bin/linux/x64/1.10/julia-1.10.2-linux-x86_64.tar.gz
tar zxvf julia-1.10.2-linux-x86_64.tar.gz

rm julia-1.10.2-linux-x86_64.tar.gz