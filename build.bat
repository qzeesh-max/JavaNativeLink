@echo off
setlocal

set "UseMSVC=0"
set "UseMSYS2=0"

:parse_args
if "%~1"=="" goto check_args
if /I "%~1"=="-UseMSVC" set "UseMSVC=1"
if /I "%~1"=="-UseMSYS2" set "UseMSYS2=1"
shift
goto parse_args

:check_args
if "%UseMSVC%"=="0" if "%UseMSYS2%"=="0" (
    set "UseMSYS2=1"
)

echo Building JavaNativeLink on Windows...

if "%UseMSVC%"=="1" (
    echo Using Microsoft Visual Studio...
    if exist build rmdir /s /q build
    mkdir build
    cd build
    cmake .. 
    if errorlevel 1 exit /b %errorlevel%
    cmake --build . --config Release
    if errorlevel 1 exit /b %errorlevel%
    ctest --output-on-failure -C Release
    if errorlevel 1 exit /b %errorlevel%
    cd ..
    echo Note: Skipping Java E2E tests for MSVC as C++26 reflection is not supported yet.
)

if "%UseMSYS2%"=="1" (
    echo Using MSYS2 g++...
    if exist build rmdir /s /q build
    mkdir build
    cd build
    cmake -G "Ninja" -DCMAKE_CXX_COMPILER=g++ ..
    if errorlevel 1 exit /b %errorlevel%
    cmake --build .
    if errorlevel 1 exit /b %errorlevel%
    ctest --output-on-failure
    if errorlevel 1 exit /b %errorlevel%
    cd ..
    
    echo Building Java E2E...
    cd tests\java_e2e
    
    g++ -std=c++26 -freflection Generator.cpp -o Generator.exe -I..\..\include -L..\..\build -lJavaNativeLink
    if errorlevel 1 exit /b %errorlevel%
    
    set "PATH=%CD%\..\..\build;%PATH%"
    .\Generator.exe
    if errorlevel 1 exit /b %errorlevel%
    
    g++ -std=c++26 -freflection -fPIC -shared Point.cpp -o Point.dll -I..\..\include -L..\..\build -lJavaNativeLink
    if errorlevel 1 exit /b %errorlevel%
    
    javac Point.java Main.java
    if errorlevel 1 exit /b %errorlevel%
    
    java --enable-native-access=ALL-UNNAMED "-Djava.library.path=.;..\..\build" Main
    if errorlevel 1 exit /b %errorlevel%
    
    cd ..\..

    echo Building Card Game Example...
    cd examples\cardgame
    call build.bat
    if errorlevel 1 exit /b %errorlevel%
    cd ..\..
)

echo Success!
endlocal
