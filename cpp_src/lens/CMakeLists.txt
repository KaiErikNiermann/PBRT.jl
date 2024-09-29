cmake_minimum_required(VERSION 3.10)  # Adjust the version as needed
project(lens)

set(CMAKE_CXX_COMPILER "/mnt/thesis-project/cpp_src/llvm-project/build/bin/clang++")

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pg -std=c++23 -freflection-ts -freflection-ext")
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O3")
# set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -static -lc++abi -fuse-ld=lld")

link_directories("/mnt/thesis-project/cpp_src/llvm-project/build/lib/x86_64-unknown-linux-gnu")

include_directories(
    "/mnt/thesis-project/cpp_src/llvm-project/libcxx/include"
)

add_executable(lens src/main.cpp)
