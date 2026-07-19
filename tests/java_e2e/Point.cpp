#include "JavaNativeLink/Exporter.h"
#include <iostream>
#include <functional>

struct Point {
    int x;
    int y;
    std::string name;
    
    Point() : x(0), y(0), name("Unknown") { std::cout << "C++ Point created (default)\n"; }
    Point(int x, int y, std::string name = "Point") : x(x), y(y), name(name) { std::cout << "C++ Point created (" << x << ", " << y << ")\n"; }
    ~Point() { std::cout << "C++ Point destroyed\n"; }
    
    void print() { std::cout << "C++ Point print: " << x << ", " << y << ", " << name << "\n"; }
    int add(int a, int b) { return a + b; }
    
    std::string greet(Point other) {
        return "Hello " + other.name + " from " + name;
    }
    
    uint32_t multiplyUnsigned(uint32_t a, uint32_t b) { return a * b; }
    
    void incReference(int& val) {
        val += 10;
    }
    
    void crashMe() {
        throw std::runtime_error("This is an expected C++ exception!");
    }
    
    int applyCallback(int a, std::function<int(int)> cb) {
        if (cb) {
            return cb(a);
        }
        return -1;
    }
};

JNL_EXPORT_CLASS(Point);
