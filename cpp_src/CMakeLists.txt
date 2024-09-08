cmake_minimum_required(VERSION 3.10)
project(PBRT)

# Include directories
include_directories(include)

# Gather source files
file(GLOB SOURCES "src/*.cpp" "src/*.inl")

# Read the .jl files
file(READ ../interface/hit-aabb.jl HIT_AABB)
file(READ ../interface/hit-triangle.jl HIT_TRI)
file(READ ../interface/hit-sphere.jl HIT_SPHERE)
file(READ ../interface/hit-bvh.jl HIT_BVH)

# Configure funcs.inl
configure_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/src/funcs.inl.in
    ${CMAKE_SOURCE_DIR}/src/funcs.inl
    @ONLY
)

# Add the main executable
add_executable(PBRT ${SOURCES})

# Set the C++ standard
target_compile_features(PBRT PRIVATE cxx_std_20)

# Set compiler options
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pg -std=c++20 -std=gnu++20")
set(CMAKE_CXX_COMPILER "/usr/bin/g++-11")
set(CMAKE_C_COMPILER "/usr/bin/gcc-10")

# Find and include necessary libraries
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

set(ENV{LD_LIBRARY_PATH} "/usr/local/julia-1.10.2/lib:$ENV{LD_LIBRARY_PATH}")

# Enable testing
enable_testing()

# Gather test source files
file(GLOB TEST_SOURCES "tests/*.cpp")


# Find Google Test
find_package(GTest REQUIRED)
include_directories(
    "/usr/local/include/julia/"
    "/usr/local/include/jluna/"
    ${GTEST_INCLUDE_DIRS}
)

add_executable(PBRT_tests ${TEST_SOURCES})

target_link_libraries(PBRT_tests PRIVATE ${GTEST_LIBRARIES} pthread "/usr/local/lib/libjluna.so" "/usr/local/julia-1.10.2/lib/libjulia.so")

add_test(NAME PBRTTests COMMAND PBRT_tests)

set_tests_properties(PBRTTests PROPERTIES ENVIRONMENT "LD_LIBRARY_PATH=/usr/local/julia-1.10.2/lib")
