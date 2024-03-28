cmake_minimum_required(VERSION 3.10)

project(PBRT)

add_executable(PBRT main.cpp)

find_library(jluna REQUIRED NAMES jluna)

find_library(jluna REQUIRED 
    NAMES jluna
    PATHS <install path>
)

target_include_directories(PBRT PRIVATE
    "/julia-1.10.2/include"
    "/usr/local/include/jluna/include/"
    "/usr/local/include/jluna/"
)

target_link_libraries(PBRT PRIVATE
    "/usr/local/lib/libjluna.so"
    "/julia-1.10.2/lib/libjulia.so"
)

target_compile_features(PBRT PRIVATE cxx_std_20)
