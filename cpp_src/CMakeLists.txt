cmake_minimum_required(VERSION 3.10)
project(PBRT)

include_directories(include)

file(GLOB SOURCES "src/*.cpp")
file(READ ../interface/hit-aabb.jl HIT_AABB)
file(READ ../interface/hit-triangle.jl HIT_TRI)
file(READ ../interface/hit-sphere.jl HIT_SPHERE)

configure_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/src/funcs.inl.in
    ${CMAKE_SOURCE_DIR}/src/funcs.inl 
    @ONLY
)

add_executable(PBRT ${SOURCES})

target_compile_features(PBRT PRIVATE cxx_std_20)

# set g++-10 
set(CMAKE_CXX_COMPILER "/usr/bin/g++-10")
set(CMAKE_C_COMPILER "/usr/bin/gcc-10")

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
    "/usr/local/julia-1.10.2/lib/libjulia.so"
)
