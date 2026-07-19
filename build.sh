#!/bin/bash
set -e

echo "Building JavaNativeLink on WSL..."

# Ensure JAVA_HOME is set
if [ -z "$JAVA_HOME" ]; then
    if [ -d "$HOME/jdk/jdk-22.0.2" ]; then
        export JAVA_HOME="$HOME/jdk/jdk-22.0.2"
        export PATH="$JAVA_HOME/bin:$PATH"
    else
        echo "JAVA_HOME not set and jdk-22 not found in ~/jdk. Please install JDK 22."
        exit 1
    fi
fi

# Clean and create build directory
rm -rf build && mkdir build && cd build

# Run CMake and build
cmake -DCMAKE_CXX_COMPILER=g++-16 ..
make -j$(nproc)

# Run C++ tests
ctest --output-on-failure
cd ..

# Build Java end-to-end test
cd tests/java_e2e
echo "Building Java E2E..."

# Compile generator
g++-16 -std=c++26 -freflection Generator.cpp -o Generator -I../../include -L../../build -lJavaNativeLink

# Run generator to create Point.java
export LD_LIBRARY_PATH=../../build:$LD_LIBRARY_PATH
./Generator

# Compile Native Library for Java tests
g++-16 -std=c++26 -freflection -fPIC -shared Point.cpp -o libPoint.so -I../../include -L../../build -lJavaNativeLink

# Compile Java
javac Point.java Main.java

# Run Java tests
java --enable-native-access=ALL-UNNAMED -Djava.library.path=.:../../build Main

echo "Success!"
