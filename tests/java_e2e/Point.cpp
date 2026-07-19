#include "JavaNativeLink/Exporter.h"
#include <iostream>

struct Point {
    int x;
    int y;
    
    Point() : x(0), y(0) { std::cout << "C++ Point created (default)\n"; }
    Point(int x, int y) : x(x), y(y) { std::cout << "C++ Point created (" << x << ", " << y << ")\n"; }
    ~Point() { std::cout << "C++ Point destroyed\n"; }
    
    void print() { std::cout << "C++ Point print: " << x << ", " << y << "\n"; }
    int add(int a, int b) { return a + b; }
    
    uint32_t multiplyUnsigned(uint32_t a, uint32_t b) { return a * b; }
    
    void incReference(int& val) {
        val += 10;
    }
    
    void crashMe() {
        throw std::runtime_error("This is an expected C++ exception!");
    }
};

JNL_EXPORT_CLASS(Point);
