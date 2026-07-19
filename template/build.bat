@echo off
setlocal

REM =============================================================================
REM JNL Template Build Script — Windows (MSYS2)
REM
REM Usage:  build.bat
REM
REM Set JNL_ROOT to point to the JavaNativeLink repository root.
REM =============================================================================

set "CLASS_NAME=MyClass"

if "%JNL_ROOT%"=="" (
    set "JNL_ROOT=%~dp0.."
)

set "JNL_INCLUDE=%JNL_ROOT%\include"
set "JNL_LIB=%JNL_ROOT%\build"

echo === Building %CLASS_NAME% with JavaNativeLink ===
echo JNL_ROOT: %JNL_ROOT%

REM Step 1: Compile the generator
echo [1/4] Compiling Generator...
g++ -std=c++26 -freflection Generator.cpp -o Generator.exe -I"%JNL_INCLUDE%" -L"%JNL_LIB%" -lJavaNativeLink
if errorlevel 1 exit /b %errorlevel%

REM Step 2: Run the generator to produce Java bindings
echo [2/4] Generating %CLASS_NAME%.java...
set "PATH=%JNL_LIB%;%PATH%"
.\Generator.exe
if errorlevel 1 exit /b %errorlevel%

REM Step 3: Compile the native shared library
echo [3/4] Compiling %CLASS_NAME%.dll...
g++ -std=c++26 -freflection -fPIC -shared %CLASS_NAME%.cpp -o %CLASS_NAME%.dll -I"%JNL_INCLUDE%" -L"%JNL_LIB%" -lJavaNativeLink
if errorlevel 1 exit /b %errorlevel%

REM Step 4: Compile and run Java
echo [4/4] Compiling and running Java...
javac %CLASS_NAME%.java Main.java
if errorlevel 1 exit /b %errorlevel%

java --enable-native-access=ALL-UNNAMED "-Djava.library.path=.;%JNL_LIB%" Main
if errorlevel 1 exit /b %errorlevel%

echo === Success! ===
endlocal
