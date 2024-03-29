cmake_minimum_required(VERSION 3.10)
project(PBRT)

add_executable(PBRT main.cpp)

target_compile_features(PBRT PRIVATE cxx_std_20)

find_library(jluna REQUIRED NAMES jluna)

find_library(jluna REQUIRED
NAMES jluna
PATHS "/usr/local/include/jluna/"
)

target_include_directories(PBRT PRIVATE
    "/usr/local/include/julia/"
    "/usr/local/include/jluna/"
)

target_link_libraries(PBRT PRIVATE
    "/usr/local/lib/libjluna.so"
    "/opt/julia-1.9.2/lib/libjulia.so"
)

target_compile_features(PBRT PRIVATE cxx_std_20)
