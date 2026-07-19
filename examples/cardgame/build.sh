#!/bin/bash
set -e

# =============================================================================
# Card Game Example — Build Script for Linux / macOS
# =============================================================================

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
JNL_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
JNL_INCLUDE="$JNL_ROOT/include"
JNL_LIB="$JNL_ROOT/build"

# Ensure JAVA_HOME is set
if [ -z "$JAVA_HOME" ]; then
    if [ -d "$HOME/jdk/jdk-22.0.2" ]; then
        export JAVA_HOME="$HOME/jdk/jdk-22.0.2"
        export PATH="$JAVA_HOME/bin:$PATH"
    fi
fi

# Determine compiler
CXX="g++-16"
if ! command -v $CXX &>/dev/null; then
    CXX="g++"
fi

cd "$SCRIPT_DIR"
echo "=== Building Card Game Example ==="

# Step 1: Compile the generator
echo "[1/4] Compiling Generator..."
$CXX -std=c++26 -freflection Generator.cpp -o Generator -I"$JNL_INCLUDE" -L"$JNL_LIB" -lJavaNativeLink

# Step 2: Run the generator
echo "[2/4] Generating CardGame.java..."
export LD_LIBRARY_PATH="$JNL_LIB:$LD_LIBRARY_PATH"
./Generator

# Step 3: Compile the native library
echo "[3/4] Compiling libCardGame.so..."
$CXX -std=c++26 -freflection -fPIC -shared CardGame.cpp -o libCardGame.so -I"$JNL_INCLUDE" -L"$JNL_LIB" -lJavaNativeLink

# Step 4: Compile Java
echo "[4/4] Compiling Java..."
javac CardGame.java CardGameUI.java

echo "=== Card Game built successfully! ==="
echo ""
echo "To launch the game:"
echo "  cd $SCRIPT_DIR"
echo "  java --enable-native-access=ALL-UNNAMED -Djava.library.path=.:$JNL_LIB CardGameUI"
