#!/bin/bash
set -e

# =============================================================================
# JNL Template Build Script — Linux / macOS
#
# Usage:  ./build.sh
#
# Set JNL_ROOT to point to the JavaNativeLink repository root.
# =============================================================================

CLASS_NAME="MyClass"

if [ -z "$JNL_ROOT" ]; then
    # Default: assume we're inside the JavaNativeLink/template/ directory
    JNL_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
fi

JNL_INCLUDE="$JNL_ROOT/include"
JNL_LIB="$JNL_ROOT/build"

# Ensure JAVA_HOME is set
if [ -z "$JAVA_HOME" ]; then
    if [ -d "$HOME/jdk/jdk-22.0.2" ]; then
        export JAVA_HOME="$HOME/jdk/jdk-22.0.2"
        export PATH="$JAVA_HOME/bin:$PATH"
    fi
fi

echo "=== Building $CLASS_NAME with JavaNativeLink ==="
echo "JNL_ROOT: $JNL_ROOT"

# Determine compiler
CXX="g++-16"
if ! command -v $CXX &>/dev/null; then
    CXX="g++"
fi

# Step 1: Compile the generator
echo "[1/4] Compiling Generator..."
$CXX -std=c++26 -freflection Generator.cpp -o Generator -I"$JNL_INCLUDE" -L"$JNL_LIB" -lJavaNativeLink

# Step 2: Run the generator to produce Java bindings
echo "[2/4] Generating ${CLASS_NAME}.java..."
export LD_LIBRARY_PATH="$JNL_LIB:$LD_LIBRARY_PATH"
./Generator

# Step 3: Compile the native shared library
echo "[3/4] Compiling lib${CLASS_NAME}.so..."
$CXX -std=c++26 -freflection -fPIC -shared ${CLASS_NAME}.cpp -o lib${CLASS_NAME}.so -I"$JNL_INCLUDE" -L"$JNL_LIB" -lJavaNativeLink

# Step 4: Compile and run Java
echo "[4/4] Compiling and running Java..."
javac ${CLASS_NAME}.java Main.java
java --enable-native-access=ALL-UNNAMED -Djava.library.path=.:$JNL_LIB Main

echo "=== Success! ==="
