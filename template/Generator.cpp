#include <fstream>
#include "JavaNativeLink/JavaGenerator.h"

// Include the C++ class to generate Java bindings for
#include "MyClass.cpp"

int main() {
    std::ofstream out("MyClass.java");
    // Parameters: output stream, package name (empty = default package), native library name
    JNL::generate_java<MyClass>(out, "", "MyClass");
    std::cout << "Generated MyClass.java\n";
    return 0;
}
