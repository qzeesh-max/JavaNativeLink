#include <fstream>
#include "JavaNativeLink/JavaGenerator.h"

// Note: Point.cpp defines the class. We can just `#include "Point.cpp"` for the generator, or declare it.
#include "Point.cpp"

int main() {
    std::ofstream out("Point.java");
    JNL::generate_java<Point>(out, "", "Point");
    return 0;
}
