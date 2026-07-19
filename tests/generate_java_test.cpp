#include <fstream>
#include "JavaNativeLink/JavaGenerator.h"

struct Point {
    int x;
    int y;
    Point() : x(0), y(0) {}
    Point(int x, int y) : x(x), y(y) {}
    void print() {}
    int add(int a, int b) { return a + b; }
};

int main() {
    std::ofstream out("Point.java");
    JNL::generate_java<Point>(out);
    return 0;
}
