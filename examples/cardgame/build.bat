@echo off
setlocal

REM =============================================================================
REM Card Game Example — Build Script for Windows (MSYS2)
REM =============================================================================

set "SCRIPT_DIR=%~dp0"
set "JNL_ROOT=%SCRIPT_DIR%..\..\"
set "JNL_INCLUDE=%JNL_ROOT%include"
set "JNL_LIB=%JNL_ROOT%build"

echo === Building Card Game Example ===

REM Step 1: Compile the generator
echo [1/4] Compiling Generator...
g++ -std=c++26 -freflection Generator.cpp -o Generator.exe -I"%JNL_INCLUDE%" -L"%JNL_LIB%" -lJavaNativeLink
if errorlevel 1 exit /b %errorlevel%

REM Step 2: Run the generator
echo [2/4] Generating CardGame.java...
set "PATH=%JNL_LIB%;%PATH%"
.\Generator.exe
if errorlevel 1 exit /b %errorlevel%

REM Step 3: Compile the native library
echo [3/4] Compiling CardGame.dll...
g++ -std=c++26 -freflection -fPIC -shared CardGame.cpp -o CardGame.dll -I"%JNL_INCLUDE%" -L"%JNL_LIB%" -lJavaNativeLink
if errorlevel 1 exit /b %errorlevel%

REM Step 4: Compile Java
echo [4/4] Compiling Java...
javac CardGame.java CardGameUI.java
if errorlevel 1 exit /b %errorlevel%

echo === Card Game built successfully! ===
echo.
echo To launch the game:
echo   java --enable-native-access=ALL-UNNAMED "-Djava.library.path=.;%JNL_LIB%" CardGameUI

endlocal
