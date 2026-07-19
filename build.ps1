param(
    [switch]$UseMSVC,
    [switch]$UseMSYS2
)

if (-not $UseMSVC -and -not $UseMSYS2) {
    $UseMSYS2 = $true
}

$ErrorActionPreference = "Stop"

echo "Building JavaNativeLink on Windows..."

if ($UseMSVC) {
    echo "Using Microsoft Visual Studio..."
    if (Test-Path build) { Remove-Item -Recurse -Force build }
    mkdir build
    cd build
    # Use default MSVC generator
    cmake .. 
    cmake --build . --config Release
    ctest --output-on-failure -C Release
    cd ..
    echo "Note: Skipping Java E2E tests for MSVC as C++26 reflection is not supported yet."
}

if ($UseMSYS2) {
    echo "Using MSYS2 g++..."
    if (Test-Path build) { Remove-Item -Recurse -Force build }
    mkdir build
    cd build
    # Ninja is available on this system
    cmake -G "Ninja" -DCMAKE_CXX_COMPILER=g++ ..
    cmake --build .
    ctest --output-on-failure
    cd ..
    
    echo "Building Java E2E..."
    cd tests\java_e2e
    
    # Compile generator
    g++ -std=c++26 -freflection Generator.cpp -o Generator.exe -I..\..\include -L..\..\build -lJavaNativeLink
    
    # Run generator
    $env:PATH = "$PWD\..\..\build;" + $env:PATH
    .\Generator.exe
    
    # Compile Native Library for Java tests (Point.dll)
    g++ -std=c++26 -freflection -fPIC -shared Point.cpp -o Point.dll -I..\..\include -L..\..\build -lJavaNativeLink
    
    # Compile Java
    javac Point.java Main.java
    
    # Run Java tests
    java --enable-native-access=ALL-UNNAMED "-Djava.library.path=.;..\..\build" Main
    
    cd ..\..
}

echo "Success!"
