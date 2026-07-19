#include <iostream>
#include <dlfcn.h>
#include "JavaNativeLink/Exporter.h"
#include <string>

struct Point {
    int x;
    int y;
    std::string name;
    
    Point() : x(0), y(0), name("Unknown") { std::cout << "C++ Point created (0, 0)\n"; }
    Point(int x, int y, std::string n = "Point") : x(x), y(y), name(n) { std::cout << "C++ Point created (" << x << ", " << y << ")\n"; }
    ~Point() { std::cout << "C++ Point destroyed\n"; }
};

void testPoint(Point p) {
    std::cout << "TestPoint: " << p.name << " at (" << p.x << ", " << p.y << ")\n";
}

int main() {
    void* handle = dlopen("./libPoint.dylib", RTLD_NOW);
    if (!handle) {
        std::cerr << "dlopen failed: " << dlerror() << "\n";
        return 1;
    }
    
    typedef const JNLClassRegistry* (*GetRegFunc)(const char*);
    GetRegFunc func = (GetRegFunc)dlsym(handle, "JNL_GetRegistry_Special");
    if (!func) {
        std::cerr << "dlsym failed: " << dlerror() << "\n";
        return 1;
    }
    std::cout << "dlsym JNL_GetRegistry address: " << (void*)func << "\n";
    
    const JNLClassRegistry* reg = func("Point");
    if (reg) {
        std::cout << "Found Point registry: " << reg->num_fields << " fields\n";
    } else {
        std::cout << "Point registry not found\n";
    }
    
    return 0;
}
