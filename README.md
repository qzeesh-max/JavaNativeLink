# JavaNativeLink (JNL)

A C++26 reflection-based library for exposing C++ classes to Java using the Java 22+ Foreign Function & Memory API (FFM). 

JavaNativeLink automatically analyzes your C++ classes and generates the required bridging code in C, alongside the Java glue code to call it safely. It uses `std::meta` (P2996) available in GCC 16 to inspect C++ classes at compile time, eliminating the need for an external AST parser like SWIG.

## Features

- **Constructors & Destructors**: Automatically exposes multiple overloaded constructors and a safe destructor wrapper.
- **Methods**: Exposes const and non-const methods.
- **Public Fields**: Automatically generates getter and setter methods for public fields.
- **Exceptions**: Safely marshals C++ exceptions (derived from `std::exception` and unknown exceptions) to Java `RuntimeException`s using thread-local error state.
- **Primitive Type Mapping**: Correctly maps C++ unsigned types to oversized signed types in Java (e.g. `uint32_t` to `long`), and maps primitive pointers/references (e.g. `int*`, `int&`) to Java arrays for safe mutation.
- **Strings**: Maps `std::string` by value seamlessly to Java `String`.
- **Bidirectional Callbacks**: Maps `std::function` to Java FFM `UpcallStub`s, allowing you to pass Java Lambdas directly to C++.
- **Virtual Methods & Directors**: Use `std::function` fields as an idiomatic replacement for virtual methods, effectively acting as "Directors" that redirect calls to Java lambdas.

## Requirements

- **C++ Compiler**: GCC 16 with `-std=c++26 -freflection` (Note: MSVC currently lacks full C++26 reflection support for generating Java bindings, but can compile the core library).
- **Java**: JDK 22 or newer (for FFM API)
- **CMake**: 3.10+

## Building

We provide automated build scripts for Windows, Linux, and macOS. These scripts will configure CMake, build the core C++ library, compile the C++ generator, produce the Java bindings, and execute the end-to-end (E2E) tests.

### Windows
You can build using MSYS2 (recommended for full C++26 reflection support) or MSVC. Run the `build.bat` script from the repository root:

*   **Using MSYS2 (Full Support)**:
    ```cmd
    .\build.bat -UseMSYS2
    ```
*   **Using MSVC (Partial Support)**:
    ```cmd
    .\build.bat -UseMSVC
    ```
    *Note: MSVC does not currently support the C++26 reflection features needed to run the Java E2E test generation step.*

### Linux (WSL / Ubuntu) and macOS
Run the provided shell script from the repository root:
```bash
./build.sh
```
Ensure that GCC 16 is installed and set as the default compiler (`g++-16` or `g++` depending on your environment), and that JDK 22 is correctly configured in your `JAVA_HOME`.

## Usage

### 1. Annotate your C++ Class

Include `JavaNativeLink/Exporter.h` and use the `JNL_EXPORT_CLASS` macro at the bottom of your file to export the class.

```cpp
#include "JavaNativeLink/Exporter.h"
#include <string>
#include <functional>

struct Point {
    int x;
    int y;
    std::string name;
    
    Point(int x, int y, std::string name) : x(x), y(y), name(name) {}
    
    void print() {
        std::cout << name << ": " << x << ", " << y << "\n";
    }
    
    // Callback example (Virtual Method alternative)
    int applyCallback(int a, std::function<int(int)> cb) {
        if (cb) return cb(a);
        return -1;
    }
};

// Export the class to Java
JNL_EXPORT_CLASS(Point);
```

### 2. Generate Java Bindings

Write a simple C++ generator program that includes `JavaNativeLink/JavaGenerator.h` and calls `JNL::generate_java`. 

```cpp
// Generator.cpp
#include "Point.cpp" // Or include the header if building separately
#include "JavaNativeLink/JavaGenerator.h"
#include <fstream>

int main() {
    std::ofstream out("Point.java");
    // Parameters: output stream, package name, native library name
    JNL::generate_java<Point>(out, "", "Point");
    return 0;
}
```

Compile and run the generator with GCC 16:
```bash
g++-16 -std=c++26 -freflection Generator.cpp -o Generator -I<path_to_jnl_include> -L<path_to_jnl_lib> -lJavaNativeLink
./Generator
```
This produces `Point.java`.

### 3. Compile your Native Library

Compile your C++ code into a shared object (`.dylib` on macOS, `.so` on Linux, `.dll` on Windows). Link against `libJavaNativeLink.dylib`.

```bash
g++-16 -std=c++26 -freflection -fPIC -shared Point.cpp -o libPoint.dylib -I<path_to_jnl_include> -L<path_to_jnl_lib> -lJavaNativeLink
```

### 4. Use in Java

Compile the generated Java file and your application code. You must enable native access.

```java
import java.lang.foreign.*;
import java.lang.invoke.*;

public class Main {
    public static void main(String[] args) throws Throwable {
        try (Arena arena = Arena.ofConfined()) {
            Point p = new Point(10, 20, "MyPoint");
            p.print();
            
            // Pass a Java Lambda as a C++ std::function callback
            MethodHandle cbHandle = MethodHandles.lookup().findStatic(Main.class, "myCallback", MethodType.methodType(int.class, int.class));
            MemorySegment stub = Linker.nativeLinker().upcallStub(cbHandle, FunctionDescriptor.of(ValueLayout.JAVA_INT, ValueLayout.JAVA_INT), arena);
            
            int result = p.applyCallback(5, stub);
            System.out.println("Callback returned: " + result);
            
            p.close(); // Important: free the native C++ object
        }
    }
    
    public static int myCallback(int x) {
        return x * 2; // Returns 10
    }
}
```

Run with:
```bash
javac Main.java Point.java
java --enable-native-access=ALL-UNNAMED -Djava.library.path=. Main
```

## Quick Start (Project Template)

The `template/` directory provides a ready-made skeleton for new JNL-based projects. To start a new project:

1. Copy the `template/` directory:
   ```bash
   cp -r template/ /path/to/my_project/
   ```
2. Rename `MyClass.cpp` and update the struct name and `JNL_EXPORT_CLASS()` call
3. Set `JNL_ROOT` to point to your JavaNativeLink install, then run:
   ```bash
   ./build.sh          # Linux/macOS
   build.bat            # Windows (MSYS2)
   ```

See `template/README.md` for full details.

## Examples

### Blackjack Card Game

A complete Blackjack game demonstrating a Java Swing GUI frontend powered by a C++ game engine backend via JNL.

- **C++ Backend** (`examples/cardgame/CardGame.cpp`): Implements deck management, shuffling, dealing, hand scoring with ace adjustment, hit/stand logic, and win/loss tracking.
- **Java Frontend** (`examples/cardgame/CardGameUI.java`): A Swing application that renders card images, provides Hit/Stand/New Game buttons, and displays scores and game status — all by calling into the native `CardGame` class.

To build and run:
```bash
# First build the core JNL library from the repo root:
./build.sh              # or build.bat -UseMSYS2 on Windows

# Then build the card game:
cd examples/cardgame
./build.sh              # or build.bat on Windows

# Launch the game:
java --enable-native-access=ALL-UNNAMED -Djava.library.path=.:../../build CardGameUI
```

## Architecture Details

- **TypeMapper (`Exporter.h`)**: A template trait that converts between Java FFM C-ABI types (`NativeType`) and native C++ types. Handles pointer indirection, unsigned-to-signed extensions, and `std::function` wrapping automatically.
- **JavaGenerator (`JavaGenerator.h`)**: Uses C++26 reflection over `std::meta::members_of` to iterate over all exported constructors, methods, and public fields, and maps them to `MethodHandle` calls in the generated Java file.
- **JNLClassRegistry**: A C-compatible struct that the `JNL_EXPORT_CLASS` macro uses to register method wrappers to a global registry, making them discoverable from Java at runtime without name-mangling complexities.

