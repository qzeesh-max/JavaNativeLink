cmake_minimum_required(VERSION 3.25)
project(JavaNativeLink CXX)

set(CMAKE_CXX_STANDARD 26)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_COMPILER "g++-16")

add_compile_options(-freflection)

# Core interface library
add_library(JavaNativeLink STATIC src/Exporter.cpp)
target_include_directories(JavaNativeLink PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)

enable_testing()
add_subdirectory(tests)
